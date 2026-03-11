<script setup>
  import { loginUserService, userInfoService } from '@/api/user'
  import { useTokenStore } from '@/stores/token'
import { useUserInfoStore } from '@/stores/userinfo'
  import { ElMessage } from 'element-plus'
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'

  const router = useRouter();
  const tokenStore = useTokenStore();
  const userInfoStore = useUserInfoStore();

  const checkToken = async () => {
    if (tokenStore.token) {
      try {
        const infoRes = await userInfoService();
        userInfoStore.setInfo(infoRes.data);
        router.push('/');
      } catch (error) {
        tokenStore.setToken('');
        userInfoStore.setInfo(null);
        console.error('Session expired, please login again');
      }
    }
  }

  checkToken();
  
  const data = ref({
    email: '',
    password: ''
  })

  const rules = ({
    email: [
      {
        required: true,
        message: 'please enter your email', 
        trigger: 'blur'
      },
      {
        type: 'email',
        message: 'please enter a valid email address',
        trigger: 'blur'
      }
    ],
    password: [
      {
        required: true,
        message: 'please enter your password', 
        trigger: 'blur'
      },
      {
        min: 6,
        max: 16,
        message: 'password length should be 6-16 characters',
        trigger: 'blur'
      }
    ]
  })

  const submitForm = async () => {
    try {
      const result = await loginUserService(data.value);
      ElMessage.success(result.message ?? 'login succeeded');
      tokenStore.setToken(result.data);
      const infoRes = await userInfoService();
      userInfoStore.setInfo(infoRes.data);
      router.push('/')
    } catch (error) {
      ElMessage.error(error.message ?? 'login failed');
      console.log(error);
    }
  }

  const resetForm = () => {
    if (!data) return
    data.value.email = ''
    data.value.password = ''
  }

</script>

<template>
  <h1>Login</h1>
  <el-form
    ref="form"
    style="max-width: 600px"
    :model="data"
    :rules="rules"
  >
    <el-form-item label="Email" prop="email">
      <el-input v-model="data.email" />
    </el-form-item>
    <el-form-item label="Password" prop="password">
      <el-input v-model="data.password" type="password" autocomplete="off" />
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submitForm()">
        Login
      </el-button>
      <el-button @click="resetForm()">Reset</el-button>
      <el-button @click="router.push('/')" link>Continue as a guest</el-button>
    </el-form-item>
  </el-form>
</template>