<template>
  <div class="menu_container animate__animated animate__fast" :class="[animationState ? 'animate__fadeIn' : 'animate__fadeOut']" v-if="!isFetchingData && isUIOpen">
    <div class="menu animate__animated animate__fast" :class="[animationState ? 'animate__zoomIn' : 'animate__fadeOut']">
      <div v-if="page == 'main'" class="columns">
        <div class="column">
          <SectionInformation :data="data ?? {}"/>
        </div>
        <div class="column">
          <SectionGame :data="data ?? {}"  :setPage="setPage"/>
        </div>
      </div>
      <SectionAnnounces v-if="page == 'announces'" :data="announces ?? []" :setPage="setPage"/>
    </div>
  </div>
</template>

<script>
  // import { Header, Section, wButton, Rules, Report } from './components';
  import { RegisterLocale, SetCurrentLang, _getLangs } from '@/assets/langs';
  import { DebugImportLangFiles, GetDebugData } from '@/assets/js/debug'
  import { isFivemNUI, mergeDeep } from '@/assets/js/utils';
  import { ResumeGame, FetchLocales, FetchData, FetchSettings } from '@/assets/js/events'

  import SectionInformation from '@/vues/Informations.vue'
  import SectionGame from '@/vues/Game.vue'
  import SectionAnnounces from '@/vues/Announces.vue'
  
  const debug = !isFivemNUI();

  export default {
    name: 'App',
    components: {
      SectionInformation,
      SectionGame,
      SectionAnnounces,
    },
    data() {
      return debug
      ? GetDebugData()
      : {
        isFetchingData: true,
        isUIOpen: false,
        animationState: false,
        page: 'main',
        data: {},
        settings: {},
      };
    },
    async beforeMount() {
      // LANGS
      if (isFivemNUI()) {
        let data = await FetchLocales();

        for (let code in data) {
          RegisterLocale(code, data[code]);
        }

        // DATA
        this.data = await FetchData();
        this.settings = await FetchSettings();

      } else {
        let langs = await DebugImportLangFiles();
        langs.forEach(({lang, data}) => RegisterLocale(lang, data));
      }
      
      this.isFetchingData = false;
      SetCurrentLang(this.settings.language);
    },
    async mounted() {
      window.addEventListener('message', (event) => {
        let { data, action } = event.data;

        if (this.settings.verbose) console.log("REQUEST", event.data)

        switch (action) {
          case 'setLocale':
            SetCurrentLang(data);
          break;
          
          case 'uiEnabled':
            this.isUIOpen = true;
            this.animationState = true;
          break;

          case 'uiDisabled':
            this.isUIOpen = false;
          break;

          case 'setData':
            if (data) {
              this.data = data
            }
          break;

          case 'setConfig':
            if (data) {
              this.config = data
            }
          break;

          default:
          break;
        }
      });
      
      window.addEventListener('keydown', (event) => {
          if (event.key == 'Escape' && this.isUIOpen == true) {
            if (this.page !== 'main') {
              this.page = 'main';
            } else {
              this.resumeGame();
            }
          }
      });

    },
    methods: {
      resumeGame: ResumeGame,
      setPage(v) {
        this.page = v
      },
    }
  }
</script>


<style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap');

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}

#app {
  width: 100%;
  height: 100vh;
  overflow: hidden;
}

.menu_container {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  background-color: var(--bg_color_opacity);
}

.menu {
  position: relative;
  
  display: flex;
  flex-direction: row;
  
  width: 100%;
  height: 100%;

  padding: 5rem;
}

.columns {
  display: flex;
  justify-content: center;
  align-items: center;

  gap: 1rem;
  
  width: 100%;
}

.column {
  display: flex;
  flex-direction: column;
  justify-content: center;

  height: 100%;

  padding: 2rem 1rem;
}

.columns .column:nth-child(1) {
  width: 30%;
}
.columns .column:nth-child(2) {
  width: 65%;
}

</style>