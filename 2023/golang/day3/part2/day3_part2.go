package main

import (
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func isNumberInRange(number, min, max int) bool {
	return number >= min && number <= max
}

func main() {
	// content, err := os.ReadFile("testinput.txt")
	content, err := os.ReadFile("../input.txt")
	rows := strings.Split(string(content), "\n")
	check(err)
	numRegex := regexp.MustCompile(`(\d+)`)
	isGearSymbolRegex := regexp.MustCompile(`\*`)
	sum := 0
	for rowIndex, row := range rows {
		possibleGearIndexMatches := isGearSymbolRegex.FindAllStringSubmatchIndex(row, -1)
		for _, possibleGearIndexSlice := range possibleGearIndexMatches {
			// fmt.Println("Possible gear on row", rowIndex)
			possibleGearIndex := possibleGearIndexSlice[0]
			var adjacentNumbers = []int{}
			for rowIndexIter := max(rowIndex-1, 0); rowIndexIter <= min(rowIndex+1, len(rows)-1); rowIndexIter++ {
				// fmt.Println("Testing row", rowIndexIter)
				numMatches := numRegex.FindAllStringSubmatchIndex(rows[rowIndexIter], -1)
				for _, numMatch := range numMatches {
					numStartIndex := numMatch[0]
					numEndIndex := numMatch[1]
					num, err := strconv.Atoi(rows[rowIndexIter][numStartIndex:numEndIndex])
					check(err)
					if isNumberInRange(possibleGearIndex, max(numStartIndex-1, 0), min(numEndIndex, len(rows)-1)) {
						// fmt.Println("Found adjacent number", num)
						adjacentNumbers = append(adjacentNumbers, num)
					}
				}
			}
			if len(adjacentNumbers) == 2 {
				// fmt.Println("Found a gear for row", rowIndex, row)
				sum += adjacentNumbers[0] * adjacentNumbers[1]
			}
		}

	}
	fmt.Println(sum)
}
