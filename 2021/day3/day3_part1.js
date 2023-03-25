#! /usr/bin/env node
const fs = require('fs');
const path = require('path');

let filename = "testinput.txt";
// let filename = "input.txt";

fs.readFile(path.join(__dirname, filename), 'utf8', (err, data) => {
    if (err) {
        console.error(err);
        return;
    }
    else {
        let horizontal = 0;
        let depth = 0;
        data.split("\n").forEach((instruction) => {
            let direction;
            let position;
            [direction, position] = instruction.split(' ');
            position = Number(position);
            if (direction === 'forward'){
                horizontal += position;
            }
            else if (direction === 'up'){
                depth -= position;
            }
            else if (direction === 'down'){
                depth += position;
            }
        });
        console.log("Answer: " + (horizontal * depth));
    }
});