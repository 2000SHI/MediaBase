import { useTokenStore } from '@/stores/token.js'
import request from '@/utils/request.js'

export const mediaListService = () => {
    const tokenStore = useTokenStore();
    // return request.get(
    //     'list',
    //     { headers: { 'Authorization': tokenStore.token } }
    // )
    return request.get('list')
}