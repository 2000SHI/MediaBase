<script setup>
import { mediaDetailService } from '@/api/media';
import { useRoute, useRouter } from 'vue-router'
import { ref } from 'vue';
import { ElMessage } from 'element-plus';
import { Back } from '@element-plus/icons-vue';
import Book from '@/views/Book.vue';
import Movie from './Movie.vue';
import Tv from './Tv.vue';
import Music from './Music.vue';

const route = useRoute();
const id = route.params.id;
const data = ref(null);

const router = useRouter();

const getDetail = async () => {
  try {
    const res = await mediaDetailService(id);
    if (res.code === 0) {
      data.value = res.data;
    }
    else {
      throw Error(res.message || 'error');
    }
  } catch (error) {
    console.error('Failed to get detail:', error);
    ElMessage.error('error');
  }
}

getDetail();

</script>

<template>
  <!-- <el-button @click="router.push('/media_library')">
    <el-icon><Back /></el-icon>
  </el-button> -->
  <p>media detail</p>
  <Book v-if="data && data.type === 'book'" :data="data" />
  <Movie v-if="data && data.type === 'movie'" :data="data" />
  <Tv v-if="data && data.type === 'tv'" :data="data" />
  <Music v-if="data && data.type === 'music'" :data="data" />
</template>