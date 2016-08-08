use warnings;
use strict;
use Data::Dumper;

my $n=0;
my $root={};
my $time = time;
open (D, "<", 'dict');
while (my $text = <D>){
	chomp $text;
	$n++;
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

# warn Dumper($root);

warn time - $time;

open (S, "<", 'text');
$n =0;
$time = time;
while (my $line = <S>){
my $found =0;
	chomp $line;
	$n++;
	my $hashRef = \$root;
	my $switch=0;
	my @tmp = split(' ', $line);
	my $match="";
	my $print ="";
	for (my $i=0; $i<=$#tmp; $i++){
		my $tmp = $tmp[$i];
		if (defined $$hashRef->{$tmp}){
			check:
			$hashRef=\$$hashRef->{$tmp};
			$match.=$tmp." ";
			if (defined $$hashRef->{''}){
				$match=~s/ $//;
				$print.="<FOUND>$match<\/FOUND> ";
				$found =1;
				$hashRef=\$root;
				$match="";
			}
		}
		else {
			$hashRef=\$root;
			if(not defined $$hashRef->{$tmp}){$print.=$match.$tmp." ";}
			# if (defined $$hashRef->{$tmp})
			else {
				$print.=$match;
				$match="";
				goto check;
				}
		}
	}
	$print=~s/ $//;
	print $print, "\n" if $found ==1;
	# last if $n>500;
}
warn time - $time;
