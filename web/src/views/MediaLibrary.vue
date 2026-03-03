<script setup>
import { mediaListService } from '@/api/media.js'
import { ref } from 'vue'

const mediaList = ref([]);

const currPage = ref(1);
const pageSize = ref(5);
const total = ref(0);

const types = ref(new Set());

const selectAll = () => {
    types.value = new Set(['movie', 'tv', 'book', 'music']);
}

const unselectAll = () => {
    types.value = new Set();
}

const getMediaList = async () => {
    const params = {
        pageNum: currPage.value,
        pageSize: pageSize.value,
        types: Array.from(types.value).join(','),
    }
    const result = await mediaListService(params);
    mediaList.value = result.data;
    total.value = result.data.total;
}

getMediaList();

const onSizeChange = (size) => {
    pageSize.value = size;
    getMediaList();
}

const onCurrentChange = (page) => {
    currPage.value = page;
    getMediaList();
}

</script>


<template>
    <el-card class="container">
        <template #header>
            <span>Media Library</span>
        </template>
        <el-button :disabled="types.size === 4" @click="selectAll">Select All</el-button>
        <el-button :disabled="types.size === 0" @click="unselectAll">Unselect All</el-button>
        <el-button
            v-for="type in ['movie', 'tv', 'book', 'music']"
            :key="type"
            :type="types.has(type) ? 'primary' : 'default'"
            @click="() => types.has(type) ? types.delete(type) : types.add(type)"
        >
            {{ type }}
        </el-button>
        <el-button type="primary" @click="getMediaList">Browse for Media</el-button>
        <!-- <el-table :data="mediaList" style="width: 100%">
            <el-table-column prop="id" label="ID" width="180" />
            <el-table-column prop="title" label="Title" width="180" />
            <el-table-column prop="type" label="Type" width="180" />
        </el-table> -->
        <el-card v-for="media in mediaList.items" :key="media.id" style="margin-top: 20px">
            <p class="title">{{ media.title }}</p>
            <p>{{ media.type }}</p>
            <p v-if="media.description">{{ media.description }}</p>
            <p>release: {{ media.releaseDate }}</p>
        </el-card>
        <el-pagination
            v-model:current-page="currPage"
            v-model:page-size="pageSize"
            :page-sizes="[5, 10, 20]"
            layout="jumper, total, sizes, prev, pager, next"
            background :total="total"
            @size-change="onSizeChange"
            @current-change="onCurrentChange"
        />
    </el-card>
</template>

<style scoped>
    .container {
        width: 100%;
        height: 100%;
    }
    .title {
        font-size: 24px;
        font-weight: bold;
    }
</style>