<template>
  <v-app id="app">
    <Header></Header>
    <Todolist></Todolist>
  </v-app>
</template>

<script>
import axios from 'axios';
import Header from './components/header.vue';
import Todolist from './components/TodoList.vue';

export default {
  components: {
    Header,
    Todolist
    }
}
</script>

<style>
#app {
  background-color: #F2F2F2;
}
</style>
