<template>
  <v-container>
    <v-row justify="end">
      <v-col md="6">
        <v-text-field v-model="query.keyword" label="keyword" />
        <v-checkbox v-model="query.is_completed" label="完了済み?" />
        <v-btn color="success" @click="search"> 検索 </v-btn>
        <v-card
          v-for="todo in todos"
          :key="todo.id"
          max-width="500"
          max-height="250"
          class="my-6"
        >
          <v-card-title>{{ todo.title }}</v-card-title>
          <v-card-text>{{ todo.body }}</v-card-text>
          <v-layout column>
            <v-col>
              <v-checkbox
                v-model="todo.is_completed"
                label="完了済み?"
                class="float-right"
              />
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
        <v-pagination
          v-model="currentPage"
          :length="totalPages"
          @input="fetchTodos"
        />
      </v-col>
      <v-col md="5">
        <TodoListForm
          :form-title.sync="todoTitle"
          :form-body.sync="todoBody"
          :form-is-completed.sync="isCompleted"
          @create-todo="createTodo"
          @update-todo="updateTodo"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from "axios";
import TodoListForm from "./TodoListForm.vue";

export default {
  components: {
    TodoListForm,
  },
  data: function () {
    return {
      // todolist
      todos: [],
      index: [],
      selectTodo: {},
      editAction: false,
      todoTitle: "",
      todoBody: "",
      isCompleted: false,
      //paginate
      currentPage: 1,
      itemsPerPage: 10,
      totalPages: null,
      //query
      query: {
        keyword: "",
        is_completed: false,
      },
    };
  },
  created() {
    this.fetchTodos();
  },
  methods: {
    fetchTodos() {
      const url = `/api/v1/todos?page=${this.currentPage}?per=${this.itemsPerPage}`;
      axios.get(url).then((response) => {
        this.todos = response.data.todos;
        this.totalPages = response.data.total_pages;
      });
    },
    createTodo: function (todoTitle, todoBody, isCompleted) {
      axios
        .post("api/v1/todos", {
          todo: { title: todoTitle, body: todoBody, is_completed: isCompleted },
        })
        .then(
          (response) => {
            this.todos.unshift({
              title: todoTitle,
              body: todoBody,
              is_completed: isCompleted,
            });
            this.fetchTodos();
          },
          (error) => {
            console.log(error, response);
          }
        );
    },
    editTodo: function (todo) {
      this.editAction = true;
      this.selectTodo = todo.id;
      console.log(this.selectTodo);
      this.todoTitle = todo.title;
      this.todoBody = todo.body;
      this.isCompleted = todo.is_completed;
    },
    updateTodo: function () {
      console.log(this.selectTodo);
      axios
        .put(`api/v1/todos/${this.selectTodo}`, {
          todo: {
            title: this.todoTitle,
            body: this.todoBody,
            is_completed: this.isCompleted,
          },
        })
        .then(
          (response) => {
            this.todoTitle = "";
            this.todoBody = "";
            this.Completed = false;
            this.editAction = false;
            this.fetchTodos();
          },
          (error) => {
            console.log(error, response);
          }
        );
    },
    deleteTodo: function (todo) {
      axios.delete(`api/v1/todos/${todo.id}`).then(
        (response) => {
          var index = this.todos.indexOf(todo);
          this.todos.splice(index, 1);
          this.todoTitle = "";
          this.todoBody = "";
          this.Completed = false;
          this.fetchTodos();
        },
        (error) => {
          console.log(error, response);
        }
      );
    },
    search: function () {
      axios
        .get("/api/v1/todos/search", {
          params: {
            keyword: this.query.keyword,
            is_completed: this.query.is_completed,
          },
        })
        .then((response) => {
          console.log(response);
          this.todos = response.data.todos;
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>
