import { useTokenStore } from '@/stores/token.js'
import request from '@/utils/request.js'

export const mediaListService = (params) => {
    const tokenStore = useTokenStore();
    // return request.get(
    //     'list',
    //     { headers: { 'Authorization': tokenStore.token } }
    // )
    console.log(params);
    return request.get('media/list', { params: params })
}