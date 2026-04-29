<?php
header("Access-Control-Allow-Origin: *");
include 'db.php';

$name = $_POST['name'];
$description = $_POST['description'];
$image = $_POST['image'];

$conn->query("INSERT INTO places (name, description, image)
VALUES ('$name', '$description', '$image')");

echo json_encode(["status"=>"success"]);
?>