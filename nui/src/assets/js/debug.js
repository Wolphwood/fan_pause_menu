function DebugImportLangFiles() {
    return Promise.all(['en', 'fr'].map(code => {
        return import(`../../../../locales/${code}.json`).then(file => ({lang: code, data: file.default || file}));
    }));
}

function GetDebugData() {
    return {
        isFetchingData: false,
        isUIOpen: true,
        animationState: true,
        page: 'main',
        data: {
          player_count: 999,
          player      : "Debugman",
          coords      : { x: 0, y: 0 },
          job         : 'Jobless',
          money       : 99999,
          time        : 999,
          id          : 0,
        },
        settings: {
          serverCode: '000000',
          language: 'fr'
        },
        announces: GetDebugAnnouncesData(),
    }
}

function GetDebugAnnouncesData() {
    return Array.from(Array(10), () => ({
        "title": "Coucou les copains",
        "subtitle": "Sous titre de bz",
        "content": [
            {
                "style": "add",
                "value": "+ Ajout d'un truc de fou"
            },
            {
                "style": "remove",
                "value": "- Suppression d'un truc de fou"
            },
            {
                "style": "change",
                "value": "* Ceci est un changement aka un fix"
            },
            {
                "style": "comment",
                "italic": true,
                "value": "Ceci est un commentaire"
            },
            {
                "style": "comment",
                "bold": true,
                "value": "Ceci est un commentaire"
            },
            {
                "value": "Ceci est un texte par défaut :))"
            },
            {
                "value": "<h1>mes couilles en string</h1>"
            }
        ]
    }));
}

export { DebugImportLangFiles, GetDebugData }