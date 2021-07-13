import request from '@/utils/request'

export function timeList() {
  return request({
    url: `/time-line/list`,
    method: 'GET',
  })
}