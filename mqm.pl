use warnings;
use strict;

my $root={};
my $time = time;
open (D, "<", 'dict');
while (my $text = <D>){
	chomp $text;
	my $hashRef = \$root;    
	my @tmp = split(' ', $text);
	foreach my $tmp (@tmp){
		$hashRef = \$$hashRef->{$tmp};
		if (\$tmp==\$tmp[-1]){
			$hashRef = \$$hashRef->{''};
			$$hashRef=1;
		}
	}
	last if $n>5;
}

warn time - $time;

sub found_match {
	my ($fm_print_line, $fm_match, $fm_found, $fm_ref)= @_;
	$fm_print_line .= "<FOUND>".$fm_match."<\/FOUND> ";
	$fm_found =1;
	$fm_ref = \$root;
	$fm_match ="";	
	return ($fm_print_line, $fm_match, $fm_found, $fm_ref);
}

open (S, "<", 'text');
$time = time;
while (my $line = <S>){
	my $found =0;
	chomp $line;
	my $hashRef = \$root;
	my $switch=0;
	my @tmp = split(' ', $line);
	my $match="";
	my $print ="";
	for (my $i=0; $i<=$#tmp; $i++){
		my $tmp = $tmp[$i];
		if (defined $$hashRef->{$tmp}){
			$hashRef=\$$hashRef->{$tmp};
			$match.=$tmp." ";
			if (defined $$hashRef->{''}){
				$match=~s/ $//;
				($print, $match, $found, $hashRef) = found_match($print, $match, $found, $hashRef);
			}
		}
		else {
			$hashRef=\$root;
			if (not defined $$hashRef->{$tmp}){
				$print.=$match.$tmp." ";
			}
			else {
				$print.=$match;
				$match="";
				$hashRef = \$$hashRef->{$tmp};
				$match.=$tmp." ";
				if (defined $$hashRef->{''}){
					$match =~s/ $//;
					($print, $match, $found, $hashRef) = found_match($print, $match, $found, $hashRef);
				}
			}
		}
	}
	$print=~s/ $//;
	print $print, "\n" if $found ==1;
}
warn time - $time;
