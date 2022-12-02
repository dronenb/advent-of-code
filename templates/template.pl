#! /usr/bin/env perl
use strict;
use warnings;
use Switch;

my $fh = undef;
if (scalar(@ARGV) > 0){
    open($fh, "<", "testinput.txt") or die $!;
}
else {
    open($fh, "<", "input.txt") or die $!;
}
my $answer = 0;
while (my $line = <$fh>){
    
}
print("$answer\n");