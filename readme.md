# 格志（gezhi）

格志是一款日记应用。本仓库是围绕它展开的 monorepo，包含移动端主应用、服务端，以及两版桌面端探索。

当前主线是 `gezhi/`（Flutter 移动端），数据全部保存在设备本地；`node/`、`pc/`、`vitepc/` 属于早期版本或实验性尝试。

## 项目一览

| 目录 | 定位 | 技术栈 | 状态 |
|---|---|---|---|
| [`gezhi/`](gezhi/) | 移动端日记 App（Android / iOS） | Flutter 3.47.7 · Dart 3.13.5 · sqflite · fleather | 主线，持续开发 |
| [`node/`](node/) | 服务端 API | Egg.js 2 · MySQL · JWT | 早期版本，接口可用 |
| [`pc/`](pc/) | 桌面端原型 | Vue 3 · Vite 2 · Electron 17 · TypeScript | 原型，页面骨架 + mock 数据 |
| [`vitepc/`](vitepc/) | 桌面端脚手架 | Electron 21 · electron-vite · Vue 3 · TypeScript · Milkdown | 脚手架，尚未接入业务 |

```
ge_zhi/
├── gezhi/      Flutter 移动端
├── node/       Egg.js 服务端
├── pc/         Electron 桌面端原型
├── vitepc/     electron-vite 桌面端脚手架
└── readme.md
```

## gezhi · 移动端

本地优先的日记 App，支持日记本、时间线、日历、搜索、名言/提示/模板库、备份导出等。详细说明见 [gezhi/README.md](gezhi/README.md)。

项目使用 FVM 管理 Flutter 版本：

```bash
cd gezhi
fvm install 3.47.7
fvm use 3.47.7
fvm flutter pub get
fvm flutter run -d <device-id>
```

打包：

```bash
fvm flutter build apk --debug
fvm flutter build apk --release
```

### 本地数据库

应用启动时会初始化 `gezhi.db`（sqflite），创建 `course`、`user`、`famous`、`tips` 表。若检测到表缺失，会删除旧库并重建。

## node · 服务端

基于 Egg.js 的接口服务，使用 MySQL 存储、JWT 鉴权。

### 启动

环境要求：Node.js >= 10、MySQL 5.7。

```bash
# 1. 创建数据库并导入表结构与示例数据
mysql -u root -p gezhi < gezhi.sql

# 2. 在 config/config.local.js 中配置本地 MySQL 连接（host / user / password / database）

# 3. 安装依赖并启动
cd node
npm install
npm run dev
```

服务默认监听 `http://127.0.0.1:7100`。

```bash
npm run lint   # 代码检查
npm test       # lint + 单元测试
npm run cov    # 覆盖率
npm start      # 生产环境后台运行
npm stop       # 停止服务
```

### 接口

| 方法 | 路径 | 说明 | 需要登录 |
|---|---|---|---|
| GET | `/` | 首页 | 否 |
| GET | `/search` | 搜索日记（FIND_IN_SET 示例查询） | 是 |
| GET | `/search/total` | 日记 / 天数统计 | 是 |
| GET | `/search/diary` | 按内容搜索日记 | 是 |
| POST | `/user/login` | 登录，返回 JWT | 否 |
| POST | `/user/register` | 注册 | 否 |
| GET | `/user/tipLibrary` | 查询提示库 | 是 |
| POST | `/user/add/tipLibrary` | 新增提示 | 是 |
| GET | `/user/remark` | 随机获取一条名言 | 是 |
| POST | `/user/add/remark` | 新增名言 | 是 |

鉴权中间件读取请求头 `Authorization: Bearer <token>`，登录与注册接口在白名单中。未携带 token 返回 `code: 5008`，token 过期返回 `code: 5009`。

### 数据表

`gezhi.sql` 提供 `date`、`diary`、`tiplibrary`、`user` 四张表的建表语句与示例数据；名言数据由代码中的 `famous_remark` 表承载。

## pc · 桌面端原型

Vue 3 + Vite + Electron 的桌面端尝试，界面基于 naive-ui、element-plus，接口层使用 mockjs 模拟数据。

```bash
cd pc
npm install

npm run dev       # 仅启动渲染进程（Vite）
npm run dev:ele   # 启动 Electron 主进程
npm run dev:all   # 同时启动以上两个
npm run build     # vue-tsc 类型检查 + vite 构建
```

主进程固定加载 `http://localhost:3000`，因此需要先启动 Vite 开发服务器。

> 注意：`dev:ele` 直接让 Electron 运行 `src/main/index.ts`，而该入口目前是未经编译的 TypeScript 原型，桌面端启动链路尚未补全构建步骤。

渲染进程入口为 `src/render/main.ts`，使用 hash 路由，页面包括：

- 今日（`today`）
- 时间线（`time-line`）
- 日历（`calendar`）
- 日记本（`diary` / `edit-diary`）
- 附件（`attachment`）
- 资源库（`resource-library`：名言、模板、提示）

## vitepc · 桌面端脚手架

基于 electron-vite 的 Electron + Vue 3 + TypeScript 工程，内置 Milkdown 编辑器依赖，目前仍是脚手架状态。

```bash
cd vitepc
npm install

npm run dev         # 开发模式
npm run build       # 类型检查 + 构建
npm run typecheck   # 仅类型检查
npm run lint        # ESLint
npm run format      # Prettier

npm run build:win   # 打包 Windows
npm run build:mac   # 打包 macOS
npm run build:linux # 打包 Linux
```

目录遵循 electron-vite 约定：

```
src/
├── main/       # 主进程
├── preload/    # 预加载脚本
└── renderer/   # 渲染进程（Vue）
```

## 约定

- 服务端业务响应统一使用 `code` 字段：`1` 表示成功，`0` 表示失败。
- 移动端所有日记数据仅存于本地 SQLite，不依赖服务端。

## 相关链接

- GitHub：<https://github.com/Hemomoo/gezhi>
