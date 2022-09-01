<template>
	<div>

		<!-- Dashboard Layout -->
		<a-layout class="layout-dashboard" id="layout-dashboard" :class="[navbarFixed ? 'navbar-fixed' : '', ! sidebarCollapsed ? 'has-sidebar' : '', layoutClass]">
			
			<!-- Main Sidebar -->
    <a-layout-sider
      collapsible
      class="sider-primary"
      breakpoint="lg"
      collapsed-width="0"
      width="250px"
      :collapsed="sidebarCollapsed"
      @collapse="$emit('toggleSidebar', ! sidebarCollapsed)"
      :trigger="null"
      :class="['ant-layout-sider-' + sidebarColor, 'ant-layout-sider-' + sidebarTheme]"
      theme="light"
      :style="{ backgroundColor: 'transparent',}">
        <div class="header-brand"><h6><a-icon type="bank" theme="filled" /> <router-link to="/" class="nav-link" @click="e => e.preventDefault()">Nuxt Finance</router-link></h6></div>
        <hr>

        <!-- Sidebar Navigation Menu -->
        <a-menu theme="light" mode="inline">
          <a-menu-item class="menu-item-header">
            Dashboard
          </a-menu-item>
          <a-menu-item>
            <a @click.prevent="dashboardClick">
              <span class="icon">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M3 4C3 3.44772 3.44772 3 4 3H16C16.5523 3 17 3.44772 17 4V6C17 6.55228 16.5523 7 16 7H4C3.44772 7 3 6.55228 3 6V4Z" fill="#111827"/>
                  <path d="M3 10C3 9.44771 3.44772 9 4 9H10C10.5523 9 11 9.44771 11 10V16C11 16.5523 10.5523 17 10 17H4C3.44772 17 3 16.5523 3 16V10Z" fill="#111827"/>
                  <path d="M14 9C13.4477 9 13 9.44771 13 10V16C13 16.5523 13.4477 17 14 17H16C16.5523 17 17 16.5523 17 16V10C17 9.44771 16.5523 9 16 9H14Z" fill="#111827"/>
                </svg>
              </span>
              <span class="label">Accounts Overview</span>
            </a>
          </a-menu-item>

          <a-menu-item class="menu-item-header">
            Asset Accounts
          </a-menu-item>
                       
          <a-menu-item v-for="(assetAcct,i) in assetAccts" :key="'A'+i">
            <a @click.prevent="accountClick(assetAcct.id,assetAcct.name)" :id="assetAcct.id">
              <span class="icon">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M8.43338 7.41784C8.58818 7.31464 8.77939 7.2224 9 7.15101L9.00001 8.84899C8.77939 8.7776 8.58818 8.68536 8.43338 8.58216C8.06927 8.33942 8 8.1139 8 8C8 7.8861 8.06927 7.66058 8.43338 7.41784Z" fill="#111827"/>
                  <path d="M11 12.849L11 11.151C11.2206 11.2224 11.4118 11.3146 11.5666 11.4178C11.9308 11.6606 12 11.8861 12 12C12 12.1139 11.9308 12.3394 11.5666 12.5822C11.4118 12.6854 11.2206 12.7776 11 12.849Z" fill="#111827"/>
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 5C11 4.44772 10.5523 4 10 4C9.44772 4 9 4.44772 9 5V5.09199C8.3784 5.20873 7.80348 5.43407 7.32398 5.75374C6.6023 6.23485 6 7.00933 6 8C6 8.99067 6.6023 9.76515 7.32398 10.2463C7.80348 10.5659 8.37841 10.7913 9.00001 10.908L9.00002 12.8492C8.60902 12.7223 8.31917 12.5319 8.15667 12.3446C7.79471 11.9275 7.16313 11.8827 6.74599 12.2447C6.32885 12.6067 6.28411 13.2382 6.64607 13.6554C7.20855 14.3036 8.05956 14.7308 9 14.9076L9 15C8.99999 15.5523 9.44769 16 9.99998 16C10.5523 16 11 15.5523 11 15L11 14.908C11.6216 14.7913 12.1965 14.5659 12.676 14.2463C13.3977 13.7651 14 12.9907 14 12C14 11.0093 13.3977 10.2348 12.676 9.75373C12.1965 9.43407 11.6216 9.20873 11 9.09199L11 7.15075C11.391 7.27771 11.6808 7.4681 11.8434 7.65538C12.2053 8.07252 12.8369 8.11726 13.254 7.7553C13.6712 7.39335 13.7159 6.76176 13.354 6.34462C12.7915 5.69637 11.9405 5.26915 11 5.09236V5Z" fill="#111827"/>
                </svg>
              </span>
              <span class="label">{{assetAcct.name}}</span>
            </a>
          </a-menu-item>
          
          <a-menu-item class="menu-item-header">
            Debt Accounts
          </a-menu-item>
          <a-menu-item v-for="(debtAcct,i) in debtAccts" :key="i">
            <a @click.prevent="accountClick(assetAcct.id,assetAcct.name)">
              <span class="icon">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M4 4C2.89543 4 2 4.89543 2 6V7H18V6C18 4.89543 17.1046 4 16 4H4Z" fill="#111827"/>
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M18 9H2V14C2 15.1046 2.89543 16 4 16H16C17.1046 16 18 15.1046 18 14V9ZM4 13C4 12.4477 4.44772 12 5 12H6C6.55228 12 7 12.4477 7 13C7 13.5523 6.55228 14 6 14H5C4.44772 14 4 13.5523 4 13ZM9 12C8.44772 12 8 12.4477 8 13C8 13.5523 8.44772 14 9 14H10C10.5523 14 11 13.5523 11 13C11 12.4477 10.5523 12 10 12H9Z" fill="#111827"/>
                </svg>
              </span>
              <span class="label">{{debtAcct.name}}</span>
            </a>
          </a-menu-item>
        </a-menu>
        <!-- / Sidebar Navigation Menu -->

        <!-- Sidebar Footer -->
        <div class="aside-footer">
          <div class="footer-box">
            <span class="icon">
              <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
							    <path fill-rule="evenodd" clip-rule="evenodd" d="M10 2C7.79086 2 6 3.79086 6 6V7H5C4.49046 7 4.06239 7.38314 4.00612 7.88957L3.00612 16.8896C2.97471 17.1723 3.06518 17.455 3.25488 17.6669C3.44458 17.8789 3.71556 18 4 18H16C16.2844 18 16.5554 17.8789 16.7451 17.6669C16.9348 17.455 17.0253 17.1723 16.9939 16.8896L15.9939 7.88957C15.9376 7.38314 15.5096 7 15 7H14V6C14 3.79086 12.2091 2 10 2ZM12 7V6C12 4.89543 11.1046 4 10 4C8.89543 4 8 4.89543 8 6V7H12ZM6 10C6 9.44772 6.44772 9 7 9C7.55228 9 8 9.44772 8 10C8 10.5523 7.55228 11 7 11C6.44772 11 6 10.5523 6 10ZM13 9C12.4477 9 12 9.44772 12 10C12 10.5523 12.4477 11 13 11C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9Z" fill="#111827"/>
						    </svg>
            </span>
            <!-- <h6>{{pageTitle}}</h6> -->
            <p>"A budget doesn't limit your freedom; it gives you freedom."</p>
            <a-button type="primary" href="https://demos.creative-tim.com/muse-vue-ant-design-dashboard/documentation" block target="_blank">
              <router-link to="budgets" @click="e => e.preventDefault()">BUDGET ACCOUNTS</router-link>
            </a-button>
          </div>
        </div>
			  <!-- / Sidebar Footer -->

        <a-button type="primary" class="sync-button">
          <svg viewBox="64 64 896 896" data-icon="cloud-download" width="20px" height="20px" fill="currentColor" aria-hidden="true" focusable="false" class=""><path d="M624 706.3h-74.1V464c0-4.4-3.6-8-8-8h-60c-4.4 0-8 3.6-8 8v242.3H400c-6.7 0-10.4 7.7-6.3 12.9l112 141.7a8 8 0 0 0 12.6 0l112-141.7c4.1-5.2.4-12.9-6.3-12.9z"></path><path d="M811.4 366.7C765.6 245.9 648.9 160 512.2 160S258.8 245.8 213 366.6C127.3 389.1 64 467.2 64 560c0 110.5 89.5 200 199.9 200H304c4.4 0 8-3.6 8-8v-60c0-4.4-3.6-8-8-8h-40.1c-33.7 0-65.4-13.4-89-37.7-23.5-24.2-36-56.8-34.9-90.6.9-26.4 9.9-51.2 26.2-72.1 16.7-21.3 40.1-36.8 66.1-43.7l37.9-9.9 13.9-36.6c8.6-22.8 20.6-44.1 35.7-63.4a245.6 245.6 0 0 1 52.4-49.9c41.1-28.9 89.5-44.2 140-44.2s98.9 15.3 140 44.2c19.9 14 37.5 30.8 52.4 49.9 15.1 19.3 27.1 40.7 35.7 63.4l13.8 36.5 37.8 10C846.1 454.5 884 503.8 884 560c0 33.1-12.9 64.3-36.3 87.7a123.07 123.07 0 0 1-87.6 36.3H720c-4.4 0-8 3.6-8 8v60c0 4.4 3.6 8 8 8h40.1C870.5 760 960 670.5 960 560c0-92.7-63.1-170.7-148.6-193.3z"></path></svg>
          <span class="sync-button-text">SYNC ACCOUNTS</span>
        </a-button>

    	</a-layout-sider>
			<!-- / Main Sidebar -->

			<!-- Layout Content -->
			<a-layout>

				<!-- Layout Header's Conditionally Fixed Wrapper -->
        <a-layout-header>
          <a-row type="flex">

            <!-- Header Breadcrumbs & Title Column -->
            <a-col :span="24" :md="6">

              <!-- Header Breadcrumbs -->
              <a-breadcrumb v-if="$auth.user">
                <a-breadcrumb-item>
                  <span style="color: #8c8c8c;">Hi, {{$auth.user.email}}!</span>
                </a-breadcrumb-item>
              </a-breadcrumb>
              <!-- / Header Breadcrumbs -->

            </a-col>
            <!-- / Header Breadcrumbs & Title Column -->

            <!-- Header Control Column -->
            <a-col :span="24" :md="18" class="header-control">

              <!-- Header Control Buttons -->
              <a class="btn-sign-in" @click.prevent="logout">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M18 10C18 14.4183 14.4183 18 10 18C5.58172 18 2 14.4183 2 10C2 5.58172 5.58172 2 10 2C14.4183 2 18 5.58172 18 10ZM12 7C12 8.10457 11.1046 9 10 9C8.89543 9 8 8.10457 8 7C8 5.89543 8.89543 5 10 5C11.1046 5 12 5.89543 12 7ZM9.99993 11C7.98239 11 6.24394 12.195 5.45374 13.9157C6.55403 15.192 8.18265 16 9.99998 16C11.8173 16 13.4459 15.1921 14.5462 13.9158C13.756 12.195 12.0175 11 9.99993 11Z" fill="#111827"/>
                </svg>
                <span>Sign Out</span>
              </a>
              <!-- / Header Control Buttons -->

            </a-col>
            <!-- / Header Control Column -->

          </a-row>
        </a-layout-header>
				<!-- / Layout Header's Conditionally Fixed Wrapper -->

				<!-- Page Content -->
				<a-layout-content>
          <div>
            <a-row type="flex" :gutter="24">

              <!-- Billing Information Column -->
              <a-col :span="24" :md="16" class="mb-24">

                <a-card :bordered="false" id="budgets" class="header-solid h-full" :bodyStyle="{paddingTop: 0,}">

                  <template #title>
                    <a-row type="flex" align="middle" class="budget-header">
                      <a-col :span="24" :md="12">
                        <h6 class="font-semibold m-0">{{pageTitle}}</h6>
                      </a-col>
                      <a-col @click.prevent="addBudget" :span="24" :md="12" style="display: flex; align-items: center; justify-content: flex-end">
                        <a-button type="primary">
                          ADD NEW BUDGET
                        </a-button> 
                      </a-col>
                    </a-row>
                  </template>
              
                  <a-col v-for="budget in budgets" :span="24" :md="12" class="budget-item" :key="budget.id">
                    <a-card :id="'budget-'+budget.id" :class="budget.cssClass">
                      <div :id="'category-'+budget.category_id">
                        <input class="budget-input budget-name" type="text" name="name" v-model="budget.name" placeholder="Name" :readonly="budget.readOnly" />
                        <input class="budget-input budget-value" type="text" name="value" v-model="budget.value" placeholder="Amount" :readonly="budget.readOnly" />
                        <span class="spent">Spent: {{budget.spent}}</span>
                      </div>
                      <div class="col-action">
                        <a-button class="edit-button" @click.prevent="editBudget(budget)" type="link" size="small" title="edit">
                          <svg width="16" height="16" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path class="fill-muted" d="M13.5858 3.58579C14.3668 2.80474 15.6332 2.80474 16.4142 3.58579C17.1953 4.36683 17.1953 5.63316 16.4142 6.41421L15.6213 7.20711L12.7929 4.37868L13.5858 3.58579Z" fill="#111827"/>
                            <path class="fill-muted" d="M11.3787 5.79289L3 14.1716V17H5.82842L14.2071 8.62132L11.3787 5.79289Z" fill="#111827"/>
                          </svg>
                        </a-button>
                        <a-button class="save-button" @click.prevent="saveBudget(budget)" type="link" size="small" title="save">
                          <a-icon type="save" theme="filled" />
                        </a-button>
                        <a-button class="delete-button" @click.prevent="deleteBudget(budget.id)" type="link" size="small" title="delete">
                          <svg width="16" height="16" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path class="fill-danger" fill-rule="evenodd" clip-rule="evenodd" d="M9 2C8.62123 2 8.27497 2.214 8.10557 2.55279L7.38197 4H4C3.44772 4 3 4.44772 3 5C3 5.55228 3.44772 6 4 6L4 16C4 17.1046 4.89543 18 6 18H14C15.1046 18 16 17.1046 16 16V6C16.5523 6 17 5.55228 17 5C17 4.44772 16.5523 4 16 4H12.618L11.8944 2.55279C11.725 2.214 11.3788 2 11 2H9ZM7 8C7 7.44772 7.44772 7 8 7C8.55228 7 9 7.44772 9 8V14C9 14.5523 8.55228 15 8 15C7.44772 15 7 14.5523 7 14V8ZM12 7C11.4477 7 11 7.44772 11 8V14C11 14.5523 11.4477 15 12 15C12.5523 15 13 14.5523 13 14V8C13 7.44772 12.5523 7 12 7Z" fill="#111827"/>
                          </svg>
                        </a-button>
                      </div>                                     
                    </a-card>
                    <a-progress
                      :stroke-color="{
                        '0%': '#87d068',
                        '70%': '#FFFF00',
                        '98%': '#ff0000',
                      }"
                      :percent="99.9"
                      :show-info="false" 
                    />
                  </a-col>
                </a-card>
              </a-col>
              <!-- Billing Information Column -->

            </a-row>
          </div>
				</a-layout-content>
				<!-- / Page Content -->

				<!-- Sidebar Overlay -->
				<div class="sidebar-overlay" @click="sidebarCollapsed = true" v-show="! sidebarCollapsed"></div>
				<!-- / Sidebar Overlay -->

			</a-layout>
			<!-- / Layout Content -->
			
			<!-- Settings Drawer -->

			<!-- / Settings Drawer -->

		</a-layout>
		<!-- / Dashboard Layout -->

	</div>
