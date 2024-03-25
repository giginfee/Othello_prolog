const swipl = require('swipl');

swipl.call('consult(game_reversi)');
let matrix =[
    [ 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 1, -1, 0, 0 ],
    [ 0, 0, -1, 1, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0 ]
]
let player= 1


let qText=`get_all_possible_move_indexes_for_item_list(List,${JSON.stringify(matrix)},${player}),matrix_to_json(List,Json)`

console.log(qText)
ret = swipl.call(qText);
if (ret) {
    console.log(`Variable X value is:`);
    console.log(JSON.parse(ret.Json));
} else {
    console.log('Call failed.');
}
