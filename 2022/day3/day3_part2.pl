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
my @threegroup;
while (my $line = <$fh>){
    chomp($line);
    push(@threegroup, $line);
    if (scalar(@threegroup) == 3){
        my @hashmap_array;
        foreach my $line2 (@threegroup){
            my $hashmap = {};
            foreach my $letter (split('', $line2)){
                $hashmap->{$letter} = 1;
            }
            push(@hashmap_array, $hashmap);
        }
        my %final_hashmap;
        foreach my $hashmap (@hashmap_array){
            foreach my $key (keys(%$hashmap)){
                if ($final_hashmap{$key}){
                    $final_hashmap{$key} += $hashmap->{$key};
                    if ($final_hashmap{$key} == 3){
                        $answer += $lookup->{$key};
                    }
                }
                else {
                    $final_hashmap{$key} = 1;
                }
            }
        }
        @threegroup = ();
    }
}
print("$answer\n");