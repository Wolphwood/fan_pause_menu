<template>
  <div class="menu_container animate__animated animate__fast" :class="[animationState ? 'animate__fadeIn' : 'animate__fadeOut']" v-if="!isFetchingData && isUIOpen" :z="lang">
    <div class="menu animate__animated animate__fast" :class="[animationState ? 'animate__zoomIn' : 'animate__fadeOut']">
      <div class="columns">
        <div class="column">
          <SectionInformation :data="data.information ?? {}"/>
        </div>
        <div class="column">
          <SectionGame/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  // import { Header, Section, wButton, Rules, Report } from './components';
  import { RegisterLocale, GetRawLocale, GetLocale, SetCurrentLang, _getLangs } from './assets/langs';
  import { isFivemNUI } from '@/assets/js/utils';

  import SectionInformation from './vues/Informations.vue'
  import SectionGame from './vues/Game.vue'

  // if (!isFivemNUI()) {
  //   await import('../../locales/en.json')
  //     .then(lang => {
  //       RegisterLocale('en', lang.default || lang);
  //     })
  //     .catch(error => {
  //       console.error('Failed to load locale:', error);
  //     });
  //   await import('../../locales/fr.json')
  //     .then(lang => {
  //       RegisterLocale('fr', lang.default || lang);
  //     })
  //     .catch(error => {
  //       console.error('Failed to load locale:', error);
  //     });
    
  //   // SetCurrentLang('fr');
  // }
  
  const debug = true;

  export default {
    name: 'App',
    components: {
      SectionInformation,
      SectionGame
    },
    data() {
      return {
        isFetchingData: true,
        isUIOpen: false,
        animationState: true,

        lang: {},
        data: {},
      }
    },
    async beforeMount() {
      if (isFivemNUI()) {
        let data = await fetch(`https://${GetParentResourceName()}/getLocales`).then(response => response.json());
        console.log('recieved datas :', data);

        for (let code in data) {
          RegisterLocale(code, data[code]);
        }



        console.log("aaaaaaaaaaaaaaaaaaaaaaaa", _getLangs() );

        SetCurrentLang('fr');

        
        this.isFetchingData = false;
      }
    },
    async mounted() {
      if (!isFivemNUI()) { // DEBUG
        setTimeout(() => {
          this.data.information = {
            player: "Debugman",
            position: { x: 0, y: 0 }
          }
        }, 5_000);
      }

      window.addEventListener('message', (event) => {
        let { data } = event;

        console.log("REQUEST", JSON.encode(data))
        switch (data.type) {
          case 'setLocales':
            // Object.keys()
          break;
          
          case 'uiEnabled':
            this.isUIOpen = true;
            this.animationState = true;
          break;

          case 'uiDisabled':
            this.isUIOpen = false;
          break;

          default:
          break;
        }
        
        if (event.data.playerDatas != undefined) this.playerDatas = event.data.playerDatas;
        if (event.data.onlinePlayTime != undefined) this.onlinePlayTime = event.data.onlinePlayTime;
        if (event.data.activePlayersNumber != undefined) this.activePlayersNumber = event.data.activePlayersNumber;
        if (event.data.ServerName != undefined) this.ServerName = event.data.ServerName;
        if (event.data.rules != undefined) this.rules = event.data.rules;
        if (event.data.Sections != undefined) this.Sections = event.data.Sections;
        if (event.data.Buttons != undefined) this.Buttons = event.data.Buttons;
        if (event.data.placeHolders != undefined) this.placeHolders = event.data.placeHolders;
        if (event.data.discordLink != undefined) this.discordLink = event.data.discordLink;
        if (event.data.timeText != undefined) this.timeText = event.data.timeText;
        if (event.data.language != undefined) this.language = event.data.language;
      });
      
      window.addEventListener('keydown', (event) => {
          if (event.key == 'Escape' && this.isUIOpen == true){
            this.resumeGame();
          }
      });
    },
    methods: {
      resumeGame() {
        this.animationState = false
        setTimeout(function(){
          fetch(`https://${GetParentResourceName()}/resumeGame`).catch((error) => console.log(""))
        }, 600)
      },
      showMap()
      {
        fetch(`https://${GetParentResourceName()}/showMap`).catch((error) => console.log(""))
      },
      showSettings()
      {
        fetch(`https://${GetParentResourceName()}/showSettings`).catch((error) => console.log(""))
      },
      disconnect(){
        fetch(`https://${GetParentResourceName()}/disconnect`).catch((error) => console.log(""))
      },
      sendReport(){ 
        fetch(`https://${GetParentResourceName()}/sendReport`, {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify([this.reportMessage, this.reportTitle]),
        }).catch((error) => console.log(""))

        this.reportMessage = ""
        this.reportTitle = ""
      },
      sendReportData(data){
        this.reportMessage = data[0]
        this.reportTitle = data[1]
      },
      copyLink(){
        document.getElementById("clipboard").select();
        document.getElementById("clipboard").setSelectionRange(0, 99999);
        document.execCommand('copy');
      }
    },
    computed: {
      currency() {
        return new Intl.NumberFormat('en-US').format(this.playerDatas.cash)
      }
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

  /* background-color: rgba(0,0,0,0.2); */
}

.menu_container {
  width: 100%;
  height: 100vh;
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
  /* display: grid; */
  /* grid-template-columns: repeat(3, 1fr); */
  
  display: flex;
  justify-content: space-between;
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
  /* background-color: yellowgreen; */
}
.columns .column:nth-child(2) {
  width: 65%;
  /* background-color: blueviolet; */
}

</style>