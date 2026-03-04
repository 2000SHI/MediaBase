<script setup>
import { ref } from 'vue';
const { data } = defineProps({
  data: Object
})

const tvData = ref(data)
</script>

<template>
  <p class="title">{{ tvData.title }}</p>
  <p v-if="tvData.description">{{ tvData.description }}</p>
  <p>Released At: {{ tvData.releaseDate }}</p>
  <p>Seasons: {{ tvData.seasons }}</p>
  <p>Rate: {{ tvData.rate || 'No Rating Yet' }}</p>
  <p>Comments: {{ tvData.comments || 'No Comments Yet' }}</p>
</template>

<style scoped>
  .title {
    font-size: large;
    font-weight: bold;
  }
</style>