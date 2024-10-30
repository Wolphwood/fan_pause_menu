<template>
  <div class="announces">
    <h1>{{ GetLocale('menu.announce.title') }}</h1>
    <div class="content" ref="content">
      <div v-if="data" v-for="(section, index) in this.announces" :key="index" class="section">
        <h2 v-if="section.title">{{  section.title  }}</h2>
        <h3 v-if="section.subtitle">{{ section.subtitle }}</h3>
        <div v-for="(content, index) in section.content" :key="index">
          <AnnounceElement :data="content" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import { AnnounceElement } from '@/components'
  import { FetchAnnounces } from '@/assets/js/events'
  import { GetLocale } from '@/assets/langs'

  export default {
    name: "SectionAnnounces",
    props: {
      data: {
        type: Array,
        required: true
      },
      setPage: {
        type: Function
      }
    },
    components: {
      AnnounceElement
    },
    data() {
      return {
        announces: this.announces ?? []
      }
    },
    methods: {
      GetLocale,
      scrollToBottom() {
        const content = this.$refs.content;
        if (content) {
          content.scrollTop = content.scrollHeight;
        }
      }
    },
    async beforeMount() {
      this.announces = await FetchAnnounces();
    },
    mounted() {
      this.scrollToBottom();
    }
  };
</script>

<style scoped>
  .announces {
    width: 100%;
    height: 100%;

    padding: 2rem;
    background-color: var(--primary-color);
  }

  .content {
    width: 100%;
    height: 100%;

    overflow-x: hidden;
    overflow-y: scroll;
  }

  .section {
    position: relative;
    margin-bottom: 2rem;

    padding-left: 1rem
  }

  .section::before {
    content: "";

    position: absolute;
    top: 0; left: 0;

    background-color: var(--primary-font-color);
    width: 5px;
    height: 100%;
  }

  .section p {
    font-size: 1.1rem;
    padding-left: 1rem;
  }
</style>