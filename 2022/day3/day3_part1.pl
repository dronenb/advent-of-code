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

my $counter = 1;
my $lookup = {};
foreach my $alpha (("a".."z", "A".."Z")){
    $lookup->{$alpha} = $counter;
    $counter++;
}
my $answer = 0;
while (my $line = <$fh>){
    
    chomp($line);
    # print("LINE: $line\n");
    my $first = substr($line, 0, length($line)/2);
    my $second = substr($line, length($line)/2);
    my %hashmap = ();
    foreach my $letter (split('', $first)){
        $hashmap{$letter} = 1;
    }
    LETTER: foreach my $letter (split('', $second)){
        if ($hashmap{$letter}){
            # print("$letter $lookup->{$letter}\n");
            $answer += $lookup->{$letter};
            last LETTER;
        }
    }
}
print("$answer\n");