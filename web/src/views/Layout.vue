<script setup>
import { useUserInfoStore } from '@/stores/userinfo';
import { useRouter } from 'vue-router';
import { Document, User, Search } from '@element-plus/icons-vue';

const router = useRouter();
const userInfoStore = useUserInfoStore();
const search = () => {
    console.log('searching')
}
</script>

<template>
    <h1>Welcom to MediaBase</h1>
    <el-container>
        <el-aside class="left">
            <el-menu router>
                <el-menu-item index="/media_library">
                    <el-icon><Document /></el-icon>
                    <span>Media Library</span>
                </el-menu-item>
                <el-menu-item index="/me">
                    <el-icon><User /></el-icon>
                    <span>Me</span>
                </el-menu-item>
                <el-menu-item index="/search">
                    <el-icon><Search /></el-icon>
                    <span>Search</span>
                </el-menu-item>
            </el-menu>
        </el-aside>
        <el-aside class="right">
            <el-header class="header">
                 <div v-if="userInfoStore.info && userInfoStore.info.name">
                     <span>{{ userInfoStore.info.name }}</span>
                     <el-dropdown>
                         <!-- <el-avatar></el-avatar> -->
                         <span>avatar</span>
                         <!-- <span class="el-dropdown-link">
                             Dropdown List<i class="el-icon-arrow-down el-icon--right"></i>
                         </span> -->
                         <template #dropdown>
                             <el-dropdown-menu>
                                 <el-dropdown-item>Profile</el-dropdown-item>
                                 <el-dropdown-item>Logout</el-dropdown-item>
                             </el-dropdown-menu>
                         </template>
                     </el-dropdown>
                 </div>
                 <div v-else>
                    <el-button @click="router.push('/login')">Sign in</el-button>
                    <el-button @click="router.push('/register')">Sign up</el-button>
                 </div>
            </el-header>
            <el-main>
                <router-view />
            </el-main>
            <el-footer>MediaBase2026</el-footer>
        </el-aside>
    </el-container>
</template>

<style scoped>
    .container {
        width: 100vw;
        height: 100vh;
    }
    .left {
        width: 20%;
    }
    .right {
        width: 80%;
    }
    .header {
        height: 60px;
        /* display: flex;
        justify-content: space-between;
        align-items: center; */
    }
</style>