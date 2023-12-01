package main

import (
	"bufio"
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

func alphaToNumeric(match string) string {
	pairs := [][]string{
		{"one", "1"},
		{"two", "2"},
		{"three", "3"},
		{"four", "4"},
		{"five", "5"},
		{"six", "6"},
		{"seven", "7"},
		{"eight", "8"},
		{"nine", "9"},
	}
	for _, pair := range pairs {
		match = strings.Replace(match, pair[0], pair[1], 1)
	}
	return match
}

// https://www.geeksforgeeks.org/how-to-reverse-a-string-in-golang/
func reverse(str string) (result string) {
	for _, v := range str {
		result = string(v) + result
	}
	return
}

func main() {
	// file, err := os.Open("testinput.txt")
	file, err := os.Open("../input.txt")
	check(err)
	scanner := bufio.NewScanner(file)
	sum := 0
	for scanner.Scan() {
		line := scanner.Text()
		regex := "one|two|three|four|five|six|seven|eight|nine"
		forwardMatch := regexp.MustCompile("([1-9]|" + regex + ")").FindStringSubmatch(line)
		reverseMatch := regexp.MustCompile("([1-9]|" + reverse(regex) + ")").FindStringSubmatch(reverse(line))
		if forwardMatch != nil && reverseMatch != nil {
			firstDigit := alphaToNumeric(forwardMatch[0])
			lastDigit := alphaToNumeric(reverse(reverseMatch[0]))
			num, err := strconv.Atoi(firstDigit + lastDigit)
			check(err)
			sum += num
		} else {
			panic("Something went wrong")
		}
	}
	fmt.Println(sum)
}
