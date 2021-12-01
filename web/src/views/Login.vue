<template>

<div  >

  <a-form
    align="center"
    layout="vertical"
    :model="formState"
    @finish="handleFinish"
    @finishFailed="handleFinishFailed"
     style="background: #c6dff7; margin: 60px 410px 60px 420px; border-radius: 5px;"

  >
 <h2 style="margin: 20px 20px;">Login</h2>
    <a-row type="primary" justify="center"  >
       
      <a-col :span="12">
        <a-form-item >
          <a-input v-model:value="formState.user" placeholder="Nome de Usuário">
            <template #prefix
              ><UserOutlined style="color: rgba(0, 0, 0, 0.25)"
            /></template>
          </a-input>
        </a-form-item>
        
        <a-form-item>
          <a-input
            v-model:value="formState.password"
            type="password"
            placeholder="Senha"
          >
            <template #prefix
              ><LockOutlined style="color: rgba(0, 0, 0, 0.25)"
            /></template>
          </a-input>
        </a-form-item>
        <a-form-item>
          <a-button
            type="primary"
            style="background: #6d25a4"
            html-type="submit"
            :disabled="formState.user === '' || formState.password === ''"
          >
            Login
          </a-button>
         <a-divider/>
           <a-row type="primary" justify="center"  >
        <p>ainda não tem Cadastro?</p>
        <a href="/register">cadastrar-se</a>
       </a-row>
        </a-form-item>
      
        </a-col>
        
    </a-row>
  </a-form>
</div>
</template>
<script>
import { UserOutlined, LockOutlined } from "@ant-design/icons-vue";
import { defineComponent, reactive } from "vue";
export default defineComponent({
  components: {
    UserOutlined,
    LockOutlined,
  },

  setup() {
    const formState = reactive({
      user: "",
      password: "",
    });

    const handleFinish = (values) => {
      console.log(values, formState);
    };

    const handleFinishFailed = (errors) => {
      console.log(errors);
    };

    return {
      formState,
      handleFinish,
      handleFinishFailed,
    };
  },
});
</script>
<style scoped>
</style>
