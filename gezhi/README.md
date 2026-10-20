# 格志日记（gezhi）

一款使用 Flutter 编写的本地日记 App，数据全部保存在设备本地 SQLite 中，不依赖服务端。

## 功能

- **日记本**：按日记本组织每日记录，支持自定义标题、封面图与模板
- **时间线**：按时间倒序浏览日记，支持网格 / 列表两种视图切换
- **日历**：按日期范围筛选与回看日记
- **发现**：日记内容搜索
- **我的**：
  - 名言库（增删改查、复制）
  - 提示库、模板库
  - 数据备份与恢复、批量导出
  - 账号、密码、存储等设置项

> 富文本编辑器已引入 `fleather`，编辑页集成尚在开发中。

## 技术栈

| 分类 | 选型 |
|---|---|
| 框架 | Flutter 3.3.10 / Dart 2.18.6 |
| 状态管理 | provider |
| 本地存储 | sqflite（SQLite） |
| 网络请求 | dio |
| 路由 | 命名路由 + `onGenerateRoute` |
| 页面适配 | flutter_screenutil |
| 富文本 | fleather |
| 其他 | webview_flutter、image_picker、url_launcher、shared_preferences、flutter_slidable、event_bus |

## 环境要求

项目使用 FVM 管理 Flutter 版本，请先安装 [FVM](https://fvm.app/)。

```bash
# 安装项目锁定的 Flutter 版本
fvm install 3.3.10
fvm use 3.3.10
```

> **必须使用 Flutter 3.3.10（Dart 2.18.6）**。项目的 SDK 约束为 `>=2.17.4 <3.0.0`，部分长期未维护的依赖无法在 Dart 3 下编译，升级 Flutter 会导致大量 API 变更。

### 空安全说明

`flutter_swiper`、`left_scroll_actions`、`toast` 等依赖尚未适配空安全，因此**所有运行与构建命令都必须追加 `--no-sound-null-safety`**，否则会在编译期报错。

## 运行

```bash
fvm flutter pub get
fvm flutter run -d <device-id> --no-sound-null-safety
```

查看可用设备：

```bash
fvm flutter devices
```

## 打包

```bash
# debug
fvm flutter build apk --debug --no-sound-null-safety

# release
fvm flutter build apk --release --no-sound-null-safety
```

## Android 构建配置

| 项 | 版本 |
|---|---|
| AGP | 7.3.1 |
| Gradle | 7.4 |
| Kotlin | 1.8.22 |
| compileSdk / targetSdk | 33 |
| minSdk | 21 |

Gradle 与 pub 均配置了国内镜像源，以规避境外网络访问失败的问题。

## 目录结构

```
lib/
├── main.dart              # 入口，初始化数据库后启动应用
├── config.dart
├── fonts/                 # 字体图标
├── model/                 # 数据模型
├── pages/                 # 页面
│   ├── index.dart         # 底部导航容器
│   ├── home/              # 日记本
│   ├── time_line/         # 时间线、富文本编辑页
│   ├── calendar/          # 日历
│   ├── search/            # 搜索
│   ├── me/                # 我的（名言库、模板库、备份导出等）
│   ├── login/             # 登录
│   └── error/             # 404
├── providers/             # 全局状态
├── routes/                # 路由表与生成器
├── sqlite/                # 数据库初始化、表定义、查询工具
├── style/                 # 主题与配色
├── utils/                 # 工具方法（网络请求等）
└── widgets/               # 可复用组件（按页面域划分）
```

## 相关仓库

- GitHub: <https://github.com/Hemomoo/gezhi>
