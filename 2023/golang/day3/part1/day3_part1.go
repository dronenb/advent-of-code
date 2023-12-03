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

			// Symbol before/after
			if !isNotSymbolRegex.MatchString(string(row[minColIndex])) || !isNotSymbolRegex.MatchString(string(row[maxColIndex])) {
				// fmt.Println("Adding number:", num)
				sum += num
				continue NUMMATCH
			}
			rowAbove := max(0, rowIndex-1)
			rowBelow := min(rowIndex+1, len(rows)-1)

			// Symbol above/below/diagonal
			for _, rowIndexIter := range []int{rowAbove, rowBelow} {
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
