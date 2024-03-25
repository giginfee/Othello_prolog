<template>
    <div class="container">
        <div class="container-2">
            <h3 class="font">Оберіть режим гри:</h3>
            <div class="input-container">
                <input v-model="x" class="input_number" type="number" min="4" max="20" step="2">
                x
                <input v-model="y" class="input_number" type="number" min="4" max="20" step="2">
            </div>
            <button-option-component @click="changeSize" :url="url"  >{{x}} x {{ y }}</button-option-component>
            <button-option-component @click="setPictureMode"  :url="url"  >Малюнок</button-option-component>

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
        changeSize(){
            this.$store.commit('setX',this.x)
            this.$store.commit('setY',this.y)
            this.$store.commit('setPictureMode',false)
        },
        setPictureMode(){
            this.$store.commit('setPictureMode',true)

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