import {createRouter, createWebHistory} from "vue-router";
import MainPage from "@/Pages/MainPage.vue";
import SizePage from "@/Pages/SizePage.vue";
import TwoPlayersPage from "@/Pages/TwoPlayersPage.vue";
import OnePlayerPage from "@/Pages/OnePlayerPage.vue";
import ComputerModePage from "@/Pages/ComputerModePage.vue";

const routes = [
    { path: '/', component: MainPage },
    { path: '/size', component: SizePage },
    { path: '/two-players', component: TwoPlayersPage },
    { path: '/one-player', component: OnePlayerPage },
    { path: '/mode', component: ComputerModePage },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router
