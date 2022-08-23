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
              <h1 class="mb-15">About Us</h1>
              <h5 class="font-regular text-muted">Our mind is on your your money</h5>
              <h5 class="font-regular text-muted">And your money is on our mind</h5>

              <p>A budget is a calculation plan, usually but not always financial, for a defined period, often one year. A budget may include anticipated sales volumes and revenues, resource quantities including time, costs and expenses, environmental impacts such as greenhouse gas emissions, other impacts, assets, liabilities and cash flows. Companies, governments, families, and other organizations use budgets to express strategic plans of activities in measurable terms.</p>



              <p class="font-semibold text-muted">Already have an account? <router-link to="/sign-in" class="font-bold text-dark">Sign In</router-link></p>
            </a-col>
            <!-- / Sign In Form Column -->

            <!-- Sign In Image Column -->
            <a-col :span="24" :md="12" :lg="12" :xl="12" class="col-img">
              <img class="static-page-image" src="@/assets/images/mind-on-money.png" alt="">
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
            collapseNav: 0
        };
    },
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
    max-width: 300px;
  }
</style>