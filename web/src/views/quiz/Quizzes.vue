<template>
  <div v-if="!isOnPageCreate($router)">
    <a-button type="primary" v-on:click="$router.push({ name: 'create' })">Criar Quizz</a-button>
  </div>
  <div v-if="isOnPageCreate($router)">
    <create-quiz/>
  </div>
</template>

<script>
import CreateQuiz from "@/views/quiz/CreateQuiz";

export default {
  name: "Quizzes",
  components: {CreateQuiz},
  methods: {
    isOnPageCreate(router) {
      return router.currentRoute.value.name === 'create';
    }
  }
}
</script>

<style scoped>

</style>
