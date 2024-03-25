<template>
    <div class="container">
        <div class="container-2">
            <h1 class="font">Реверсі</h1>
            <h3 class="font">Оберіть режим гри:</h3>
        <button-option-component url="/size" @click="changeURL('/two-players')">2 гравця</button-option-component>
        <button-option-component url="/mode" @click="changeURL('/one-player')" >Гра з комп'ютером</button-option-component>

        </div>
    </div>

</template>

<script>
import ButtonOptionComponent from "@/components/ButtonOptionComponent.vue";

export default {
    name: "MainPage",
    components: {ButtonOptionComponent},
    methods:{
        changeURL(url){
            console.log(url)
            this.$store.commit('url',url)
            console.log(this.$store.state.url)
        }
    }
}
</script>

<style scoped>
h1{
    color: #181818;
    font-size: 85px;
    display: inline-block;
}
h3{
    color: #181818;

}
.container, .container-2{
    height: 100%;
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 15px;
}
.container{
    background-color: #fbeee0;
    border: #222222 6px solid;

}
.container-2{
    height: 95%;
    width: 95%;
    border: #222222 3px solid;
    background-color: #fff8f4;

    /*background-color: #f8f8f8;*/
}


</style>