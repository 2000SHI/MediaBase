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

const movie = ref({
  type: 'movie',
  title: '',
  description: '',
  releaseDate: '',
  durationMinutes: null,
  rating: ''
})

const movieRules = ({
  title: [requiredRule],
  releaseDate: [{ type: 'date', ...requiredRule }],
  durationMinutes: [posNumRule],
  rating: [requiredRule]
})

const moviePeople = ref([]);
const newPerson = ref(null);
const role = ref('');
const character = ref('');

const addContributor = () => {
  if (!newPerson.value || !role.value) {
    ElMessage.error('Please select the person and the role');
    return;
  }
  moviePeople.value.push({
    id: newPerson.value.id,
    name: newPerson.value.name,
    role: role.value,
    characterName: character.value || null
  });
  newPerson.value = null;
  role.value = '';
  character.value = null;
}

const checkParams = () => {
  if (!movie.value.title) {
    ElMessage.error('please enter movie title');
    return false;
  }
  if (!movie.value.releaseDate) {
    ElMessage.error('please enter movie release date');
    return false;
  }
  if (!movie.value.rating) {
    ElMessage.error('please enter movie rating');
    return false;
  }
  if (!movie.value.durationMinutes) {
    ElMessage.error('please enter movie duration');
    return false;
  }
  return true;
}

const addMedium = async () => {
  if (!checkParams()) return;
  const res = await addService({
    ...movie.value,
    releaseDate: getDateString(movie.value.releaseDate),
    contributor: moviePeople.value
  });
  if (res.code === 0) {
    movie.value.title = '';
    movie.value.description = '';
    movie.value.releaseDate = null;
    movie.value.rating = '';
    movie.value.durationMinutes = null;
  }
  ElMessage.success('Added successfully');
}
      
getPeople();

</script>

<template>
  <el-form
    :model="movie"
    :rules="movieRules"
  >
    <el-form-item label="Title" prop="title">
      <el-input v-model="movie.title" />
    </el-form-item>
    <el-form-item label="Description">
      <el-input v-model="movie.description" />
    </el-form-item>
    <el-form-item label="Release Date"  prop="releaseDate">
      <el-date-picker
        v-model="movie.releaseDate"
        type="date"
        placeholder="Pick a date"
      />
    </el-form-item>
    <el-form-item label="Duration Minutes"  prop="durationMinutes">
      <el-input-number v-model="movie.durationMinutes" :min="1" />
    </el-form-item>
    <el-form-item label="Rating"  prop="rating">
      <el-select v-model="movie.rating" placeholder="please select movie rating">
        <el-option label="Not Rated" value="Not Rated" />
        <el-option label="G" value="G" />
        <el-option label="PG" value="PG" />
        <el-option label="PG-13" value="PG-13" />
        <el-option label="R" value="R" />
        <el-option label="NC-17" value="NC-17" />
      </el-select>
    </el-form-item>
  </el-form>
  <hr>
  <p>
    Contributors
  </p>
  <el-table :data="moviePeople">
    <el-table-column prop="name" label="Name" />
    <el-table-column prop="role" label="Role" />
    <el-table-column prop="characterName" label="Character" />
    <el-table-column fixed="right">
      <template #default="scope">
        <el-button
          type="danger"
          size="small"
          @click.prevent="moviePeople.splice(scope.$index, 1);"
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
    <el-option label="director" value="director" />
    <el-option label="writer" value="writer" />
    <el-option label="cast" value="cast" />
  </el-select>
  <el-input v-if="role === 'cast'" v-model="character" placeholder="enter the character name" />
  <el-button type="primary" @click="addContributor('movie');">
    Add Contributor
  </el-button>
  <hr>
  <el-button type="primary" size="large" @click="addMedium('movie');">
    Add Movie
  </el-button>
</template>