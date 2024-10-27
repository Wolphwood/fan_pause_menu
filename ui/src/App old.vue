<template>
  <div class="menu_container animate__animated animate__fast" :class="[animationState ? 'animate__fadeIn' : 'animate__fadeOut']" v-if="isUIOpen">
    <div class="clipboard" style="position: absolute; opacity: 0;"><input type="text" v-model="discordLink" id="clipboard"></div>
    <div class="menu animate__animated animate__fast" :class="[animationState ? 'animate__zoomIn' : 'animate__fadeOut']">
      <!-- MENU LEFT -->
      <div class="menu_left">

        <div class="menu_header">
          <div class="header_content">
            <Header :title="this.ServerName" :players="this.activePlayersNumber" :language="this.language" />
          </div>
          <div class="section_name">
            <div class="line"></div>
            <div style="font-weight: 600; color: white; font-style: italic;">Informations</div>
            <div class="line"></div>
          </div>
        </div>

        <div class="informationsContent">
          <div class="informations_container">
            <Section :title="Sections.News.title" :text="Sections.News.text" />
            <Section :title="Sections.Updates.title" :text="Sections.Updates.text" />
          </div>
          <div class="informations_container2">
            <div class="menu_points">
              <wButton :title="`menu.button.settings`" :title_second="Buttons.MapSection.text"        :icon=1  @click="showMap()"/>
              <wButton :title="`menu.button.map`"      :title_second="Buttons.SettingsSection.text"   :icon=2 @click="showSettings()" />
              <wButton :title="`menu.button.quit`"     :title_second="Buttons.ResumeSection.text"     :icon=3 @click="resumeGame()" />
              <wButton :title="`keytest`"              :title_second="Buttons.DisconnectSection.text" :icon=4 @click="disconnect()"/>
            </div>
            
            <div class="player_information">
              <div class="info_box_title">{{ Sections.CharacterInfo.title }}</div>
              <!-- Name -->
              <div class="info_box" id="info_name">
                <div class="name">{{ playerDatas.name }}</div>
              </div>

              <!-- Job -->
              <div class="info_box" id="info_job">
                <div class="name">{{ playerDatas.job }}</div>
              </div>

              <!-- Cash -->
              <div class="info_box" id="info_cash">
                <div class="name">{{ currency }} $</div>
              </div>

            </div>
          </div>
        </div>
      </div>
      <div class="menu_right">
        <div class="rules_content">
          <Rules :rules="this.rules" :rulesTitle="Sections.Rules.title"/>
        </div>
        <div class="event_content">
          <Section :title="Sections.CustomSection.title" :text="Sections.CustomSection.text" />
        </div>
        <div class="sectionBottom">
          <Report :reportTitle="this.Sections.Report.title" :placeholderText="this.placeHolders.text" :placeholderTitle="this.placeHolders.title" :message="this.reportMessage" :title="this.reportTitle" @sendReportData="sendReportData"/>

          <div class="buttons" @click="copyLink()">
            <div class="menu_button">
              <div class="icon"><i class="fa-brands fa-discord"></i></div>
              <div class="menu_button_text">
                <div class="menu_button_title">{{ Sections.DiscordSection.title }}</div>
                <div class="menu_text">{{ Sections.DiscordSection.text }}</div>
              </div>
            </div>

            <div class="menu_button" @click="sendReport()">
              <div class="icon"><i class="fa-solid fa-paper-plane"></i></div>
              <div class="menu_button_text">
                <div class="menu_button_title">{{ Sections.SubmitSection.title }}</div>
                <div class="menu_text">{{ Sections.SubmitSection.text }}</div>
              </div>
            </div>

            <div class="player_info_buttons">
              <div class="playTimeContent">
                <div class="name">{{ onlinePlayTime }} {{ timeText.text }}</div>
              </div>
              <div class="id_button" id="info_id">
                <div class="name">{{ playerDatas.id}}</div>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import { Header, Section, wButton, Rules, Report } from './components';
  import { RegisterLocale, GetRawLocale, GetLocale, FormatString } from './assets/langs';

  import { isFivemNUI } from '@/assets/js/utils';
  
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
      Header,
      Section,
      wButton,
      Rules,
      Report,
    },
    data() {
      return debug
        ? {
          isUIOpen: true,
          animationState: true,
          playerDatas: [],
          onlinePlayTime: 0,
          activePlayersNumber: 0,
          rules: [],
          ServerName: "",
          Sections: {
            News: {
              title: "News - TEST"
            },
            Updates: {
              title: "Updates - v0.0.0"
            },
            CharacterInfo: {
              title: "CharacterInfo - TEST"
            },
            CustomSection: {
              title: "CustomSection - TEST"
            },
            Report: {
              title: "Report - TEST"
            },
            DiscordSection: {
              title: "DiscordSection - TEST"
            },
            DiscordSection: {
              title: "DiscordSection - TEST"
            },
            SubmitSection: {
              title: "SubmitSection - TEST"
            },
            Rules: {
              title: "SubmitSection - TEST"
            },
          },
          placeHolders: [],
          Buttons: {
            MapSection: {
              title: "MapSection - Test"
            },
            SettingsSection: {
              title: "SettingsSection - Test"
            },
            ResumeSection: {
              title: "ResumeSection - Test"
            },
            DisconnectSection: {
              title: "DisconnectSection - Test"
            },
          },
          reportMessage: "",
          reportTitle: "",
          discordLink: "",
          timeText: "",
          language: "",
        }
        : {
          isUIOpen: false,
          animationState: false,
          playerDatas: [],
          onlinePlayTime: 0,
          activePlayersNumber: 0,
          rules: [],
          ServerName: "",
          Sections: [],
          placeHolders: [],
          Buttons: [],
          reportMessage: "",
          reportTitle: "",
          discordLink: "",
          timeText: "",
          language: "",
        }
      ;
    },
    mounted() {
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

:root {
  /* --theme_color: #0dba22; */
  --bg_color: #171717;
  --bg_color_opacity: rgb(23, 23, 23, 0.6);
}

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

.menu_container{
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
  width: 70%;
  height: 60%;
  margin-bottom: 18%;
  display: flex;
  flex-direction: row;
}

.menu_right {
  position: absolute;
  top: 0;
  right: 0;
  width: 50%;
  height: 152%;
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.header_content {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.section_name {
  width: 87%;
  display: flex;
  align-items: center;
  flex-direction: row;
  gap: 10px;
  margin-top: 30px;
}

.line {
  width: 50%;
  height: 3px;
  background-color: rgb(255, 255, 255, 0.6);
}

.menu_header{
  width: 90%;
}

.informationsContent {
  width: 78%;
  display: flex;
  flex-direction: column;
  gap: 100px;
}

.informations_container {
  width: 100%;
  height: 300px;
  margin-top: 30px;
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.informations_container2 {
  width: 100%;
  height: fit-content;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-direction: row;
}

.title_name {
  color: white;
  font-size: 24px;
  font-weight: 500;
  text-transform: uppercase;
  padding: 5px 30px;
  font-style: italic;
}

.menu_points {
  width: 50%;
  height: fit-content;
  display: flex;
  flex-direction: column;
  gap: 15px;
  margin-top: 30px;
}

.player_information {
  width: 45%;
  height: 370px;
  display: flex;
  align-items: center;
  flex-direction: column;
  margin-top: 30px;
}

.info_box {
  width: 100%;
  height: fit-content;
  background-color: var(--bg_color_opacity);
  margin-top: 10px;
  padding: 33.5px 0;
}

.info_box_title {
  width: 100%;
  height: fit-content;
  background-color: var(--bg_color);
  padding: 10px;
  text-align: center;
  color: white;
  font-style: italic;
  font-weight: 500;
  text-transform: uppercase;
  border-bottom: 2px solid white;
}

.name {
  position: relative;
  font-size: 20px;
  color: white;
  text-align: center;
  font-weight: 600;
  -webkit-text-stroke-width: 1px;
  -webkit-text-stroke-color: rgba(0, 0, 0, 0.6);
  text-shadow: 0px 0px 5px rgba(0, 0, 0, 0.6);
}

#info_name {
  position: relative;
}

#info_job {
  position: relative;
  text-transform: capitalize;
}

#info_cash {
  position: relative;
}

#info_name::before {
  position: absolute;
  content: "NAME";
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-size: 60px;
  color: rgb(255, 255, 255, 0.1);
  font-weight: 700;
  text-shadow: 0px 0px 5px transparent;
  letter-spacing: 5px;
}

