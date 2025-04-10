<?php
session_start();
require 'config.php';

$product_id = isset($_GET['id']) ? (int) $_GET['id'] : 0;
$stmt = $pdo->prepare("SELECT * FROM products WHERE id = ?");
$stmt->execute([$product_id]);
$product = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$product) {
    die("Товар не найден");
}
?>
<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($product['name']) ?> - Магазин подарков</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet">
    <?php include 'header.php'; ?>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .carousel img {
            max-height: 500px;
            object-fit: contain;
        }

        .product-details {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Стилизация кнопок */
        .button-group {
            display: flex;
            gap: 10px;
            justify-content: flex-start;
            margin-top: 10px;
        }

        .btn {
            background-color: #007bff;
            color: #fff;
            border: 1px solid #007bff;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn:hover {
            background-color: #0056b3;
            border-color: #0056b3;
            transform: translateY(-2px);
            /* Эффект "поднятия" кнопки */
        }

        .btn:active {
            background-color: #004085;
            border-color: #004085;
            transform: translateY(0);
        }

        .button-group .btn {
            margin-top: 10px;
        }

        /* Кнопка избранного */
        form #add-to-favorites {
            background-color: #28a745;
            border-color: #28a745;
        }

        form #add-to-favorites:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
    </style>
</head>

<body>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6">
                <div id="productCarousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="images/<?= $product['image'] ?>" class="d-block w-100"
                                alt="<?= $product['name'] ?>">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="product-details">
                    <h1><?= htmlspecialchars($product['name']) ?></h1>
                    <p class="text-muted">Цена: <?= $product['price'] ?> руб.</p>
                    <p><?= htmlspecialchars($product['description']) ?></p>
                    <div class="button-group">
                        <form action="add_to_cart.php" method="POST" class="d-inline">
                            <input type="hidden" name="product_id" value="<?= $product['id'] ?>">
                            <button type="submit" class="btn btn-primary">Добавить в корзину</button>
                        </form>
                        <form action="add_to_favorites.php" method="POST">
                            <input type="hidden" name="product_id" value="<?= $product_id; ?>">
                            <button type="submit" class="btn btn-primary" id="add-to-favorites">Добавить в избранное</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-5">
            <h3>Отзывы</h3>
            <ul class="list-group">
                <?php
                $reviews = $pdo->prepare("
                SELECT reviews.*, users.username 
                FROM reviews 
                JOIN users ON reviews.user_id = users.id 
                WHERE reviews.product_id = ?
            ");
                $reviews->execute([$product_id]);
                while ($review = $reviews->fetch(PDO::FETCH_ASSOC)):
                    ?>
                    <li class="list-group-item">
                        <strong><?= htmlspecialchars($review['username']) ?>:</strong>
                        <span class="badge bg-warning text-dark">⭐ <?= $review['rating'] ?>/5</span>
                        <p><?= htmlspecialchars($review['comment']) ?></p>
                    </li>
                <?php endwhile; ?>
            </ul>

            <?php if (isset($_SESSION['user'])): ?>
                <div class="mt-4">
                    <h4>Оставить отзыв</h4>
                    <form method="POST" action="add_review.php">
                        <input type="hidden" name="product_id" value="<?= $product['id'] ?>">
                        <div class="mb-3">
                            <label for="rating" class="form-label">Оценка:</label>
                            <select name="rating" id="rating" class="form-select">
                                <option value="5">⭐️⭐️⭐️⭐️⭐️</option>
                                <option value="4">⭐️⭐️⭐️⭐️</option>
                                <option value="3">⭐️⭐️⭐️</option>
                                <option value="2">⭐️⭐️</option>
                                <option value="1">⭐️</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="comment" class="form-label">Комментарий:</label>
                            <textarea name="comment" id="comment" class="form-control" rows="3" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Отправить</button>
                    </form>
                </div>
            <?php else: ?>
                <p class="mt-4">Чтобы оставить отзыв, <a href="login.php">войдите</a> в аккаунт.</p>
            <?php endif; ?>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>