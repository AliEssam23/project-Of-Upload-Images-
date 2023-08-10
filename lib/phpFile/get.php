
<?php

include "connect.php";




$stmt = $con->prepare("SELECT `image` FROM `imageofuser`");
$stmt->execute();

$user = $stmt->fetchAll(PDO::FETCH_ASSOC);
if ($stmt->rowCount()) {
    echo (json_encode($user));
}


?>