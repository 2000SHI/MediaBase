import { useTokenStore } from '@/stores/token.js'
import request from '@/utils/request.js'

export const searchService = (pageParams, filter) => {
    return request.post(
        'search',
        filter,
        { params: pageParams }
    );
}