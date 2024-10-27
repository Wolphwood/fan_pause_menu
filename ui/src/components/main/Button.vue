<template>
    <div class="button">
        <div class="icon" v--if="icon"><span :class="'material-symbols-' + (type ?? 'rounded')">{{ icon }}</span></div>
        <div class="title">{{ GetLocale(title ?? "unknown") }}</div>
    </div>
</template>

<script>
    import { GetLocale } from '@/assets/langs';

    export default{
        name: 'wButton',
        props: {
            title: String,
            icon : String,
            type : String,
        },
        methods: {
            GetLocale
        }
    }
</script>

<style scoped>
.material-symbols-rounded {
    font-size: 50px;
    font-variation-settings:
    'FILL' 1,
    'wght' 400,
    'GRAD' 0,
    'opsz' 48
}
.material-symbols-outlined {
  font-variation-settings:
  'FILL' 0,
  'wght' 400,
  'GRAD' 0,
  'opsz' 24
}


.button {
    position: relative;

    display: grid;
    grid-template-columns: repeat(3, 1fr);
    justify-items: center;
    align-items: center;

    width: 100%;
    height: 80px;
    
    cursor: pointer;
    
    /* padding: 10px; */
    
    background-color: var(--primary-color);
    transition: 250ms;
    
    color: var(--primary-font-color);
}
/* .button::before {
    content: "";
    position: absolute;
    top: 0; left: 0;

    background-color: var(--primary-font-color);

    width: 3px;
    height: 100%;
} */

.button:hover {
    background-color: var(--primary-color-highlight);
}

.title {
    grid-column: 2 / span 3;
    justify-self: left;
}

</style>