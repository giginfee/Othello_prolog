<template>
    <div ref="cell" class="cell"  v-bind:class="{'can-press':canPress, 'non-active': state===2}" >
        <div v-if="state!==0 && state!==2" class="circle" v-bind:class="{'player2': state===-1}"></div>
    </div>

</template>

<script>
export default {
    name: "Cell",
    props:{
        j:
            {type:Number,
            required:true},
        i:
            {type:Number,
            required:true},
        state:
            {type:Number,
            default:0},
        canPress:{
            type:Boolean,
            default:false},
        isPressed: {
            type:Boolean,
            default:false},
    },
    methods:{
      emitMove(){

          // this.$refs["cell"].classList.add("pressed")
          setTimeout(()=>{
              // this.$refs["cell"].classList.remove("pressed")
              this.$emit('doMove', this.i, this.j)

              },50)

      }
    },
    data(){
        return{

        }
    },mounted() {

    },beforeUpdate() {
        this.$refs["cell"].removeEventListener("click",this.emitMove)
        if(this.canPress)
            this.$refs["cell"].addEventListener("click",this.emitMove)
    }
}
</script>

<style scoped>

.circle{
    width: 90%;
    height: 90%;
    border: 0;
    border-radius: 100px;
    background-color: #ab9875;
}
.cell{
    display: flex;
    justify-content: center;
    align-items: center;
    aspect-ratio: 1 / 1;
    border-bottom: #222222 1px solid;
    border-right: #222222 1px solid;
    background-color: #f8f8f8;
    transition: background-color 0.02s linear;


}
.can-press{
  cursor: pointer;
    background-color: #dcd4cc;
}
.player2{
    background-color: #46433e
}
.non-active{
    background-color: #222222;
}
.pressed{
    background-color: #79fcd6;

}
</style>