<?php
session_start();
require 'config.php';

if (!isset($_SESSION['user'])) {
    header('Location: login.php');
    exit;
}

// Получаем ID пользователя
$stmt = $pdo->prepare("SELECT id FROM users WHERE username = ?");
$stmt->execute([$_SESSION['user']]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);
$user_id = $user['id'];

// Проверяем, был ли передан ID товара
if (isset($_POST['product_id'])) {
    $product_id = (int)$_POST['product_id'];

    // Удаляем товар из избранного
    $deleteStmt = $pdo->prepare("DELETE FROM favorites WHERE user_id = ? AND product_id = ?");
    $deleteStmt->execute([$user_id, $product_id]);

    $_SESSION['message'] = 'Товар удалён из избранного!';
}

header('Location: favorites.php');
exit;
?>
