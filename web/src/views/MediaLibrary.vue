<script setup>
import { mediaListService } from '@/api/media.js'
import { ref } from 'vue'
const mediaList = ref([{
    "id": 1,
    "title": "Example Media",
    "type": "image",
    "created_at": "2024-06-01T12:00:00Z"
}])
const getMediaList = async () => {
     const result = await mediaListService();
     mediaList.value = result.data;
}
getMediaList();
const keyWord = ref('');
</script>


<template>
    <h1>Media Library</h1>
    <el-card class="container">
        <template #header>
            <span>Media Library</span>
        </template>
        <el-input v-model="keyWord" placeholder="Search for media"></el-input>
        <el-button type="primary" @click="search">Browse for Media</el-button>
        <el-table :data="mediaList" style="width: 100%">
            <el-table-column prop="id" label="ID" width="180" />
            <el-table-column prop="title" label="Title" width="180" />
            <el-table-column prop="type" label="Type" width="180" />
        </el-table>
    </el-card>
</template>

<style scoped>
    .container {
        width: 100%;
        height: 100%;
    }
</style>