<template>
  <div class="components-page-header-demo-responsive" style="border: 1px solid rgb(235, 237, 240)">
    <a-layout class="layout">
      <div class="ant-page-header ant-page-header-ghost">
        <div class="ant-page-header-heading">
          <span class="ant-page-header-heading-title">
            <NuxtLink to="/">
              Nuxt Finance
            </NuxtLink>
          </span>
          <span class="ant-page-header-heading-sub-title">A Very Nice Site 😎</span>
        </div>
        <div>
          <a-button key="1"><NuxtLink to="/public-content">Public Content</NuxtLink></a-button>
          <a-button key="2" v-if="$auth.$state.loggedIn"><NuxtLink to="/private-content">Private Content</NuxtLink></a-button>
          <a-button key="3" v-if="!$auth.$state.loggedIn"><NuxtLink to="/log-in">Log In</NuxtLink></a-button>
          <a-button key="4" v-if="$auth.$state.loggedIn" @click.prevent="logout">Log Out</a-button>
          <a-button key="5" type="primary" v-if="!$auth.$state.loggedIn"><NuxtLink to="/sign-up">Sign Up</NuxtLink></a-button>
          <div class="logged-in-as">
            <span v-if="!$auth.$state.loggedIn" >Not logged in</span>
            <span v-if="$auth.$state.loggedIn">Logged in as {{this.$auth.user.email}}</span>
          </div>
        </div>
      </div>
      <a-layout-content style="margin: 10px 0 0; padding: 0 50px">
        <div :style="{ background: '#fff', padding: '24px', minHeight: '280px' }">
          <Nuxt />        
        </div>
      </a-layout-content>
      <a-layout-footer style="text-align: center">
        Cool Site ©2022
      </a-layout-footer>
    </a-layout>
  </div>

</template>

<script>
export default {
  methods: {
    logout: function () {
      this.$auth.logout().catch(e => {this.error = e + ''})
    }
  }
}
</script>

<style>
.logged-in-as {
  margin: 0 0 0 20px;
  display: inline;
}
.components-page-header-demo-responsive {
  padding-bottom: 5px;
}
.components-page-header-demo-responsive tr:last-child td {
  padding-bottom: 0;
}
.ant-page-header {
  display: flex;
  justify-content: space-between;
} 
.ant-page-header-heading {
  width: inherit;
}
.ant-page-header-heading-title a {
  color: rgba(0, 0, 0, 0.85);
}
#components-page-header-demo-responsive .ant-statistic-content {
  font-size: 20px;
  line-height: 28px;
}
@media (max-width: 576px) {
  #components-page-header-demo-responsive .content {
    display: block;
  }

  #components-page-header-demo-responsive .main {
    width: 100%;
    margin-bottom: 12px;
  }

  #components-page-header-demo-responsive .extra {
    width: 100%;
    margin-left: 0;
    text-align: left;
  }
}
</style>

