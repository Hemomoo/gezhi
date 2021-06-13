import { createApp } from 'vue'
import App from './App.vue'
import '@/styles/index' // 全局css
import router from "@/router/index"
import naive from 'naive-ui'





export const app = createApp(App).use(router).use(naive).mount('#app')

