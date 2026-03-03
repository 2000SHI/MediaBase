<script setup>
import { useUserInfoStore } from '@/stores/userinfo';
import { useRouter } from 'vue-router';
import { Document, User, Search } from '@element-plus/icons-vue';
import avater from '@/assets/default-avater.avif';
import { useTokenStore } from '@/stores/token';

const router = useRouter();
const userInfoStore = useUserInfoStore();
const tokenStore = useTokenStore();

const handleCommand = (command) => {
  if (command === 'logout') {
      userInfoStore.removeInfo();
      tokenStore.removeToken();
      router.push('/login');
} else {
    router.push('/me');
  }
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
                 <div v-if="userInfoStore.info && userInfoStore.info.username">
                     <span>{{ userInfoStore.info.username }}</span>
                     <el-dropdown @command="handleCommand">
                         <!-- <el-avatar></el-avatar> -->
                         <el-avatar :src="userInfoStore.info.avatar || avater" />
                         <!-- <span class="el-dropdown-link">
                             Dropdown List<i class="el-icon-arrow-down el-icon--right"></i>
                         </span> -->
                         <template #dropdown>
                             <el-dropdown-menu>
                                <el-dropdown-item command="me">Profile</el-dropdown-item>
                                <el-dropdown-item command="logout">Logout</el-dropdown-item>
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