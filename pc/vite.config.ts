import path from 'path'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
function resolve(dir) {
  return path.join(__dirname, dir)
}



// https://vitejs.dev/config/
export default defineConfig({
  base: './',
  plugins: [vue()],
  resolve:{
    extensions: ['.js', '.vue', '.json'],
    alias:{
      '@': resolve('src/render')
    }
  },
  css: {
    // css预处理器
    preprocessorOptions: {
      scss: {
        // 引入 var.scss 这样就可以在全局中使用 var.scss中预定义的变量了
        // additionalData: '@import "./src/assets/scss/var.scss"'
      }
    }
  }


  // optimizeDeps: {
  //   exclude: ['electron'], // 告诉 Vite 不要转换 electron 模块
  // },
})
