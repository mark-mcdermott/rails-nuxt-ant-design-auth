<template>
	<div>

		<!-- Default Layout -->
		<a-layout class="layout-default" id="layout-default">

			<!-- Layout Header ( Navbar ) -->
      <AppHeader></AppHeader>
			<!-- / Layout Header ( Navbar ) -->


			<!-- Page Content -->
			<a-layout-content>
        <div class="sign-in">
		
          <a-row type="flex" :gutter="[24,24]" justify="space-around" align="middle">

            <!-- Sign In Form Column -->
            <a-col :span="24" :md="12" :lg="{span: 12, offset: 0}" :xl="{span: 6, offset: 2}" class="col-form">
              <h1 class="mb-15">Sign Up</h1>
              <h5 class="font-regular text-muted">Enter your email and password</h5>

              <!-- Sign In Form -->
              <a-form
                id="components-form-demo-normal-login"
                :form="form"
                class="login-form"
                @submit.prevent="handleSubmit"
                :hideRequiredMark="true"
              >
                <a-form-item class="mb-10" label="Email" :colon="false">
                  <a-input 
                  placeholder="Email" 
                  v-model="email"
                />
                </a-form-item>
                <a-form-item class="mb-5" label="Password" :colon="false">
                  <a-input
                  type="password" 
                  placeholder="Password"
                  v-model="password"
                />
                </a-form-item>
                <a-form-item>
                  <a-button type="primary" block html-type="submit" class="login-form-button">
                    SIGN UP
                  </a-button>
                </a-form-item>
              </a-form>
              <!-- / Sign In Form -->

              <p class="font-semibold text-muted">Already have an account? <router-link to="/sign-in" class="font-bold text-dark">Sign In</router-link></p>
            </a-col>
            <!-- / Sign In Form Column -->

            <!-- Sign In Image Column -->
            <a-col :span="24" :md="12" :lg="12" :xl="12" class="col-img">
              <img class="static-page-image" src="@/assets/images/hand-with-cash-darker.png" alt="">
            </a-col>
            <!-- Sign In Image Column -->

          </a-row>
          
        </div>
			</a-layout-content>
			<!-- / Page Content -->

			<!-- Layout Footer -->
      <AppFooter></AppFooter>
			<!-- / Layout Footer -->

		</a-layout>
		<!-- / Default Layout -->

	</div>
</template>
<script>
import AppHeader from '../components/app-header.vue';
import AppFooter from '../components/app-footer.vue';
export default {
  data() {
    return {
      collapseNav: 0,
      email: '',
      password: ''
    };
  },
  beforeCreate() {
      // Creates the form and adds to it component's "form" property.
      this.form = this.$form.createForm(this, { name: "normal_login" });
  },
  methods: {
    // Handles input validation after submission.
    async handleSubmit() {
      this.error = '';
      try {
        await this.$axios.$post('/users', {
          user: {
            email: this.email,
            password: this.password
          }
        })
        await this.$auth.login({
          data: {
            user: {
              email: this.email,
              password: this.password
            }
          }
        })
        this.$router.push('dashboard')
      } catch (e) {
        console.log('in catch')
        if (e.response.status == 401) {
          this.error = 'Signup Unsuccessful: 401 Unauthorized'
        } else {
          console.log(e) 
          this.error = e + ''
        }
      }
    },
    async login() {
      this.error = '';
      try {
        await this.$auth.login({
          data: {
            user: {
              email: this.email,
              password: this.password
            }
          }
        })
        this.$router.push('dashboard')
      } catch (e) {
        if (e.response.status == 401) {
          this.error = 'Invalid email or password.'
        } else {
          this.error = e + ''
        }
      }
    }, 
  },
  components: { AppHeader, AppFooter }
}
</script>

<style lang="scss" scoped>
	body {
		background-color: #ffffff;
	}

  .sign-in .col-img img.static-page-image {
    max-width: 400px;
  }
</style>