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
    my @chars = split('', $line);
    CHAR: foreach my $i (0..(scalar(@chars)-1)){
        my %found;
        foreach my $j ($i..($i+13)){
            $found{$chars[$j]} = 1;
        }
        if (scalar(keys(%found)) == 14){
            $answer = $i + 14;
            last CHAR;
        }
    }
}
print("ANSWER: $answer\n");