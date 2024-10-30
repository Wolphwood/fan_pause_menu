<template>
  <div class="game">
    <wButton class="line bottom settings"  title="menu.button.settings"  icon="settings" @click="openSettings"/>
    <wButton class="line bottom map"       title="menu.button.map"       icon="map"      @click="openMap" :style="`--x: ${coords.x * 100}%; --y: ${coords.y * 100}%;`"/>
    
    <wButton class="line bottom announces" title="menu.button.announces" icon="campaign"           @click="announces"/>
    <wButton class="line bottom report"    title="menu.button.report"    icon="flag"               @click="report"/>
    <wButton class="line bottom quit"      title="menu.button.quit"      icon="power_settings_new" @click="quit"/>
  </div>
</template>

<script>
  import { wButton } from '../components'

  import { calculateMapPosPercentage } from '@/assets/js/utils'
  import { ShowMap, ShowSettings, Quit, SendReport } from '@/assets/js/events'

  export default {
    name: "SectionInformation",
    components: {
      wButton
    },
    props: {
      data: {
        type: Object,
        required: true
      },
      setPage: {
        type: Function
      }
    },
    methods: {
      openMap: ShowMap,
      openSettings: ShowSettings,
      quit: Quit,
      report: SendReport,
      announces: function() {
        this.setPage('announces');
      }
    },
    computed: {
      coords() {
        let { x, y } = calculateMapPosPercentage(this.data.coords?.x ?? 0, this.data.coords?.y ?? 0);
        return {
          x: x,
          y: 1 - y
        }
      }
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

    transition: background 2s ease-in-out;
  }

  .button.map, .button.settings {
    grid-column: 1 / span 3;
    font-size: 3rem;
  }
  .button.map {
    grid-row: 2 / span 2;
    font-size: 4rem;
  }

  .button.map::before {
    background-image: url('../assets/img/map.png');
  }

  /* .button.announces::before {
    background-image: url('../assets/img/announce.png');
  } */

</style>