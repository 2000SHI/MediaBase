<script setup>
import { ref } from 'vue';
// const props = defineProps({
//   data: Object
// })
const { data } = defineProps({
  data: Object
})

const musicData = ref(data)
</script>

<template>
  <p class="title">{{ musicData.title }}</p>
  <p v-if="musicData.description">{{ musicData.description }}</p>
  <p>Released At: {{ musicData.releaseDate }}</p>
  <p>Album: {{ musicData.album }}</p>
  <p>Duration: {{ musicData.durationSeconds }} secs</p>
</template>

<style scoped>
  .title {
    font-size: large;
    font-weight: bold;
  }
</style>