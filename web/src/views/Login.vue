<template>

  <div>

    <a-form
        align="center"
        layout="vertical"
        :model="formState"
        @finish="handleFinish"
        @finishFailed="handleFinishFailed"
        style="background: #c6dff7;
        margin-left: 30%;
        margin-right: 30%;
         min-width: 460px;
          border-radius: 5px;"

    >
      <h2 style="margin: 20px 20px;">Login</h2>
      <a-row type="primary" justify="center">

        <a-col :span="12">
          <a-form-item>
            <a-input v-model:value="formState.user" placeholder="Email">
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
            <a-button
                type="primary"
                html-type="submit"
                :disabled="formState.user === '' || formState.password === ''"
                @click.prevent="onSubmit(formState)"
            >
              Login
            </a-button>
            <a-divider/>
            <a-row type="primary" justify="center">
              <p>Ainda não tem cadastro?</p>
            </a-row>
            <a href="/register">Cadastrar-se</a>
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
    beforeMount() {

      const x = sessionStorage.getItem("token");
      if (x !== null) {
        this.$router.push("/quizzes");
      }

    },
    onSubmit(userData) {
      axios.post(baseUrl + '/users/sessions', {
        email: userData.user,
        password: userData.password
      }).then((res) => {

        sessionStorage.setItem("token", res.data.token);
        sessionStorage.setItem("user", JSON.stringify(res.data.user));
        sessionStorage.setItem("needsRefresh", true);
        this.$router.push("/quizzes");

      }).catch((err) => {
        console.error(err);
      });
    }
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
