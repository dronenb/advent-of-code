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

func main() {
	// content, err := os.ReadFile("testinput.txt")
	content, err := os.ReadFile("../input.txt")
	rows := strings.Split(string(content), "\n")
	check(err)
	numRegex := regexp.MustCompile(`(\d+)`)
	isNotSymbolRegex := regexp.MustCompile(`^\d|\.$`)
	sum := 0
	for rowIndex, row := range rows {
		numMatches := numRegex.FindAllStringSubmatchIndex(row, -1)
		check(err)
	NUMMATCH:
		for _, numMatch := range numMatches {
			colStartIndex := numMatch[0]
			colEndIndex := numMatch[1]
			num, err := strconv.Atoi(row[colStartIndex:colEndIndex])
			check(err)
			minColIndex := max(colStartIndex-1, 0)
			maxColIndex := min(colEndIndex, len(row)-1)
			rowAbove := max(0, rowIndex-1)
			rowBelow := min(rowIndex+1, len(rows)-1)

			// Check current row, above, and below
			for _, rowIndexIter := range []int{rowAbove, rowIndex, rowBelow} {
				for colIndexIter := minColIndex; colIndexIter <= maxColIndex; colIndexIter++ {
					if !isNotSymbolRegex.MatchString(string(rows[rowIndexIter][colIndexIter])) {
						// fmt.Println("Adding number:", num)
						sum += num
						continue NUMMATCH
					}
				}
			}
		}
	}
	fmt.Println(sum)
}
