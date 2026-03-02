import axios from "axios";
import { ElMessage } from "element-plus";
import router from "@/router";
import { useTokenStore } from "@/stores/token";

// const baseURL = 'http://localhost:8080/';
const baseURL = '/api';
const instance = axios.create({ baseURL })


instance.interceptors.request.use(
    (config) => {
        // You can add common headers or authentication tokens here
        const tokenStore = useTokenStore();
        if (tokenStore.token) {
            config.headers.Authorization = tokenStore.token;
        }
        return config;
    },
    (err) => {
        Promise.reject(err);
    }
)

instance.interceptors.response.use(
    result => {
        if (result.data.code === 0) {
            return result.data;
        }
        else {
            ElMessage.error(result.data.msg ?? 'failed')
            return Promise.reject(result.data);
        }
    },
    err => {
        console.log(err.response)
        if (err.response && err.response.status === 401) {
            ElMessage.error('Unauthorized, please login again');
            router.push('/login');
        }
        ElMessage.error('application error')
        return Promise.reject(err);
    }
)

export default instance;