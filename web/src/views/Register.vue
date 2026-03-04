<script setup>
  import { registerUserService } from '@/api/user'
  import { ElMessage } from 'element-plus'
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'

  const data = ref({
    username: '',
    password: '',
    rePassword: ''
  })

  const router = useRouter()

  const validateRePass = (rule, value, callback) => {
    if (value === '') {
      callback(new Error('Please input the password again'))
    } else if (value !== data.value.pass) {
      callback(new Error("Two passwords don't match!"))
    } else {
      callback()
    }
  }

  const rules = ({
    username: [
      {
        required: true,
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
    ],
    rePassword: [{ validator: validateRePass, trigger: 'blur' }],
  })

  const submitForm = async () => {
    const result = await registerUserService(data.value)
    ElMessage.success(result.message ?? 'register succeeded')
    router.push('/')
  }

  const resetForm = () => {
    if (!data) return
    data.value.username = ''
    data.value.password = ''
    data.value.rePassword = ''
  }

</script>

<template>
  <h1>Sign up</h1>
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
      <el-input
        v-model="data.password"
        type="password"
        autocomplete="off"
      />
    </el-form-item>
    <el-form-item label="Confirm" prop="rePassword">
      <el-input
        v-model="data.rePassword"
        type="password"
        autocomplete="off"
      />
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submitForm()">
        Sign up
      </el-button>
      <el-button @click="resetForm()">Reset</el-button>
      <el-button @click="router.push('/')" link>Continue as a guest</el-button>
    </el-form-item>
  </el-form>
</template>