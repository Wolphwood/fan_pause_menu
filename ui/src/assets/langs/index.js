const LANGS = {};
let default_lang = 'en';
let current_locale = default_lang;

function RegisterLocale(code, locale) { // ⚠ Will override existings keys
    LANGS[code] = Object.assign(
        LANGS[code] ?? {},
        locale ?? {}
    )
}

function GetRawLocale(key, options = {}) {
    if (!LANGS[current_locale]) return key;
    if (!LANGS[current_locale][key]) return key;

    let value = LANGS[current_locale][key];

    if (Array.isArray(value)) {
        if (options.AllowArray === true) {
            return LANGS[current_locale][key];
        } else {
            return LANGS[current_locale][key].randomElement();
        }
    }

    return LANGS[current_locale][key];
}

function FormatString(string, args = []) {
    if (typeof args === 'undefined') args = [];
    if (!Array.isArray(args)) args = [ args ];

    let index = 0;
    return string.replace(/\%([sdifuxX])/g, (match, specifier) => {
        let value = args[index++];

        switch (specifier) {
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
    if (!LANGS[current_locale]) return key;
    if (!LANGS[current_locale][key]) return key;

    let value = GetRawLocale(key, options);

    if (Array.isArray(value)) {
        return value.map(s => FormatString(s, args));
    } else {
        return FormatString(value, args);
    }
}

export {
    RegisterLocale,
    GetRawLocale,
    GetLocale,
    FormatString,
}