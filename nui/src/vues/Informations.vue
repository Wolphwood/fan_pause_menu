<template>
  <div class="information">
    <div class="header">
      <wHeader/>
    </div>
    <div class="container">
      <div class="player-count">{{ GetLocale('menu.information.player_count', [ data.player_count ?? 999 ]) }}</div>

      <div class="frame">
        <div class="back-text">{{ GetLocale('menu.information.user') }}</div>
        <div class="text">{{ data.player ?? 'Username' }}</div>
      </div>

      <div class="frame">
        <div class="back-text">{{ GetLocale('menu.information.job') }}</div>
        <div class="text">{{ data.job ?? 'Jobless' }}</div>
      </div>

      <div class="frame">
        <div class="back-text">{{ GetLocale('menu.information.money') }}</div>
        <div class="text">{{ FormatMoney(data.money ?? 999999) }}</div>
      </div>
      
      <div class="frame">
        <div class="back-text">{{ GetLocale('menu.information.time_played') }}</div>
        <div class="text">{{ FormatTime(data.time ?? 98765) }}</div>
      </div>

      <div class="frame">
        <div class="back-text">{{ GetLocale('menu.information.id') }}</div>
        <div class="text">{{ data.id ?? 0 }}</div>
      </div>
    </div>
  </div>
</template>

<script>
  import { GetLocale, GetCurrentLang } from '@/assets/langs';
  import { wHeader } from '../components';

  function FormatTime(s) {
    const d = Math.floor(s / (24 * 3600));
    s %= 24 * 3600;
    const h = Math.floor(s / 3600);
    s %= 3600;
    const m = Math.floor(s / 60);
    s %= 60;

    const resultat = [];
    if (d > 0) resultat.push(`${d}d`);
    if (h > 0) resultat.push(`${h}h`);
    if (m > 0) resultat.push(`${m}m`);
    if (s > 0) resultat.push(`${s}s`);
    
    return resultat.join(" ");
  }

  function FormatMoney(v) {
    let formatter =  Intl.NumberFormat(GetCurrentLang(), {
      style: 'currency',
      currency: 'USD',
      currencyDisplay: "narrowSymbol"
    });
    return formatter.format(v);
  }

  export default {
    name: "SectionInformation",
    components: {
      wHeader
    },
    props: {
      data: {
        type: Object,
        required: true
      }
    },
    methods: {
      GetLocale,

      FormatMoney, FormatTime
    }
  };
</script>

<style scoped>
  .information {
    height: 100%;
    
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    
    gap: 20px;

    font-weight: bold;
  }
  
  .container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 1.2rem;
  }

  .player-count {
    padding: 1rem;
    font-size: 2rem;

    text-align: center;

    text-transform: uppercase;

    color: black;
    background-color: white;
  }

  .frame {
    position: relative;

    display: flex;
    align-items: center;
    justify-content: center;

    height: 4.5rem;

    background-color: var(--primary-color);

    text-align: center;

    overflow: hidden;
  }

  .frame .back-text {
    position: absolute;

    text-transform: uppercase;
    white-space: nowrap;

    font-size: 3.5rem;

    opacity: 0.1;
  }
  .frame .text {
    white-space: nowrap;

    font-size: 2rem;
  }
</style>