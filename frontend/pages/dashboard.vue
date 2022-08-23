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
            <h6>Budgets</h6>
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
                  <!-- <router-link to="/"> Fri Jul 29 2022</router-link> -->
                </a-breadcrumb-item>
                <!-- <a-breadcrumb-item>11:06 PM</a-breadcrumb-item> -->
              </a-breadcrumb>
              <!-- / Header Breadcrumbs -->

              <!-- Header Page Title -->
              <div class="ant-page-header-heading">
                <span class="ant-page-header-heading-title">{{ this.pageTitle }}</span>
              </div>
              <!-- / Header Page Title -->

            </a-col>
            <!-- / Header Breadcrumbs & Title Column -->

            <!-- Header Control Column -->
            <a-col :span="24" :md="18" class="header-control">

              <!-- Header Control Buttons -->

              <!-- <a-button type="link" ref="secondarySidebarTriggerBtn" @click="$emit('toggleSettingsDrawer', true)">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M11.4892 3.17094C11.1102 1.60969 8.8898 1.60969 8.51078 3.17094C8.26594 4.17949 7.11045 4.65811 6.22416 4.11809C4.85218 3.28212 3.28212 4.85218 4.11809 6.22416C4.65811 7.11045 4.17949 8.26593 3.17094 8.51078C1.60969 8.8898 1.60969 11.1102 3.17094 11.4892C4.17949 11.7341 4.65811 12.8896 4.11809 13.7758C3.28212 15.1478 4.85218 16.7179 6.22417 15.8819C7.11045 15.3419 8.26594 15.8205 8.51078 16.8291C8.8898 18.3903 11.1102 18.3903 11.4892 16.8291C11.7341 15.8205 12.8896 15.3419 13.7758 15.8819C15.1478 16.7179 16.7179 15.1478 15.8819 13.7758C15.3419 12.8896 15.8205 11.7341 16.8291 11.4892C18.3903 11.1102 18.3903 8.8898 16.8291 8.51078C15.8205 8.26593 15.3419 7.11045 15.8819 6.22416C16.7179 4.85218 15.1478 3.28212 13.7758 4.11809C12.8896 4.65811 11.7341 4.17949 11.4892 3.17094ZM10 13C11.6569 13 13 11.6569 13 10C13 8.34315 11.6569 7 10 7C8.34315 7 7 8.34315 7 10C7 11.6569 8.34315 13 10 13Z" fill="#111827"/>
                </svg>
              </a-button> -->
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

            <!-- Counter Widgets -->
            <a-row v-show="showWidgets" :gutter="24">
              <a-col :span="24" :lg="12" :xl="6" class="mb-24" v-for="(stat, index) in counterWidgetStats" :key="index">
                <!-- Widget 1 Card -->
                	<a-card :bordered="false" class="widget-1">
                  <a-statistic
                    :title="stat.title"
                    :value="stat.value"
                    :prefix="stat.prefix"
                    :suffix="stat.suffix"
                    :precision="0"
                    class="text-success"
                    :class="'text-' + stat.status"
                  >
                  </a-statistic>
                  <div class="icon" v-html="stat.icon"></div>
                </a-card>
                <!-- / Widget 1 Card -->
              </a-col>
            </a-row>
            <!-- / Counter Widgets -->

            <!-- Charts -->
            <a-row :gutter="24" type="flex" align="stretch">
              <a-col :span="24" :lg="10" class="mb-24">

                <div v-show="showBarChart">
                  <!-- Active Users Card -->
                  <a-card  :bordered="false" class="dashboard-bar-chart">
                      <div>
                        <canvas ref="barChart" class="bar-chart-canvas" style="height: 220px"></canvas>
                      </div>
                    <div class="card-title">
                      <h6>Cash Net Worth</h6>
                      <p>this month <span class="text-success">+23%</span></p>
                    </div>
                    <div class="card-content">
                      <p>Not included in above chart:</p>
                    </div>
                    <a-row class="card-footer" type="flex" justify="center" align="top">
                      <a-col :span="6">
                        <h4>{{this.otherAssets.stock}}</h4>
                        <span>Stock</span>
                      </a-col>
                      <a-col :span="6">
                        <h4>{{this.otherAssets.retirement}}</h4>
                        <span>401K</span>
                      </a-col>
                      <a-col :span="6">
                        <h4>{{this.otherAssets.house}}</h4>
                        <span>House</span>
                      </a-col>
                      <a-col :span="6">
                        <h4>{{this.otherAssets.cars}}</h4>
                        <span>Cars</span>
                      </a-col>
                    </a-row>
                  </a-card>
                  <!-- Active Users Card -->
                </div>

              </a-col>
              <a-col :span="24" :lg="lineChartCols" class="mb-24">
                
                <!-- Line Chart Card -->
                <a-card :bordered="false" class="dashboard-bar-line header-solid">
                  <template #title>
                    <h6>{{lineChartTitle}}</h6>			
                    <!-- <p>than last year <span class="text-success">+20%</span></p> -->
                  </template>
                  <template #extra v-if="showLineChartLegend">
                    <a-badge color="primary" class="badge-dot-primary" text="Main Checking" />
                    <a-badge color="primary" class="badge-dot-secondary" text="Credit Card" />
                  </template>
                  <div>
                    <canvas ref="lineChart" style="height: 310px"></canvas>
                  </div>
                </a-card>
                <!-- / Line Chart Card -->

              </a-col>
            </a-row>
            <!-- / Charts -->

            <!-- Table & Timeline -->
            <a-row :gutter="24" type="flex" align="stretch">
              <!-- Table -->
              <a-col :span="24" :lg="24" class="mb-24">
                
                <!-- Projects Table Card -->
                <a-card v-show="showTable" :bordered="false" class="header-solid h-full" :bodyStyle="{padding: 0,}">
                  <template #title>
                    <a-row type="flex" align="middle">
                      <a-col :span="24" :md="12">
                        <h6>Transactions</h6>			
                        <!-- <p>done this month <span class="text-primary">+40%</span></p> -->
                      </a-col>
                      <!-- <a-col :span="24" :md="12" style="display: flex; align-items: center; justify-content: flex-end">
                        <a-radio-group class="tableSelector" v-model="projectHeaderBtns" size="small">
                          <a-radio-button value="all">ACCOUNT 1</a-radio-button>
                          <a-radio-button value="online">ACCOUNT 2</a-radio-button>
                          <a-radio-button value="stores">ACCOUNT 3</a-radio-button>
                        </a-radio-group>
                      </a-col> -->
                    </a-row>
                  </template>
                  <a-table :columns="tableColumns" :data-source="tableData" :pagination="false">

                    <!--
                    <a-space slot="members" slot-scope="members" :size="-12" class="avatar-chips">
                      <template v-for="member in members">
                        <a-avatar :key="member" size="small" :src="member" />
                      </template>
                    </a-space>

                    <template slot="company" slot-scope="company">
                      <h6 class="m-0">
                        <img :src="company.logo" width="25" class="mr-10">
                        {{ company.name }}
                      </h6>
                    </template>

                    <template slot="completion" slot-scope="completion">
                      <span class="font-bold text-muted text-sm">{{ completion.label ? completion.label : completion }}</span>
                      <a-progress :percent="completion.value ? completion.value : completion" :show-info="false" size="small" :status="completion.status ? completion.status : 'normal'" />
                    </template>
                    -->

                  </a-table>

                  <!-- <div class="table-upload-btn">
                    <a-button type="dashed" block>
                      <svg width="16" height="16" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M3 17C3 16.4477 3.44772 16 4 16H16C16.5523 16 17 16.4477 17 17C17 17.5523 16.5523 18 16 18H4C3.44772 18 3 17.5523 3 17ZM6.29289 6.70711C5.90237 6.31658 5.90237 5.68342 6.29289 5.29289L9.29289 2.29289C9.48043 2.10536 9.73478 2 10 2C10.2652 2 10.5196 2.10536 10.7071 2.29289L13.7071 5.29289C14.0976 5.68342 14.0976 6.31658 13.7071 6.70711C13.3166 7.09763 12.6834 7.09763 12.2929 6.70711L11 5.41421L11 13C11 13.5523 10.5523 14 10 14C9.44771 14 9 13.5523 9 13L9 5.41421L7.70711 6.70711C7.31658 7.09763 6.68342 7.09763 6.29289 6.70711Z" fill="#111827"/>
                      </svg>
                      Upload New Project
                    </a-button>
                  </div> -->
                </a-card>
                <!-- / Projects Table Card -->
                
              </a-col>
              <!-- / Table -->

              <!-- Timeline -->
              <a-col :span="24" :lg="8" class="mb-24">

                <!-- Orders History Timeline Card -->
                
                <!-- / Orders History Timeline Card -->

              </a-col>
              <!-- / Timeline -->
            </a-row>
            <!-- / Table & Timeline -->

          </div>
				</a-layout-content>
				<!-- / Page Content -->

				<!-- Layout Footer -->
				
				<!-- / Layout Footer -->

				
				<!-- Floating Action Button For Toggling Settings Drawer -->
    		<!-- <a-button class="fab" shape="circle" @click="showSettingsDrawer = true">
					<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path fill-rule="evenodd" clip-rule="evenodd" d="M11.4892 3.17094C11.1102 1.60969 8.8898 1.60969 8.51078 3.17094C8.26594 4.17949 7.11045 4.65811 6.22416 4.11809C4.85218 3.28212 3.28212 4.85218 4.11809 6.22416C4.65811 7.11045 4.17949 8.26593 3.17094 8.51078C1.60969 8.8898 1.60969 11.1102 3.17094 11.4892C4.17949 11.7341 4.65811 12.8896 4.11809 13.7758C3.28212 15.1478 4.85218 16.7179 6.22417 15.8819C7.11045 15.3419 8.26594 15.8205 8.51078 16.8291C8.8898 18.3903 11.1102 18.3903 11.4892 16.8291C11.7341 15.8205 12.8896 15.3419 13.7758 15.8819C15.1478 16.7179 16.7179 15.1478 15.8819 13.7758C15.3419 12.8896 15.8205 11.7341 16.8291 11.4892C18.3903 11.1102 18.3903 8.8898 16.8291 8.51078C15.8205 8.26593 15.3419 7.11045 15.8819 6.22416C16.7179 4.85218 15.1478 3.28212 13.7758 4.11809C12.8896 4.65811 11.7341 4.17949 11.4892 3.17094ZM10 13C11.6569 13 13 11.6569 13 10C13 8.34315 11.6569 7 10 7C8.34315 7 7 8.34315 7 10C7 11.6569 8.34315 13 10 13Z" fill="#111827"/>
					</svg>
				</a-button> -->
				<!-- / Floating Action Button For Toggling Settings Drawer -->

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
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);

