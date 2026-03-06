import { useTokenStore } from '@/stores/token.js'
import request from '@/utils/request.js'

export const personFindService = (params) => {
    return request.get('person/detail', { params: params })
}