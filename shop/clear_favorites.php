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

// Очищаем все избранные товары пользователя
$deleteStmt = $pdo->prepare("DELETE FROM favorites WHERE user_id = ?");
$deleteStmt->execute([$user_id]);

$_SESSION['message'] = 'Избранное очищено!';
header('Location: favorites.php');
exit;
?>
