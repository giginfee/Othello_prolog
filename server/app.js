const express = require("express")
const bodyparser = require("body-parser")
const cors = require("cors")
const swipl = require("swipl")

const app = express();
const PORT = 8888;

app.use(cors())
app.use(bodyparser.json())
swipl.call('consult(game_reversi)');

app.post("/do-move", (req, res)=>{
    let {player, i,j, matrix}=req.body
    let qText=`get_all_moves_indexes([${i},${j}],${JSON.stringify(matrix)},${player}, List), change_matrix(${JSON.stringify(matrix)},[[${i},${j}]|List], ${player}, Res )
,matrix_to_json(Res,Json)`
    let ret = swipl.call(qText);
    if (ret) {
        ret=JSON.parse(ret.Json);
        res.json(ret)
    } else {
        console.log('Call do-move failed.');
    }

})
app.post(`/get-computer-move/hard`, (req, res)=>{
    let {player, matrix}=req.body
    let qText=`get_move_minimax(${JSON.stringify(matrix)},${player},Move),change_matrix(${JSON.stringify(matrix)},[Move], ${player}, Res ), matrix_to_json(Res,Json)`
    console.log(qText)
    let ret = swipl.call(qText);
    if (ret) {
        ret=JSON.parse(ret.Json);

        console.log(ret)
        res.json(ret)

    } else {
        console.log('Call computer failed.');
    }

})
app.post("/get-full-computer-move/hard", (req, res)=>{
    let {player, matrix}=req.body
    let qText=`do_minimax_move(${JSON.stringify(matrix)},${player},Res), matrix_to_json(Res,Json)`
    console.log(qText)
    let ret = swipl.call(qText);
    if (ret) {
        ret=JSON.parse(ret.Json);

        console.log(ret)
        res.json(ret)

    } else {
        console.log('Call computer failed.');
    }

})
app.post(`/get-computer-move/easy`, (req, res)=>{
    let {player, matrix}=req.body
    let qText=`get_optimal_move(${JSON.stringify(matrix)},${player},Move),change_matrix(${JSON.stringify(matrix)},[Move], ${player}, Res ), matrix_to_json(Res,Json)`
    console.log(qText)
    let ret = swipl.call(qText);
    if (ret) {
        ret=JSON.parse(ret.Json);

        console.log(ret)
        res.json(ret)

    } else {
        console.log('Call computer failed.');
    }

})
app.post("/get-full-computer-move/easy", (req, res)=>{
    let {player, matrix}=req.body
    let qText=`do_optimal_move(${JSON.stringify(matrix)},${player},Res), matrix_to_json(Res,Json)`
    console.log(qText)
    let ret = swipl.call(qText);
    if (ret) {
        ret=JSON.parse(ret.Json);

        console.log(ret)
        res.json(ret)

    } else {
        console.log('Call computer failed.');
    }

})



app.post("/possible-moves", (req, res)=>{
    let {matrix, player}=req.body
    let qText=`get_all_possible_move_indexes_for_item_list(List,${JSON.stringify(matrix)},${player}),matrix_to_json(List,Json)`
    let ret = swipl.call(qText);
    if (ret) {
        ret=JSON.parse(ret.Json);
    } else {
        console.log('Call failed.');
    }
    let movesMatrix=[]

    for(let i in matrix){
        let row=[]
        for(let j in matrix[i]) {
            row.push(0)
        }
        movesMatrix.push(row)
    }
    for(let [i,j] of ret)
        movesMatrix[i][j]=1
    res.json(movesMatrix)
})







app.listen(PORT,()=>{
    console.log(`Listening on port ${PORT}`)
})