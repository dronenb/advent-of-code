#! /usr/bin/env perl
use strict;
use warnings;
use Switch;

# open(my $fh, "<", "testinput.txt") or die $!;
open(my $fh, "<", "input.txt") or die $!;
my $score = 0;
while (my $line = <$fh>){
    my ($them, $mine) = split(" ", $line);
    switch($mine){
        case "X" {
            $score += 1;
        }
        case "Y" {
            $score += 2;
        }
        case "Z" {
            $score += 3;
        }
    }
    switch($them){
        case "A" {
            switch($mine){
                case "X" {
                    $score += 3;
                }
                case "Y" {
                    $score += 6;
                }
                case "Z" {
                    $score += 0;
                }
            }
        }
        case "B" {
            switch($mine){
                case "X" {
                    $score += 0;
                }
                case "Y" {
                    $score += 3;
                }
                case "Z" {
                    $score += 6;
                }
            }
        }
        case "C" {
            switch($mine){
                case "X" {
                    $score += 6;
                }
                case "Y" {
                    $score += 0;
                }
                case "Z" {
                    $score += 3;
                }
            }
        }
    }
}
print("Answer: $score\n");