<script setup>
import { ref } from 'vue';
// const props = defineProps({
//   data: Object
// })
const { data } = defineProps({
  data: Object
})

const MovieData = ref(data)
</script>

<template>
  <p class="title">{{ MovieData.title }}</p>
  <p v-if="MovieData.description">{{ MovieData.description }}</p>
  <p>Released At: {{ MovieData.releaseDate }}</p>
  <p>Duration: {{ MovieData.durationMinutes }} mins</p>
  <p>Rating: {{ MovieData.rating }}</p>
</template>

<style scoped>
  .title {
    font-size: large;
    font-weight: bold;
  }
</style>