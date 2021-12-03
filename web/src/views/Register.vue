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
                v-model:value="formState.name"
                placeholder="Nome">
              <template #prefix>
                <UserOutlined style="color: rgba(0, 0, 0, 0.25); "/>
              </template>
            </a-input>
          </a-form-item>

          <a-form-item>
            <a-input
                v-model:value="formState.surname"
                placeholder="Sobrenome">
              <template #prefix>
                <UserOutlined style="color: rgba(0, 0, 0, 0.25); "/>
              </template>
            </a-input>
          </a-form-item>

          <a-form-item type="e-mail">
            <a-input v-model:value="formState.email" placeholder="Email">
              <template #prefix
              >
                <UserOutlined style="color: rgba(0, 0, 0, 0.25)"
                />
              </template>
            </a-input>
          </a-form-item>

          <a-form-item>
            <a-input
                v-model:value="formState.password"
                type="password"
                placeholder="Senha"
            >
              <template #prefix
              >
                <LockOutlined style="color: rgba(0, 0, 0, 0.25)"
                />
              </template>
            </a-input>
          </a-form-item>
          <a-form-item>
            <a-input
                v-model:value="formState.confirm"
                type="password"
                placeholder="Confirmar Senha"
            >
              <template #prefix
              >
                <LockOutlined style="color: rgba(0, 0, 0, 0.25)"
                />
              </template>
            </a-input>
          </a-form-item>
          <a-form-item>
            <a-button
                type="primary"
                html-type="submit"
                :disabled="
                formState.name === '' ||
                formState.surname === '' ||
                formState.password === '' ||
                formState.email === '' ||
                formState.confirm != formState.password
              "
                @click.prevent="onSubmit(formState)">
              Registrar-se
            </a-button>
            <a-divider/>
            <a-row type="primary" justify="center">
              <p>Já tem cadastro?</p>
            </a-row>
            <a href="/login">Login</a>
          </a-form-item>
        </a-col>

      </a-row>
    </a-form>
  </div>
</template>
<script>
import {UserOutlined, LockOutlined} from "@ant-design/icons-vue";
import {defineComponent, reactive} from "vue";
import axios from "axios";
import {baseUrl} from "@/services/QuizService";

export default defineComponent({
  components: {
    UserOutlined,
    LockOutlined,
  },
  methods: {
    onSubmit(data) {
      axios.post(baseUrl + '/users/register', {
        first_name: data.name,
        last_name: data.surname,
        email: data.email,
        password: data.password
      }).then((res) => {
        console.log(res);
        this.$router.push("/login")
      }).catch((err) => {
        console.error(err);
      });
    }
  },
  setup() {
    const formState = reactive({
      name: "",
      surname: "",
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
