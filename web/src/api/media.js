import { useTokenStore } from '@/stores/token.js'
import request from '@/utils/request.js'

export const mediaListService = (params) => {
    console.log(params);
    return request.get('media/list', { params: params })
}