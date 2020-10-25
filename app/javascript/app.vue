<template>
  <v-app id="app">
    <Header />
    <TodoList />
  </v-app>
</template>

<script>
import Header from "./components/header.vue";
import TodoList from "./components/TodoList.vue";

export default {
  components: {
    Header,
    TodoList,
  },
};
</script>

<style>
#app {
  background-color: #f2f2f2;
}
</style>
