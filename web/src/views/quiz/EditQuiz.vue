<template>
  <a-typography-title>{{ $router.currentRoute.value.params['id'] }}</a-typography-title>
  <a-form :label-col="labelCol" :wrapper-col="wrapperCol">

    <a-form-item label="Título" v-bind="validateInfos.title">
      <a-input v-model:value="quiz.title"/>
    </a-form-item>

    <a-form-item :wrapper-col="{ span: 14, offset: 4 }">
      <a-button type="primary" @click.prevent="onSubmit($router)">Salvar</a-button>
    </a-form-item>

  </a-form>
</template>


<script>

import {defineComponent, reactive} from 'vue';
import {Form} from 'ant-design-vue';
import {baseUrl} from "@/services/QuizService";
import axios from "axios";

const useForm = Form.useForm;
export default defineComponent({
  data() {
    return {
      quiz: {}
    }
  },
  beforeMount() {
    this.loadQuiz();
  },
  methods: {
    loadQuiz() {
      axios.get(baseUrl + "/quizzes/" + this.router.currentRoute.value.params['id'])
          .then(res => {
            this.quiz = res.data;
          }).catch(err => {
        console.error(err);
      })
    }
  },
  setup() {
    const rulesRef = reactive({
      title: [
        {
          required: true,
          message: 'O título é obrigatório',
        },
      ]
    });
    const {resetFields, validate, validateInfos} = useForm(this.quiz, rulesRef);
    const onSubmit = (router) => {
      validate()
          .then(() => {
            console.log(router.currentRoute.value.params["id"]);

          })
          .catch(err => {
            console.log('error', err);
          });
    };
    return {
      labelCol: {span: 4},
      wrapperCol: {span: 14},
      validateInfos,
      resetFields,
      onSubmit,
    };
  },
});
</script>


