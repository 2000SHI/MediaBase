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

export const updateService = (data) => {
    const tokenStore = useTokenStore();
    return request.put(
        '/user/update',
        data,
        { headers: { 'Authorization': tokenStore.token } }
    );
}

export const uploadAvatarService = (file) => {
    const tokenStore = useTokenStore();
    const formData = new FormData();
    formData.append('avatar', file);
    return request.patch(
        '/user/updateAvatar',
        formData,
        { headers: {
            'Authorization': tokenStore.token,
            'Content-Type': 'multipart/form-data'
        } }
    );
}

export const updatePwdService = (params) => {
    const tokenStore = useTokenStore();
    return request.patch(
        '/user/updatePwd',
        params,
        { headers: {
            'Authorization': tokenStore.token
        } }
    );
}

export const getRoleService = (id) => {
    const tokenStore = useTokenStore();
    return request.get(
        '/user/admin',
        { headers: { 'Authorization': tokenStore.token } }
    );
}