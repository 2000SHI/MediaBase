<script setup>
import { ElMessage } from 'element-plus';
import { ref } from 'vue';
import { onBeforeUnmount } from 'vue';
import { useUserInfoStore } from '@/stores/userinfo';
import { userInfoService, updateService, uploadAvatarService, updatePwdService } from '@/api/user';

const userInfoStore = useUserInfoStore();

const uploading = ref(false);
const imgUrl = ref(userInfoStore.info.avatar);
let imgFile = null;

const edit = ref(false);
const newName = ref(userInfoStore.info.username);

const changing = ref(false);
const pwdData = ref({
  oldPwd: '',
  newPwd: '',
  rePwd: ''
})

const validateRePass = (rule, value, callback) => {
  if (value === '') {
    callback(new Error('Please input the password again'))
  } else if (value !== pwdData.value.newPwd) {
    callback(new Error("Two passwords don't match!"))
  } else {
    callback()
  }
}

const rules = ({
    oldPwd: [
      {
        required: true,
        message: 'please enter your old password', 
        trigger: 'blur'
      },
      {
        min: 6,
        max: 16,
        messaged: 'password length should be 6-16 characters',
        trigger: 'blur'
      }
    ],
    newPwd: [
      {
        required: true,
        message: 'please enter your new password', 
        trigger: 'blur'
      },
      {
        min: 6,
        max: 16,
        message: 'password length should be 6-16 characters',
        trigger: 'blur'
      }
    ],
    rePwd: [{ validator: validateRePass, trigger: 'blur' }],
  })

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

const cancelEdit = () => {
  edit.value = false;
  newName.value = userInfoStore.info.username;
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

const confirmAvatar = async () => {
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

const cancelChange = () => {
  changing.value = false;
  pwdData.value.oldPwd = '';
  pwdData.value.newPwd = '';
  pwdData.value.rePwd = '';
}

const confirmChange = async () => {
  const params = {
    old_pwd: pwdData.value.oldPwd,
    new_pwd: pwdData.value.newPwd,
    re_pwd: pwdData.value.rePwd
  }
  try {
    const res = await updatePwdService(params);
    if (res.code === 0) {
      ElMessage.success('Change successfully');
      changing.value = false;
      pwdData.value.oldPwd = '';
      pwdData.value.newPwd = '';
      pwdData.value.rePwd = '';
    }
  } catch (error) {
    console.error('Failed to change password:', error);
    ElMessage.error('change failed');
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
        <el-button @click="confirmAvatar()">Confirm</el-button>
      </div>
      <p>Basic Information</p>
      <el-button
        v-if="!edit"
        type="primary"
        @click="edit = true"
      >
        Edit Profile
      </el-button>
      <div v-else>
        <p>Edit Mode</p>
        <el-button @click="saveEdit">Save</el-button>
        <el-button @click="cancelEdit()">Cancel</el-button>
      </div>
      <!-- <p v-if="!edit">Name: {{ userInfoStore.info.username }}</p> -->
      <p>Name: <input v-model="newName" :disabled="!edit"/></p>
      <p>Email: {{ userInfoStore.info.email }}</p>
      <el-button v-if="!changing" type="primary" @click="changing = true">
        Change Password
      </el-button>
      <div v-else>
        <el-button @click="cancelChange()">
          Cancel
        </el-button>
        <el-button @click="confirmChange()">
          Confirm
        </el-button>
        <el-form
          :model="pwdData"
          :rules="rules"
        >
          <el-form-item label="Old Password" prop="oldPwd">
            <el-input type="password" v-model="pwdData.oldPwd" placeholder="Enter the old password" />
          </el-form-item>
          <el-form-item label="New Password" prop="newPwd">
            <el-input type="password" v-model="pwdData.newPwd" placeholder="Enter the new password" autocomplete="off" />
          </el-form-item>
          <el-form-item label="Confirm Password" prop="rePwd">
            <el-input type="password" v-model="pwdData.rePwd" placeholder="Confirm the new password" />
          </el-form-item>
        </el-form>
      </div>
    </div>
    <div v-else>
      <p>Please sign in to view your profile information.</p>
    </div>
  </el-card>
</template>