<script setup>
import {
  mediaDetailService,
  mediaPeopleService,
  getRateService,
  addRateService,
  updateRateService,
  getCommentService,
  addCommentService,
  deleteCommentService
} from '@/api/media';
import { useRoute, useRouter } from 'vue-router'
import { ref } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';
import { Back } from '@element-plus/icons-vue';
import Book from '@/views/Book.vue';
import Movie from './Movie.vue';
import Tv from './Tv.vue';
import Music from './Music.vue';
import { useUserInfoStore } from '@/stores/userinfo';
import { userInfoService } from '@/api/user';

const route = useRoute();
const id = route.params.id;
const data = ref(null);
const people = ref([]);

const userInfoStore = useUserInfoStore();

const dialog = ref(false);

const router = useRouter();

const getDetail = async () => {
  try {
    const res = await mediaDetailService(id);
    if (res.code === 0) {
      data.value = res.data;
    }
    else {
      throw Error(res.message || 'error');
    }
  } catch (error) {
    console.error('Failed to get detail:', error);
    ElMessage.error('error');
  }
}

const getPeople = async () => {
  try {
    const res = await mediaPeopleService(id);
    if (res.code === 0) {
      console.log(res.data);
      for (const person of res.data) {
        people.value.push({
          id: person.personId,
          name: person.name,
          role: person.characterName ? person.role + ' as ' + person.characterName : person.role
        })
      }
    }
    else {
      throw Error(res.message || 'error');
    }
  } catch (error) {
    console.error('Failed to get media people:', error);
    ElMessage.error('error');
  }
}

getDetail();
getPeople();

const rate = ref(null);
const comments = ref([]);
const updateRate = ref(false);
const newRate = ref(null);
const editComment = ref(false);
const newComment = ref('');

const rateValues = [
  { value: 0, label: 0 },
  { value: 1, label: 1 },
  { value: 2, label: 2 },
  { value: 3, label: 3 },
  { value: 4, label: 4 },
  { value: 5, label: 5 },
  { value: 6, label: 6 },
  { value: 7, label: 7 },
  { value: 8, label: 8 },
  { value: 9, label: 9 },
  { value: 10, label: 10 }
]

const getUserReview = async () => {
  if (userInfoStore.info.id) {
    try {
      const rateRes = await getRateService(data.value.id);
      if (rateRes.code === 0) {
        rate.value = rateRes.data;
      }
      else {
        throw Error(rateRes.message || 'failed to get rate');
      }
      const commentsRes = await getCommentService(data.value.id);
      if (commentsRes.code === 0) {
        comments.value = commentsRes.data;
      }
      else {
        throw Error(rateRes.message || 'failed to get comments');
      }
      console.log(rateRes);
      console.log(commentsRes);
    } catch (error) {
      console.error('Failed to fetch rate & comments', error);
      ElMessage.error('Failed to fetch rate & comments');
    }
  }
}

const showDialog = async () => {
  if (userInfoStore.info.id) {
    await getUserReview();
    dialog.value = true;
  }
  else {
    ElMessage.error('Please Login');
    router.push('/login');
  }
}

const confirmRate = async () => {
  if (!data.value.id) {
    ElMessage.error('Loading... Please try again later');
    return;
  }
  if (newRate.value === null) {
    ElMessage.error('Please select your rate');
    return;
  }
  try {
    let res = null;
    const params = {
      mediaId: data.value.id,
      score: newRate.value
    }
    if (rate.value !== null) {
      res = await updateRateService(params);
    }
    else {
      res = await addRateService(params);
    }
    if (res.code === 0) {
      ElMessage.success('Rated successfully');
      updateRate.value = false;
      newRate.value = null;
      await getUserReview();
    }
    else {
      throw Error(res.message || 'failed to rate');
    }
  } catch (error) {
    console.error('Failed to rate', error);
    ElMessage.error('Failed to rate');
  }
}

const cancelRate = () => {
  updateRate.value = false;
  newRate.value = null;
}

