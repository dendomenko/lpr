<template>
    <div class="col-md-12" v-if="exist">
        <p><strong>{{ comment.user.email }}</strong></p>
        <p>{{ comment.text }}</p>
        <button v-if="comment.user.id === userId" @click="deleteComment">X</button>
    </div>
</template>

<script>
  import {mapGetters} from 'vuex';

  export default {
    props: ['comment'],
    data() {
      return {
        exist: true
      }
    },
    computed: {
      ...mapGetters({
        userId: 'authentication/userId'
      })
    },
    methods: {
      deleteComment() {
        this.$store.dispatch('comments/deleteComment', this.comment.id).then(() => {
          this.exist = false
        });
      }
    }
  }
</script>