<?php
require 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST['name'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $stock = $_POST['stock'];
    $category_id = $_POST['category_id'];
    
    // Проверка существования категории
    $stmt = $pdo->prepare("SELECT id FROM categories WHERE id = ?");
    $stmt->execute([$category_id]);
    
    if ($stmt->rowCount() == 0) {
        die("Ошибка: указанная категория не существует.");
    }

    $image = $_FILES['image']['name'];
    $target = "images/" . basename($image);

    if (move_uploaded_file($_FILES['image']['tmp_name'], $target)) {
        $stmt = $pdo->prepare("INSERT INTO products (category_id, name, description, price, image, stock) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->execute([$category_id, $name, $description, $price, $image, $stock]);
        echo "Товар успешно добавлен!";
    } else {
        echo "Ошибка при загрузке изображения.";
    }
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <!-- Мета-тег для корректного отображения на мобильных устройствах -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Добавление товара</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <?php include 'header.php'; ?>
    <style>
        /* Дополнительные стили для мобильных устройств */
        @media (max-width: 576px) {
            .container {
                padding: 15px;
            }
            h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2>Добавить товар</h2>
    <form action="add_product.php" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Название</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Описание</label>
            <textarea name="description" class="form-control" required></textarea>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Цена</label>
                <input type="number" name="price" class="form-control" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Количество</label>
                <input type="number" name="stock" class="form-control" required>
            </div>
        </div>
        <div class="mb-3">
            <label class="form-label">Категория</label>
            <select name="category_id" class="form-select" required>
                <option value="">Выберите категорию</option>
                <?php
                require 'config.php';
                $stmt = $pdo->query("SELECT id, name FROM categories");
                while ($category = $stmt->fetch(PDO::FETCH_ASSOC)) {
                    echo "<option value=\"{$category['id']}\">{$category['name']}</option>";
                }
                ?>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Изображение</label>
            <input type="file" name="image" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Добавить</button>
    </form>
</div>
</body>
</html>