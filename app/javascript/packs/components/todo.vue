<template>
  <div>

    <!-- todoInput form ------------------------------------------------------>
    <div class="addTodoDrawer">
      <div class="offset-md-2 col-md-8" v-if="showAddTodo">
        <form @submit.prevent="addTodo()"> 
          <div class="form-row">
            <div class="form-group col-md-6">
              <input type="text" v-model="todoInput.title" class="form-control" placeholder="Title" autofocus id="todoInputTitle">
            </div>

            <div class="form-group col-md-4">
              <input type="date" v-model="todoInput.due" class="form-control" :min="this.todaysDate()">
            </div>

            <div class="form-group col-md-2">
              <select v-model="todoInput.priority" class="form-control" placeholder="Priority">
                <option selected :value="1">1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
              </select>
            </div>
          </div>

          <div class="form-group">
            <input type="textarea" v-model="todoInput.details" class="form-control" placeholder="Details...">
          </div>

          <input type="submit" class="btn btn-primary" value="Add">
        </form>
        <p v-for="error in todoInputErrors">{{ error }}</p>
      </div>
    </div>
  
    <!-- Todos Drawer ------------------------------------------------------>
    <div class="todosDrawer">
      <div class="container-fluid">
        <button @click="showAddTodo = !showAddTodo" class="btn btn-primary btn-sm float-right">{{ showAddTodo ? "Hide Panel" : "Show Panel" }}</button>

        <div class="row">
          <div class="col-md-6">
            <h2>Priority 1</h2>
            <hr />
            <p v-for="todo in priority1">
              <span class="badge badge-light float-right">{{ todo.due }}</span>
              {{ todo.title }}
              <a href="#" @click="deleteTodo(todo.id)">X</a>
              <br>
              <span class="text-muted">{{ todo.details }}</span>
            </p>
          </div>

          <div class="col-md-6">
            <h2>Priority 2</h2>
            <hr />
            <p v-for="todo in priority2">
              <span class="badge badge-light float-right">{{ todo.due }}</span>
              {{ todo.title }}
              <a href="#" @click="deleteTodo(todo.id)">X</a>
              <br>
              <span class="text-muted">{{ todo.details }}</span>
            </p>
          </div>
        </div>
        
        <div class="row">
          <div class="col-md-6">
            <h2>Priority 3</h2>
            <hr />
            <p v-for="todo in priority3">
              <span class="badge badge-light float-right">{{ todo.due }}</span>
              {{ todo.title }}
              <a href="#" @click="deleteTodo(todo.id)">X</a>
              <br>
              <span class="text-muted">{{ todo.details }}</span>
            </p>
          </div>

          <div class="col-md-6">
            <h2>Priority 4</h2>
            <hr />
            <p v-for="todo in priority4">
              <span class="badge badge-light float-right">{{ todo.due }}</span>
              {{ todo.title }}
              <a href="#" @click="deleteTodo(todo.id)">X</a>
              <br>
              <span class="text-muted">{{ todo.details }}</span>
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

const APIBase = process.env.TODO_MATRIX_API;

export default{
  data() {
    return {
      todos: [],
      todoInput: {
        title: "",
        priority: 1,
        details: "",
        due: null,
        position: null
      },
      todoInputErrors: [],
      showAddTodo: false
    }
  },

  created() {
    axios.get(APIBase + '/todos')
    .then((response) => {
      this.todos = response.data
    })
    this.todoInput.due = this.todaysDate()
  },

  methods: {
    addTodo() {
      this.todoInput.position = this.getTodosWithPriority(this.todoInput.priority).length

      axios.post(APIBase + '/todos', this.todoInput)
        .then((response) => {
          this.todos.push(response.data)
          this.todoInput.title = ""
          this.todoInput.details = ""
          this.todoInputErrors = []

          let input = document.getElementById('todoInputTitle')
          input.focus()
          input.select()
        })
        .catch((error) => {
          this.todoInputErrors = error.response.data.errors
        })
    },

    deleteTodo(id) {
      axios.delete(APIBase + '/todos/' + id)
      .then((response) => {
        this.todos = this.todos.filter(x => x.id !== id)
      })
    },

    getTodosWithPriority(num) {
      return this.todos.filter(x => x.priority == num)
    },
    
    todaysDate() {
      let date = new Date()
      return `${date.getFullYear()}-${("0" + (date.getMonth() + 1)).slice(-2)}-${("0" + date.getDate()).slice(-2)}`
    }
  },

  computed: {
    priority1() {
      return this.getTodosWithPriority(1)
    },

    priority2() {
      return this.getTodosWithPriority(2)
    },

    priority3() {
      return this.getTodosWithPriority(3)
    },

    priority4() {
      return this.getTodosWithPriority(4)
    }
  }
}
</script>

<style>
form {
  padding: 100px 0;
}

.todosDrawer {
  padding: 20px 0;
}
</style>
