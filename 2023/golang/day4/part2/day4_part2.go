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
	cards := strings.Split(string(content), "\n")
	check(err)
	cardRemovalRegex := regexp.MustCompile(`Card\s+\d+:\s+`)
	middleSplitRegex := regexp.MustCompile(`\s+\|\s+`)
	spaceSplitRegex := regexp.MustCompile(`\s+`)
	numOfCards := make([]int, len(cards))
	for i := range numOfCards {
		numOfCards[i] = 1
	}
	for cardIndex, card := range cards {
		card = cardRemovalRegex.ReplaceAllString(card, "")
		splitRow := middleSplitRegex.Split(card, -1)
		winningNumbers := spaceSplitRegex.Split(splitRow[0], -1)
		myNumbers := spaceSplitRegex.Split(splitRow[1], -1)
		numMatches := 0
		for _, num := range myNumbers {
			if slices.Contains(winningNumbers, num) {
				numMatches++
			}
		}
		for nextCard := cardIndex + 1; nextCard <= cardIndex+numMatches; nextCard++ {
			// fmt.Printf("Card: %d. Adding %d copy of card %d\n", cardIndex+1, numOfCards[cardIndex], nextCard+1)
			numOfCards[nextCard] += numOfCards[cardIndex]
			// fmt.Printf("There are now %d copies of card %d\n", numOfCards[nextCard], nextCard+1)
		}
	}
	sum := 0
	for _, card := range numOfCards {
		sum += card
	}
	fmt.Println(sum)
}
