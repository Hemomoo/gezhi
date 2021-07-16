import request from '@/utils/request'

interface Img {
    img: string;
    date: string;
    id: string;
}


interface ResponseInterface {
    imgs:Img[]
}


export function attachmentFn() {
    return request<ResponseInterface>({
        url: `/attachment/list`,
        method: 'GET',
    })
}