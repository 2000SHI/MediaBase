<script setup>
import { personFindService, personMediaService } from '@/api/person';
import { ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { Back } from '@element-plus/icons-vue';

const route = useRoute();
const router = useRouter();
const id = route.params.id;

const personData = ref(null)
const media = ref([])

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

const getMedia = async () => {
  try {
    const res = await personMediaService({ id: id });
    if (res.code == 0) {
      for (const medium of res.data) {
        media.value.push({
          id: medium.mediaId,
          title: medium.title,
          roles: medium.roles.join(',')
        })
      }
    }
    else {
      throw Error(res.message || 'error');
    }
  } catch (error) {
    console.error('Failed to get media:', error);
    ElMessage.error('error');
  }
}

getData();
getMedia();

</script>

<template>
  <!-- <el-button @click="router.push('/search')">
    <el-icon><Back /></el-icon>
  </el-button> -->
  <div v-if="personData">
    <p class="title">{{ personData.name }}</p>
    <p v-if="personData.bio">{{ personData.bio }}</p>
  </div>
  <card v-if="media">
    <p>Known for</p>
    <el-table :data="media">
      <el-table-column label="Title">
        <template #default="{ row }">
          <el-button
            link
            type="primary"
            @click="router.push(`/media_library/${row.id}`)"
          >
            {{ row.title }}
          </el-button>
        </template>
      </el-table-column>
      <el-table-column prop="roles" label="Role" />
    </el-table>
  </card>
</template>

<style scoped>
  .title {
    font-size: large;
    font-weight: bold;
  }
</style>