import path from 'path'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'


// https://vitejs.dev/config/
export default defineConfig({
  base: './',
  plugins: [vue()],
  // optimizeDeps: {
  //   exclude: ['electron'], // 告诉 Vite 不要转换 electron 模块
  // },
})
