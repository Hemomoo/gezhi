import Mock from 'mockjs'
import { MockMethod } from "vite-plugin-mock";
const data = Mock.mock({
    'items|24': [{
        id: '@id',
        img: Mock.Random.image('200x100'),
        date: '@date',
    }]
})

export default [
    {
        url: '/attachment/list',
        method: 'get',
        response: () => {
            return {
                code: 200,
                message: "success",
                data: {
                    imgs: data.items,
                }
            }
        }
    }
] as MockMethod[];
