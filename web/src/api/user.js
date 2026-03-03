import { useTokenStore } from '@/stores/token'
import request from '@/utils/request'

export const registerUserService = (data) => {
    const params = new URLSearchParams();
    for (let key in data) {
        params.append(key, data[key]);
    }
    return request.post('/user/register', params);
}

export const loginUserService = (data) => {
    const params = new URLSearchParams();
    for (let key in data) {
        params.append(key, data[key]);
    }
    return request.post('/user/login', params);
}

export const userInfoService = () => {
    const tokenStore = useTokenStore();
    return request.get(
        '/user/info',
        { headers: { 'Authorization': tokenStore.token } }
    );
}