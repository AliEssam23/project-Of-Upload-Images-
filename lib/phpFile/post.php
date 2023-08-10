<?php

include "connect.php";

$image = htmlspecialchars(strip_tags($_POST["image"]));


$stmt = $con->prepare("INSERT INTO `imageofuser`(`image`) VALUES ('$image')");
$stmt->execute();





$stmt = $con->prepare("SELECT * FROM `imageofuser`");
$stmt->execute();

$user=$stmt->fetchAll(PDO::FETCH_ASSOC);


if ($stmt->rowCount() ) {
    echo (json_encode($user));
} 

?>