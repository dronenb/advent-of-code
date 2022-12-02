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
        elf_scores = [];
        current_elf = 0;
        data.split("\n").forEach((number) => {
            if (number === ""){
                elf_scores.push(current_elf);
                current_elf = 0;
            }
            else {
                number = Number(number);
                current_elf += number;
            }
        });
        elf_scores.push(current_elf);
        elf_scores.sort(function (a, b) {  return a - b;  });
        elf_scores.reverse();
        answer = elf_scores[0] + elf_scores[1] + elf_scores[2];
        console.log("Answer: " + answer);
    }
});