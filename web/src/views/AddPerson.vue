<script setup>
import { ElMessage } from 'element-plus';
import { ref } from 'vue';
import { personAddService } from '@/api/person';

const person = ref({
  name: '',
  bio: ''
})

const personRules = ({
  name: {
    required: true,
    message: 'Please enter person name', 
    trigger: 'blur'
  }
})

const clearPerson = () => {
  person.value.name = '';
  person.value.bio = '';
}

const addPerson = async () => {
  if (!person.value.name) {
    ElMessage.error('Please enter person name');
    return;
  }
  try {
    const res = await personAddService(person.value);
    if (res.code === 0) {
      ElMessage.success('Person added');
      clearPerson();
    }
    else {
      throw Error(res.message || 'failed to add person');
    }
  }
  catch (error) {
    ElMessage.error('failed to add person');
    console.error(error);
  }
}
</script>

<template>
  <el-card>
    <el-form
      :model="person"
      :rules="personRules"
    >
    <el-form-item label="Name" prop="name">
      <el-input v-model="person.name" />
    </el-form-item>
    <el-form-item label="Biography">
      <el-input v-model="person.bio" />
    </el-form-item>
    </el-form>
    <el-button @click="clearPerson">Clear</el-button>
    <el-button type="primary" @click="addPerson">Add</el-button>
  </el-card>
</template>