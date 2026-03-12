<script setup>
import { getPeople, requiredRule, getDateString } from '@/utils/addMedium';
import { ref } from 'vue';
import { Close } from '@element-plus/icons-vue';
import { ElMessage } from 'element-plus';
import { addService } from '@/api/media';

const people = ref([]);

const fetchPeople = async () => {
  people.value = await getPeople();
}

fetchPeople();

const book = ref({
  type: 'book',
  title: '',
  description: '',
  releaseDate: '',
  publisher: ''
})

const bookRules = ({
  title: [requiredRule],
  releaseDate: [{ type: 'date', ...requiredRule }],
  publisher: [requiredRule]
})

const bookPeople = ref([]);
const newPerson = ref(null);
const role = ref('');

const addContributor = () => {
  if (!newPerson.value || !role.value) {
    ElMessage.error('Please select the person and the role');
    return;
  }
  bookPeople.value.push({
    id: newPerson.value.id,
    name: newPerson.value.name,
    role: role.value
  });
  newPerson.value = null;
  role.value = '';
}

const checkParams = () => {
  if (!book.value.title) {
    ElMessage.error('please enter book title');
    return false;
  }
  if (!book.value.releaseDate) {
    ElMessage.error('please enter book release date');
    return false;
  }
  if (!book.value.publisher) {
    ElMessage.error('please enter book publisher');
    return false;
  }
  return true;
}

const addMedium = async () => {
  if (!checkParams()) return;
  const res = await addService({
    ...book.value,
    releaseDate: getDateString(book.value.releaseDate),
    contributor: bookPeople.value
  });
  if (res.code === 0) {
    book.value.title = '';
    book.value.description = '';
    book.value.releaseDate = null;
    book.value.publisher = '';
  }
  ElMessage.success('Added successfully');
}
      
getPeople();

</script>

<template>
  <el-form
    :model="book"
    :rules="bookRules"
  >
    <el-form-item label="Title" prop="title">
      <el-input v-model="book.title" />
    </el-form-item>
    <el-form-item label="Description">
      <el-input v-model="book.description" />
    </el-form-item>
    <el-form-item label="Release Date" prop="releaseDate">
      <el-date-picker
        v-model="book.releaseDate"
        type="date"
        placeholder="Pick a date"
      />
    </el-form-item>
    <el-form-item label="Publisher" prop="publisher">
      <el-input v-model="book.publisher" />
    </el-form-item>
  </el-form>
  <hr>
  <p>
    Contributors
  </p>
  <el-table :data="bookPeople">
    <el-table-column prop="name" label="Name" />
    <el-table-column prop="role" label="Role" />
    <el-table-column prop="characterName" label="Character" />
    <el-table-column fixed="right">
      <template #default="scope">
        <el-button
          type="danger"
          size="small"
          @click.prevent="bookPeople.splice(scope.$index, 1);"
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
    <el-option label="author" value="author" />
  </el-select>
  <el-button type="primary" @click="addContributor('book');">
    Add Contributor
  </el-button>
  <hr>
  <el-button type="primary" size="large" @click="addMedium('book');">
    Add Book
  </el-button>
</template>