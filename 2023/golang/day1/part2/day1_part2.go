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
	match = strings.Replace(match, "one", "1", 1)
	match = strings.Replace(match, "two", "2", 1)
	match = strings.Replace(match, "three", "3", 1)
	match = strings.Replace(match, "four", "4", 1)
	match = strings.Replace(match, "five", "5", 1)
	match = strings.Replace(match, "six", "6", 1)
	match = strings.Replace(match, "seven", "7", 1)
	match = strings.Replace(match, "eight", "8", 1)
	match = strings.Replace(match, "nine", "9", 1)
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
		origLine := scanner.Text()
		line := origLine
		regex := "one|two|three|four|five|six|seven|eight|nine"
		alphaStringRegex := regexp.MustCompile("([1-9]|" + regex + ")")
		backwardAlphaStringRegex := regexp.MustCompile("([1-9]|" + reverse(regex) + ")")
		forwardMatch := alphaStringRegex.FindStringSubmatch(line)
		reverseMatch := backwardAlphaStringRegex.FindStringSubmatch(reverse(line))
		firstDigit := alphaToNumeric(forwardMatch[0])
		lastDigit := alphaToNumeric(reverse(reverseMatch[0]))
		num, err := strconv.Atoi(firstDigit + lastDigit)
		check(err)
		sum += num
	}
	fmt.Println(sum)
}
