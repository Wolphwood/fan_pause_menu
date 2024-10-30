<template>
    <p :class="classes">{{ content }}</p>
</template>

<script>
    export default{
      name: 'AnnounceElement',
      props: {
        data: Object
      },
      computed: {
        classes() {
          let styles = [ this.data.type ?? this.data.style ?? 'default' ];

          if (this.data.bold) styles.push('bold');
          if (this.data.italic) styles.push('italic');
          if (this.data.underlined) styles.push('underlined');

          return styles.join(' ');
        },
        content() {
          return this.data.content ?? this.data.value ?? '';
        }
      }
    }
</script>

<style scoped>
  p {
    margin-bottom: 0.1rem;
  }

  .remove, .rem, .rm, .r {
    color: var(--remove-font-color, #FF0000);
  }
  .add, .a {
    color: var(--add-font-color, #00C700);
  }
  .edit, .change, .e {
    color: var(--edit-font-color, #cfcfcf);
  }
  .comment, .c {
    color: var(--comment-font-color, #cfcfcf);
  }

  .bold {
    font-weight: bold;
  }
  .italic {
    font-style: italic;
  }
  .underline {
    text-decoration: underline;
  }
</style>