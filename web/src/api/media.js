import { useTokenStore } from '@/stores/token.js'
import request from '@/utils/request.js'

export const mediaListService = (params) => {
    return request.get('media/list', { params: params })
}

export const mediaDetailService = (id) => {
    return request.get('media/detail', {params: { id: id }})
}