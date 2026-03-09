<script setup>
import { ref } from 'vue';
// const props = defineProps({
//   data: Object
// })
const { data } = defineProps({
  data: Object
})

const bookData = ref(data)
</script>

<template>
  <p class="title">{{ bookData.title }}</p>
  <p v-if="bookData.description">{{ bookData.description }}</p>
  <p>Released At: {{ bookData.releaseDate }}</p>
  <p>Publisher: {{ bookData.publisher }}</p>
</template>

<style scoped>
  .title {
    font-size: large;
    font-weight: bold;
  }
</style>