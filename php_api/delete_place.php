<?php
header("Access-Control-Allow-Origin: *");
include 'db.php';

$id = $_POST['id'];

$conn->query("DELETE FROM places WHERE id=$id");

echo json_encode(["status"=>"success"]);
?>