export default ({
  middleware: 'auth',

// ! ||--------------------------------------------------------------------------------||
// ! ||                                      DATA                                      ||
// ! ||--------------------------------------------------------------------------------||

  data() {
    return {
      finances: null,
      pageTitle: 'Dashboard',
      lineChartTitle: 'Main Checking & Credit Card',
      lineChartDataSet1Title: '',
      lineChartDataSet2Title: '',
      showWidgets: true,
      showBarChart: true,
      showTable: false,
      showLineChartLegend: true,
      lineChartCols: 14,
      widget1Val: '',
      widget2Val: '',
      widget3Val: '',
      widget4Val: '',
      otherAssets: {},

      assetAccts: [],
      debtAccts: [],
      
      barChart: null,
      lineChart: null,

      lineChartContents: [],
      barChartContents: {},
      // lineChartData: [],
      // lineChartLabels: [],

      tableData: [],

      // Sidebar collapsed status.
      sidebarCollapsed: false,
      
      // Main sidebar color.
      sidebarColor: "primary",
      
      // Main sidebar theme : light, white, dark.
      sidebarTheme: "light",

      // Header fixed status.
      navbarFixed: false,

      // Settings drawer visiblility status.
      showSettingsDrawer: false,

      // Counter Widgets stats
      counterWidgetStats: [
        {
          title: "Main Checking",
          value: null,
          suffix: "+30%",
          icon: `
                <svg width="22" height="22" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M8.43338 7.41784C8.58818 7.31464 8.77939 7.2224 9 7.15101L9.00001 8.84899C8.77939 8.7776 8.58818 8.68536 8.43338 8.58216C8.06927 8.33942 8 8.1139 8 8C8 7.8861 8.06927 7.66058 8.43338 7.41784Z" fill="#111827"/>
                  <path d="M11 12.849L11 11.151C11.2206 11.2224 11.4118 11.3146 11.5666 11.4178C11.9308 11.6606 12 11.8861 12 12C12 12.1139 11.9308 12.3394 11.5666 12.5822C11.4118 12.6854 11.2206 12.7776 11 12.849Z" fill="#111827"/>
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 5C11 4.44772 10.5523 4 10 4C9.44772 4 9 4.44772 9 5V5.09199C8.3784 5.20873 7.80348 5.43407 7.32398 5.75374C6.6023 6.23485 6 7.00933 6 8C6 8.99067 6.6023 9.76515 7.32398 10.2463C7.80348 10.5659 8.37841 10.7913 9.00001 10.908L9.00002 12.8492C8.60902 12.7223 8.31917 12.5319 8.15667 12.3446C7.79471 11.9275 7.16313 11.8827 6.74599 12.2447C6.32885 12.6067 6.28411 13.2382 6.64607 13.6554C7.20855 14.3036 8.05956 14.7308 9 14.9076L9 15C8.99999 15.5523 9.44769 16 9.99998 16C10.5523 16 11 15.5523 11 15L11 14.908C11.6216 14.7913 12.1965 14.5659 12.676 14.2463C13.3977 13.7651 14 12.9907 14 12C14 11.0093 13.3977 10.2348 12.676 9.75373C12.1965 9.43407 11.6216 9.20873 11 9.09199L11 7.15075C11.391 7.27771 11.6808 7.4681 11.8434 7.65538C12.2053 8.07252 12.8369 8.11726 13.254 7.7553C13.6712 7.39335 13.7159 6.76176 13.354 6.34462C12.7915 5.69637 11.9405 5.26915 11 5.09236V5Z" fill="#111827"/>
                </svg>`,
        },
        {
          title: "Main Checking + Subaccounts",
          value: null,
          suffix: "+20%",
          icon: `
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M9 2C8.44772 2 8 2.44772 8 3C8 3.55228 8.44772 4 9 4H11C11.5523 4 12 3.55228 12 3C12 2.44772 11.5523 2 11 2H9Z" fill="#111827"/>
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M4 5C4 3.89543 4.89543 3 6 3C6 4.65685 7.34315 6 9 6H11C12.6569 6 14 4.65685 14 3C15.1046 3 16 3.89543 16 5V16C16 17.1046 15.1046 18 14 18H6C4.89543 18 4 17.1046 4 16V5ZM7 9C6.44772 9 6 9.44772 6 10C6 10.5523 6.44772 11 7 11H7.01C7.56228 11 8.01 10.5523 8.01 10C8.01 9.44772 7.56228 9 7.01 9H7ZM10 9C9.44772 9 9 9.44772 9 10C9 10.5523 9.44772 11 10 11H13C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9H10ZM7 13C6.44772 13 6 13.4477 6 14C6 14.5523 6.44772 15 7 15H7.01C7.56228 15 8.01 14.5523 8.01 14C8.01 13.4477 7.56228 13 7.01 13H7ZM10 13C9.44772 13 9 13.4477 9 14C9 14.5523 9.44772 15 10 15H13C13.5523 15 14 14.5523 14 14C14 13.4477 13.5523 13 13 13H10Z" fill="#111827"/>
                </svg>`,
        },
        {
          title: "Main Credit Card",
          value: null,
          status: "danger",
          suffix: "-20%",
          icon: `
                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22">
                  <g id="bank" transform="translate(0.75 0.75)">
                    <path id="Shape" transform="translate(0.707 9.543)" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="1.5"/>
                    <path id="Path" d="M10.25,0,20.5,9.19H0Z" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="1.5"/>
                    <path id="Path-2" data-name="Path" d="M0,.707H20.5" transform="translate(0 19.793)" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="1.5"/>
                  </g>
                </svg>`,
        },
        {
          title: "Nestegg",
          value: null,
          suffix: "+10%",
          icon: `
                <svg width="22" height="22" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M3.17157 5.17157C4.73367 3.60948 7.26633 3.60948 8.82843 5.17157L10 6.34315L11.1716 5.17157C12.7337 3.60948 15.2663 3.60948 16.8284 5.17157C18.3905 6.73367 18.3905 9.26633 16.8284 10.8284L10 17.6569L3.17157 10.8284C1.60948 9.26633 1.60948 6.73367 3.17157 5.17157Z" fill="#111827"/>
                </svg>`,
        },
      ],
      projectHeaderBtns: 'all',
      // "Projects" table list of columns and their properties.
      tableColumns: [
        {
          title: 'DATE',
          dataIndex: 'date',
          width: 125
          // scopedSlots: { customRender: 'company' },
          // width: 300,
        },
        {
          title: 'DESCRIPTION',
          dataIndex: 'description',
          // scopedSlots: { customRender: 'members' },
        },
        {
          title: 'AMOUNT',
          dataIndex: 'amount',
          width: 125
          // class: 'font-bold text-muted text-sm',
        },
        {
          title: 'BALANCE',
          // scopedSlots: { customRender: 'completion' },
          dataIndex: 'balance',
          width: 125
        },
      ],

    } // return 
  },


// ! ||--------------------------------------------------------------------------------||
// ! ||                                     METHODS                                    ||
// ! ||--------------------------------------------------------------------------------||

  // methods: {

  //   dashboardClick: function() {
  //     this.pageTitle = 'Dashboard';
  //     this.lineChartTitle = 'Main Checking & Credit Card';
  //     this.showLineChartLegend = true;
  //     this.showWidgets = true;
  //     this.showBarChart = true;
  //     this.showTable = false;
  //     this.lineChartCols = 14;

      // populate sidebar accounts & line chart
      // const userId = this.$auth.user.id;
      // const accountsApi = '/accounts/' + userId;
      /*this.$axios.$get(accountsApi)
        .then(accts => {
          let userAssetAccts = [];
          let userDebtAccts = [];
          accts.forEach(acct => {
            const acctId = acct.id;
            const acctName = slugToMixedCaseWords(acct.name); 
            if (acct.account_type_id == 1) {
              userAssetAccts.push({ id: acctId, name: acctName });
            } else if (acct.account_type_id == 2) {
              userDebtAccts.push({ id: acctId, name: acctName });
            }
          })
          this.assetAccts = userAssetAccts;
          this.debtAccts = userDebtAccts;
        })
        .then(() => {

          // get bar chart
          const cashNetWorthApi = /cash-net-worth/ + userId;
          this.$axios.$get(cashNetWorthApi)
            .then((cashNetWorth) => { 
              let labels = [];
              let data = [];
              cashNetWorth.forEach((monthObj) => {
                labels.push(monthObj.month);
                data.push(monthObj.balance);
              });
              let barChartContents = { 'labels': labels, 'data': data }
              this.barChart.destroy();
              this.renderBarChart(barChartContents);
            });    

          // get line chart
          const mainAssetAcct = this.assetAccts[0];
          const mainDebtAcct = this.debtAccts[0];
          this.lineChartDataSet1Title = mainAssetAcct.name;
          this.lineChartDataSet2Title = mainDebtAcct.name;
          const lineChartAccts = [mainAssetAcct,mainDebtAcct];
          let lineChartContent = [];
          new Promise((resolve) => {
            lineChartAccts.forEach((acct,index) => {
              const transactionsApi = 'transactions/account/' + acct.id + '/' + userId;
              this.$axios.$get(transactionsApi)
                .then((transactionsData) => {
                  const dataClean = transactionsData.map((row)=>{ 
                    const date = row.date;
                    const description = row.description;
                    const amount = row.amount;  
                    const balance = row.balance;
                    return {date, description, amount, balance};
                  });  
                  const sparseBalances = transactionsToSparseBalances(dataClean);
                  const filledBalances = sparseBalancesToFilledBalances(sparseBalances);
                  const balances = filledBalances.map(row => { return row.balance.replace('$','').replace(',',''); });
                  const filledDates = filledBalances.map(row => { return row.date; });
                  const title = acct.name;
                  const labels = filledDates;
                  const data = balances;
                  const thisLineChartContent = {title: title, labels: labels, data: data};
                  lineChartContent.push(thisLineChartContent)
                  if (index === lineChartAccts.length -1) {
                    resolve();
                  }
                })
            }); 
          }).then(() => {
            this.lineChart.destroy();
            this.renderLineChart(lineChartContent);
          });
        });

    },*/

    /*accountClick: function(acctId,name) {
      
      this.pageTitle = name;
      this.lineChartTitle = name,
      this.showLineChartLegend = false; 
      this.showWidgets = false;
      this.showBarChart = false;
      this.showTable = true;
      this.lineChartCols = 24;

      const userId = this.$auth.user.id;
      const transactionsApi = 'transactions/account/' + acctId + '/' + userId
      this.$axios.$get(transactionsApi)
        .then((transactionsData) => {
          
          
            const dataClean = transactionsData.map((row)=>{ 
              const date = row.date;
              const description = row.description;
              const amount = row.amount;  
              const balance = row.balance;
              return {date, description, amount, balance};
            });  
            const sparseBalances = transactionsToSparseBalances(dataClean);
            const filledBalances = sparseBalancesToFilledBalances(sparseBalances);
            const balances = filledBalances.map(row => { return row.balance.replace('$','').replace(',',''); });
            const filledDates = filledBalances.map(row => { return row.date; });
            const lineChartTitle = 'Mobile Apps';
            const lineChartLabels = filledDates;
            const lineChartData = balances;
            
              this.lineChart.destroy();
              this.renderLineChart([{ title: lineChartTitle, labels: lineChartLabels, data: lineChartData }]);

              this.tableData = dataClean.map((row, index)=>{ 
                const key = index;
                const date = friendlyDate(row.date);
                const description = row.description;
                const amount = row.amount;  
                const balance = row.balance;
                return {key, date, description, amount, balance};
              });
        })
    },*/

    /*toggleSidebar( value ) {
      this.sidebarCollapsed = value ;
    },
    toggleSettingsDrawer( value ) {
      this.showSettingsDrawer = value ;
    },
    toggleNavbarPosition( value ) {
      this.navbarFixed = value ;
    },
    updateSidebarTheme( value ) {
      this.sidebarTheme = value ;
    },
    updateSidebarColor( value ) {
      this.sidebarColor = value ;
    },
    logout: function () {
      this.$auth.logout().catch(e => {this.error = e + ''})
    },*/

    /*renderBarChart: function(barChartContents) {
      this.barChartContents = barChartContents;

      const barChartCtx = this.$refs.barChart.getContext("2d");
      this.barChart = new Chart(barChartCtx, {
        type: "bar",
        data: {
          // labels: ["Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
          labels: this.computedBarChartContents['labels'],
          datasets: [{
            label: "Sales",
            backgroundColor: '#fff',
            borderWidth: 0,
            borderSkipped: false,
            borderRadius: 6,
            data: this.computedBarChartContents['data'],
            maxBarThickness: 20,
          },],
        },
        options: {
          layout: {
            padding: {
              top: 30,
              right: 15,
              left: 10,
              bottom: 5,
            },
          },
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              display: false,
            },
          },
          tooltips: {
            enabled: true,
            mode: "index",
            intersect: false,
          },
          scales: {
            y: {
              grid: {
                display: true,
                color: "rgba(255, 255, 255, .2)",
                zeroLineColor: "#ffffff",
                borderDash: [6],
                borderDashOffset: [6],
              },
              ticks: {
                suggestedMin: 0,
                suggestedMax: 1000,
                display: true,
                color: "#fff",
                callback: function(value, index, values) {
                  return '$' + value;
                },
                font: {
                  size: 14,
                  lineHeight: 1.5,
                  weight: '600',
                  family: "Open Sans",
                },
              },
            },
            x: {
              grid: {
                display: false,
              },
              ticks: {
                display: true,
                color: "#fff",
                font: {
                  size: 14,
                  lineHeight: 1.5,
                  weight: '600',
                  family: "Open Sans",
                },
              },
            },
          },
        }
      });
    },*/

    /*renderLineChart: function(chartContent) {
      this.lineChartContents = chartContent;

      const options = {
        tension: 0.4,
        borderWidth: 0,
        pointRadius: 0,
        borderWidth: 3,
        maxBarThickness: 6,
        borderColor: ['#1890FF', '#B37FEB']
      }

      let dataSets = [];
      new Promise((resolve) => {
        chartContent.forEach((content, index) => {

          let thisDataSet = {
            data: this.computedLineChartContents[index]['data'],
            label: this.computedLineChartContents[index]['title'],
            tension: options.tension,
            borderWidth: options.borderWidth,
            pointRadius: options.pointRadius,
            borderColor: options.borderColor[index],
            borderWidth: options.borderWidth,
            maxBarThickness: options.maxBarThickness
          }

          dataSets.push(thisDataSet);

        })
        if (dataSets.length == 2) { 
          resolve() 
        }
      }).then(() => {
        const lineChartCtx = this.$refs.lineChart.getContext("2d");
        this.lineChart = new Chart(lineChartCtx, {
            type: "line",
            data: {
              labels: this.computedLineChartContents[0]['labels'],
              datasets: dataSets
            },
            options: {
              layout: {
                padding: {
                  top: 30,
                  right: 15,
                  left: 10,
                  bottom: 5,
                },
              },
              responsive: true,
              maintainAspectRatio: false,
              plugins: {
                legend: {
                  display: false,
                },
              },
              tooltips: {
                enabled: true,
                mode: "index",
                intersect: false,
              },
              scales: {
                y: {
                  grid: {
                    display: true,
                    color: "rgba(0, 0, 0, .2)",
                    zeroLineColor: "#000000",
                    borderDash: [6],
                    borderDashOffset: [6],
                  },
                  ticks: {
                    suggestedMin: 0,
                    suggestedMax: 1000,
                    display: true,
                    color: "#8C8C8C",
                    callback: function(value) {
                      return toCurrency(value);
                    },
                    font: {
                      size: 14,
                      lineHeight: 1.8,
                      weight: '600',
                      family: "Open Sans",
                    },
                  },
                },
                x: {
                  grid: {
                    display: false,
                  },
                  ticks: {
                    display: true,
                    color: "#8C8C8C",
                    font: {
                      size: 14,
                      lineHeight: 1.5,
                      weight: '600',
                      family: "Open Sans",
                    },
                  },
                },
              },
            }
          });
      })

    }

  },*/

  computed: {

    /*computedLineChartContents : {
      get() {
        return this.lineChartContents;
      },
      set(arr) {
        this.lineChartContents = arr
      }
    },

    computedBarChartContents : {
      get() {
        return this.barChartContents;
      },
      set(obj) {
        this.barChartContents = obj
      }
    },*/

    // Sets layout's element's class based on route's meta data.
    layoutClass() {
      return this.$route.meta.layoutClass;
    }
  },


// ! ||--------------------------------------------------------------------------------||
// ! ||                                     MOUNTED                                    ||
// ! ||--------------------------------------------------------------------------------||

  mounted () { 
    
    // call finances api here!!
    const userId = this.$auth.user.id;
    const financesApi = '/finances/' + userId;
    this.$axios.$get(financesApi)
      .then(finances => {
        console.log(finances)
      });

    /*this.tableData = [
      {
        key: '1',
        date: '2/7/22',
        description: 'description',
        amount: '$4.72',
        balance: '$14,000',
      },
      {
        key: '2',
        date: '2/7/22',
        description: 'description',
        amount: '$4.72',
        balance: '$14,000',
      },
      {
        key: '3',
        date: '2/7/22',
        description: 'description',
        amount: '$4.72',
        balance: '$14,000',
      },
      {
        key: '4',
        date: '2/7/22',
        description: 'description',
        amount: '$4.72',
        balance: '$14,000',
      },
      {
        key: '5',
        date: '2/7/22',
        description: 'description',
        amount: '$4.72',
        balance: '$14,000',
      },
      {
        key: '6',
        date: '2/7/22',
        description: 'description',
        amount: '$4.72',
        balance: '$14,000',
      },
    ];*/

    // const barChartCtx = this.$refs.barChart.getContext("2d");
    // this.renderBarChart(barChartCtx);

    if (this.$auth == undefined || this.$auth.user == undefined || !this.$auth.user) {
      this.$router.push('/sign-in')
    }


    // populate widgets
    // const userId = this.$auth.user.id;
    // main checking balance widget
    /*const accountsApi = '/accounts/' + userId;
    this.$axios.$get(accountsApi)
      .then(accts => {
        const mainCheckingId = accts[0]['id'];
        const mainCheckingBalanceApi = 'account-balance/' + mainCheckingId + '/' + userId;
        this.$axios.$get(mainCheckingBalanceApi)
          .then((mainCheckingBal) => {
            this.counterWidgetStats[0].value = mainCheckingBal;
          })
        return accts;
      })
      // credit balance widget
      .then(accts => {
        let creditAcct = null;
        accts.forEach((acct) => {
          if (acct.account_type_id == 2) {
            creditAcct = acct;
          }
        })
        const creditBalanceApi = 'account-balance/' + creditAcct.id + '/' + userId;
        this.$axios.$get(creditBalanceApi)
          .then((creditBal) => {
            this.counterWidgetStats[2].value = creditBal;
          })
        return accts;
      })
      .then((accts) => {
        let nestegg = null;
        accts.forEach((acct) => {
          if (acct.name.includes('nestegg')) {
            nestegg = acct;
          }
        })
        const nesteggBalanceApi = 'account-balance/' + nestegg.id + '/' + userId;
        this.$axios.$get(nesteggBalanceApi)
          .then((nesteggBal) => {
            this.counterWidgetStats[3].value = nesteggBal;
          })
      });*/


    // total checking balance widget
    /*const checkingBalanceApi = /checking-balance/ + userId;
    this.$axios.$get(checkingBalanceApi)
      .then((checkingBal) => { 
        this.counterWidgetStats[1].value = checkingBal 
      });*/   

    // get bar chart 
   /*const cashNetWorthApi = /cash-net-worth/ + userId;
    this.$axios.$get(cashNetWorthApi)
      .then((cashNetWorth) => { 
        let labels = [];
        let data = [];
        cashNetWorth.forEach((monthObj) => {
          labels.push(monthObj.month);
          data.push(monthObj.balance);
        });
        let barChartContents = { 'labels': labels, 'data': data }
        this.renderBarChart(barChartContents);
      });    */
    

    // get other assets (for below bar chart)
    /*const otherAssetsApi = /other-assets/ + userId;
    this.$axios.$get(otherAssetsApi)
      .then((otherAssets) => { 
        otherAssets.forEach((asset) => {
          const name = asset.name;
          const value = toKCurrency(asset.value);
          if (name == '401k') {
            this.otherAssets['retirement'] = value;
          } else {
            this.otherAssets[name] = value;
          }
          
        });
        
      });   */ 
    

    // populate sidebar accounts & line chart
    // const userId = this.$auth.user.id;
    // const accountsApi = '/accounts/' + userId;
    /*this.$axios.$get(accountsApi)
      .then(accts => {
        let userAssetAccts = [];
        let userDebtAccts = [];
        accts.forEach(acct => {
          const acctId = acct.id;
          const acctName = slugToMixedCaseWords(acct.name); 
          if (acct.account_type_id == 1) {
            userAssetAccts.push({ id: acctId, name: acctName });
          } else if (acct.account_type_id == 2) {
            userDebtAccts.push({ id: acctId, name: acctName });
          }
        })
        this.assetAccts = userAssetAccts;
        this.debtAccts = userDebtAccts;
      })
      .then(() => {

        // get line chart
        const mainAssetAcct = this.assetAccts[0];
        const mainDebtAcct = this.debtAccts[0];
        this.lineChartDataSet1Title = mainAssetAcct.name;
        this.lineChartDataSet2Title = mainDebtAcct.name;
        const lineChartAccts = [mainAssetAcct,mainDebtAcct];
        let lineChartContent = [];
        new Promise((resolve) => {
          lineChartAccts.forEach((acct,index) => {
            const transactionsApi = 'transactions/account/' + acct.id + '/' + userId;
            this.$axios.$get(transactionsApi)
              .then((transactionsData) => {
                const dataClean = transactionsData.map((row)=>{ 
                  const date = row.date;
                  const description = row.description;
                  const amount = row.amount;  
                  const balance = row.balance;
                  return {date, description, amount, balance};
                });  
                const sparseBalances = transactionsToSparseBalances(dataClean);
                const filledBalances = sparseBalancesToFilledBalances(sparseBalances);
                const balances = filledBalances.map(row => { return row.balance.replace('$','').replace(',',''); });
                const filledDates = filledBalances.map(row => { return row.date; });
                const title = acct.name;
                const labels = filledDates;
                const data = balances;
                const thisLineChartContent = {title: title, labels: labels, data: data};
                lineChartContent.push(thisLineChartContent)
                if (index === lineChartAccts.length -1) {
                  resolve();
                }
              })
          }); 
        }).then(() => {
          this.renderLineChart(lineChartContent);
        });
      });  */
  },
  // Right before the component is destroyed,
  // also destroy the chart.
  beforeDestroy: function () {
    if (this.barChart != null) {
      this.barChart.destroy();
    }
    if (this.lineChart != null) {
      this.lineChart.destroy();
    }
  },
})

