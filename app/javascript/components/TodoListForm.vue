<template>
  <v-form>
    <v-text-field v-model="localFormTitle" label="タイトル"></v-text-field>
    <v-textarea v-model="localFormBody" label="詳細"></v-textarea>
    <v-layout column>
      <v-col>
        <v-checkbox v-model="localFormIsCompleted" label="完了済み?" class="float-right"></v-checkbox>
      </v-col>
      <v-col class="text-right">
        <div v-if="this.$parent.editAction">
          <v-btn @click="update" elevation="2">更新</v-btn>
        </div>
        <div v-else>
          <v-btn @click="create" elevation="2">追加</v-btn>
        </div>
      </v-col>
  </v-layout>
  </v-form>
</template>

<script>
  export default {
    props: {
      formTitle: {
        type: String
      },
      formBody: {
        type: String
      },
      formIsCompleted: {
        type: Boolean
      }
    },
    computed: {
      localFormTitle: {
        get: function() {
          return this.formTitle
        },
        set: function(value) {
          this.$emit('update:formTitle', value)
        }
      },
      localFormBody: {
        get: function() {
          return this.formBody
        },
        set: function(value) {
          this.$emit('update:formBody', value)
        }
      },
      localFormIsCompleted: {
        get: function() {
          return this.formIsCompleted
        },
        set: function(value) {
          this.$emit('update:formIsCompleted', value)
        }
      }
    },
    methods: {
      create() {
        this.$emit('create-todo', this.localFormTitle, this.localFormBody, this.localFormIsCompleted)
        this.localFormTitle = '',
        this.localFormBody = '',
        this.localFormIsCompleted = false
      },
      update() {
        this.$emit('update-todo', this.localFormTitle, this.localFormBody, this.localFormIsCompleted)
        this.todoTitle = '',
        this.todoBody = '',
        this.isCompleted = false
      }
    }
  }
</script>