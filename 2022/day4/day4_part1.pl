#! /usr/bin/env perl
use strict;
use warnings;
use Switch;
use Data::Dumper;

my $fh = undef;
if (scalar(@ARGV) > 0){
    open($fh, "<", "testinput.txt") or die $!;
}
else {
    open($fh, "<", "input.txt") or die $!;
}
my $answer = 0;
while (my $line = <$fh>){
    chomp($line);
    my ($first, $second) = split(',', $line);
    my ($first_start, $first_end) = split('-', $first);
    my ($second_start, $second_end) = split('-', $second);
    my %first = map {$_ => 0} "$first_start".."$first_end";
    my %second = map {$_ => 0} "$second_start".."$second_end";
    if (
        scalar(grep {exists($second{$_})} keys(%first)) == scalar(keys(%first))
        ||
        scalar(grep {exists($first{$_})} keys(%second)) == scalar(keys(%second))
    
    ){
        $answer++;
    }
}
print("Answer: $answer\n");