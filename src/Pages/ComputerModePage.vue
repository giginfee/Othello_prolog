<template>
    <div class="container">
        <div class="container-2">
            <h3 class="font">Оберіть режим гри з комп'ютером:</h3>
            <button-option-component @click="changeComputerMode('easy')" url="/size"  >Легший</button-option-component>
            <button-option-component @click="changeComputerMode('hard')" url="/size" >Важчий</button-option-component>

        </div>
    </div>
</template>

<script>
import ButtonOptionComponent from "@/components/ButtonOptionComponent.vue";

export default {
    name: "SizePage",
    components: {ButtonOptionComponent},
    data(){
        return {
            x:10,
            y:10,
            url:""
        }
    },
    methods:{
        changeComputerMode(mode){
            this.$store.commit('setComputerMode',mode)
        }
    },
    mounted() {
        this.url=this.$store.state.url
    }

}
</script>

<style scoped>
.input_number{
    width: 45px;
    height: 40px;
    border-radius: 5px;
}
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