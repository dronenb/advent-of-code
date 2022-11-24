#! /usr/bin/env node
const fs = require('fs');
const path = require('path');

// let filename = "testinput.txt";
let filename = "input.txt";

fs.readFile(path.join(__dirname, filename), 'utf8', (err, data) => {
    if (err) {
        console.error(err);
        return;
    }
    else {
        let numbers = data.split("\n").map((element)=>{return Number(element)});
        let previous_sum = '';
        let increases = 0;

        for (let i = 0; i < numbers.length; i++){
            if (i > 0 && i < (numbers.length - 1)){
                let sum = numbers[i] + numbers[i-1] + numbers[i+1];
                if (!(previous_sum === '') && sum > previous_sum){
                    increases++
                }
                previous_sum = sum;
            }
        }
        console.log("Answer: " + increases);
    }
});