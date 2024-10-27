<template>
    <div class="information">
      <wHeader/>
      <wButton :title="'menu.button.settings'" :icon="'person'"/>
      <wButton :title="'menu.button.map'"      :icon="'work'"/>
      <wButton :title="'menu.button.quit'"     :icon="'person'"/>
    </div>
</template>

<script>
  import { wHeader, wButton } from '../components'


  export default {
    name: "SectionInformation",
    components: {
      wHeader, wButton
    },
    props: {
      data: {
        type: Object, // ou Object, String, selon le type de données
        required: true
      }
    }
  };
</script>

<style scoped>
  .information {
    display: flex;
    flex-direction: column;
    justify-content: center;
    
    gap: 20px;

    padding: 0 20%;
  }
</style>