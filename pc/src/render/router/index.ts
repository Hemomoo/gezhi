import { createRouter, createWebHashHistory } from 'vue-router';
import Layout from '../layout/index.vue';

const routes = [
  // 今天
  {
    path: '/',
    component: Layout,
    redirect: '/today',
    children: [{
      path: '/today',
      name: 'today',
      component: () => import('../../render/views/today/index.vue')
    }],
  },
  // 标题
  {
    path: '/tit',
    component: Layout,
    redirect: '/tit',
    children: [{
      path: '/tit',
      name: 'tit',
      component: () => import('../../render/views/tit/index.vue')
    }]
  },
  // 资源库
  // 时间线
  {
    path: '/time-line',
    component: Layout,
    redirect: '/time-line',
    children: [{
      path: '/time-line',
      name: 'time-line',
      component: () => import('../../render/views/time-line/index.vue')
    }],
  }
]

// 3. 创建路由实例并传递 `routes` 配置
// 你可以在这里输入更多的配置，但我们在这里
// 暂时保持简单
const router = createRouter({

  // 4. 内部提供了 history 模式的实现。为了简单起见，我们在这里使用 hash 模式。
  history: createWebHashHistory(),
  routes, // `routes: routes` 的缩写
})

console.log('router: ', router);

export default router
