<template>
  <v-container>
    <v-row justify="end">
  <v-col md=6>
      <v-card v-for="todo in todos" :key="todo.id" max-width=500 max-height=250 class="my-6">
        <v-card-title>{{ todo.title }}</v-card-title>
        <v-card-text>{{ todo.body }}</v-card-text>
        <v-layout column>
          <v-col>
            <v-checkbox v-model="todo.is_completed" label="完了済み?" class="float-right"></v-checkbox>
          </v-col>
          <v-col class="text-right">
            <v-btn icon @click="editTodo(todo)">
              <v-icon>edit</v-icon>
            </v-btn>
            <v-btn icon @click="deleteTodo(todo)">
              <v-icon>delete</v-icon>
            </v-btn>
          </v-col>
        </v-layout>
      </v-card>
      <v-pagination v-model="currentPage" :length="totalPages" @input="fetchTodos"></v-pagination>
  </v-col>
  <v-col md=5>
    <v-form>
      <v-text-field v-model="todoTitle" label="タイトル"></v-text-field>
      <v-textarea v-model="todoBody" label="詳細"></v-textarea>
      <v-layout column>
        <v-col>
          <v-checkbox v-model="isCompleted" label="完了済み?" class="float-right"></v-checkbox>
        </v-col>
        <v-col class="text-right">
          <div v-if="editAction">
            <v-btn @click="updateTodo" elevation="2">更新</v-btn>
          </div>
          <div v-else>
            <v-btn @click="createTodo" elevation="2">追加</v-btn>
          </div>
        </v-col>
    </v-layout>
    </v-form>
  </v-col>
  </v-row>
  </v-container>
</template>

<script>
import axios from 'axios';

export default {
  data: function() {
    return{
      // todolist
      todos: [],
      index: [],
      selectTodo: {},
      editAction: false,
      todoTitle: '',
      todoBody: '',
      isCompleted: false,
      //paginate
      currentPage: 1,
      itemsPerPage: 10,
      totalPages: null,
    }
  },
  created() {
    this.fetchTodos()
  },
  methods: {
    fetchTodos() {
      axios
      const url = `/api/v1/todos?page=${this.currentPage}?per=${this.itemsPerPage}`
      axios
        .get(url)
        .then(response => {
          this.todos = response.data.todos;
          this.totalPages = response.data.total_pages;
        })
      },
    createTodo: function() {
      if(this.todoTitle == '') return;
      
      axios.post('api/v1/todos', { todo: { title: this.todoTitle, body: this.todoBody, is_completed: this.isCompleted }}).then((response) => {
        this.todos.unshift({
          title: this.todoTitle,
          body: this.todoBody,
          is_completed: this.isCompleted
        })
        this.todoTitle = '';
        this.todoBody = '';
        this.Completed = false;
      }, (error) => {
        console.log(error, response);
      });
  },
  editTodo: function(todo) {
    this.editAction = true;
    this.selectTodo = todo.id;
    console.log(this.selectTodo);
    this.todoTitle = todo.title;
    this.todoBody = todo.body;
    this.isCompleted = todo.is_completed;
  },
  updateTodo: function() {
    console.log(this.selectTodo);
    axios.put(`api/v1/todos/${this.selectTodo}`, { todo: { title: this.todoTitle, body: this.todoBody, is_completed: this.isCompleted }}).then((response) => {
        this.todoTitle = '';
        this.todoBody = '';
        this.Completed = false;
        this.editAction = false;
        this.fetchTodos();
      }, (error) => {
        console.log(error, response);
      });
    },
  deleteTodo: function(todo) {
    axios.delete(`api/v1/todos/${todo.id}`).then((response) => {
        var index = this.todos.indexOf(todo)
        this.todos.splice(index, 1);
        this.todoTitle= '';
        this.todoBody = '';
        this.Completed = false;
      }, (error) => {
        console.log(error, response);
      });
  }
  },
}
</script>