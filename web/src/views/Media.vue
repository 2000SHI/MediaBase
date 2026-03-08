<script setup>
import { mediaDetailService, mediaPeopleService } from '@/api/media';
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
const people = ref([]);

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

const getPeople = async () => {
  try {
    const res = await mediaPeopleService(id);
    if (res.code === 0) {
      for (const person of res.data) {
        people.value.push({
          id: person.personId,
          name: person.name,
          role: person.role + person.character
        })
      }
    }
    else {
      throw Error(res.message || 'error');
    }
  } catch (error) {
    console.error('Failed to get media people:', error);
    ElMessage.error('error');
  }
}

getDetail();
getPeople();

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
  <card v-if="people">
    <p>Contributors</p>
    <el-table :data="people">
      <el-table-column label="Name">
        <template #default="{ row }">
          <el-button
            link
            type="primary"
            @click="router.push(`/person/${row.id}`)"
          >
            {{ row.name }}
          </el-button>
        </template>
      </el-table-column>
      <el-table-column prop="role" label="Role" />
    </el-table>
  </card>
</template>