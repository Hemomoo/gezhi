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
      component: () => import('@/views/today/index.vue')
    }],
  },
  // 日历
  {
    path: '/calendar',
    component: Layout,
    redirect: '/calendar',
    children: [{
      path: '/calendar',
      name: 'calendar',
      component: () => import('@/views/calendar/index.vue')
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
      component: () => import('@/views/time-line/index.vue')
    }],
  },
  {
    path: '/diary',
    component: Layout,
    redirect: '/diary',
    children: [{
      path: '/diary',
      name: 'diary',
      component: () => import('@/views/diary/index.vue')
    }, {
      path: "/edit-diary",
      name: 'edit-diary',
      component: () => import("@/views/diary/edit-diary.vue")
    }],
  },
  {
    path: "/resouce",
    component: Layout,
    redirect: '/resource',
    children: [{
      path: "/resouce",
      name: 'resouce',
      component: () => import('@/views/resource-library/index.vue')
    }

    ]
  },

  // 附件
  {
    path: '/attachment',
    component: Layout,
    redirect: '/attachment',
    children: [
      {
        path: '/attachment',
        name: 'attachment',
        component: () => import('@/views/attachment/index.vue')
      }
    ]
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
