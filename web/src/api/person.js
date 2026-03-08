import { useTokenStore } from '@/stores/token.js'
import request from '@/utils/request.js'

export const personFindService = (params) => {
    return request.get('person/detail', { params: params })
}

export const personMediaService = (params) => {
    return request.get('person/media', { params: params })
}