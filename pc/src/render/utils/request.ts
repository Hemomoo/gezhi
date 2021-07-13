import axios from 'axios'

const service = axios.create({
    baseURL: '/', // url = base url + request url
    timeout: 500000000 // request timeout
})

// 请求拦截器
service.interceptors.request.use(
    config => {
        return config
    },
    error => {
        // do something with request error
        console.log(error) // for debug
        return Promise.reject(error)
    }
)

// 响应拦截器
service.interceptors.response.use(
    response => {
        const res = response.data
        console.log(`response响应: ${response.config.url}`, response.data)
        return res.data
    },
    error => {
        return Promise.reject(error)
    }
)

export default service
