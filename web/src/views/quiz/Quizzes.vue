<template>
  <div v-if="!isOnPageCreate($router)">

    <a-list item-layout="horizontal" :data-source="data">
      <template #renderItem="{ item }">
        <a-list-item>
          <a-list-item-meta v-bind:description="item.id">
            <template #title>
              <h3>{{ item.title }}</h3>
            </template>
          </a-list-item-meta>
        </a-list-item>
      </template>
    </a-list>

    <a-divider/>

    <a-button type="primary" v-on:click="$router.push({ name: 'create' })">Criar um Quizz</a-button>
  </div>

  <div v-if="isOnPageCreate($router)">
    <create-quiz/>
  </div>

</template>
<script>
import {defineComponent} from 'vue';
import {baseUrl} from "@/services/QuizService";
import CreateQuiz from "@/views/quiz/CreateQuiz";
import axios from "axios";

export default defineComponent({
  components: {
    CreateQuiz
  },
  data() {
    return {
      data: []
    }
  },
  methods: {
    isOnPageCreate(router) {
      return router.currentRoute.value.name === 'create';
    },
    loadData() {
      axios.get(baseUrl + '/quizzes')
          .then((res) => {
            this.data = res.data.data;
          }).catch((err) => {
        console.error(err);
      });
    }
  },
  beforeMount() {
    this.loadData();
  },

});
</script>
