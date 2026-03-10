<script setup>
import { useUserInfoStore } from '@/stores/userinfo';
import { useRouter } from 'vue-router';
import { ref } from 'vue';
import { getRoleService } from '@/api/user';

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

</script>

<template>
  <p>add media page</p>
</template>