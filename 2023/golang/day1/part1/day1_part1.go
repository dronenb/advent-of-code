package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	file, err := os.Open("input.txt")
	check(err)
	scanner := bufio.NewScanner(file)
	sum := 0
	for scanner.Scan() {
		line := scanner.Text()
		regex := regexp.MustCompile("[0-9]")
		match := regex.FindAllStringSubmatch(line, -1)
		if match != nil {
			firstDigit := string(match[0][0])
			lastDigit := match[len(match)-1:][0][0]
			str := firstDigit + lastDigit
			num, err := strconv.Atoi(str)
			check(err)
			sum += num
		}
	}
	fmt.Println(sum)
}
