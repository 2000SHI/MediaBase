<script setup>
import { personFindService } from '@/api/person';
import { ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { Back } from '@element-plus/icons-vue';

const route = useRoute();
const router = useRouter();
const id = route.params.id;

const personData = ref(null)

const getData = async () => {
  try {
    const res = await personFindService({ id: id });
    if (res.code == 0) {
      personData.value = res.data;
    }
    else {
      throw Error(res.message || 'error');
    }
  } catch (error) {
    console.error('Failed to get detail:', error);
    ElMessage.error('error');
  }
}

getData();

</script>

<template>
  <!-- <el-button @click="router.push('/search')">
    <el-icon><Back /></el-icon>
  </el-button> -->
  <div v-if="personData">
    <p class="title">{{ personData.name }}</p>
    <p v-if="personData.bio">{{ personData.bio }}</p>
  </div>
</template>

<style scoped>
  .title {
    font-size: large;
    font-weight: bold;
  }
</style>