</template>

<script>

export default ({
  middleware: 'auth',

// ! ||--------------------------------------------------------------------------------||
// ! ||                                      DATA                                      ||
// ! ||--------------------------------------------------------------------------------||

  data() {
    return {
      pageTitle: 'Budgets',
      navbarFixed: false,
      sidebarCollapsed: false,
      sidebarColor: "primary",
      sidebarTheme: "light",
      assetAccts: [],
      debtAccts: [],
      budgets: [],
      editable: false,
      budgetName: '',
      budgetValue: '',
    }
  },

// ! ||--------------------------------------------------------------------------------||
// ! ||                                    COMPUTED                                    ||
// ! ||--------------------------------------------------------------------------------||

  computed: {
    // Sets layout's element's class based on route's meta data.
    layoutClass() {
      return this.$route.meta.layoutClass;
    },
    // computedBudgets : {
    //   get() {
    //     return this.budgets;
    //   },
    //   set(arr) {
    //     this.budgets = arr
    //   }
    // },
  },

// ! ||--------------------------------------------------------------------------------||
// ! ||                                     MOUNTED                                    ||
// ! ||--------------------------------------------------------------------------------||

  mounted () { 
    if (this.$auth == undefined || this.$auth.user == undefined || !this.$auth.user) {
      this.$router.push('/sign-in')
    }      

    // populate sidebar accounts
    const userId = this.$auth.user.id;
    const financesApi = '/finances/' + userId;
    this.$axios.$get(financesApi)
      .then(finances => {

        this.finances = finances;

        // sidebar
        this.assetAccts = finances.accounts.asset_accounts;
        this.debtAccts = finances.accounts.debt_accounts;

        // get budgets
        let budgets = []
        for (const thisId in finances.budgets) {
          finances.budgets[parseInt(thisId)].cssClass = 'payment-method-card budget-text';
          finances.budgets[parseInt(thisId)].readOnly = 'readonly';
          budgets.push(finances.budgets[parseInt(thisId)])
        }        
        this.budgets = budgets;
        

  
        // let userAssetAccts = [];
        // let userDebtAccts = [];
        // accts.forEach(acct => {
        //   const acctId = acct.id;
        //   const acctName = slugToMixedCaseWords(acct.name); 
        //   if (acct.account_type_id == 1) {
        //     userAssetAccts.push({ id: acctId, name: acctName });
        //   } else if (acct.account_type_id == 2) {
        //     userDebtAccts.push({ id: acctId, name: acctName });
        //   }
        // })
        // this.assetAccts = userAssetAccts;
        // this.debtAccts = userDebtAccts;
      })
    
    // // get budgets
    // const budgetsApi = '/budgets/' + userId;
    // this.$axios.$get(budgetsApi)
    //   .then(budgets => {
    //     this.budgets = budgets
    //     console.log(budgets)
    //   })
 
  }, // close mounted

// ! ||--------------------------------------------------------------------------------||
// ! ||                                     METHODS                                    ||
// ! ||--------------------------------------------------------------------------------||

  methods: {
    addBudget() {
      new Promise((resolve) => {
        const id = '-undefined';
        this.budgets.unshift({id:id,name:'',value:0,cssClass:'payment-method-card budget-text editable'})
        resolve();
      })
    },
    editBudget(budgetObj) {
      console.log(budgetObj)
      // const budget = document.getElementById('budget-'+id);
      // budget.classList.add('editable');
      // const inputs = budget.getElementsByClassName('budget-input')
      // const inputsArr = Array.prototype.slice.call(inputs)
      // inputsArr.forEach((input) => {
      //   input.removeAttribute('readonly');
      // });
    },

    saveBudget(budgetObj) {
      // console.log(budgetObj)
      const userId = this.$auth.user.id;
      const createBudgetApi = '/budgets/' + userId + '/' + budgetObj.name.toLowerCase() + '/' + budgetObj.value;
        this.$axios.$post(createBudgetApi)
          .then((res) => {
            console.log(res)
          });
      },

      // let error = false;
      // // get the input vals
      // const budget = document.getElementById('budget-'+budgetId);
      // const inputs = budget.getElementsByClassName('budget-input')
      // const inputsArr = Array.prototype.slice.call(inputs)
      // let name;
      // let value;
      // inputsArr.forEach((input) => {
      //   if (input.name == 'name') {
      //     name = input.value;
      //   } else if (input.name == 'value') {
      //     value = input.value;
      //   }
      // });
      // const userId = this.$auth.user.id;
      // const spentHtmlCollection = budget.getElementsByClassName('spent');
      // const spentArr = Array.prototype.slice.call(spentHtmlCollection);
      // const spent = spentArr[0];
      
      // // some error checking
      // const categoriesApi = '/category-names/user/' + userId;
      // if (name == '') {
      //   spent.classList.add('error');
      //   spent.innerText = "Name can't be blank";
      
      // } else {

      //   // if new budget, create new budget in db
      //   if (budgetId == undefined) {
          
      //     // create budget in db
      //     this.$axios.$get(categoriesApi)
      //       .then((userCategories) => {

      //         // some more error checking first
      //         if (userCategories.includes(name.toLowerCase())) {
      //           spent.classList.add('error');
      //           spent.innerText = "You already have " + name;
      //         } else {

      //           // now create budget in db
      //           const createBudgetApi = '/budgets/' + userId + '/' + name.toLowerCase() + '/' + value;
      //           this.$axios.$post(createBudgetApi)
      //             .then((res) => {
      //               console.log(res)
      //             });
      //         }
      //       });

      //   // if pre-existing budget, edit current record in db
      //   } else {
      //     const editBudgetApi = '/budgets/' + budgetId + '/' + name.toLowerCase() + '/' + value;
      //     this.$axios.$put(editBudgetApi)
      //       .then((res) => {
      //         console.log(res)
      //       }); 
      //   }

      // }

      // // set budget back to read mode
      // if (!error) {
      //   budget.classList.remove('editable');
      //   inputsArr.forEach((input) => {
      //     input.readOnly = true;
      //   });
      // }

    // },
    deleteBudget(id) {
      const deleteBudgetApi = '/budgets/' + id;
      this.$axios.$delete(deleteBudgetApi)
        .then((res) => {
          const index = this.budgets.map(object => object.id).indexOf(id);
          this.budgets.splice(index, 1);
        });
    }

  }

}) // close export default

