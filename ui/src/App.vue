<template>
  <div class="menu_container animate__animated animate__fast" :class="[animationState ? 'animate__fadeIn' : 'animate__fadeOut']" v-if="isUIOpen">
    <div class="menu animate__animated animate__fast" :class="[animationState ? 'animate__zoomIn' : 'animate__fadeOut']">
      <div class="columns">
        <div class="column">
          <SectionInformation :data="data.information ?? {}"/>
        </div>
        <div class="column">

        </div>
      </div>
    </div>
  </div>
</template>

<script>
  // import { Header, Section, wButton, Rules, Report } from './components';
  import { RegisterLocale, GetRawLocale, GetLocale, FormatString } from './assets/langs';
  import { isFivemNUI } from '@/assets/js/utils';

  import SectionInformation from './vues/Informations.vue'
  
  if (!isFivemNUI()) {
    await import('../../locales/en.json')
      .then(LangEn => {
          RegisterLocale('en', LangEn.default || LangEn);
      })
      .catch(error => {
          console.error('Failed to load locale:', error);
      });
  }
  
  const debug = true;

  export default {
    name: 'App',
    components: {
      SectionInformation
    },
    data() {
      return {
        isUIOpen: true,
        animationState: true,

        data: {
        }
      }
    },
    mounted() {
      setTimeout(() => {
        this.data.information = {
          player: "Debugman"
        }
      }, 5_000);

      if (isFivemNUI()) {
        let langs = fetch(`https://${GetParentResourceName()}/getLocales`).then(response => response.json());
        console.log(langs);
      }

      window.addEventListener('message', (event) => {

        let { data } = event;

        switch (data.type) {
          case 'setLocales':

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
  
  width: 75%;
  height: 80%;
}

.columns {
  width: 100%;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
}

.columns .column {
  background-color: yellowgreen;
}

.columns .column:nth-child(2) {
  background-color: blueviolet;
}

</style>