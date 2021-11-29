<template>
  <div>
    
    <a-form
      align="center"
      layout="vertical"
      :model="formState"
      @finish="handleFinish"
      @finishFailed="handleFinishFailed"
      style="background: #c6dff7; margin: 30px 300px 30px 300px; border-radius: 5px;border-color: blue;"
    >
      <h2>Cadastro</h2>
      <a-row type="primary" justify="center">
        <a-col :span="12">
          <a-form-item>
            <a-input
              v-model:value="formState.user"
              placeholder="Nome de Usuário"
          
            >
              <template #prefix
                ><UserOutlined style="color: rgba(0, 0, 0, 0.25); "
              /></template>
            </a-input>
          </a-form-item>
          <a-form-item type="e-mail">
            <a-input v-model:value="formState.email" placeholder="Email">
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
            <a-input
              v-model:value="formState.confirm"
              type="password"
              placeholder="Confirmar Senha"
            >
              <template #prefix
                ><LockOutlined style="color: rgba(0, 0, 0, 0.25)"
              /></template>
            </a-input>
          </a-form-item>
          <a-form-item>
            <a-button
              type="primary"
              html-type="submit"
              :disabled="
                formState.user === '' ||
                formState.password === '' ||
                formState.email === '' ||
                formState.confirm != formState.password
              "
            >
              Registrar-se
            </a-button>
              <a-divider/>
             <a-row type="primary" justify="center"  >
        <p>Já Tem Cadastro?</p>
        <a href="/login">Login</a>
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
      email: "",
      password: "",
      confirm: "",
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
