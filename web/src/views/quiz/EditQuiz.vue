<template>
  <h4>{{ $router.currentRoute.value.params['id'] }}</h4>
  <a-form>

    {{ quiz }}
    <br/>
    {{ alternative }}
    <br/>
    {{ question }}

    <a-form-item label="Título">
      <a-input v-model:value="quiz.title"/>
    </a-form-item>

    <a-divider/>


    <div v-for="(question, index) in questions" :key="question.id">

      <a-form-item v-bind:label="'Questão ' + (index + 1)">
        <div style="display: flex">
          <a-input v-model:value="question.title"/>

          <a-button style="margin-left: 20px" type="secondary" @click.prevent="editQuestion(question)">
            <EditOutlined/>
          </a-button>
          <a-button style="margin-left: 20px" type="primary" danger @click.prevent="">
            <DeleteOutlined/>
          </a-button>
        </div>
      </a-form-item>

    </div>


    <a-form-item :wrapper-col="{ span: 5, offset: 4 }" v-if="!creatingNewQuestion">
      <a-button type="primary" @click.prevent="newQuestion()">Adicionar Questões</a-button>
    </a-form-item>

    <div v-if="creatingNewQuestion">

      <a-form-item v-bind:label="'Questão ' + (questions.length+1) ">
        <a-input v-model:value="question.content"/>
      </a-form-item>


      <a-form-item v-for="alternative in alternative" :key="alternative.key">

        <div style="display: flex">
          <a-radio v-model:checked="alternative.correct" @click="checkCorrect(alternative.key)"/>
          <a-input v-model:value="alternative.content"/>
          <a-button style="margin-left: 20px" type="primary" danger @click.prevent="removeAlternative(alternative.key)">
            <DeleteOutlined/>
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
import {
  EditOutlined,
  DeleteOutlined
} from '@ant-design/icons-vue';
import axios from "axios";


export default defineComponent({
  components: {
    EditOutlined,
    DeleteOutlined
  },
  data() {
    return {
      quiz: {
        id: '',
        title: ''
      },
      question: {
        content: '',
      },
      questions: [],
      alternative: [],
      count: 0,
      creatingNewQuestion: false
    }
  },
  beforeMount() {
    if (sessionStorage.getItem("token") === null) {
      this.$router.push("/login");
    }


    this.loadQuiz();
    this.loadQuestions();
  },
  methods: {
    loadQuiz() {
      axios.get(baseUrl + "/quizzes/" + this.$router.currentRoute.value.params['id'],
          {
            headers: {
              authorization: 'Bearer ' + sessionStorage.getItem("token")
            }
          })
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
        let quizId = this.$router.currentRoute.value.params['id'];
        axios.post(baseUrl + "/quizzes/" + quizId + "/questions", {
          question: {
            quiz_id: quizId,
            title: this.question.content,
            alternatives: this.alternative
          }
        }, {
          headers: {
            authorization: 'Bearer ' + sessionStorage.getItem("token")
          }
        })
            .then(res => {
              console.log(res.data.data);
              this.question = {
                content: '',
              };
              this.alternative = [];
              this.loadQuestions();
            }).catch(err => {
          console.error(err);
        })
      } else {
        // save quiz
      }
    },
    loadQuestions() {
      let quizId = this.$router.currentRoute.value.params['id'];
      axios.get(baseUrl + "/quizzes/" + quizId + "/questions", {
        headers: {
          authorization: 'Bearer ' + sessionStorage.getItem("token")
        }
      })
          .then(res => {
            this.questions = res.data.data;
          }).catch(err => {
        console.error(err);
      })
    },
    editQuestion(question) {
      this.question = question;
      let quizId = this.$router.currentRoute.value.params['id'];
      axios.get(baseUrl + "/quizzes/" + quizId + "/questions/" + question.id, {
        headers: {
          authorization: 'Bearer ' + sessionStorage.getItem("token")
        }
      })
          .then(res => {
            this.questions = res.data.data;
          }).catch(err => {
        console.error(err);
      })
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
        content: '',
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


