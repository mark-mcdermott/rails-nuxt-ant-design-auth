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
              <h1 class="mb-15">Home</h1>
              <h5 class="font-regular text-muted">Relax&mdash;you got this.</h5>
              <p>Concepts of wealth also vary across time. Modern labor-saving inventions and the development of the sciences have vastly improved the standard of living in modern societies for even the poorest of people. This comparative wealth across time is also applicable to the future; given this trend of human advancement, it is possible that the standard of living that the wealthiest enjoy today will be considered impoverished by future generations.</p>
              <p class="font-semibold text-muted">Already have an account? <router-link to="/sign-in" class="font-bold text-dark">Sign In</router-link></p>
            </a-col>
            <!-- / Sign In Form Column -->

            <!-- Sign In Image Column -->
            <a-col :span="24" :md="12" :lg="12" :xl="12" class="col-img">
              <img class="static-page-image" src="@/assets/images/huell-money-bed.png" alt="">
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
    beforeCreate() {
        // Creates the form and adds to it component's "form" property.
        this.form = this.$form.createForm(this, { name: "normal_login" });
    },
    methods: {
        // Handles input validation after submission.
        handleSubmit(e) {
            e.preventDefault();
            this.form.validateFields((err, values) => {
                if (!err) {
                    console.log("Received values of form: ", values);
                }
            });
        },
    },
    components: { AppHeader, AppFooter }
}
</script>

<style lang="scss" scoped>
	body {
		background-color: #ffffff;
	}

  h5 { 
    margin-bottom: 0;
  }

  p {
    margin: 20px 0 25px;
  }

  .sign-in .col-img img.static-page-image {
    margin: 50px 0 0;
    max-width: 500px;
    border-radius:5px;
  }
  @media (max-width: 768px) {
    .sign-in .col-img img.static-page-image {
        margin: 0 auto;
      }
    }
</style>