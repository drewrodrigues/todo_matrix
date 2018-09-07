import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import axios from 'axios'

document.addEventListener('DOMContentLoaded', () => {
  const APIBase = "https://serene-sierra-84377.herokuapp.com";
  const app = new Vue({
    el: '#app',

    data: {
      todos: [],
      todoInput: ""
    },

    template: `
      <div>
        <input type="text" v-model="todoInput" @keyup.enter="addTodo()">
        <ul>
          <li v-for="(todo, index) in todos">
            {{ todo.title }}
            <a href="#" @click="deleteTodo(todo.id, index)">X</a>
          </li>
        </ul>
        {{ todos }}
      </div>
    `,

    components: { App },

    created() {
      axios.get(APIBase + '/todos')
      .then((response) => {
        this.todos = response.data;
      });
    },

    methods: {
      addTodo() {
        axios.post(APIBase + '/todos', { title: this.todoInput })
        .then((response) => {
          this.todos.push(response.data);
        });
      },

      deleteTodo(id, index) {
        axios.delete(APIBase + '/todos/' + id)
        .then((response) => {
          this.$delete(this.todos, index)
        });
      }
    }
  })
})
