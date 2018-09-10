import Vue from 'vue/dist/vue.esm'
import Todo from "./components/todo";

document.addEventListener('DOMContentLoaded', () => {

const app = new Vue({
  name: 'app',
  components: {
    Todo 
  },

  el: "#app", 

  template: "<div id='#app'><Todo></Todo></div>",
})

})
