<script setup>
import { useUserInfoStore } from '@/stores/userinfo';
import { useRouter } from 'vue-router';
import { ref } from 'vue';
import { getRoleService } from '@/api/user';
import AddPerson from './AddPerson.vue';
import AddBook from './AddBook.vue';
import AddMovie from './AddMovie.vue';
import AddMusic from './AddMusic.vue';
import AddTv from './AddTv.vue';

const userInfoStore = useUserInfoStore();
const router = useRouter();

const admin = ref(false);

const checkRole = async () => {
  if (!userInfoStore.info.id) return;
  try {
    const res = await getRoleService();
    if (res.code === 0 && res.data === true) {
      admin.value = res.data;
    }
    else {
      throw Error('failed to get role');
    }
  } catch (error) {
    console.error(error);
    router.push('/media_library');
  }
}

checkRole();

const activeTab = ref('medium');

const activeMediumTab = ref('book');

</script>

<template>
  <p>add page</p>
  <el-tabs v-model="activeTab">
    <el-tab-pane label="Add Medium" name="medium">
      <el-card>
        <el-tabs v-model="activeMediumTab">
          <el-tab-pane label="Add Book" name="book">
            <AddBook />
          </el-tab-pane>
          <el-tab-pane label="Add Movie" name="movie">
            <AddMovie />
          </el-tab-pane>
          <el-tab-pane label="Add Music" name="music">
            <AddMusic />
          </el-tab-pane>
          <el-tab-pane label="Add Tv" name="tv">
            <AddTv />
          </el-tab-pane>
        </el-tabs>
      </el-card>
    </el-tab-pane>
    <el-tab-pane label="Add Person" name="person">
      <AddPerson />
    </el-tab-pane>
  </el-tabs>
</template>