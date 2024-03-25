<template>
    <div class="container">
        <div class="container-2">
            <div class="content-container">
                <div class="board">
                    <div v-for="(row,i) in matrix" class="line">
                        <cell v-for="(cell,j) in row" class="cell" :i="i" :j="j" :state="matrix[i][j]"
                              :can-press="possibleMoveIndexesMatrix[i][j]===1"
                                @doMove="doMove"
                        ></cell>
                    </div>
                </div>
                <div class="stats">
                    <div class="player-stat" v-bind:class="{'active-player':activePlayer===1}">
                        <h3>Player 1</h3>
                        <div class="player-score">{{score1}}</div>
                    </div>
                    <div class="player-stat" v-bind:class="{'active-player':activePlayer===-1}">
                        <h3>Player 2</h3>
                        <div class="player-score">{{score2}}</div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</template>

<script>
import ButtonOptionComponent from "@/components/ButtonOptionComponent.vue";
import Cell from "@/components/Cell.vue";

export default {
    name: "TwoPlayersPage",
    components: {Cell, ButtonOptionComponent},
    methods:{
        endOfGameCheck(){
            let player = (this.score1>this.score2) ? 1 : 2
            if((this.countElemsInMatrix(0, this.matrix)===0 || this.noMoves===2)) {
                console.log(this.score1, this.score2)
                if(this.score1===this.score2){
                    alert(`Draw! Play again to know the winner`)
                    this.started=false
                    this.ended=true
                    return
                }
                alert(`Player ${player} won!`)
                this.started=false
                this.ended=true
            }
            console.log("moves to do")
            console.log(this.countElemsInMatrix(1, this.possibleMoveIndexesMatrix))
            if (this.countElemsInMatrix(1, this.possibleMoveIndexesMatrix)===0){
                console.log("noMoves")
                this.noMoves++
                this.activePlayer*=-1
                this.getPossibleMoveIndexes()
                console.log(this.activePlayer)
                this.started=false
            }else
                this.noMoves=0
        },
        countElemsInMatrix(elem, matrix){
            let res=0
            for(let row of matrix) {
                for (let cell of row) {
                    if(cell===elem)
                        res++
                }
            }
            return res},
        doMoveFetch(player, i, j){
            const options = {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    player, i,j, matrix:this.matrix
                })
            };
            fetch("http://localhost:8888/do-move", options)
                .then(response => response.json())
                .then(data => {
                    this.matrix = data;
                    this.activePlayer*=-1
                    this.getPossibleMoveIndexes()
                })
                .catch(error => console.error('Помилка:', error));

        },

        doMove( i, j){
            this.doMoveFetch(this.activePlayer, i, j)

        },
        initMatrix(){
          for(let i = 0;i<this.x;i++) {
              let row=[]
              for (let j = 0; j < this.y; j++) {
                  row.push(0)
              }
              this.matrix.push(row)
          }
          this.possibleMoveIndexesMatrix=JSON.parse(JSON.stringify(this.matrix))
          let centerX=this.x/2;
          let centerY=this.y/2;
          this.matrix[centerX][centerY]=1
          this.matrix[centerX-1][centerY-1]=1
          this.matrix[centerX][centerY-1]=-1
          this.matrix[centerX-1][centerY]=-1
        },

        initPictureMatrix(){
            this.matrix=this.$store.state.pictureMatrix[Math.floor(Math.random() * 3)]
            this.possibleMoveIndexesMatrix=JSON.parse(JSON.stringify(this.matrix))

        },
        getPossibleMoveIndexes(){
            if( this.ended===true)
                return
            const data = {
                matrix: this.matrix,
                player: this.activePlayer,
            };

            const options = {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            };

            fetch("http://localhost:8888/possible-moves", options)
                .then(response => response.json())
                .then(data => {
                    this.possibleMoveIndexesMatrix = data;
                    console.log("possibleMoveIndexesMatrix")
                    console.log(data)
                    console.log("matrix")
                    console.log(this.matrix)
                    this.started=true
                    this.endOfGameCheck()

                })
                .catch(error => console.error('Помилка:', error));
        }
    },
    data(){
        return{
            x:4,
            y:4,
            activePlayer:1,
            matrix:[],
            picture:false,
            possibleMoveIndexesMatrix:[],
            started:false,
            noMoves:0


        }
    },
    mounted() {
        console.log()
        this.x=this.$store.state.x
        this.y=this.$store.state.y
        this.picture=this.$store.state.picture
        if(!this.picture)
            this.initMatrix()
        else
            this.initPictureMatrix()

        this.getPossibleMoveIndexes()


    },computed:{
        score1(){
            return this.countElemsInMatrix(1, this.matrix)
        },
        score2(){
            return this.countElemsInMatrix(-1, this.matrix)
        },
    }

}
</script>

<style scoped>
.active-player{
    border: #422800 2px solid;
}
.stats{
    display: flex;
    width: 80%;
    gap:50px;

}
.player-stat{
    box-sizing: border-box;
    margin-top: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    flex: 1;

}

.line :first-child {
    border-left: #222222 1px solid;

}
.line{

    display: flex;
    flex-direction: row;
    justify-content: center;
    flex: 1;
    /*max-width: 100%;*/
    overflow: hidden;

}
.board :first-child .cell{
    border-top: #222222 1px solid;

}
.board{
    flex: 1;
    display: flex;
    flex-direction: column;
    width: 100%;
    max-width: 100%;
    max-height: 400px;
    justify-content: center;


}
.content-container{
    display: flex;
    flex-direction: column;
    height: 100%;
    width: 60%;
    margin: 15px 0;
    justify-content: center;
    align-items: center;

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