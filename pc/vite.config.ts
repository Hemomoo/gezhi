import path from "path";
import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
function resolve(dir) {
  return path.join(__dirname, dir);
}

// https://vitejs.dev/config/
export default defineConfig({
  base: "./",
  plugins: [vue()],
  resolve: {
    // 忽略后缀名的配置选项, 添加 .vue 选项时要记得原本默认忽略的选项也要手动写入
    extensions: [".mjs", ".js", ".ts", ".jsx", ".tsx", ".json", ".vue",'.scss'],
    // 别名
    alias: {
      "@": resolve("src/render"),
    },
  },
  css: {
    // css预处理器
    preprocessorOptions: {
      scss: {
        // 引入 var.scss 这样就可以在全局中使用 var.scss中预定义的变量了
        // additionalData: '@import "./src/assets/scss/var.scss"'
      },
    },
  },

  // optimizeDeps: {
  //   exclude: ['electron'], // 告诉 Vite 不要转换 electron 模块
  // },
});
