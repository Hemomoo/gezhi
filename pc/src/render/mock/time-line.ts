import Mock from 'mockjs'
import { MockMethod } from "vite-plugin-mock";
const data = Mock.mock({
  'items|20': [{
    id: '@id',
    title: '@sentence(2, 4)',
    display_time: '@datetime',
  }]
})

export default [
  {
    url: '/time-line/list',
    method: 'get',
    response: () => {
      const items = data.items
      return {
        code: 200,
        data: {
          total: items.length,
          items: items
        }
      }
    }
  }
] as MockMethod[];
