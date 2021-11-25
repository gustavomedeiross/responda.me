<template>
  <h4>{{ $router.currentRoute.value.params['id'] }}</h4>
  <a-form >

    {{quiz}}
    <br/>
    {{alternative}}
    <br/>
    {{questions}}

    <a-form-item label="Título">
      <a-input v-model:value="quiz.title"/>
    </a-form-item>

    <a-divider/>

    <a-form-item :wrapper-col="{ span: 5, offset: 4 }" v-if="!creatingNewQuestion">
      <a-button type="primary" @click.prevent="newQuestion()">Adicionar Questões</a-button>
    </a-form-item>

    <div v-if="creatingNewQuestion">

      <a-form-item label="Questão 1">
        <a-input v-model:value="questions.content"/>
      </a-form-item>


      <a-form-item v-for="alternative in alternative" :key="alternative.key">

        <div style="display: flex">
          <a-radio v-model:checked="alternative.correct" @click="checkCorrect(alternative.key)"/>
          <a-input v-model:value="alternative.description"/>
          <a-button style="margin-left: 20px" type="primary" danger @click.prevent="removeAlternative(alternative.key)">
            -
          </a-button>
        </div>
      </a-form-item>

      <a-form-item :wrapper-col="{ span: 5, offset: 22 }">
        <a-button type="primary" @click.prevent="newAlternative()">+</a-button>
      </a-form-item>

    </div>


    <a-form-item :wrapper-col="{ span: 5, offset: 22 }">
      <a-button type="primary" @click.prevent="onSubmit()">{{ getSaveDescription() }}</a-button>
    </a-form-item>

  </a-form>
</template>


<script>

import {defineComponent} from 'vue';
import {baseUrl} from "@/services/QuizService";
import axios from "axios";


export default defineComponent({
  data() {
    return {
      quiz: {
        id: '',
        title: ''
      },
      questions: {
        content: '',
      },
      alternative: [],
      count: 0,
      creatingNewQuestion: false
    }
  },
  beforeMount() {
    this.loadQuiz();
  },
  methods: {
    loadQuiz() {
      axios.get(baseUrl + "/quizzes/" + this.$router.currentRoute.value.params['id'])
          .then(res => {
            console.log(res.data.data);
            this.quiz = res.data.data;
          }).catch(err => {
        console.error(err);
      })
    },
    onSubmit() {
      if (this.creatingNewQuestion) {
        this.creatingNewQuestion = false;
        // save question
      } else {
        // save quiz
      }
    },
    newQuestion() {
      this.creatingNewQuestion = true;
    },
    getSaveDescription() {
      if (this.creatingNewQuestion) {
        return 'Salvar Questão';
      }
      return 'Salvar';
    },
    newAlternative() {
      this.alternative.push({
        description: '',
        correct: false,
        key: this.count++
      })
    },
    removeAlternative(key) {
      this.alternative = this.alternative.filter(function (item) {
        return item.key !== key
      })
    },
    checkCorrect(key) {
      this.alternative.forEach((value => {
        value.correct = value.key === key;
      }))
    }
  }
});
</script>


