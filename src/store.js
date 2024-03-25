import {createStore} from "vuex"

export default createStore({
    state:{
        url:"/",
        picture:false,
        x:4,
        y:4,
        mode:"",
        computerMoveMode:"hard",
        pictureMatrix:{
            0:[[2,0,0,0,0,0,0,0],
                [0,2,0,0,0,0,0,0],
                [0,0,2,-1, 1,0,0,0],
                [0,0, 0,1,-1,2,0,0],
                [0,0,0,0,0,0,2,0],
                [0,0,0,0,0,0,0,2]],
            1:[[0,0,0,0,0,0,0,0,0,0],
                [0,0,0,0,2,2,0,0,0,0],
                [0,0,0,2,0,0,2,0,0,0],
                [0,0,2,0,0,0,0,2,0,0],
                [0,2,0,0,-1,1,0,0,2,0],
                [0,2,0,0,1,-1,0,0,2,0],
                [0,0,2,0,0,0,0,2,0,0],
                [0,0,0,2,0,0,2,0,0,0],
                [0,0,0,0,2,2,0,0,0,0],
                [0,0,0,0,0,0,0,0,0,0]],
            2:[[2,0,0,0,0,0,0,0,2,0],
                [0,2,0,0,0,0,0,2,0,0],
                [0,0,2,0,-1,1,2,0,0,0],
                [0,0,0,2,1,-1,0,2,0,0],
                [0,0,2,0,0,0,0,0,2,0],
                [0,2,0,0,0,0,0,0,0,2]],
        }
    },
    mutations:{
        setX(state,x){
            state.x=x
        },
        setComputerMode(state,x){
            state.computerMoveMode=x
        },
        setY(state,y){
            state.y=y
        },
        setPictureMode(state, mode){
            state.picture=mode
        },
        url(state, url){
            state.url=url
        }
    },
    getters:{

    },
    actions:{}
})