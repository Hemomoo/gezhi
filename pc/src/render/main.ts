import { createApp } from 'vue'
import App from './App.vue'
import '@/styles/index' // 全局css
import router from "@/router/index"
import naive from 'naive-ui'
// 富文本编辑器
import VMdEditor from '@kangc/v-md-editor';
import '@kangc/v-md-editor/lib/style/base-editor.css';
import githubTheme from '@kangc/v-md-editor/lib/theme/github.js';
import '@kangc/v-md-editor/lib/theme/style/github.css';
import 'element-plus/lib/theme-chalk/index.css';
import ElementPlus from 'element-plus';






export const app = createApp(App).use(router).use(naive).use(VMdEditor).use(ElementPlus).mount('#app')
