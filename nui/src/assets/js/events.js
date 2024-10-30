import { isFivemNUI } from './utils';
import { DebugImportLangFiles, GetDebugData } from './debug';

function ResumeGame() {
    if (!isFivemNUI()) return;

    this.animationState = false;
    setTimeout(() => {
        fetch(`https://${GetParentResourceName()}/resumeGame`);
    }, 300)
}

function ShowMap() {
    if (!isFivemNUI()) return;
  fetch(`https://${GetParentResourceName()}/showMap`);
}

function ShowSettings() {
    if (!isFivemNUI()) return;
  fetch(`https://${GetParentResourceName()}/showSettings`);
}

function Quit() {
    if (!isFivemNUI()) return;
    fetch(`https://${GetParentResourceName()}/disconnect`);
}

function SendReport() { 
    if (!isFivemNUI()) return;
    fetch(`https://${GetParentResourceName()}/report`);
}

function FetchLocales() {
    if (!isFivemNUI()) return DebugImportLangFiles();
    return fetch(`https://${GetParentResourceName()}/getLocales`).then(response => response.json());
}

function FetchData() {
    if (!isFivemNUI()) return GetDebugData().data;
    return fetch(`https://${GetParentResourceName()}/getData`).then(response => response.json());
}

function FetchSettings() {
    if (!isFivemNUI()) return GetDebugData().settings;
    return fetch(`https://${GetParentResourceName()}/getConfig`).then(response => response.json());
}

function FetchAnnounces() {
    if (!isFivemNUI()) return GetDebugData().announces;
    return fetch(`https://${GetParentResourceName()}/getAnnounces`).then(response => response.json());
}


export  { ResumeGame, ShowMap, ShowSettings, Quit, SendReport, FetchLocales, FetchData, FetchSettings, FetchAnnounces };