<template>
<div><router-link :to="url">
    <button ref="btn" class="button-74 button font" role="button">



        <slot></slot>
    </button>
</router-link>
</div>

</template>

<script>
export default {
    name: "ButtonOptionComponent",
    props:{
        url:{type:String, required:true},
    },
    data()
    {
        return{
           fullUrl:""
        }
    },
    mounted() {
        this.$refs["btn"].addEventListener("click",()=>{
            this.$emit("click")
        })
        this.fullUrl=`${this.url}/${this.option}`
    }
}
</script>

<style scoped>
.button{
    width: 300px;
    height: 60px;
}

.button-74 {
   background-color: #fbeee0;
   border: 2px solid #422800;
   border-radius: 30px;
   box-shadow: #422800 4px 4px 0 0;
   color: #422800;
   cursor: pointer;
   display: inline-block;
   font-weight: 600;
   font-size: 18px;
   padding: 0 18px;
   line-height: 50px;
   text-align: center;
   text-decoration: none;
   user-select: none;
   -webkit-user-select: none;
   touch-action: manipulation;
}

.button-74:hover {
    background-color: #cba787;
}

.button-74:active {
    box-shadow: #422800 2px 2px 0 0;
    transform: translate(2px, 2px);
}

@media (min-width: 768px) {
    .button-74 {
        min-width: 120px;
        padding: 0 25px;
    }
}
</style>