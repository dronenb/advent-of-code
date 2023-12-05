package main

import (
	"fmt"
	"os"
	"regexp"
	"slices"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	// content, err := os.ReadFile("testinput.txt")
	content, err := os.ReadFile("../input.txt")
	rows := strings.Split(string(content), "\n")
	check(err)
	cardRemovalRegex := regexp.MustCompile(`Card\s+\d+:\s+`)
	middleSplitRegex := regexp.MustCompile(`\s+\|\s+`)
	spaceSplitRegex := regexp.MustCompile(`\s+`)
	sum := 0
	for _, row := range rows {
		row = cardRemovalRegex.ReplaceAllString(row, "")
		splitRow := middleSplitRegex.Split(row, -1)
		winningNumbers := spaceSplitRegex.Split(splitRow[0], -1)
		myNumbers := spaceSplitRegex.Split(splitRow[1], -1)
		numWinners := 0
		for _, num := range myNumbers {
			if slices.Contains(winningNumbers, num) {
				if numWinners == 0 {
					numWinners++
				} else {
					numWinners *= 2
				}
			}
		}
		sum += numWinners
	}
	fmt.Println(sum)
}
