## Rails, Nuxt & Ant Design Auth
This is a simple placeholder app that demonstrates working signup/login/logout functionality with Rails, Nuxt & Ant Design. It has content, which is pulled in from a PostgreSQL database through a backend API. Public content can be viewed by anyone and private content is protected and can only  be viewed when the user is logged in. Frontend auth uses the Nuxt Auth module and backend auth uses the Devise and Devise-JWT gems. I have a this same app/tutorial but with Vuetify instead of Ant Design [here](https://github.com/mark-mcdermott/rails-nuxt-vuetify-auth).

![Screenshot 1](https://github.com/mark-mcdermott/rails-nuxt-ant-design-auth/blob/main/screenshot-1.jpg)

![Screenshot 2](https://github.com/mark-mcdermott/rails-nuxt-ant-design-auth/blob/main/screenshot-2.jpg)

![Install Demo Gif](https://github.com/mark-mcdermott/rails-nuxt-ant-design-auth/blob/main/install-demo.gif)

### To Run 
- You must have PostgreSQL running in the background. See https://www.postgresql.org/download/
- `git clone https://github.com/mark-mcdermott/rails-nuxt-ant-design-auth`
- `cd rails-nuxt-ant-design-auth/backend && bundle`
- `rails db:drop db:create db:migrate`
- `rails db:seed`
- `rails secret` and then copy the the long outputted string 
- Then open the unencrypted rails credentials file
  - The command to do this depends on what text editor you use
    - If you use VS Code, to do this run `EDITOR='code --wait' rails credentials:edit` and if VS Code asks you if you want to open the encrypted file, click `OK`
    - If you use Atom, use the above line but replace `code` with `atom`.
    - If you use Nano, run `EDITOR="nano" rails credentials:edit`. Same with Vim - run `EDITOR="vi" rails credentials:edit`
  - Once the unencrypted credentials file is open, delete the commented lines 
  - For the first line, add `jwt_secret: <secret>` where `<secret>` is the long string you copied above
  - The credentials file sould look something like this (your long strings will be different, of course)
```
jwt_secret: 85b20bb9de62823e820d6baeac8cd4a1977c83e40bef77d43f14eda9c9e1767082b7c9bc08661c1ed52d6ea7cf79b5e517234080dbdab8a9c78554edf1dd4a1d
secret_key_base: 961863ec54530ab1739e2744dff87a13369671df612c49f5a552f4a247afdf734fb8cd03881f1870b35c9ae0cf44fbc6fe91d309bbdfca886a4b8d061aa1f414
```
  - Save the file and close it
- `rails s`
- In another tab, `cd rails-nuxt-ant-design-auth/frontend && yarn && npm run dev`
- Once the frontend is running (listening) in terminal, check the terminal output for the url/port it says it's listening on and go there in your browser. It will be `http://localhost:<port>` but the port is chosen randomly each time. The port will be something like `56377`, but the actual port number will be different for you. In your browser you should see something like https://share.cleanshot.com/YHidal.
- In your browser, navigate to `http://localhost:<port>/public-content`. You should see something like https://share.cleanshot.com/3yNlTI.
- Navigate to `http://localhost:<port>/log-in` - you should see something like https://share.cleanshot.com/9DBPh6. Enter `test@mail.com` for the email and `password` for the password and click Log In. https://share.cleanshot.com/67ManX If you can't login but it's giving you 200 status on the backend when you try, try the db and credential parts above again
- You should now be redirected to the Home page and should be logged in. It should look like this: https://share.cleanshot.com/IiwLIn
- Now navigate to `http://localhost:<port>/private-content`. It should look like https://share.cleanshot.com/Cj5tgf
- Now click Log Out. You should be redirected to the Home page and should be logged out. https://share.cleanshot.com/KIOGB4

### Credit
This is a modified/updated version of https://medium.com/@fishpercolator/how-to-separate-frontend-backend-with-rails-api-nuxt-js-and-devise-jwt-cf7dd9da9d16 and is not really original content whatsoever. The author of that post, Quinn Daley, did all the hard work. I had to modify it to make it work for me (Rails has gone through some updates since that was written in 2018) and I've spelled out all the steps in a bit more detail. I've also simplified some parts and fleshed out other parts a bit more. Note that the original uses docker, but this version doesn't - it just runs locally.

### Caveat
This is not an attempt to build a robust, bulletproof auth implementation. Please look to third party solutions for that.

## How To Build This Repo From Scratch
This is a tutorial on how to create this repo from scratch. 

## Initialize The Rails Backend And The Nuxt Frontend

### Create Main Folder
- `mkdir my-rails-nuxt-ant-design-auth`
- `cd my-rails-nuxt-ant-design-auth`
- `git init`
- `touch .gitignore`
- paste this into your `.gitignore` file:
```
backend/config/credentials.yml.enc

# Below are all the Nuxt default gitignore settings

# Logs
frontend/logs
frontend/*.log
frontend/npm-debug.log*
frontend/yarn-debug.log*
frontend/yarn-error.log*

# Runtime data
frontend/pids
frontend/*.pid
frontend/*.seed
frontend/*.pid.lock

# Directory for instrumented libs generated by jscoverage/JSCover
frontend/lib-cov

# Coverage directory used by tools like istanbul
frontend/coverage

# nyc test coverage
frontend/.nyc_output

# Grunt intermediate storage (http://gruntjs.com/creating-plugins#storing-task-files)
frontend/.grunt

# Bower dependency directory (https://bower.io/)
frontend/bower_components

# node-waf configuration
frontend/.lock-wscript

# Compiled binary addons (https://nodejs.org/api/addons.html)
frontend/build/Release

# Dependency directories
frontend/node_modules/
frontend/jspm_packages/

# TypeScript v1 declaration files
frontend/typings/

# Optional npm cache directory
frontend/.npm

# Optional eslint cache
frontend/.eslintcache

# Optional REPL history
frontend/.node_repl_history

# Output of 'npm pack'
frontend/*.tgz

# Yarn Integrity file
frontend/.yarn-integrity

# dotenv environment variables file
frontend/.env

# parcel-bundler cache (https://parceljs.org/)
frontend/.cache

# next.js build output
frontend/.next

# nuxt.js build output
frontend/.nuxt

# Nuxt generate
frontend/dist

# vuepress build output
frontend/.vuepress/dist

# Serverless directories
frontend/.serverless

# IDE / Editor
frontend/.idea

# Service worker
frontend/sw.*

# Vim swap files
frontend/*.swp

# macOS
.DS_Store
```

### Initialize The Rails Backend
- `rails new backend -T --skip-spring -C -B -d postgresql --api`
- `cd backend`
- `rm -rf .git .gitignore .gitattributes`
- open `backend/Gemfile`
  - add these lines to the bottom of the `Gemfile` (line 46):
```
gem "devise", "~> 4.8"
gem "devise-jwt", "~> 0.9.0"
```
  - also uncomment `# gem "jbuilder"` (line 16) and `# gem "rack-cors"` (line 34) and save.
  - run `bundle`
  - run `rails s`
  - open a browser tab on and go to `http://localhost:3000` on it.
  
### Initialize The Nuxt Frontend 
- Open a new terminal tab
- `cd` into the main `my-rails-nuxt-ant-design-auth` folder 
- Run `npx create-nuxt-app frontend` and when prompted enter these for the questions 
  - Project name: hit enter to accept default of `frontend`
  - Programming language: Select JavaScript and hit enter
  - Package manager: Select Yarn and hit enter 
  - UI framework: Select Ant Design Vue and hit enter 
  - Nuxt.js modules: on Axios hit spacebar to select and then hit enter
  - Linting tools: press enter to contiue without choosing a linter 
  - Testing framework: None
  - Rendering Tools: select Single Page App and hit enter
  - Deployment target: select Server and hit enter 
  - Development tools: hit enter to continue without choosing any development tools 
  - Enter your github username and hit enter
  - Version control system: select None and hit enter
  - After that it will take a couple minutes for Nuxt to install the starter app files
- `cd frontend`
- `yarn`
- `npm run dev`
- It will take a minute for Nuxt to load here. Once it says `Listening on: http://localhost:55081` (your port number, the `55081` part, will be different), open the localhost url it says in your browser. If we didn't have the rails server running in the other terminal tab, Nuxt would run on port 3000 by default, but since rails is running on 3000, nuxt chooses a random port).

## Setup The Backend

### Create Rails Models
- Open a third terminal tab and `cd` into the main folder, `my-rails-nuxt-ant-design-auth` 
- Do `cd backend`
- Run `rails g scaffold PublicContent name:string`
- Run `rails g scaffold PrivateContent name:string`
- Here you need to stop the rails server running in terminal. Find that terminal tab and hit `control + c` to stop the server.
- Run `rails db:drop db:create db:migrate`
- Now start the rails server again in the rails terminal tab by running `rails s`

### Scope The Rails Routes To /API
- Open `backend/config/routes.rb`
- Make the `routes.rb` file look like this:
```
Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    resources :public_contents, :private_contents
  end
end
```

### Update CORS Settings
- Open `backend/config/initializaers/cors.rb` 
  - Uncomment lines 8-16
  - Then change the origins `"example.com"` on line 10 to `"*"`

### Install Devise-JWT 
- Make sure you're in the `backend` folder and run the following:
- `rails g devise:install`
- `rails g devise user`
- `rails g model jwt_denylist jti:string:index exp:datetime`
- Open the migration file just created (`backend/db/migrate` and it should be the last file there at the bottom) and make it look like this:
```
class CreateJwtDenylists < ActiveRecord::Migration[7.0]
  def change
    create_table :jwt_denylists do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false
    end
    add_index :jwt_denylists, :jti
  end
end
```
- Open `backend/app/models/deny_list.rb` and make it look like this:
```
class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist
end
```
- Open `backend/app/models/user.rb` and make it look like this:
```
class User < ApplicationRecord
  devise :database_authenticatable, 
         :registerable,
         :jwt_authenticatable, 
         jwt_revocation_strategy: JwtDenylist
end
```
- `rails db:migrate`
- Open `backend/app/controllers/application_controller.rb` and make it look like this:
```
class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json
end
```

### Setup Rails JWT Credentials
- Make sure you are in the `backend` folder and run `rails secret`. This outputs a long random string. Copy this whole string.
- Open the rails credential file  
  - If you use VS Code, to open the credentials file, run `EDITOR='code --wait' rails credentials:edit`
  - The above line works for the Atom editor, too - just change `code` to `atom`
  - For other editors like Nano, you can run this instead: `EDITOR="nano" rails credentials:edit`. This also works for VI - just change `nano` to `vi`.
- Once your credential file is open using the above method (that unencrypts it - if you open it normally, it will still be encrypted), delete the commented lines and add a new first line: `jwt_secret: <secret>` but change `<secret>` to the long string you copied above. The credentials file will look something like this:
```
jwt_secret: 45a7335169c37a67c314671b698cfffeba735e46959a641479749aadce63fad7c430484f90be041a7c3d9b99b2480f687df6e22610b98e15f07006c1ae4eacff
secret_key_base: 461fe7f27abcfd0f4bb477f05b1d649b2f5dac2592f70be033a1eac1b1390f591e141fb7acf428a0dc4773063d6922c0a72965d2c30145252889ccaad194a387
```
- Make sure you save the credentials file and then close it in your editor (this reencrypts it).
- Now in `backend/config/initializers/devise.rb`, add the following lines on line 29:
```
config.jwt do |jwt|
  jwt.secret = Rails.application.credentials.jwt_secret
end
```

### Add Public/Private Content Seed Data And User Seed Data
- Open `backend/db/seeds.rb` again and make it look like this:
```
PublicContent.create(name:'public content 1')
PublicContent.create(name:'public content 2')
PublicContent.create(name:'public content 3')
PrivateContent.create(name:'private content 1')
PrivateContent.create(name:'private content 2')
PrivateContent.create(name:'private content 3')
User.create(email:'test@mail.com',password:'password')
```
- Now run `rails db:seed`  
- Confirm your seed data took:
  - Run `rails c`
  - Then run `PublicContent.all`
  - Run `PrivateContent.all`
  - Run `User.all`
  - The public/private content should show three entries for each and one user should show.
  - Run `exit` to exit the rails console.

### Create Sessions Controller And Views
- From `backend` run `touch app/controllers/sessions_controller.rb` and then make the new file created there look like this:
```
class SessionsController < Devise::SessionsController
  def create
    super { @token = current_token }
  end

  def show
  end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
```
- Run `mkdir app/views/devise`
- Run `mkdir app/views/devise/sessions`
- Run `touch app/views/devise/sessions/create.json.jbuilder`
- Run `touch app/views/devise/sessions/show.json.jbuilder`
- Open `app/views/devise/sessions/create.json.jbuilder` and make the file there look like this:
```
json.token @token
```
- Open `app/views/devise/sessions/show.json.jbuilder` and make the file there look like this:
```
if user_signed_in?
  json.user do
    json.(current_user, :id, :email)
  end
end
```


### Update Routes
- Open `backend/config/routes.rb` and make it look like this:
```
Rails.application.routes.draw do  
  scope :api, defaults: {format: :json} do
    resources :public_contents, :private_contents
    devise_for :users, controllers: {sessions: 'sessions'}
    devise_scope :user do
      get 'users/current', to: 'sessions#show'
    end
  end
end
```

### Verify The Backend Is Setup Correctly
- In your browser refresh your `localhost:3000` tab while watching your terminal that is running the rails server (the `rails s` command). Make sure there are no errors visible on both the `localhost:3000` webpage and in the terminal output when you refresh the webpage.
- Now in your browser, go to `localhost:3000/api/public_contents` and you should see output like this on the webpage:
```
[{"id":1,"name":"public content 1","created_at":"2022-08-16T23:06:21.560Z","updated_at":"2022-08-16T23:06:21.560Z","url":"http://localhost:3000/api/public_contents/1"},{"id":2,"name":"public content 2","created_at":"2022-08-16T23:06:21.568Z","updated_at":"2022-08-16T23:06:21.568Z","url":"http://localhost:3000/api/public_contents/2"},{"id":3,"name":"public content 3","created_at":"2022-08-16T23:06:21.573Z","updated_at":"2022-08-16T23:06:21.573Z","url":"http://localhost:3000/api/public_contents/3"}]
```
- Go to `localhost:3000/api/private_contents` and you should see output like this on the webpage:
```
[{"id":1,"name":"private content 1","created_at":"2022-08-16T23:06:21.588Z","updated_at":"2022-08-16T23:06:21.588Z","url":"http://localhost:3000/api/private_contents/1"},{"id":2,"name":"private content 2","created_at":"2022-08-16T23:06:21.596Z","updated_at":"2022-08-16T23:06:21.596Z","url":"http://localhost:3000/api/private_contents/2"},{"id":3,"name":"private content 3","created_at":"2022-08-16T23:06:21.601Z","updated_at":"2022-08-16T23:06:21.601Z","url":"http://localhost:3000/api/private_contents/3"}]
```

## Setup The Frontend

### Update The Nuxt Axios Settings 
- Open `frontend/nuxt.config.js`
- change the Axios lines from 46-49 to looks like this:
```
  axios: {
    host: 'localhost',
    port: 3000,
    prefix: '/api'
  },
```

### Add Some Frontend Layout 
- In the `frontend` folder, run 
```
mkdir layouts
```
- Then run 
```
touch layouts/default.vue
```
- Open `frontend/layouts/default.vue` 
- Change the default layout file to look like this:
```
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
          <a-button key="2"><NuxtLink to="/private-content">Private Content</NuxtLink></a-button>
          <a-button key="3"><NuxtLink to="/log-in">Log In</NuxtLink></a-button>
          <a-button key="4">Log Out</a-button>
          <a-button key="5" type="primary"><NuxtLink to="/sign-up">Sign Up</NuxtLink></a-button>
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

<style>
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



```

## Setup Nuxt Auth Module
- From inside `frontend` run `yarn add --exact @nuxtjs/auth`
- Open `frontend/nuxt.config.js` and add `'@nuxtjs/auth'` in modules on line 43
- From inside `frontend`, run `touch store/index.js`
- Open the `frontend/store/index.js` file just created and make it look like this:
```
export default {
  state: () => ({
  })
}
```
- Your terminal tab running Nuxt (`npm run dev`) probably crashed when we added the auth module before adding `frontend/store/index.js`. If so, hit `control + c` to get back to a prompt and then run `npm run dev` again. You will again have to open a new browser tab with the localhost url outputted from the `npm run dev` line. It will look like `http://localhost:55679/` but with your port number instead of `55679`. The frontend webpage should look like this now https://share.cleanshot.com/bM0a2M

### Clean Up The Home Page Content 
- Open `frontend/pages/index.vue` and make the file look like this:
```
<template>
  <h1>{{title}}</h1>
</template>

<script>
export default {
  data() {
    return {
      title: 'Home'
    }
  }
}
</script>

```
- Restart your Nuxt terminal tab (it probably crashed when we turned on auth without first creating `frontend/store/index.js`) by running `npm run dev`. In a browser, open the `http://localhost:<port>` url specified in the terminal output.
- The frontend browser tab should now look like this https://share.cleanshot.com/RxjwQ8

### Add Some Content Pages
- In terminal, make sure you are in the `frontend` folder.
- `touch pages/public-content.vue`
- `touch pages/private-content.vue`
- `touch pages/sign-up.vue`
- `touch pages/log-in.vue`

### Fill In Public/Private Content Pages 
- Open `frontend/pages/public-content.vue` and make it look like this
```
<template>
  <div>
    <h1>{{title}}</h1>
    <a-table :dataSource="contents" :columns="columns" :pagination="false" />
  </div>
</template>

<script>
export default {
  data () {
    return {
      title: 'Public Content',
      contents: [],
      columns: [
        { title: 'Id', dataIndex: 'id', key: 'id'},
        { title: 'Name', dataIndex: 'name', key: 'name'}
      ]
    }
  },
  methods: {
    async updateContent() {
      this.contents = await this.$axios.$get('/public_contents');
    }
  },
  mounted () {
    this.updateContent();
  }
}
</script>

<style>
.components-page-header-demo-responsive tr:last-child td {
  padding-bottom: 16px;
}
</style>
```
- Open `frontend/pages/private-content.vue` and make it look like this
```
<template>
  <div>
    <h1>{{title}}</h1>
    <a-table :dataSource="contents" :columns="columns" :pagination="false" />
  </div>
</template>

<script>
export default {
  data () {
    return {
      title: 'Private Content',
      contents: [],
      columns: [
        { title: 'Id', dataIndex: 'id', key: 'id'},
        { title: 'Name', dataIndex: 'name', key: 'name'}
      ]
    }
  },
  methods: {
    async updateContent() {
      this.contents = await this.$axios.$get('/private_contents');
    }
  },
  mounted () {
    this.updateContent();
  }
}
</script>

<style>
.components-page-header-demo-responsive tr:last-child td {
  padding-bottom: 16px;
}
</style>
```

## Fill In The Log In Page
- Open the `frontend/pages/log-in.vue` and make it look like this:
```
<template>
  <div>
    <h1>{{title}}</h1>
    <a-form :model="formState" :label-col="labelCol" :wrapper-col="wrapperCol">
      <a-form-item label="Email">
        <a-input v-model:value="formState.email" />
      </a-form-item>
      <a-form-item label="Password">
        <a-input type="password" v-model:value="formState.password" />
      </a-form-item>
      <a-form-item :wrapper-col="{ span: 14, offset: 4 }">
        <a-button type="primary" @click="signIn">Log In</a-button>
      </a-form-item>
    </a-form>
  </div>
</template>
<script>
import { defineComponent, reactive, toRaw } from 'vue';
export default defineComponent({
  data() {
    return {
      title: 'Log In'
    }
  },
  setup() {
    const formState = reactive({
      email: '',
      password: '',
    });
    const signIn = () => {
      console.log('email:', formState.email);
      console.log('password:', formState.password);
    };
    return {
      labelCol: {
        span: 4,
      },
      wrapperCol: {
        span: 14,
      },
      formState,
      signIn,
    };
  },
});
</script>
```
- Open `frontend/nuxt.config.js` and add this after the axios stuff on line 55:
```
auth: {
  strategies: {
    local: {
      endpoints: {
        registration:  { url: '/users' },
        login:  { url: '/users/sign_in' },
        logout: { url: '/users/sign_out', method: 'delete' },
        user:   { url: '/users/current' }
      }
    }
  }
},
```
- Open the `frontend/pages/sign-up.vue` and make it look like this:
```
<template>
  <div>
    <h1>{{title}}</h1>
    <a-form :model="formState" :label-col="labelCol" :wrapper-col="wrapperCol">
      <a-form-item label="Email">
        <a-input v-model:value="formState.email" />
      </a-form-item>
      <a-form-item label="Password">
        <a-input type="password" v-model:value="formState.password" />
      </a-form-item>
      <a-form-item :wrapper-col="{ span: 14, offset: 4 }">
        <a-button type="primary" @click="signIn">Sign Up</a-button>
      </a-form-item>
    </a-form>
  </div>
</template>
<script>
import { defineComponent, reactive, toRaw } from 'vue';
export default defineComponent({
  data() {
    return {
      title: 'Sign Up'
    }
  },
  setup() {
    const formState = reactive({
      email: '',
      password: '',
    });
    const signIn = () => {
      console.log('email:', formState.email);
      console.log('password:', formState.password);
    };
    return {
      labelCol: {
        span: 4,
      },
      wrapperCol: {
        span: 14,
      },
      formState,
      signIn,
    };
  },
});
</script>
```
- In your browser, go to `http://localhost:<your port number>/public-content` - it should look like this: https://share.cleanshot.com/JfaChp
- Go to `http://localhost:<your port number>/private-content` - it should look like this: https://share.cleanshot.com/EanBBH
- Go to `http://localhost:<your port number>/sign-up` - it should look like this: https://share.cleanshot.com/gfTIQV
- Go to `http://localhost:<your port number>/log-in` - it should look like this: https://share.cleanshot.com/aSjNxL
- At this point if you try to actually sign up on the Sign Up page, you will get an error: "Your application has sessions disabled". To avoid this, add the following to `backend/config/application.rb` at line 26:
```
config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
```
- Now restart the rails terminal tab by hitting `control + c` to get exit the server and then run `rails s` to start the server again.
- Now go to `http://localhost:<your port number>/sign-up` and try to sign up. 
  - Fill in an email address and password and click Sign Up.
  - You should then be redirected to the home page and in the top right it should say `Logged in as <your email>` like this https://share.cleanshot.com/Tz3G4S
- Now log out and go to `http://localhost:<your port number>/private-content` - note that it loads and shows the "private content" from the database. Since we are logged out, we don't want to actually be able to see this. Let's fix this.

### Make Private Content Logged-In Only
- Open `backend/app/controllers/private_contents_controller.rb` and add this on line 2: 
```
before_action :authenticate_user!
``` 
- Now in your browser open the chrome inspector and go to the Console tab. Now refresh the page. The private content should now not be showing at all on the page and in the console you should see a 401 Unauthorized error like this https://share.cleanshot.com/L0MH7l
- This is good and means the backend API is only sending private data to the frontend when the requester is logged in. But really we don't want a logged in user to be able to go to the Private Content page at all. So let's hide the Private Content nav link from users that aren't logged in.
- Open `frontend/layouts/default.vue` and on the Private Content link on line 9 add `v-if="$auth.$state.loggedIn"` so it now looks like this:
```
<NuxtLink v-if="$auth.$state.loggedIn" to="/private-content">Private Content</NuxtLink>`
```
- Now go to the homepage. Since we are logged out, the Private Content nav link does not show. https://share.cleanshot.com/diAimO
- This is good, but users who are not logged in can still directly navigate to the Private Content page by typing in `http://localhost:<your port>/private-content` in their browser. The private content on the page does not actually load, but really we want this page to redirect somewhere else for users who aren't logged in. Let's fix this.
- Open `frontend/nuxt.config.js` and Add this following on line 66 in the auth settings and under the strategies settings:
```
redirect: {
  login: '/log-in',
  logout: '/',
  callback: '/log-in',
  home: '/'
},
```
- Now open `frontend/pages/private-content.vue` and add this line on line 21 just inside `export default {`
```
middleware: 'auth',
```
- Now try directly navigating to `http://localhost:<your port>/private-content` in your browser and you should be redirected to the login page.

### Sources
This is modified version of the tutorial posted at https://medium.com/@fishpercolator/how-to-separate-frontend-backend-with-rails-api-nuxt-js-and-devise-jwt-cf7dd9da9d16
