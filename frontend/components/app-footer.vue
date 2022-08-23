<template>
  <a-layout-footer>

  <!-- Footer Navigation Menu -->
  <a-menu mode="horizontal">
    <a-menu-item><router-link to="/" class="nav-link" @click="e => e.preventDefault()">Home</router-link></a-menu-item>
    <a-menu-item><router-link to="/about-us" class="nav-link" @click="e => e.preventDefault()">About Us</router-link></a-menu-item>
    <a-menu-item v-if="this.$auth.loggedIn"><router-link to="/dashboard" class="nav-link" @click="e => e.preventDefault()">Dashboard</router-link></a-menu-item>
    <a-menu-item v-if="!this.$auth.loggedIn"><router-link to="/sign-in" class="nav-link" @click="e => e.preventDefault()">Sign In</router-link></a-menu-item>
    <a-menu-item v-if="!this.$auth.loggedIn"><router-link to="/sign-up" class="nav-link" @click="e => e.preventDefault()">Sign Up</router-link></a-menu-item>
  </a-menu>
  <!-- / Footer Navigation Menu -->
  
  <!-- Copyright Notice -->
  <p class="copyright">
    Copyright © 2022
  </p>
  <!-- / Copyright Notice -->

  </a-layout-footer>
</template>

<style lang="scss" scoped>
.ant-menu-horizontal > .ant-menu-item > a {
  color: #8c8c8c;
}
.ant-menu-horizontal > .ant-menu-item > a.nuxt-link-active,
.ant-menu-horizontal > .ant-menu-item > a:hover {
  color: rgba(0, 0, 0, 0.65); 
}
</style>