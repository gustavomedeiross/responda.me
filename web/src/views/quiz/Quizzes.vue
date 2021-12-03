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
          <a-button style="margin-left: 20px" type="text" danger @click.prevent="editQuiz(item)">
            <EditOutlined/>
          </a-button>
          <a-button style="margin-left: 20px" type="text" danger @click.prevent="deleteQuiz(item)">
            <DeleteOutlined/>
          </a-button>
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
import {DeleteOutlined, EditOutlined} from "@ant-design/icons-vue";

export default defineComponent({
  components: {
    CreateQuiz,
    EditOutlined,
    DeleteOutlined
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
    editQuiz(quiz) {
      this.$router.push(/quizzes/ + quiz.id);
    },
    deleteQuiz(quiz) {
      axios.delete(baseUrl + '/quizzes/' + quiz.id,
          {
            headers: {
              authorization: 'Bearer ' + sessionStorage.getItem("token")
            }
          })
          .then(() => {
            this.loadData();
          }).catch((err) => {
        console.error(err);
      });
    },
    loadData() {
      axios.get(baseUrl + '/quizzes',
          {
            headers: {
              authorization: 'Bearer ' + sessionStorage.getItem("token")
            }
          })
          .then((res) => {
            this.data = res.data.data;
          }).catch((err) => {
        console.error(err);
      });
    }
  },
  beforeMount() {
    if (sessionStorage.getItem("token") === null) {
      this.$router.push("/login");
    }

    if (sessionStorage.getItem("needsRefresh") === 'true') {
      sessionStorage.setItem("needsRefresh", null);
      this.$router.go();
    }
    this.loadData();
  },

});
</script>
