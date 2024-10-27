config = {
    discordLink = "https://discord.gg/NuFJ4w7jzU", -- Set discrod link
    discord_Webhook = "https://discord.com/api/webhooks/1299372240965472296/-J-WaDhp3DhuN_4RRYpXgQdb9za4uxbZQDayy6Q7WwcAp3oTP_z6RLncUdI2b7XawlIL",
    discord_WebhookName = "Report Serveur !",
    discord_footer_message = "Repport de : ",
    discord_WebhookColor = 16753920, -- Only decimal color
    discord_error_message = "Formulaire incorrect!",

    ServerName = 'Voice Line City', -- Server Name
    server_language = 'en', -- en or hu

    -- Section Names and text
    Sections = {
        News = {
            title = 'Message du jour', 
            text = 'Aujourd\'hui c\'est soirée crêpe (C\'est Ema qui paye :>)'
        }, -- News Section

        Updates = {
            title = 'Patch-Notes', 
            text = 'Ajouts du menue de changelogs :0'
        }, -- Updates Section

        CharacterInfo = {
            title = 'Vos informations', 
        }, -- Charachter Information Section
        
        Rules = {
            title = 'Conseils pour le rp !', 
        }, -- Rules Section

        Report = {
            title = 'Report', 
            text = 'Faite un report de bug ou de joueur ici !'
        }, -- Report Section

        DiscordSection = {
            title = 'Discord', 
            text = 'Vous auriez perdu le discord ? C\'est par la !'
        }, -- Discord Section

        SubmitSection = {
            title = 'Envoyer', 
            text = 'Envoyer le report!'
        }, -- Submit Section

        CustomSection = {
            title = 'Remerciement', 
            text = 'N\'hésiter pas a remercier toute l\'équipe de Voice Line City pour le super serveur ! Et si vous avez un soucis n\'hésiter pas a contacter un de nos staff !'
        }, -- Submit Section

    },


    -- Set Button title and text
    Buttons = {
        MapSection = {
            title = 'Map', 
            text = ''
        }, 
        SettingsSection = {
            title = 'Paramètre', 
            text = ''
        },
        ResumeSection = {
            title = 'Revenir', 
            text = ''
        },
        DisconnectSection = {
            title = 'Bye bye', 
            text = ''
        },
    },

    rules = {
        {
            title = 'Mettre en place une action',
            text = 'Pour lancer la scène, concentrez vous sur quelques éléments clés : Que font les personnages ? Où se trouvent-ils ? En apportant ces informations au début de votre scène, vous facilitez le travail de vos partenaires RP et votre objectif sera clair dans votre tête : "À quoi sert cette scène pour mon personnage ?" Soyez à l\'écoute des détails que vos partenaires RP fournissent et enrichissez la scène ensemble. Les actions concrètes, liées au rôle ou à la profession de vos personnages, sont particulièrement utiles car elles offrent un contexte clair sur lequel vos partenaires RP peuvent s\'appuyer pour faire avancer l\'histoire. Cela permet de démarrer rapidement une scène.'
        },
        {
            title = 'Entrer et sortir d\'une scene rp avec un but !',
            text = 'Entrer, sortir et rester pendant une scène doit toujours être justifié et apporter du sens à l’histoire. Évitez de rester immobile sans contribuer, d\'entrer ou sortir d\'une scène sans raison. Chaque action doit avoir un but et enrichir l’improvisation avec vos partenaires et ainsi éviter les moments de blanc.'
        },
        {
            title = 'Accepter une situation > oui et...',
            text = 'Lorsque vous recevez une information d’un partenaire RP, acceptez la comme une fait incontestable. Ajoutez ensuite d’autres éléments pour enrichir l’histoire. En restant ouvert et en acceptant pleinement ce que propose votre partenaire RP, vous créerez ensemble un scénario sympa et dynamique, tout en faisant évoluer vos relations personnages. Refuser une proposition bloque le développement de la scène et un refus peut frustrer votre partenaire RP.'
        },
        {
            title = 'Tirer le fil de l\'histoire',
            text = 'Lorsque l\'un des joueurs propose une idée, développez la pour voir jusqu\'où elle peut mener. Évitez les digressions, les changements brusques de lieux qui pourraient semer la confusion et empêcher d\'explorer pleinement l\'idée de départ. Sauter d\'une idée à l\'autre sans approfondir ne permet pas de construire une histoire, de développer des personnages ou de progresser vers un but cohérent. Restez concentré sur le moment présent et sur l\'action autant que possible.'
        },
        {
            title = 'Accepter les imprévus et les situations improbables',
            text = 'Dans la vie quotidienne, suivre la voix de la raison peut paraître naturel. Il faut faire ci, comme ça, pour cela. Sur GTA RP, une autre logique s\'applique. Voice Line City existe dans le but de nous évader du quotidien et de nous amuser tous ensemble. Vous pouvez incarner n\'importe quel personnage, braquer une banque, être un super héros licorne, un millionnaire ou même être complètement détestable. Laissez libre cours à votre imagination, et quand une situation improbable vous tombe dessus : profitez en pour vous amuser.'
        },
        {
            title = 'AMOUSEZ-VOUS UN MAX !',
            text = 'Une fois lancés, un immense terrain de jeu s\'ouvre à vous et à vos partenaires RP. Ce qui est formidable, c\'est que vous progressez ensemble. Vous développez une véritable dynamique de groupe où chacun se confronte aux mêmes défis, aux mêmes problèmes, au même univers. Restez ouverts et bienveillants, surtout avec les débutants RP et/ou GTA, et enfin ... AMUSEZ-VOUS !! 💖'
        },
    },

    -- Set placeholder text
    placeHolders = {
        text = "J'ai trouver un bug avec tel objet ici...",
        title = "Titre du rapport",
    },

    time = {
        text = "Minutes"
    }
}