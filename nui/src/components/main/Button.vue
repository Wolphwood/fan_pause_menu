<template>
    <div class="button">
        <div class="icon"><span :class="'material-symbols-' + (type ?? 'rounded')">{{ icon }}</span></div>
        <div>{{ GetLocale(title ?? "unknown") }}</div>
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
  'opsz' 48
}

.icon {
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 150%;
}

.button {
    position: relative;

    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    
    cursor: pointer;
        
    background-color: var(--primary-color);
    transition: 250ms;
    
    color: var(--primary-font-color);

    user-select: none;

    --line-size: 6px;
}

.button.line::after {
    content: "";
    position: absolute; 
    background-color: var(--primary-font-color);
}
.button.top::after { top: 0; left: 0; height: var(--line-size, 3px); width: 100%; }
.button.bottom::after { bottom: 0; left: 0; height: var(--line-size, 3px); width: 100%; }
.button.right::after { top: 0; left: 0; width: var(--line-size, 3px); height: 100%; }
.button.right::after { top: 0; right: 0; width: var(--line-size, 3px); height: 100%; }


.button:hover {
    background-color: var(--primary-color-highlight);
}

</style>