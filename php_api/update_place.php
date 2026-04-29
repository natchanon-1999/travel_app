<?php
header("Access-Control-Allow-Origin: *");
include 'db.php';

$id = $_POST['id'];
$name = $_POST['name'];
$description = $_POST['description'];

$conn->query("UPDATE places 
SET name='$name', description='$description'
WHERE id=$id");

echo json_encode(["status"=>"success"]);
?>