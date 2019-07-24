#!/usr/bin/perl -w
#### perl qMGR.pl benchmark.txt 
### input benchmark file ####

$f0=$ARGV[0];
open I, "$f0";

$t=0;
while(<I>){
	chomp;
	@a=split /\,/;
	$nb=shift @a;
	$t=$nb+$t;
	$a=join "\t",@a;
	$map{$a}=$nb;
}
close I;



for $k2(keys %map){
		@b=split /\,/,$k2;
		$b=scalar @b;
		for $i(1 .. $b-2){
			$right{$b[$i]}=$b[$i+1];
			$left{$b[$i]}=$b[$i-1];
		}
		$right{$b[0]}=$b[1];
		$left{$b[0]}=$b[$b-1];
		$right{$b[$b-1]}=$b[0];
		$left{$b[$b-1]}=$b[$b-2];
		for $k0(@b){
			$re{$k0}=0;#1
		}
		for $g1(@b){
			$cg{$g1}++;
		}
}
close I;

#### input user's file ###


$fx=$ARGV[1]; #### the name of input file 
$fo=$ARGV[2]; #### the simple label of output file 

$fp=$fx;


open I, "$fp";

undef%map;
while(<I>){
	chomp;
	@a=split /\,/;
	$nb=shift @a;
	$a=join "\t",@a;
	$map{$a}=$nb;
}
close I;




for $k(keys %map){
	$sp_score{$k}=0;
	undef @c;
		@c=split /\t/,$k;
		$c=scalar @c;
		for $i(1 .. $c-2){
			if($right{$c[$i]} ne $c[$i+1]){
				$sp_score{$k}++;
				$re{$c[$i]}=$re{$c[$i]}+$map{$k};
			}
			if($left{$c[$i]} ne $c[$i-1]){
				$sp_score{$k}++;
 				$re{$c[$i]}=$re{$c[$i]}+$map{$k};
			}
		}
		if($right{$c[0]} ne $c[1]){
				$sp_score{$k}++;
       				$re{$c[0]}=$re{$c[0]}+$map{$k};
		}
		if($left{$c[0]} ne $c[$c-1]){
				$sp_score{$k}++;
				$re{$c[0]}=$re{$c[0]}+$map{$k};
		}
		if($right{$c[$c-1]} ne $c[0]){
				$sp_score{$k}++;
				$re{$c[$c-1]}=$re{$c[$c-1]}+$map{$k};
		}
		if($left{$c[$c-1]} ne $c[$c-2]){
				$sp_score{$k}++;
				$re{$c[$c-1]}=$re{$c[$c-1]}+$map{$k};
		}
		
		for $eg(keys %cg){
			if ($k!~/$eg/){
				$sp_score{$k}=$sp_score{$k}+2;
				$re{$eg}= $re{$eg}+(2*$map{$k});
			}
		}
	}
close I;


open O, ">$fo"."_each_spec_scores.txt";
for $k2(keys %sp_score){
    print O "$sp_score{$k2}\t$map{$k2}\t$k2\n";

}
close O;



open O1, ">$fo"."_each_gene_freqence.txt";
for $k2(@b){
	$rcs=$re{$k2}/(2*$t);
	$rc = sprintf "%0.5f",$rcs;
    print O1 "$k2\t$rc\t$re{$k2}\n";
}
close O1;


