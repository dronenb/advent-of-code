package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
	// "math"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func Max(x, y int) int {
	if x < y {
		return y
	}
	return x
}

func main() {
	// file, err := os.Open("testinput.txt")
	file, err := os.Open("../input.txt")
	check(err)
	scanner := bufio.NewScanner(file)
	gameRegex := regexp.MustCompile(`^Game (\d+): `)
	colorRegex := regexp.MustCompile(`^(\d+) (\w+)$`)
	sum := 0
	// GAME:
	for scanner.Scan() {
		minRed := 0
		minGreen := 0
		minBlue := 0
		line := scanner.Text()
		match := gameRegex.FindStringSubmatch(line)
		check(err)
		if match != nil {
			gameNum, err := strconv.Atoi(match[1])
			check(err)
			line = strings.Replace(line, fmt.Sprintf("Game %d: ", gameNum), "", 1)
			handfuls := strings.Split(line, "; ")
			for _, handful := range handfuls {
				colors := strings.Split(handful, ", ")
				for _, color := range colors {
					match := colorRegex.FindAllStringSubmatch(color, -1)
					if match != nil {
						num, err := strconv.Atoi(match[0][1])
						check(err)
						color := match[0][2]
						switch color {
						case "blue":
							minBlue = Max(num, minBlue)
						case "red":
							minRed = Max(num, minRed)
						case "green":
							minGreen = Max(num, minGreen)
						}
					}
				}
			}
		} else {
			panic("Not matched")
		}
		sum += minRed * minGreen * minBlue
	}
	fmt.Println(sum)
}
