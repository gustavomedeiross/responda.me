<template>
  <a-form :label-col="labelCol" :wrapper-col="wrapperCol">

    <a-form-item label="Título" v-bind="validateInfos.title">
      <a-input v-model:value="quiz.title"/>
    </a-form-item>

    <a-form-item label="Descrição" v-bind="validateInfos.description">
      <a-textarea v-model:value="quiz.description"/>
    </a-form-item>

    <a-form-item :wrapper-col="{ span: 14, offset: 4 }">
      <a-button type="primary" @click.prevent="onSubmit">Salvar</a-button>
      <a-button style="margin-left: 10px" @click="resetFields">Limpar</a-button>
    </a-form-item>

  </a-form>
</template>

<script>

import {defineComponent, reactive, toRaw} from 'vue';
import {Form} from 'ant-design-vue';

const useForm = Form.useForm;
export default defineComponent({
  setup() {
    const quiz = reactive({
      title: '',
      description: ''
    });
    const rulesRef = reactive({
      title: [
        {
          required: true,
          message: 'O título é obrigatório',
        },
      ],
      description: [
        {
          required: false,
        },
      ],
    });
    const {resetFields, validate, validateInfos} = useForm(quiz, rulesRef);
    const onSubmit = () => {
      validate()
          .then(() => {
            console.log(toRaw(quiz));
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

