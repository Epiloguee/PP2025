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

// Получаем товары в корзине
$stmt = $pdo->prepare(
    "SELECT products.*, cart.quantity FROM cart 
    JOIN products ON cart.product_id = products.id 
    WHERE cart.user_id = ?"
);
$stmt->execute([$user_id]);
$cart_items = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Рассчитываем общую сумму
$total_price = 0;
foreach ($cart_items as $item) {
    $total_price += $item['price'] * $item['quantity'];
}
?>
<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Корзина - Магазин подарков</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <?php include 'header.php'; ?>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .cart-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .cart-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 15px;
            background: #fdfdfd;
        }

        .cart-item img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="cart-container">
            <h2 class="text-center mb-4">Ваша корзина</h2>
            <?php if (empty($cart_items)): ?>
                <p class="text-center">Ваша корзина пуста.</p>
            <?php else: ?>
                <?php foreach ($cart_items as $item): ?>
                    <div class="cart-item" data-id="<?= $item['id'] ?>">
                        <div class="d-flex align-items-center">
                            <img src="images/<?= htmlspecialchars($item['image']) ?>"
                                alt="<?= htmlspecialchars($item['name']) ?>">
                            <div class="ms-3">
                                <h5 class="mb-1">
                                    <a href="product.php?id=<?= $item['id'] ?>">
                                        <?= htmlspecialchars($item['name']) ?>
                                    </a>
                                </h5>
                                <p class="mb-0 text-muted">Цена: <span
                                        class="price"><?= htmlspecialchars($item['price']) ?></span> ₽</p>
                            </div>
                        </div>
                        <div>
                            <button class="btn btn-outline-secondary update-quantity" data-action="decrease">−</button>
                            <span class="quantity"><?= $item['quantity'] ?></span>
                            <button class="btn btn-outline-secondary update-quantity" data-action="increase">+</button>
                            <button class="btn btn-danger remove-item">Удалить</button>
                        </div>
                    </div>
                <?php endforeach; ?>
                <h4 class="text-end mt-3">Итого: <span id="total-price"><?= $total_price ?></span> ₽</h4>
                <form class="text-center mt-3">
                    <button type="button" id="order-button" class="btn btn-success">Оформить заказ</button>
                </form>
                <form action="cart_functions.php" method="POST" class="text-center mt-2">
                    <button type="submit" class="btn btn-outline-danger">Очистить корзину</button>
                </form>
            <?php endif; ?>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('.update-quantity').click(function () {
                let action = $(this).data('action');
                let item = $(this).closest('.cart-item');
                let productId = item.data('id');
                let quantityElement = item.find('.quantity');
                let quantity = parseInt(quantityElement.text());
                if (action === 'increase') {
                    quantity++;
                } else if (action === 'decrease' && quantity > 1) {
                    quantity--;
                }
                $.post('cart_functions.php', { product_id: productId, quantity: quantity }, function (response) {
                    if (response.success) {
                        quantityElement.text(quantity);
                        $('#total-price').text(response.total_price);
                    }
                }, 'json');
            });
        });

        $(document).ready(function () {
            // Увеличение и уменьшение количества
            $('.update-quantity').click(function () {
                let action = $(this).data('action');
                let item = $(this).closest('.cart-item');
                let productId = item.data('id');
                let quantityElement = item.find('.quantity');
                let quantity = parseInt(quantityElement.text());

                if (action === 'increase') {
                    quantity++;
                } else if (action === 'decrease' && quantity > 1) {
                    quantity--;
                }

                $.post('cart_functions.php', { product_id: productId, quantity: quantity }, function (response) {
                    if (response.success) {
                        quantityElement.text(quantity);
                        $('#total-price').text(response.total_price);
                    }
                }, 'json');
            });

            // Удаление товара из корзины
            $('.remove-item').click(function () {
                let item = $(this).closest('.cart-item');
                let productId = item.data('id');

                $.post('cart_functions.php', { remove_product_id: productId }, function (response) {
                    if (response.success) {
                        item.remove();
                        $('#total-price').text(response.total_price);
                    }
                }, 'json');
            });

            // Очистка всей корзины
            $('form[action="cart_functions.php"]').submit(function (e) {
                e.preventDefault(); // Останавливаем стандартную отправку формы

                $.post('cart_functions.php', { clear_cart: true }, function (response) {
                    if (response.success) {
                        $('.cart-item').remove();
                        $('#total-price').text(0);
                    }
                }, 'json');
            });
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.4/gsap.min.js"></script>
    <script src="glitch.js"></script>
</body>

</html>