<script setup>
import { searchService } from '@/api/global';
import { ref } from 'vue'

const keyword = ref('');
const result = ref([]);

const currPage = ref(1);
const pageSize = ref(5);
const total = ref(0);

const types = ref(new Set());

const selectAll = () => {
    types.value = new Set(['movie', 'tv', 'book', 'music', 'person']);
}

const unselectAll = () => {
    types.value = new Set();
}

const search = async () => {
    const pageParams = {
        pageNum: currPage.value,
        pageSize: pageSize.value,
    }
    const filter = {
        types: Array.from(types.value),
        keyword: keyword.value,
    }
    const resBody = await searchService(pageParams, filter);
    result.value = resBody.data;
    total.value = resBody.data.total;
}

const onSizeChange = (size) => {
    pageSize.value = size;
    search();
}

const onCurrentChange = (page) => {
    currPage.value = page;
    search();
}

</script>

<template>
    <el-card class="container">    
        <template #header>
            <span>Search</span>
        </template>
        <el-button :disabled="types.size === 4" @click="selectAll">Select All</el-button>
        <el-button :disabled="types.size === 0" @click="unselectAll">Unselect All</el-button>
        <el-button
            v-for="type in ['movie', 'tv', 'book', 'music', 'person']"
            :key="type"
            :type="types.has(type) ? 'primary' : 'default'"
            @click="() => types.has(type) ? types.delete(type) : types.add(type)"
        >
            {{ type }}
        </el-button>
        <el-input v-model="keyword" placeholder="Input keyword"></el-input>
        <el-button @click="search" type="primary">Search</el-button>
        <el-card v-for="item in result.items" :key="item.id" style="margin-top: 20px">
            <div v-if="item.type">
                <p class="title">{{ item.title }}</p>
                <p>{{ item.type }}</p>
                <p v-if="item.description">{{ item.description }}</p>
                <p>release: {{ item.releaseDate }}</p>
            </div>
            <div v-else>
                <p class="title">{{  item.name  }}</p>
                <p v-if="item.bio">{{  item.bio  }}</p>
            </div>
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