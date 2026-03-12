<script setup>
import { getPeople, requiredRule, posNumRule, getDateString  } from '@/utils/addMedium';
import { ref } from 'vue';
import { Close } from '@element-plus/icons-vue';
import { ElMessage } from 'element-plus';
import { addService } from '@/api/media';

const people = ref([]);

const fetchPeople = async () => {
  people.value = await getPeople();
}

fetchPeople();

const tv = ref({
  type: 'tv',
  title: '',
  description: '',
  releaseDate: '',
  seasons: null
})

const tvRules = ({
  title: [requiredRule],
  releaseDate: [{ type: 'date', ...requiredRule }],
  seasons: [posNumRule]
})

const tvPeople = ref([]);
const newPerson = ref(null);
const role = ref('');
const character = ref('');

const addContributor = () => {
  if (!newPerson.value || !role.value) {
    ElMessage.error('Please select the person and the role');
    return;
  }
  tvPeople.value.push({
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
  if (!tv.value.title) {
    ElMessage.error('please enter tv title');
    return false;
  }
  if (!tv.value.releaseDate) {
    ElMessage.error('please enter tv release date');
    return false;
  }
  if (!tv.value.seasons) {
    ElMessage.error('please enter tv seasons');
    return false;
  }
  return true;
}

const addMedium = async () => {
  if (!checkParams()) return;
  const res = await addService({
    ...tv.value,
    releaseDate: getDateString(tv.value.releaseDate),
    contributor: tvPeople.value
  });
  if (res.code === 0) {
    tv.value.title = '';
    tv.value.description = '';
    tv.value.releaseDate = null;
    tv.value.seasons = null;
  }
  ElMessage.success('Added successfully');
}
      
getPeople();

</script>

<template>
  <el-form
    :model="tv"
    :rules="tvRules"
  >
    <el-form-item label="Title" prop="title">
      <el-input v-model="tv.title" />
    </el-form-item>
    <el-form-item label="Description">
      <el-input v-model="tv.description" />
    </el-form-item>
    <el-form-item label="Release Date" prop="releaseDate">
      <el-date-picker
        v-model="tv.releaseDate"
        type="date"
        placeholder="Pick a date"
      />
    </el-form-item>
    <el-form-item label="Seasons" prop="seasons">
      <el-input-number v-model="tv.seasons" :min="1" />
    </el-form-item>
  </el-form>
  <hr>
  <p>
    Contributors
  </p>
  <el-table :data="tvPeople">
    <el-table-column prop="name" label="Name" />
    <el-table-column prop="role" label="Role" />
    <el-table-column prop="characterName" label="Character" />
    <el-table-column fixed="right">
      <template #default="scope">
        <el-button
          type="danger"
          size="small"
          @click.prevent="tvPeople.splice(scope.$index, 1);"
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
    <el-option label="creator" value="creator" />
    <el-option label="cast" value="cast" />
  </el-select>
  <el-input v-if="role === 'cast'" v-model="character" placeholder="enter the character name" />
  <el-button type="primary" @click="addContributor('tv');">
    Add Contributor
  </el-button>
  <hr>
  <el-button type="primary" size="large" @click="addMedium('movie');">
    Add Tv
  </el-button>
</template>