#! /usr/bin/env perl
use strict;
use warnings;
use Switch;
use Data::Dumper;
use List::Util qw/sum/;

my $fh = undef;
if (scalar(@ARGV) > 0){
    open($fh, "<", "testinput.txt") or die $!;
}
else {
    open($fh, "<", "input.txt") or die $!;
}
my $answer = 0;
my $tree = {
    'dirs' => {},
    'files' => {},
    'parent' => undef,
};
my $pwd;
while (my $line = <$fh>){
    chomp($line);
    if ($line =~ m/\$ cd \//){
        $pwd = $tree;
    }
    elsif ($line =~ m/\$ cd \.\./){
        $pwd = $pwd->{'parent'};
    }
    elsif ($line =~ m/\$ cd (.*)/){
        my $dir = $1;
        $pwd = $pwd->{'dirs'}->{$dir};
    }
    elsif ($line =~ m/dir (.*)/){
        my $dir = $1;
        if (not(exists($pwd->{'dirs'}->{$dir}))){
            $pwd->{'dirs'}->{$dir} = {'dirs'=>{}, 'files'=>{}, 'parent' => $pwd};
        }
    }
    elsif ($line =~ m/(\d+) (.*)/){
        my ($size, $filename) = ($1, $2);
        $pwd->{'files'}->{$filename} = $size;
    }
}
sum_subtree($tree);

sub sum_subtree {
    my ($tree) = @_;
    my $running_sum = 0;
    foreach my $value (values(%{$tree->{'files'}})){
        $running_sum += $value;
    }
    foreach my $dir (keys %{$tree->{'dirs'}}){
        $running_sum += sum_subtree($tree->{'dirs'}->{$dir});
    }
    $tree->{'size'} = $running_sum;
    if ($running_sum <= 100000){
        $answer += $running_sum;
    }
    return $running_sum;
}
print("ANSWER: $answer\n");
