import { createApp, provide } from 'vue'
import App from './App.vue'
import '@/styles/index' // 全局css
import router from "@/router/index"
import naive from 'naive-ui'


import 'element-plus/lib/theme-chalk/index.css';
import ElementPlus from 'element-plus';
import { store, key } from '../render/store/index'
import setupProdMockServer from '../render/mock/index'



// 富文本编辑器
import VueMarkdownEditor from '@kangc/v-md-editor';
import '@kangc/v-md-editor/lib/style/base-editor.css';
import vuepressTheme from '@kangc/v-md-editor/lib/theme/vuepress.js';
import '@kangc/v-md-editor/lib/theme/style/vuepress.css';

import Prism from 'prismjs';

VueMarkdownEditor.use(vuepressTheme, {
    Prism,
});







//  创建mock数据。
setupProdMockServer()

export const app = createApp(App).use(router).use(naive).use(ElementPlus).use(store, key).use(VueMarkdownEditor).mount('#app')
// console.log('createApp(App): ', createApp({
//     name:"component12121",
//     data() {
//         return { count: 4 }
//     }
// }).mount('#app'));
console.log('app', app);


