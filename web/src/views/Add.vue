<script setup>
import { useUserInfoStore } from '@/stores/userinfo';
import { useRouter } from 'vue-router';
import { ref } from 'vue';
import { getRoleService } from '@/api/user';
import { ElMessage } from 'element-plus';
import { personAddService, personListService } from '@/api/person';
import { Close } from '@element-plus/icons-vue';
import { addService } from '@/api/media';

const userInfoStore = useUserInfoStore();
const router = useRouter();

const admin = ref(false);

const checkRole = async () => {
  if (!userInfoStore.info.id) return;
  try {
    const res = await getRoleService();
    if (res.code === 0 && res.data === true) {
      admin.value = res.data;
    }
    else {
      throw Error('failed to get role');
    }
  } catch (error) {
    console.error(error);
    router.push('/media_library');
  }
}

checkRole();

const people = ref([]);

const getPeople = async () => {
  try {
    const res = await personListService();
    if (res.code === 0) {
      people.value = res.data;
    }
    else {
      throw Error('failed to get people');
    }
  }
  catch (error) {
    console.error(error);
  }
}

getPeople();

const requiredRule = {
  required: true,
  message: 'this field cannot be blank', 
  trigger: 'blur'
}

const posNumRule = {
  type: 'number',
  required: true,
  message: 'please enter a positive number',
  trigger: 'blur'
}

const activeTab = ref('medium');

const person = ref({
  name: '',
  bio: ''
})

const personRules = ({
  name: [requiredRule]
})

const clearPerson = () => {
  person.value.name = '';
  person.value.bio = '';
}

const addPerson = async () => {
  if (!person.value.name) {
    ElMessage.error('Please enter person name');
    return;
  }
  try {
    const res = await personAddService(person.value);
    if (res.code === 0) {
      ElMessage.success('Person added');
      clearPerson();
      getPeople();
    }
    else {
      throw Error(res.message || 'failed to add person');
    }
  }
  catch (error) {
    ElMessage.error('failed to add person');
    console.error(error);
  }
}

const activeMediumTab = ref('book');

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

const bookPeople = ref([]);
const moviePeople = ref([]);
const musicPeople = ref([]);
const tvPeople = ref([]);

const newPerson = ref(null);
const role = ref('');
const character = ref('');

const addContributor = (type) => {
  if (!newPerson.value || !role.value) {
    ElMessage.error('Please select the person and the role');
    return;
  }
  switch (type) {
    case 'book':
      bookPeople.value.push({
        id: newPerson.value.id,
        name: newPerson.value.name,
        role: role.value
      });
      newPerson.value = null;
      role.value = '';
      break;
    case 'movie':
      moviePeople.value.push({
        id: newPerson.value.id,
        name: newPerson.value.name,
        role: role.value,
        characterName: character.value || null
      });
      newPerson.value = null;
      role.value = '';
      character.value = null;
      break;
    case 'music':
      musicPeople.value.push({
        id: newPerson.value.id,
        name: newPerson.value.name,
        role: role.value
      });
      newPerson.value = null;
      role.value = '';
      break;
    case 'tv':
      tvPeople.value.push({
        id: newPerson.value.id,
        name: newPerson.value.name,
        role: role.value,
        characterName: character.value || null
      });
      newPerson.value = null;
      role.value = '';
      character.value = null;
      break;
    default:
      console.error('invalid type when adding contributor');
  }
}

const deleteContributor = (index, type) => {
  switch (type) {
    case 'book':
      bookPeople.value.splice(index, 1);
      break;
    case 'movie':
      moviePeople.value.splice(index, 1);
      break;
    case 'music':
      musicPeople.value.splice(index, 1);
      break;
    case 'tv':
      tvPeople.value.splice(index, 1);
      break;
    default:
      console.error('invalid type when adding contributor');
  }
}

const checkParams = (type) => {
  switch (type) {
    case 'book':
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
      break;
    case 'movie':
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
      break;
    case 'music':
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
      break;
    case 'tv':
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
      break;
    default:
      console.error('invalid type when adding contributor');
  }
  return true;
}

const getDateString = (date) => {
  return new Date(movie.value.releaseDate).toISOString().split('T')[0];
}

const addMedium = async (type) => {
  let res = null;
  switch (type) {
    case 'book':
      if (!checkParams('book')) return;
      res = await addService({
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
      break;
    case 'movie':
      if (!checkParams('movie')) return;
      res = await addService({
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
      break;
    case 'music':
      if (!checkParams('music')) return;
      res = await addService({
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
      break;
    case 'tv':
      if (!checkParams('tv')) return;
      res = await addService({
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
      break;
    default:
      console.error('invalid type when adding contributor');
      return;
  }
  ElMessage.success('Added successfully');
}

</script>

<template>
  <p>add page</p>
  <el-tabs v-model="activeTab">
    <el-tab-pane label="Add Medium" name="medium">
      <el-card>
        <el-tabs v-model="activeMediumTab">
          <el-tab-pane label="Add Book" name="book">
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
                    @click.prevent="deleteContributor(scope.$index, 'book')"
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
              <el-option label="writer" value="writer" />
            </el-select>
            <el-button type="primary" @click="addContributor('book');">
              Add Contributor
            </el-button>
            <br>
            <el-button type="primary" @click="addMedium('book');">
              Add Book
            </el-button>
          </el-tab-pane>
          <el-tab-pane label="Add Movie" name="movie">
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
                    @click.prevent="deleteContributor(scope.$index, 'movie')"
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
              <el-option label="writer" value="writer" />
              <el-option label="director" value="director" />
              <el-option label="cast" value="cast" />
            </el-select>
            <el-input v-if="role === 'cast'" v-model="character" placeholder="enter the character name" />
            <el-button type="primary" @click="addContributor('movie');">
              Add Contributor
            </el-button>
            <br>
            <el-button type="primary" @click="addMedium('movie');">
              Add Movie
            </el-button>
          </el-tab-pane>
          <el-tab-pane label="Add Music" name="music">
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
                    @click.prevent="deleteContributor(scope.$index, 'music')"
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
              <el-option label="composer" value="composer" />
              <el-option label="lyricist" value="lyricist" />
              <el-option label="artist" value="artist" />
            </el-select>
            <el-button type="primary" @click="addContributor('music');">
              Add Contributor
            </el-button>
            <br>
            <el-button type="primary" @click="addMedium('music');">
              Add Music
            </el-button>
          </el-tab-pane>
          <el-tab-pane label="Add Tv" name="tv">
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
                    @click.prevent="deleteContributor(scope.$index, 'tv')"
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
              <el-option label="cast" value="cast" />
              <el-option label="creator" value="creator" />
            </el-select>
            <el-input v-if="role === 'cast'" v-model="character" placeholder="enter the character name" />
            <el-button type="primary" @click="addContributor('tv');">
              Add Contributor
            </el-button>
            <br>
            <el-button type="primary" @click="addMedium('movie');">
              Add Tv
            </el-button>
          </el-tab-pane>
        </el-tabs>
      </el-card>
    </el-tab-pane>
    <el-tab-pane label="Add Person" name="person">
      <el-card>
        <el-form
          :model="person"
          :rules="personRules"
        >
        <el-form-item label="Name" prop="name">
          <el-input v-model="person.name" />
        </el-form-item>
        <el-form-item label="Biography">
          <el-input v-model="person.bio" />
        </el-form-item>
        </el-form>
        <el-button @click="clearPerson">Clear</el-button>
        <el-button type="primary" @click="addPerson">Add</el-button>
      </el-card>
    </el-tab-pane>
  </el-tabs>
</template>