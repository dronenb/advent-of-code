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
my $answer = '';
my @column_lines;
my @moves;
my %column_indices;
my $num_columns = 0;
while (my $line = <$fh>){
    chomp($line);
    if ($line eq ''){
        next;
    }
    elsif ($line =~ m/\[/){
        push(@column_lines, $line);
    }
    elsif ($line =~ m/move/){
         push (@moves, $line);
    }
    else {
        foreach my $num (split(m/\s+/, $line)){
            next if ($num eq '');
            if ($num > $num_columns){
                $num_columns = $num;
            }
            $column_indices{$num} = index($line, $num);
        }
    }
}
my @columns;
foreach my $colnum (0..($num_columns - 1)) {
    push(@columns, []);
    foreach my $column_line (reverse(@column_lines)){
        my $letter = substr($column_line, $column_indices{$colnum + 1}, length($colnum + 1));
        $letter =~ s/\s//g;
        if (!($letter eq '')){
            push(@{$columns[$colnum]}, $letter);
        }
    }
}
foreach my $move (@moves){
    $move =~ m/move (\d+) from (\d+) to (\d)+/;
    my ($count, $previous, $next) = ($1, $2, $3);
    foreach my $num (1..$count){
        push(@{$columns[$next-1]}, pop(@{$columns[$previous-1]}));
    }
}
$answer = join('', map {$_->[-1]} @columns);
print("ANSWER: $answer\n");