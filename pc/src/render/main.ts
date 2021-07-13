import { createApp, provide } from 'vue'
import App from './App.vue'
import '@/styles/index' // 全局css
import router from "@/router/index"
import naive from 'naive-ui'
// 富文本编辑器
import '@kangc/v-md-editor/lib/style/base-editor.css';
import '@kangc/v-md-editor/lib/theme/style/github.css';
import 'element-plus/lib/theme-chalk/index.css';
import ElementPlus from 'element-plus';
import { store, key } from '../render/store/index'
import Mock from './mock' // 刚刚手写的mock.js文件




export const app = createApp(App).use(router).use(naive).use(ElementPlus).use(store, key).use(Mock).mount('#app')