// utils
function slugToMixedCaseWords(slug) {
  return slug.replace('_',' ').replace(/(^\w{1})|(\s+\w{1})/g, letter => letter.toUpperCase())
}
function friendlyDateToJsDate(friendly) { // 12/31/22 => Date('12/31/2022') 
  const yearIndex = friendly.length - 2;
  const fullDate = friendly.slice(0, yearIndex) + '20' + friendly.slice(yearIndex);
  return new Date(fullDate)
}
function jsDateToFriendlyDate(date) {
    return date.getMonth()+1 + "/" + date.getDate() + "/" + date.getFullYear().toString().substr(-2);
}
function doesArrOfBalObjsContainDate(arr, date) {
  for (const row of arr) {
    if (row.date == date) return true;
  }
  return false;
}
function sparseBalancesToFilledBalances(sparse) {
  let filled = [];
  const start = friendlyDateToJsDate(sparse[0]['date']);
  const end = friendlyDateToJsDate(sparse[sparse.length-1]['date']);
  let prevBal = sparse[0]['balance'];
  let curDate = start;

  while (curDate <= end) {
    const thisDay = jsDateToFriendlyDate(curDate);
    let match = null;
    for (const row of sparse) {
      if (row.date == thisDay) {
        match = row;
        break;
      } 
    }
    if (match) {
      if (!doesArrOfBalObjsContainDate(filled,thisDay)) {
        filled.push(match);
        prevBal = match.balance;
      }
    } else {
      filled.push({ date: thisDay, balance: prevBal });
    }
    curDate.setDate(curDate.getDate() + 1);
  }
  return filled;
}
function transactionsToSparseBalances(transactions) {
  return transactions.map(function(transaction){ 
    const date = friendlyDate(transaction.date);
    const balance = transaction.balance;
    return { date, balance }; 
  });
}
function friendlyDate(date) { // takes in yyyy-mm-dd, returns m/d/yy
  const arr = date.split('-');
  let year = arr[0].toString();
  year = year.slice(2);
  let month = arr[1];
  month = (month[0] == '0') ? month[1] : month;
  let day = arr[2];
  day = (day[0] == '0') ? day[1] : day;
  return month+'/'+day+'/'+year
}
function toCurrency(num) {
  const totalWithCommas = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  const totalWithDollarSign = '$' + totalWithCommas;
  return totalWithDollarSign;
}
function toKCurrency(num) {
  const totalWithCommas = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  const totalWithDollarSign = '$' + totalWithCommas;
  const totalWithK = totalWithDollarSign.slice(0, -4) + 'k';
  return totalWithK;
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



</style>