<template>
  <v-app id="app">
    <Header />
    <Todolist />
  </v-app>
</template>

<script>
import axios from "axios";
import Header from "./components/header.vue";
import Todolist from "./components/TodoList.vue";

export default {
  components: {
    Header,
    Todolist,
  },
};
</script>

<style>
#app {
  background-color: #f2f2f2;
}
</style>
