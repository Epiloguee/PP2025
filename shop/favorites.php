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

// Обработка добавления в избранное
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_to_favorites'])) {
    $product_id = (int)$_POST['product_id'];

    // Проверяем, есть ли товар уже в избранном
    $checkStmt = $pdo->prepare("SELECT * FROM favorites WHERE user_id = ? AND product_id = ?");
    $checkStmt->execute([$user_id, $product_id]);

    if ($checkStmt->rowCount() === 0) {
        // Добавляем товар в избранное
        $insertStmt = $pdo->prepare("INSERT INTO favorites (user_id, product_id) VALUES (?, ?)");
        $insertStmt->execute([$user_id, $product_id]);
        $_SESSION['message'] = 'Товар добавлен в избранное!';
    } else {
        $_SESSION['message'] = 'Товар уже в избранном!';
    }
    header('Location: favorites.php');
    exit;
}

// Получаем избранные товары пользователя
$stmt = $pdo->prepare(
    "SELECT products.* FROM favorites 
    JOIN products ON favorites.product_id = products.id 
    WHERE favorites.user_id = ?"
);
$stmt->execute([$user_id]);
$favorites = $stmt->fetchAll(PDO::FETCH_ASSOC);

?>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Избранное - Магазин подарков</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <?php include 'header.php'; ?>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .favorites-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .product-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 15px;
            background: #fdfdfd;
        }
        .product-card img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="favorites-container">
            <h2 class="text-center mb-4">Ваши избранные товары</h2>
            <?php if (isset($_SESSION['message'])): ?>
                <div class="alert alert-success"> <?= $_SESSION['message'] ?> </div>
                <?php unset($_SESSION['message']); ?>
            <?php endif; ?>

            <?php if (empty($favorites)): ?>
                <p class="text-center">У вас пока нет избранных товаров.</p>
            <?php else: ?>
                <?php foreach ($favorites as $product): ?>
                    <div class="product-card">
                        <div class="d-flex align-items-center">
                            <img src="images/<?= htmlspecialchars($product['image']) ?>" alt="<?= htmlspecialchars($product['name']) ?>">
                            <div class="ms-3">
                                <h5 class="mb-1"><?= htmlspecialchars($product['name']) ?></h5>
                                <p class="mb-0 text-muted">Цена: <?= htmlspecialchars($product['price']) ?> ₽</p>
                            </div>
                        </div>
                        <div>
                            <form action="add_to_cart.php" method="POST" class="d-inline">
                                <input type="hidden" name="product_id" value="<?= $product['id'] ?>">
                                <button type="submit" class="btn btn-success">В корзину</button>
                            </form>
                            <form action="remove_favorite.php" method="POST" class="d-inline">
                                <input type="hidden" name="product_id" value="<?= $product['id'] ?>">
                                <button type="submit" class="btn btn-danger">Удалить</button>
                            </form>
                        </div>
                    </div>
                <?php endforeach; ?>
                <form action="clear_favorites.php" method="POST" class="text-center mt-4">
                    <button type="submit" class="btn btn-outline-danger">Очистить избранное</button>
                </form>
            <?php endif; ?>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>