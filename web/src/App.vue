<template>
  <a-layout class="layout" >
    <a-layout-header style="background: #6d25a4">
      <div class="logo" />
      <a-menu
          v-model:selectedKeys="selectedKeys"
         style="background: #6d25a4"
          mode="horizontal"
          :style="{ lineHeight: '64px' }"
      >
        <a-menu-item key="quizzes" >
          <router-link to="/quizzes"></router-link>
          Quizzes
        </a-menu-item>
        <a-menu-item key="about" >
          <router-link to="/about"></router-link>
          About
        </a-menu-item>
      </a-menu>
    </a-layout-header>
    <a-layout-content style="padding: 0 50px">
      <a-breadcrumb style="margin: 16px 0">
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

export default defineComponent({
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

/* [data-theme='dark'] .site-layout-content {
 
  background: #141414;
} */
</style>
