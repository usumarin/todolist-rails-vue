<template>
  <v-app id="app">
    <Header></Header>
    <Todo></Todo>
  </v-app>
</template>

<script>
import axios from 'axios';
import Header from './components/header.vue';
import Todo from './components/todo.vue';

export default {
  components: {
    Header,
    Todo
    }
}
</script>

<style>
</style>
