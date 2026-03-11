import { useTokenStore } from '@/stores/token.js'
import request from '@/utils/request.js'

export const mediaListService = (params) => {
    return request.get('media/list', { params: params })
}

export const mediaDetailService = (id) => {
    return request.get('media/detail', {params: { id: id }})
}

export const mediaPeopleService = (id) => {
    return request.get('media/people', {params: { id: id }})
}

export const getRateService = (id) => {
    const tokenStore = useTokenStore();
    return request.get(
        'media/rate',
        {
            params: { mediaId: id },
            headers: { 'Authorization': tokenStore.token }
        }
    );
}

export const addRateService = (data) => {
    const tokenStore = useTokenStore();
    const params = new URLSearchParams();
    for (let key in data) {
        params.append(key, data[key]);
    }
    return request.post(
        'media/rate',
        params,
        {
            headers: { 'Authorization': tokenStore.token }
        }
    );

}
export const updateRateService = (data) => {
    console.log(data);
    const tokenStore = useTokenStore();
    const params = new URLSearchParams();
    for (let key in data) {
        params.append(key, data[key]);
    }
    return request.put(
        'media/rate',
        params,
        {
            headers: { 'Authorization': tokenStore.token }
        }
    );
}

export const getCommentService = (id) => {
    const tokenStore = useTokenStore();
    return request.get(
        'media/comment',
        {
            params: { mediaId: id },
            headers: { 'Authorization': tokenStore.token }
        }
    );
}

export const addCommentService = (data) => {
    const tokenStore = useTokenStore();
    const params = new URLSearchParams();
    for (let key in data) {
        params.append(key, data[key]);
    }
    return request.post(
        'media/comment',
        params,
        {
            headers: { 'Authorization': tokenStore.token }
        }
    );
}

export const deleteCommentService = (id) => {
    const tokenStore = useTokenStore();
    return request.delete(
        'media/comment',
        {
            params: { id: id },
            headers: { 'Authorization': tokenStore.token }
        }
    );
}

export const addService = (params) => {
    const tokenStore = useTokenStore();
    return request.post(
        'media/',
        params,
        {
            headers: { 'Authorization': tokenStore.token }
        }
    );
}