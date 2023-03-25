#! /usr/bin/env perl
use strict;
use warnings;
use Switch;
use Data::Dumper;

sub main {
    my $answer = 0;
    my $fh = undef;
    if (scalar(@ARGV) > 0){
        open($fh, "<", "testinput.txt") or die $!;
    }
    else {
        open($fh, "<", "input.txt") or die $!;
    }
    while (my $line = <$fh>){
        
    }
    print("ANSWER: $answer\n");
}
main();