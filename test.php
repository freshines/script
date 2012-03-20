#!/usr/bin/php
<?php
echo 'a';
$in = fopen("php://stdin","r");
$results = array();
while ( $line = fgets($in,4096) )
{
	$words = preg_split('/\W/',$line,0,PREG_SPLIT_NO_EMPTY);
	foreach ($words as $word)
		$results[$word]++ ;
}
fclose($in);
foreach ($results as $key => $value)
{
	print "$key\t$value\n";
}