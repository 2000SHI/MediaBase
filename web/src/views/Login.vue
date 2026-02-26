<script setup>
  import { loginUserService } from '@/api/user'
import { useTokenStore } from '@/stores/token'
  import { ElMessage } from 'element-plus'
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'
  
  const data = ref({
    username: '',
    password: ''
  })

  const rules = ({
    username: [
      {
        require: true,
        message: 'please enter your username', 
        trigger: 'blur'
      },
      {
        min: 1,
        max: 32,
        message: 'username length should be 1-32 characters',
        trigger: 'blur'
      }
    ],
    password: [
      {
        require: true,
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

  const tokenStore = useTokenStore()

  const submitForm = async () => {
    const result = await loginUserService(data.value)
    ElMessage.success(result.message ?? 'login succeeded')
    tokenStore.setToken(result.data)
    useRouter().push('/')
  }

  const resetForm = () => {
    if (!data) return
    data.value.username = ''
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
    <el-form-item label="Username" prop="username">
      <el-input v-model="data.username" />
    </el-form-item>
    <el-form-item label="Password" prop="password">
      <el-input v-model="data.password" type="password" autocomplete="off" />
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submitForm()">
        Login
      </el-button>
      <el-button @click="resetForm()">Reset</el-button>
    </el-form-item>
  </el-form>
</template>