// ! ||--------------------------------------------------------------------------------||
// ! ||                                      UTILS                                     ||
// ! ||--------------------------------------------------------------------------------||

function slugToMixedCaseWords(slug) {
  return slug.replace('_',' ').replace(/(^\w{1})|(\s+\w{1})/g, letter => letter.toUpperCase())
}

</script>

<style lang="scss" scoped>

.layout-dashboard {
  .ant-layout-sider.sider-primary.ant-layout-sider-primary {
    .header-brand {
      h6 {
        white-space: nowrap;
        font-size: 16px;
        i {
          margin: 0 1px 0 0;
          position: relative;
          top: 1px;
          font-size: 19px;
        }
        a {
          color: #141414; 
        }
      }
      @media (min-width: 992px) {
        h6 {
          font-size: 14px;
        }
      }
    }
  }
  .footer-box p {
    font-size: 11px;
  }

  .sync-button {
    text-align: left;
    width: 100%;
    .sync-button-text {
      margin: 0 0 0 20px; 
      display: inline-block;
    }
  }

  // .ant-breadcrumb>span:last-child .ant-breadcrumb-link {
  .ant-breadcrumb span span {
    
    color: #8c8c8c;
    
  }

  // bar chart
  canvas.bar-chart-canvas {
		background-image: linear-gradient(to right, #00369E, #005CFD, #A18DFF);
    
	}

  //table 
  .tableSelector label {
    font-size: 10px;
    height: 28px;
    line-height: 26px;
  }

}

.budget-header {
  margin: 7px 0 15px;
}

.budget-item {
  margin: 0 0 30px;
  .payment-method-card.ant-card.budget-text {
    input {
      margin: 4px 0 0;
      padding: 5px;
      max-width: 130px;
      border: 1px solid #fff;
      width: 60%;
      word-spacing: 0;
      line-height: 17px;
      span {
        font-size: 12px;
      }
    }
    .spent {
      margin: 0 0 0 8px;
      display: block;
      word-spacing: 0;
      font-size: 11px;
      &.error {
        color: #ff0000;
      }
    }
    .edit-button {
      display: inline-block;
    }
    .save-button {
      display: none;
    }    
    &.editable {
      input {
        border: 1px solid #ccc;
      }
      .spent {
        visibility: hidden;
      }
      .edit-button { 
        display: none;
      }
      .save-button {
        display: inline-block;
        font-size: 15px;
      }
    }
  }
}





</style>