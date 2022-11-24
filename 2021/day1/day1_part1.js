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
        let previous = '';
        let increases = 0;
        data.split("\n").forEach((number) => {
            number = Number(number);
            if (!(previous === '') && number > previous){
                increases++;
            }
            previous = number;
        });
        console.log("Answer: " + increases);
    }
});