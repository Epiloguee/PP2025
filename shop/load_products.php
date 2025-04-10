<?php
require 'config.php';

$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$limit = 20; // Количество товаров на одной странице
$offset = ($page - 1) * $limit;

// Обработка фильтров
$categories = [];
if (isset($_GET['categories']) && is_array($_GET['categories'])) {
    if (!in_array('all', $_GET['categories'])) {
        $categories = $_GET['categories'];
    }
}

if ($categories) {
    // Именованные плейсхолдеры для каждой категории
    $placeholders = [];
    $params = [];
    foreach ($categories as $index => $cat) {
        $key = ':cat' . $index;
        $placeholders[] = $key;
        $params[$key] = $cat;
    }
    $query = "SELECT * FROM products WHERE category_id IN (" . implode(',', $placeholders) . ") LIMIT :limit OFFSET :offset";
    $stmt = $pdo->prepare($query);
    // Привязываем параметры категорий для корректной дальнейшей обработки
    foreach ($params as $key => $value) {
        $stmt->bindValue($key, $value);
    }
    $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
    $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
    $stmt->execute();
} else {
    $query = "SELECT * FROM products LIMIT :limit OFFSET :offset";
    $stmt = $pdo->prepare($query);
    $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
    $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
    $stmt->execute();
}

$products = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Вывод товаров в виде карточек
if ($products):
    foreach ($products as $row): ?>
        <div class="col-md-4 product-item">
            <a href="product.php?id=<?= $row['id'] ?>" class="card mb-4" style="text-decoration: none;">
                <img src="images/<?= $row['image'] ?>" class="card-img-top" alt="<?= $row['name'] ?>">
                <div class="card-body">
                    <h5 class="card-title"><?= $row['name'] ?></h5>
                    <p class="card-text">Цена: <?= $row['price'] ?> руб.</p>
                </div>
            </a>
        </div>
    <?php endforeach;
else:
    // Если товаров больше нет
    echo '';
endif;
?>
