<script setup>
import { ElMessage } from 'element-plus';
import { ref } from 'vue';
import { onBeforeUnmount } from 'vue';
import { useUserInfoStore } from '@/stores/userinfo';
import { userInfoService, updateService, uploadAvatarService } from '@/api/user';

const userInfoStore = useUserInfoStore();

const uploading = ref(false);
const imgUrl = ref(userInfoStore.info.avatar);
let imgFile = null;

const edit = ref(false);
const newName = ref(userInfoStore.info.username);

const saveEdit = async () => {
  const params = {
    id: userInfoStore.info.id,
    username: newName.value,
    email: userInfoStore.info.email
  };
  try {
    const res = await updateService(params);
    console.log(res);
    if (res.code === 0) {
      ElMessage.success('Profile updated successfully');
      userInfoStore.setInfo({ ...userInfoStore.info, username: newName.value });
      uploading.value = false;
      edit.value = false;
    } else {
      throw Error(res.message || 'Update failed');
    }
  } catch (error) {
    console.error('Failed to update user info:', error);
    ElMessage.error('Update failed');
  }
}

const selectImg = (file) => {
  imgFile = file;
  const rawFile = file.raw;
  if (!rawFile) return;

  // Create preview URL
  imgUrl.value = URL.createObjectURL(rawFile);
  uploading.value = true;
}

onBeforeUnmount(() => {
  if (imgUrl.value && imgUrl.value.startsWith('blob:')) {
    URL.revokeObjectURL(imgUrl.value);
  }
})

const confirm = async () => {
  try {
    const res = await uploadAvatarService(imgFile.raw);
    if (res.code === 0) {
      ElMessage.success('Avatar updated successfully');
      uploading.value = false;
      imgFile = null;
      const infoRes = await userInfoService();
      userInfoStore.setInfo(infoRes.data);
      imgUrl.value = infoRes.data.avatar;
      console.log(imgUrl.value);
      URL.revokeObjectURL(imgUrl.value);
    } else {
      throw Error(res.message || 'Upload failed');
    }
  } catch (error) {
    console.error('Failed to upload avatar:', error);
    ElMessage.error('Failed to upload avatar');
  }
}

</script>

<template>
  <h1>Me</h1>
  <el-card>
    <template #header>
        <span>My Profile</span>
    </template>
    <div v-if="userInfoStore.info && userInfoStore.info.username">
      <el-avatar
        shape="square"
        size="large"
        v-if="userInfoStore.info.avatar"
        :src="imgUrl"
        alt="Avatar"
      />
      <p v-else>No Avatar</p>
      <el-upload
        :show-file-list="false"
        :auto-upload="false"
        accept="image/*"
        :on-change="selectImg"
      >
        <el-button
          v-if="!uploading"
          type="primary"
        >
          Change Avatar
        </el-button>
      </el-upload>
      <div v-if="uploading">
        <el-button @click="uploading = false">Cancel</el-button>
        <el-button @click="confirm()">Confirm</el-button>
      </div>
      <p>Basic Information</p>
      <el-button
        v-if="!edit"
        type="primary"
        @click="edit = !edit"
      >
        Edit Profile
      </el-button>
      <div v-else>
        <p>Edit Mode</p>
        <el-button @click="saveEdit">Save</el-button>
        <el-button @click="edit = false">Cancel</el-button>
      </div>
      <p v-if="!edit">Name: {{ userInfoStore.info.username }}</p>
      <p v-else>Name: <input v-model="newName" /></p>
      <p>Email: {{ userInfoStore.info.email }}</p>
    </div>
    <div v-else>
      <p>Please sign in to view your profile information.</p>
    </div>
  </el-card>
</template>