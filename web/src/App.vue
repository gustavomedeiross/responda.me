<template>
  <a-layout class="layout">
    <div v-if="!isLogged()" style="height: 120px">
    </div>
    <a-layout-header style="background: #6d25a4" v-if="isLogged()">

      <a-menu
          v-model:selectedKeys="selectedKeys"
          style="background: #6d25a4"
          mode="horizontal"
          :style="{ lineHeight: '64px' }"
      >

        <div style="display: flex">
          <img
              style="height: 20px; margin-top: 20px; margin-right: 50px"
              src="https://dewey.tailorbrands.com/production/brand_version_mockup_image/392/6463452392_dd72b9df-b12a-4bee-9657-0d3763163173.png?cb=1638557944"/>

          <a-menu-item key="quizzes" class="header-set">

            <ExperimentOutlined/>
            <router-link to="/quizzes"></router-link>
            Quizzes
          </a-menu-item>
          <a-menu-item key="about" class="header-set">
            <QuestionCircleOutlined/>
            <router-link to="/about"></router-link>
            About
          </a-menu-item>
        </div>
        <a-menu-item key="account" class="header-set" >
          <UserOutlined />
          <router-link to="/account"></router-link>
          Account
        </a-menu-item>
      </a-menu>
    </a-layout-header>
    <a-layout-content style="padding: 0 50px">
      <a-breadcrumb style="margin: 16px 0" v-if="isLogged()">
        <a-breadcrumb-item v-for="item in breadcrumbs($router)" :key="item">
          {{ item }}
        </a-breadcrumb-item>
      </a-breadcrumb>
      <div :style="{ background: '#fff', padding: '24px', minHeight: '80vh' }">
        <router-view/>
      </div>
    </a-layout-content>
    <a-layout-footer style="text-align: center">
      responda.me © 2021
    </a-layout-footer>
  </a-layout>
</template>

<script>
import {defineComponent, ref} from 'vue';
// eslint-disable-next-line no-unused-vars
import {string} from "vue-types";
import {ExperimentOutlined, QuestionCircleOutlined, UserOutlined} from "@ant-design/icons-vue";

export default defineComponent({
  components: {
    ExperimentOutlined,
    QuestionCircleOutlined,
    UserOutlined
  },
  methods: {
    isLogged() {
      let x = sessionStorage.getItem("token");
      if (x === 'null') {
        x = null;
        sessionStorage.setItem("needRefresh", true);
      }
      return x !== null;
    }
  },
  setup() {
    const breadcrumbs = function (router) {
      let routes = router.currentRoute.value.fullPath;
      return routes.split('/').splice(1, routes.length);
    }
    return {
      breadcrumbs,
      selectedKeys: ref<string[string]>(['quizzes', 'about']),
    };
  },
});
</script>
<style>
.site-layout-content {
  min-height: 280px;
  padding: 24px;
  background: #fff;
}

#components-layout-demo-top .logo {
  float: left;
  width: 120px;
  height: 31px;
  margin: 16px 24px 16px 0;
  background: rgba(255, 255, 255, 0.3);
}

.ant-row-rtl #components-layout-demo-top .logo {
  float: right;
  margin: 16px 0 16px 24px;
}

.header-set {
  color: #bae637;
}

.ant-btn-dangerous {
  background-color: #bae637 !important;
  color: #9254de !important;
  border-color: #bae637 !important;
}

.ant-btn-primary {
  font-weight: 400 !important;
  color: #bae637 !important;
  background-color: #9254de !important;
  border-color: #9254de !important;
}
</style>
