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
        highest_elf = 0;
        current_elf = 0;
        data.split("\n").forEach((number) => {
            if (number === ""){
                if (current_elf > highest_elf){
                    highest_elf = current_elf;
                }
                current_elf = 0;
            }
            else {
                number = Number(number);
                current_elf += number;
            }
        });
        console.log("Answer: " + highest_elf);
    }
});