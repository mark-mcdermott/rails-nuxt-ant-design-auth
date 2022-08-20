<template>
  <div>
    <h1>{{title}}</h1>
    <a-form>
      <a-form-item label="Email">
        <a-input v-model:value="email" />
      </a-form-item>
      <a-form-item label="Password">
        <a-input type="password" v-model:value="password" />
      </a-form-item>
      <a-form-item>
        <a-button type="primary"  @click="signup">Sign Up</a-button>
      </a-form-item>
    </a-form>
  </div>
</template>
<script>
export default {
  data () {
    return {
      title: 'Sign Up',
      email: '',
      password: '',
      error: null,
      value: ''
    }
  },
  methods: {
    async signup() {
      try {
        await this.$axios.$post('users', {
          user: { email: this.email, password: this.password }
        })
        .then(() => { 
          this.$auth.login({
            data: {
              user: {
                email: this.email,
                password: this.password
              }
            }
          })
        });
      } catch(e) {
        this.error = e + ''
      }
    },
    logout: function () {
      this.$auth.logout().catch(e => {this.error = e + ''})
    }
  }
}
</script>