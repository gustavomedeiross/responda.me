<template>
  <a-form :label-col="labelCol" :wrapper-col="wrapperCol">

    <a-form-item label="Título" v-bind="validateInfos.title">
      <a-input v-model:value="quiz.title"/>
    </a-form-item>

    <a-form-item :wrapper-col="{ span: 14, offset: 4 }">
      <a-button type="primary" @click.prevent="onSubmit($router)">Salvar</a-button>
      <a-button style="margin-left: 10px" @click="resetFields">Limpar</a-button>
    </a-form-item>

  </a-form>
</template>

<script>

import {defineComponent, reactive, toRaw} from 'vue';
import {Form} from 'ant-design-vue';
import {baseUrl} from "@/services/QuizService";
import axios from "axios";

const useForm = Form.useForm;
export default defineComponent({
  setup() {
    const quiz = reactive({
      title: ''
    });

    if (sessionStorage.getItem("token") === null) {
      this.$router.push("/login");
    }

    const rulesRef = reactive({
      title: [
        {
          required: true,
          message: 'O título é obrigatório',
        },
      ]
    });
    const {resetFields, validate, validateInfos} = useForm(quiz, rulesRef);
    const onSubmit = (router) => {
      validate()
          .then(() => {
            console.log('cadastrando...', toRaw(quiz));

            axios.post(baseUrl + '/quizzes', {
              quiz: quiz
            }, {
              headers: {
                authorization: 'Bearer ' + sessionStorage.getItem("token")
              }
            }).then((res) => {
              console.log(res.data.data.id);
              console.log(router);
              router.removeRoute({name: 'create'})
              router.push({path: '/quizzes/' + res.data.data.id})
            }).catch((err) => {
              console.error(err);
            });

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
      quiz,
      onSubmit,
    };
  },
});
</script>

