import { createApp } from 'vue'
import App from './App.vue'
import '@/styles/index.scss' // 全局css
import router from "@/router/index"




export const app = createApp(App).use(router).mount('#app')

