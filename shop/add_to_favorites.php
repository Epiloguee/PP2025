<?php
session_start();
require 'config.php'; // Подключение к базе данных

// Проверяем, авторизован ли пользователь
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}

// Получаем ID пользователя и товара
$user_id = $_SESSION['user_id'];
$product_id = $_POST['product_id'] ?? null;

if ($product_id) {
    // Проверяем, есть ли товар уже в избранном
    $stmt = $pdo->prepare("SELECT * FROM favorites WHERE user_id = :user_id AND product_id = :product_id");
    $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
    $stmt->bindParam(':product_id', $product_id, PDO::PARAM_INT);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$result) {
        // Если товара нет в избранном, добавляем его
        $stmt = $pdo->prepare("INSERT INTO favorites (user_id, product_id) VALUES (:user_id, :product_id)");
        $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
        $stmt->bindParam(':product_id', $product_id, PDO::PARAM_INT);

        if ($stmt->execute()) {
            $_SESSION['success_message'] = 'Товар успешно добавлен в избранное!';
        } else {
            $_SESSION['error_message'] = 'Произошла ошибка при добавлении в избранное.';
        }
    } else {
        $_SESSION['error_message'] = 'Этот товар уже есть в вашем списке избранного.';
    }
    $stmt = null;
}

header('Location: product.php?id=' . $product_id);
exit();