const confirmComment = async () => {
  if (!newComment.value) {
    ElMessage.error('Please enter your comment');
    return;
  }
  try {
    const params = {
      mediaId: data.value.id,
      comment: newComment.value
    }
    const res = await addCommentService(params);
    if (res.code === 0) {
      ElMessage.success('Comment added');
      editComment.value = false;
      newComment.value = '';
      getDetail();
      getUserReview();
    }
    else {
      throw Error(res.message || 'failed to comment');
    }
  } catch (error) {
    console.error('Failed to comment', error);
    ElMessage.error('Failed to comment');
  }
}

const cancelComment = () => {
  newComment.value = '';
  editComment.value = false;
}

const confirmDelete = (id) => {
  ElMessageBox.confirm(
    'Are you sure you want to delete this comment?',
    'Warning',
    {
      confirmButtonText: 'OK',
      cancelButtonText: 'Cancel',
      type: 'warning',
    }
  )
  .then(() => {
    deleteComment(id)
  })
  .catch(() => {
    ElMessage.info({
      type: 'info',
      message: 'Delete canceled',
    })
  })
}

const deleteComment = async (id) => {
  try {
    const res = await deleteCommentService(id);
    if (res.code === 0) {
      ElMessage({
        type: 'success',
        message: 'Delete completed',
      });
      getDetail();
      getUserReview();
    }
    else {
      throw Error(rateRes.message || 'failed to delete comment');
    }
  } catch (error) {
    console.error('Failed to delete comment', error);
    ElMessage.error('Failed to delete comment');
  }
}

</script>

<template>
  <!-- <el-button @click="router.push('/media_library')">
    <el-icon><Back /></el-icon>
  </el-button> -->
  <p>media detail</p>
  <div v-if="data">
    <Book v-if="data && data.type === 'book'" :data="data" />
    <Movie v-if="data && data.type === 'movie'" :data="data" />
    <Tv v-if="data && data.type === 'tv'" :data="data" />
    <Music v-if="data && data.type === 'music'" :data="data" />
    <p>Rate: {{ data.rate ?? 'No Rated Yet' }}</p>
    <p v-if="!data.comments">No Comments Yet</p>
    <div v-if="data.comments">
      <p class="largeText">Comments</p>
      <div class="comment" v-for="comment in data.comments">
        <p class="username">{{ comment.username }}</p>
        <p>{{ comment.comment }}</p>
      </div>
    </div>
    <el-button type="primary" @click="showDialog">Rate & Comment</el-button>
    <el-dialog v-model="dialog" title="Rate & Comment">
      <div v-if="!updateRate">
        <div v-if="rate !== null">
          <p>My Rate: {{ rate }}</p>
          <el-button type="primary" @click="updateRate = true;">Change rate</el-button>
        </div>
        <div v-else>
          <span>Not rated</span>
          <el-button type="primary" @click="updateRate = true;">Rate now</el-button>
        </div>
      </div>
      <div v-else>
        <el-select v-model="newRate" placeholder="Choose your rate">
          <el-option
            v-for="rateValue in rateValues"
            :key="rateValue.value"
            :label="rateValue.label"
            :value="rateValue.value"
          />
        </el-select>
        <el-button type="primary" @click="confirmRate">Confirm</el-button>
        <el-button @click="cancelRate">Cancel</el-button>
      </div>
      <p>My Comments</p>
      <el-button v-if="!editComment" type="primary" @click="editComment = true">Add new</el-button>
      <div v-else>
        <el-input v-model="newComment" placeholder="enter your thought" />
        <el-button type="primary" @click="confirmComment">Confirm</el-button>
        <el-button @click="cancelComment">Cancel</el-button>
      </div>
      <div v-for="comment in comments">
        <p>{{ comment.comment }}</p>
        <el-button type="danger" @click="confirmDelete(comment.id)">Delete</el-button>
      </div>
    </el-dialog>
    <card v-if="people">
      <p class="largeText">Contributors</p>
      <el-table :data="people">
        <el-table-column label="Name">
          <template #default="{ row }">
            <el-button
              link
              type="primary"
              @click="router.push(`/person/${row.id}`)"
            >
              {{ row.name }}
            </el-button>
          </template>
        </el-table-column>
        <el-table-column prop="role" label="Role" />
      </el-table>
    </card>
  </div>
</template>

<style scoped>
  .largeText {
    font-size: large;
  }
  .comment {
    border-style: solid;
    border-width: 1px;
    border-color: gray;
  }
  .username {
    font-size: small;
    color: gray;
  }
</style>