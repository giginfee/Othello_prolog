<script setup>
import HelloWorld from './components/HelloWorld.vue'
import TheWelcome from './components/TheWelcome.vue'
import MainPage from "@/Pages/MainPage.vue";
import SizePage from "@/Pages/SizePage.vue";
import TwoPlayersPage from "@/Pages/TwoPlayersPage.vue";
</script>

<template>
<!--    <main-page></main-page>-->
<!--    <size-page></size-page>-->
    <router-view></router-view>
<!--    <two-players-page :x="4" :y="4" :picture="true"></two-players-page>-->
</template>


<style scoped>


</style>
