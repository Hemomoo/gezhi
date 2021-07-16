import request from '@/utils/request'

export function attachmentFn() {
    return request({
      url: `/attachment/list`,
      method: 'GET',
    })
  }