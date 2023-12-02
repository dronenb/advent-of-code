#! /usr/bin/env perl
use strict;
use warnings;
use Switch;
use Data::Dumper;
use POSIX qw/ceil/;
use List::Util qw/max sum/;

sub main {
    my $fh = undef;
    if (scalar(@ARGV) > 0){
        open($fh, "<", "testinput.txt") or die $!;
    }
    else {
        open($fh, "<", "input.txt") or die $!;
    }
    my $tree_height_arrayref = [];
    while (my $line = <$fh>){
        chomp($line);
        my @split = split('', $line);
        push(@{$tree_height_arrayref}, \@split);
    }
    my $row_max_index = $#{$tree_height_arrayref};
    my $col_max_index = $#{$tree_height_arrayref->[0]};
    my $visible_arrayref = [map {[map {0}(0..$col_max_index)]} (0..$row_max_index)];

    ROW: for my $row_index (0..$row_max_index){
        COL: for my $col_index (0..$col_max_index){
            if (is_perimeter($row_index, $col_index, $row_max_index, $col_max_index)){
                $visible_arrayref->[$row_index]->[$col_index] = 1;
                next COL;
            }
            my $tree_height = $tree_height_arrayref->[$row_index]->[$col_index];
            # Side to side
            for my $test ([0..($col_index-1)],[($col_index+1)..$col_max_index]){
                COL2: for my $col (@$test){
                    my $test_height = $tree_height_arrayref->[$row_index]->[$col];
                    if ($test_height < $tree_height){
                        if ($col == (max(@$test))){
                            $visible_arrayref->[$row_index]->[$col_index] = 1;
                            next COL;
                        }
                        else {
                            next COL2;
                        }
                    }
                    else {
                        last COL2;
                    }
                }
            }

            # Up/down
            for my $test ([0..($row_index-1)],[($row_index+1)..$row_max_index]){
                ROW2: for my $row (@$test){
                    my $test_height = $tree_height_arrayref->[$row]->[$col_index];
                    if ($test_height < $tree_height){
                        if ($row == (max(@$test))){
                            $visible_arrayref->[$row_index]->[$col_index] = 1;
                            next COL;
                        }
                        else {
                            next ROW2;
                        }
                    }
                    else {
                        last ROW2;
                    }
                }
            }
        }
    }
    printf("%d", sum(map{sum(@$_)}(@$visible_arrayref)));
}

sub is_perimeter {
    my ($row_index, $col_index, $row_max_index, $col_max_index) = @_;
    return ($row_index == 0 || $row_index == $row_max_index || $col_index == 0 || $col_index == $col_max_index);
}

main();