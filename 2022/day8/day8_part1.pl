#! /usr/bin/env perl
use strict;
use warnings;
use Switch;
use Data::Dumper;
use POSIX qw/ceil/;

sub main {
    my $fh = undef;
    if (scalar(@ARGV) > 0){
        open($fh, "<", "testinput.txt") or die $!;
    }
    else {
        open($fh, "<", "input.txt") or die $!;
    }
    my $tree_arrayref = [];
    while (my $line = <$fh>){
        chomp($line);
        my @split = map{{'val'=>$_}} split('', $line);
        push(@{$tree_arrayref}, \@split);
    }
    my $rows = scalar(@{$tree_arrayref});
    my $columns = scalar(@{$tree_arrayref->[0]});
    print("ROWS: $rows COLUMNS: $columns\n");

    # Transverse outer layer and marked them all visible
    foreach my $index_pair (transverse_2d_perimeter($tree_arrayref, 0, 0, 0, 1, 0)){
        my $row = $index_pair->[0];
        my $column = $index_pair->[1];
        if ($row == 0){
            $tree_arrayref->[$row]->[$column]->{'visible_top'} = 1;
        }
        elsif ($row == $rows-1){
            $tree_arrayref->[$row]->[$column]->{'visible_bottom'} = 1;
        }
        if ($column == 0){
            $tree_arrayref->[$row]->[$column]->{'visible_left'} = 1;
        }
        elsif ($column == $columns-1){
            $tree_arrayref->[$row]->[$column]->{'visible_right'} = 1;
        }
    }

    # Calculate top visibility
    foreach my $row (1..($rows-1)){
        foreach my $column (0..($columns-1)){
            my @trees_above = (0..$row-1);
            my @trees_shorter = grep{$tree_arrayref->[$row]->[$column]->{'val'} > $tree_arrayref->[$_]->[$column]->{'val'}} @trees_above;
            # print("$row $column\n");
            # print(Dumper(\@trees_shorter));
            if (
                scalar(@trees_shorter) == scalar(@trees_above)
            ){
                $tree_arrayref->[$row]->[$column]->{'visible_top'} = 1;
            }
            else {
                $tree_arrayref->[$row]->[$column]->{'visible_top'} = 0;
            }
        }
    }
    # Calculate bottom visibility
    foreach my $row (0..($rows-2)){
        foreach my $column (0..($columns-1)){
            my @trees_below = ($row..($rows-1));
            my @trees_shorter = grep{$tree_arrayref->[$row]->[$column]->{'val'} > $tree_arrayref->[$_]->[$column]->{'val'}} @trees_below;

            if (
                scalar(@trees_shorter) == scalar(@trees_below)
            ){
                print("$row $column is visible from bottom\n");
                $tree_arrayref->[$row]->[$column]->{'visible_bottom'} = 1;
            }
            else {
                $tree_arrayref->[$row]->[$column]->{'visible_bottom'} = 0;
            }
        }
    }
}

sub transverse_2d_perimeter {
    my ($arrayref, $current_column, $current_row, $columns_traversed, $layer_target, $current_layer) = @_;
    my $rows = scalar(@{$arrayref}) - 1;
    my $columns = scalar(@{$arrayref->[0]}) - 1;
    my $transversal_indices_arrayref;

    # Return if we've already traversed the array
    if ($columns_traversed == ($rows+1)*($columns+1) || ($layer_target && $current_layer == $layer_target)){
        return ();
    }
    push(@$transversal_indices_arrayref, map {[$current_row, $_]} ($current_column..($columns-$current_column)));
    push(@$transversal_indices_arrayref, map {[$_, $columns-$current_column]} (($current_row+1)..($rows-$current_row)));
    push(@$transversal_indices_arrayref, map {[$rows-$current_row, $_]} reverse($current_column..($columns-$current_column-1)));
    push(@$transversal_indices_arrayref, map {[$_, $current_column]} reverse(($current_row+1)..($rows-$current_row-1)));
    $columns_traversed += scalar(@$transversal_indices_arrayref);
    return (@$transversal_indices_arrayref, transverse_2d_perimeter($arrayref, $current_row+1, $current_column+1, $columns_traversed, $layer_target, $current_layer+1));
}

# sub is_tree_visible {
#     my ($tree_arrayref, $current_row, $current_column) = @_;
#     my $visible = 0;
#     if (){

#     }
#     $tree_arrayref->{$row}->{$column}->{'visible'} = $visible;
#     return $tree_arrayref->{$row}->{$column}->{'visible'};
# }
main();