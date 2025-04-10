<?php
session_start();
require 'config.php';

if (!isset($_SESSION['user'])) {
    echo json_encode(['success' => false, 'message' => 'Пользователь не авторизован']);
    exit;
}

// Получаем ID пользователя
$stmt = $pdo->prepare("SELECT id FROM users WHERE username = ?");
$stmt->execute([$_SESSION['user']]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);
$user_id = $user['id'];

// 1. Обновление количества товара
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['product_id'], $_POST['quantity'])) {
    $product_id = (int)$_POST['product_id'];
    $quantity = (int)$_POST['quantity'];
    
    if ($quantity < 1) {
        echo json_encode(['success' => false, 'message' => 'Некорректное количество']);
        exit;
    }
    
    $stmt = $pdo->prepare("UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?");
    $stmt->execute([$quantity, $user_id, $product_id]);
    
    // Пересчитываем общую сумму корзины
    $stmt = $pdo->prepare("SELECT SUM(products.price * cart.quantity) AS total_price FROM cart JOIN products ON cart.product_id = products.id WHERE cart.user_id = ?");
    $stmt->execute([$user_id]);
    $total = $stmt->fetch(PDO::FETCH_ASSOC)['total_price'] ?? 0;
    
    echo json_encode(['success' => true, 'total_price' => $total]);
    exit;
}

// 2. Удаление товара из корзины
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['remove_product_id'])) {
    $product_id = (int)$_POST['remove_product_id'];
    $stmt = $pdo->prepare("DELETE FROM cart WHERE user_id = ? AND product_id = ?");
    $stmt->execute([$user_id, $product_id]);
    
    // Пересчитываем общую сумму корзины
    $stmt = $pdo->prepare("SELECT SUM(products.price * cart.quantity) AS total_price FROM cart JOIN products ON cart.product_id = products.id WHERE cart.user_id = ?");
    $stmt->execute([$user_id]);
    $total = $stmt->fetch(PDO::FETCH_ASSOC)['total_price'] ?? 0;
    
    echo json_encode(['success' => true, 'total_price' => $total]);
    exit;
}

// 3. Очистка всей корзины
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['clear_cart'])) {
    $stmt = $pdo->prepare("DELETE FROM cart WHERE user_id = ?");
    $stmt->execute([$user_id]);
    echo json_encode(['success' => true, 'total_price' => 0]);
    exit;
}

echo json_encode(['success' => false, 'message' => 'Некорректный запрос']);
exit;
