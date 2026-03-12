<script setup>
import { getPeople, requiredRule, posNumRule, getDateString } from '@/utils/addMedium';
import { ref } from 'vue';
import { Close } from '@element-plus/icons-vue';
import { ElMessage } from 'element-plus';
import { addService } from '@/api/media';

const people = ref([]);

const fetchPeople = async () => {
  people.value = await getPeople();
}

fetchPeople();

const music = ref({
  type: 'music',
  title: '',
  description: '',
  releaseDate: '',
  album: '',
  durationSeconds: null
})

const musicRules = ({
  title: [requiredRule],
  releaseDate: [{ type: 'date', ...requiredRule }],
  album: [requiredRule],
  durationMinutes: [posNumRule]
})

const musicPeople = ref([]);
const newPerson = ref(null);
const role = ref('');

const addContributor = () => {
  if (!newPerson.value || !role.value) {
    ElMessage.error('Please select the person and the role');
    return;
  }
  musicPeople.value.push({
    id: newPerson.value.id,
    name: newPerson.value.name,
    role: role.value
  });
  newPerson.value = null;
  role.value = '';
}

const checkParams = () => {
  if (!music.value.title) {
    ElMessage.error('please enter music title');
    return false;
  }
  if (!music.value.releaseDate) {
    ElMessage.error('please enter music release date');
    return false;
  }
  if (!music.value.album) {
    ElMessage.error('please enter music album');
    return false;
  }
  if (!music.value.durationSeconds) {
    ElMessage.error('please enter music duration');
    return false;
  }
  return true;
}

const addMedium = async () => {
  if (!checkParams()) return;
  const res = await addService({
    ...music.value,
    releaseDate: getDateString(music.value.releaseDate),
    contributor: musicPeople.value
  });
  if (res.code === 0) {
    music.value.title = '';
    music.value.description = '';
    music.value.releaseDate = null;
    music.value.album = '';
    music.value.durationSeconds = null;
  }
  ElMessage.success('Added successfully');
}
      
getPeople();

</script>

<template>
  <el-form
    :model="music"
    :rules="musicRules"
  >
    <el-form-item label="Title" prop="title">
      <el-input v-model="music.title" />
    </el-form-item>
    <el-form-item label="Description">
      <el-input v-model="music.description" />
    </el-form-item>
    <el-form-item label="Release Date" prop="releaseDate">
      <el-date-picker
        v-model="music.releaseDate"
        type="date"
        placeholder="Pick a date"
      />
    </el-form-item>
    <el-form-item label="Album" prop="album">
      <el-input v-model="music.album" />
    </el-form-item>
    <el-form-item label="Duration Seconds" prop="durationSeconds">
      <el-input-number v-model="music.durationSeconds" :min="1" />
    </el-form-item>
  </el-form>
  <hr>
  <p>
    Contributors
  </p>
  <el-table :data="musicPeople">
    <el-table-column prop="name" label="Name" />
    <el-table-column prop="role" label="Role" />
    <el-table-column fixed="right">
      <template #default="scope">
        <el-button
          type="danger"
          size="small"
          @click.prevent="musicPeople.splice(scope.$index, 1);"
        >
          <el-icon><Close /></el-icon>
        </el-button>
      </template>
    </el-table-column>
  </el-table>
  <p>Add Contributor</p>
  <el-select v-model="newPerson" value-key="id" placeholder="select contributor">
    <el-option
      v-for="person in people"
      :key="person.id"
      :label="person.name"
      :value="{ id: person.id, name: person.name }"
    />
  </el-select>
  <el-select v-model="role" placeholder="select the role">
    <el-option label="artist" value="artist" />
    <el-option label="composer" value="composer" />
    <el-option label="lyricist" value="lyricist" />
  </el-select>
  <el-button type="primary" @click="addContributor('music');">
    Add Contributor
  </el-button>
  <hr>
  <el-button type="primary" size="large" @click="addMedium('music');">
    Add Music
  </el-button>
</template>