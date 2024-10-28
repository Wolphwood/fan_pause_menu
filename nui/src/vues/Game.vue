<template>
  <div class="game">
    <wButton class="line bottom settings"  title="menu.button.settings"  icon="settings"/>
    <wButton class="line bottom map"       title="menu.button.map"       icon="map"/>
    
    <wButton class="line bottom announces" title="menu.button.announces" icon="campaign"/>
    <wButton class="line bottom report"    title="menu.button.report"    icon="flag"/>
    <wButton class="line bottom quit"      title="menu.button.quit"      icon="power_settings_new"/>
  </div>
</template>

<script>
  import { GetLocale } from '@/assets/langs';
  import { wButton } from '../components'

  // HAUT GAUCHE -9776 16000
  // BAS DROITE 16000 -10056

  // function 

  export default {
    name: "SectionInformation",
    components: {
      wButton
    },
    props: {
      data: {
        type: Object, // ou Object, String, selon le type de données
        required: true
      }
    },
    methods: {
      GetLocale
    }
  };
</script>

<style scoped>
  .game {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-template-rows: repeat(4, 1fr);
    
    gap: 20px;

    height: 100%;
  }

  .button {
    font-weight: bold;
    font-size: 2rem;
    text-transform: uppercase;
    padding: 0 .5rem;
  }

  .button::before {
    content: "";

    position: absolute;

    width: 100%;
    height: 100%;

    background-size: 200%;
    background-position: var(--x, 50%) var(--y, 50%);
    background-repeat: no-repeat;

    opacity: 0.2;
  }

  .button.map, .button.settings {
    --x: 50%;
    --y: 50%;

    grid-column: 1 / span 3;
    font-size: 3rem;
  }
  .button.map {
    grid-row: 2 / span 2;
    font-size: 4rem;
  }

  /* .button.settings {
    grid-column: 1 / span 3;
    font-size: 5rem;
  } */

  .button.map::before {
    background-image: url('../assets/img/map.png');
  }
  /* .button.announces::before {
    background-image: url('../assets/img/announce.png');
  } */

</style>