#info_job::before {
  position: absolute;
  content: "JOB";
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-size: 60px;
  color: rgb(255, 255, 255, 0.1);
  font-weight: 700;
  text-shadow: 0px 0px 5px transparent;
  letter-spacing: 5px;
}

#info_cash::before {
  position: absolute;
  content: "Cash";
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-size: 60px;
  color: rgb(255, 255, 255, 0.1);
  font-weight: 700;
  text-shadow: 0px 0px 5px transparent;
  letter-spacing: 5px;
}

#info_id{
  position: relative;
}

#info_id::before{
  position: absolute;
  content: "ID";
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-size: 60px;
  color: rgb(255, 255, 255, 0.1);
  font-weight: 700;
  text-shadow: 0px 0px 5px transparent;
  letter-spacing: 5px;
  padding-left: 10px;
}

.playTimeContent{
  position: relative;
  width: 60%;
  height: 100px;
  background-color: var(--bg_color_opacity);
  display: flex;
  justify-content: center;
  align-items: center;
}

.playTimeContent::before{
  position: absolute;
  content: "ONLINE";
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-size: 40px;
  color: rgb(255, 255, 255, 0.1);
  font-weight: 700;
  text-shadow: 0px 0px 5px transparent;
  letter-spacing: 5px;
}

.id_button{
  position: relative;
  width: 100px;
  height: 100px;
  background-color: var(--bg_color_opacity);
  display: flex;
  justify-content: center;
  align-items: center;
}


.rules_content {
  width: 100%;
}

.sectionBottom {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  gap: 30px;
  flex-direction: row;
  transform: translateY(-10px);
}

.buttons {
  width: 50%;
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.menu_button {
  width: 100%;
  height: 100px;
  background-color: var(--bg_color_opacity);
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: row;
  border-bottom: 3px solid white;
  cursor: pointer;
  transition: 0.5s;
}
.menu_button:hover{
  box-shadow: inset 0px -5px 10px rgba(255, 255, 255, 0.3);
}

.menu_button_text{
  width: 70%;
}

.icon {
  width: 25%;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 35px;
  color: white;
  text-shadow: 0px 0px 10px rgba(255, 255, 255, 0.3);
}

.menu_button_title{
  font-size: 24px;
  color: white;
  font-weight: 600;
}

.menu_text{
  color: rgb(255, 255, 255, 0.6);
}

.player_info_buttons{
  width: 100%;
  height: 100px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-direction: row;
}
</style>