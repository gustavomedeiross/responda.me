<template>

<div size="middle" align="center" >
  
    <a-col :span="8">
        
        <a-form :layout="formState.layout" :model="formState" v-bind="formItemLayout" >
    <a-form-item label="Login" align="center" >
      
    </a-form-item>
    <a-form-item label="Nome">
      <a-input v-model:value="formState.name" placeholder="Digíte o Nome de Usuário" />
    </a-form-item>
    <a-form-item label="Senha">
      <a-input v-model:value="formState.password" placeholder="Digite a Senha" />
    </a-form-item>
    <a-form-item :wrapper-col="buttonItemLayout.wrapperCol">
      <a-button type="primary">Acessar</a-button>
    </a-form-item>
  </a-form>
    </a-col>
   
  
  </div>
</template>
<script>
import { computed, defineComponent, reactive } from 'vue';
export default defineComponent({
  setup() {
    const formState = reactive({
      layout: 'horizontal',
      fieldA: '',
      fieldB: '',
    });
    const formItemLayout = computed(() => {
      const {
        layout,
      } = formState;
      return layout === 'horizontal' ? {
        labelCol: {
          span: 4,
        },
        wrapperCol: {
          span: 14,
        },
      } : {};
    });
    const buttonItemLayout = computed(() => {
      const {
        layout,
      } = formState;
      return layout === 'horizontal' ? {
        wrapperCol: {
          span: 14,
          offset: 4,
        },
      } : {};
    });
    return {
      formState,
      formItemLayout,
      buttonItemLayout,
    };
  },

});
</script>
<style scoped>

</style>
