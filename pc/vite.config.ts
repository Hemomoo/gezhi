import path from 'path'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'


// https://vitejs.dev/config/
export default defineConfig({
  // root: path.join(__dirname, 'src/render'), // 指向渲染进程目录
  // input: 'src/main.js',  // 入口文件
  plugins: [vue()],
  // optimizeDeps: {
  //   exclude: ['electron'], // 告诉 Vite 不要转换 electron 模块
  // },
})
