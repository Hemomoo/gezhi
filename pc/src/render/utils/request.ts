import axios, { AxiosRequestConfig, AxiosResponse } from "axios";


export interface MyResponseType<T = any> {
    code: number;
    message: string;
    data: T;
  }


const service = axios.create({
    baseURL: '/', // url = base url + request url
    timeout: 500000000, // request timeout
})

// 请求拦截器
service.interceptors.request.use(
    (config: AxiosRequestConfig) => {
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
    (response: AxiosResponse):any => {
        return response.data
    },
    error => {
        return Promise.reject(error)
    }
)

const request = async <T = any>(config: AxiosRequestConfig): Promise<MyResponseType<T>> => {
    try {
      const { data } = await service.request<MyResponseType<T>>(config)
      return data
    } catch (err) {
      const message = err.message || '请求失败'
      console.error(message) // 失败消息提示
      return {
        code: -1,
        message,
        data: null as any
      }
    }
  }
  


export default request
