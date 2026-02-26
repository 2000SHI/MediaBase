<script setup>
    import { useUserInfoStore } from '@/stores/userinfo';
    const userInfoStore = useUserInfoStore();
</script>

<template>
    <h1>Me</h1>
    <el-card>
        <template #header>
            <span>My Profile</span>
        </template>
        <div v-if="userInfoStore.info && userInfoStore.info.name">
            <img v-if="userInfoStore.info.avatar" :src="userInfoStore.info.avatar" alt="Avatar">
            <p v-else>No Avatar</p>
            <p>Name: {{ userInfoStore.info.name }}</p>
            <p>Email: {{ userInfoStore.info.email }}</p>
        </div>
        <div v-else>
            <p>Please sign in to view your profile information.</p>
        </div>
    </el-card>
</template>