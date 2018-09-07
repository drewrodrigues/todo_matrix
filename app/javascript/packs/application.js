/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

// Vue.use(TurbolinksAdapter)

// import News from './components/shared/News.vue'
// import NavBar from './components/shared/NavBar.vue'
// import Flash from './components/shared/Flash.vue'

const app = new Vue({
  name: 'app',
  components: {
  },

  el: "#app", 

  data: {
    flashMessages: []
  },

  template: "<div id='#app'>Something</div>",

  methods: {
    addFlash(message, className) {
      this.flashMessages.push({message: message, className: className});
      setTimeout(() => {
        this.flashMessages.shift()
      }, 3500)
    }
  }
})
