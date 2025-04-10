<?php
session_start();
require 'config.php';

if (!isset($_SESSION['user_id'])) {
    die('Ошибка: пользователь не авторизован.');
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $product_id = $_POST['product_id'];
    $rating = $_POST['rating'];
    $comment = trim($_POST['comment']);
    $user_id = $_SESSION['user_id'];
    $created_at = date('Y-m-d H:i:s');

    if ($rating >= 1 && $rating <= 5 && !empty($comment)) {
        $stmt = $pdo->prepare("INSERT INTO reviews (user_id, product_id, rating, comment, created_at) VALUES (?, ?, ?, ?, ?)");
        if ($stmt->execute([$user_id, $product_id, $rating, $comment, $created_at])) {
            $_SESSION['success'] = "Ваш отзыв успешно добавлен!";
        } else {
            $_SESSION['error'] = "Ошибка при добавлении отзыва. Попробуйте снова.";
        }
    } else {
        $_SESSION['error'] = "Заполните все поля корректно.";
    }
    header("Location: product.php?id=$product_id");
    exit;
}
?>
