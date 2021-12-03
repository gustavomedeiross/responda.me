<template>
  <div>

    <a-form
        align="center"
        layout="vertical"
        style="background: #c6dff7; margin: 30px 300px 30px 300px; border-radius: 5px;border-color: blue;"
    >
      <h1>Conta</h1>
      <h2>nome de usuário</h2>
      <p>{{user.full_name}}</p>
      <h2>Email</h2>
      <p>{{user.email}}</p>

            <a-button
                type="primary"
                style="background: #6d25a4"
                html-type="submit"
                @click.prevent="logout"
               >
             Logout
            </a-button>
    </a-form>
  </div>
</template>
<script>

import { defineComponent } from "vue";


export default defineComponent({
  methods: {
      logout(){
        sessionStorage.setItem("token", null)
     sessionStorage.setItem("user", null)
     this.$router.push("/login")
  },
  },
  data() {
    return {
      user: {
      
      },

    };
  },
  beforeMount(){
    this.user = JSON.parse(sessionStorage.getItem("user"))
  
  }
});
</script>
<style scoped>
</style>
