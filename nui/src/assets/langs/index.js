let LANGS = {};
let default_lang = 'en';
let current_locale = default_lang;

function GetDefaultLang() {
    return default_lang;
}
function GetCurrentLang() {
    return current_locale;
}
function SetCurrentLang(lang) {
    return current_locale = lang;
}


function RegisterLocale(code, locale) { // ⚠ Will override existings keys
    LANGS[code] = Object.assign(
        LANGS[code] ?? {},
        locale ?? {}
    )
}

function GetRawLocale(key, options = {}) {
    if (!LANGS[options.lang ?? current_locale]) return null;
    if (!LANGS[options.lang ?? current_locale][key]) return null;

    let value = LANGS[options.lang ?? current_locale][key];

    if (Array.isArray(value)) {
        if (options.AllowArray === true) {
            return LANGS[options.lang ?? current_locale][key];
        } else {
            return LANGS[options.lang ?? current_locale][key].randomElement();
        }
    }

    return LANGS[current_locale][key];
}

function FormatString(string, args = []) {
    if (typeof args === 'undefined' || args == null) return string;
    if (!Array.isArray(args)) args = [ args ];
    if (args.length === 0) return string;

    let index = 0;
    return string.replace(/\%([asdifuxX])/g, (match, specifier) => {
        let value = args[index++];

        switch (specifier) {
            case 'a':  // Any
                return value;
            
            case 's':  // String
                return String(value);
            
            case 'd':  // Integer (signed)
            case 'i':
                return parseInt(value);
            
            case 'f':  // Floating-point
                return parseFloat(value).toFixed(2);  // Par défaut à 2 décimales, ajustable
            
            case 'u':  // Unsigned integer
                return Math.abs(parseInt(value));
            
            case 'x':  // Hexadecimal lowercase
                return parseInt(value).toString(16);
            
            case 'X':  // Hexadecimal uppercase
                return parseInt(value).toString(16).toUpperCase();
            
            default:
                return match; // Ne rien changer si le spécificateur n'est pas reconnu
        }
    });
}

function GetLocale(key, args = [], options = {}) {
    if (!LANGS[options.lang ?? current_locale]) return options.default ?? key;
    if (!LANGS[options.lang ?? current_locale][key]) return options.default ?? key;
    
    let value = GetRawLocale(key, options) ?? GetRawLocale(key, Object.assign({}, options, { lang: default_lang }));
    if (!value) return options.default ?? key;

    if (Array.isArray(value)) {
        return value.map(s => FormatString(s, args));
    } else {
        return FormatString(value, args);
    }
}

const _getLangs = (k) => k ? LANGS[k] : LANGS;

export {
    GetDefaultLang,
    GetCurrentLang,
    SetCurrentLang,
    RegisterLocale,
    GetRawLocale,
    GetLocale,
    FormatString,

    _getLangs,
}