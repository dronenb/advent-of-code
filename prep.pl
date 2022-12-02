#! /usr/bin/env perl
use strict;
use warnings;
if (scalar(@ARGV) > 0){
    my ($year, $day) = split("/", $ARGV[0]);
    mkdir("$year/day$day");
    system("cp templates/template.pl $year/day$day/day".$day."_part1.pl");
    system("cp templates/template.pl $year/day$day/day".$day."_part2.pl");
    system("touch $year/day$day/testinput.txt");
}
