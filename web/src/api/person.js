import { useTokenStore } from '@/stores/token.js'
import request from '@/utils/request.js'

export const personListService = () => {
    return request.get('person/list');
}

export const personFindService = (params) => {
    return request.get('person/detail', { params: params })
}

export const personMediaService = (params) => {
    return request.get('person/media', { params: params })
}

export const personAddService = (data) => {
    const tokenStore = useTokenStore();
    const params = new URLSearchParams();
    for (let key in data) {
        params.append(key, data[key]);
    };
    return request.post(
        'person',
        params,
        {
            headers: { 'Authorization': tokenStore.token }
        }
    );
}