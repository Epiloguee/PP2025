<?php
session_start();
require 'config.php';

if (!isset($_SESSION['user'])) {
    header('Location: login.php');
    exit;
}

$stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
$stmt->execute([$_SESSION['user']]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['profile_image'])) {
    try {
        // Получаем старое изображение пользователя
        $old_image = $user['profile_image'];

        // Проверяем, существует ли старое изображение и удаляем его
        if ($old_image && file_exists($old_image)) {
            unlink($old_image);  // Удаляем старое изображение
        }

        // Загружаем новое изображение
        $img_tmp = $_FILES['profile_image']['tmp_name'];
        $img_ext = pathinfo($_FILES['profile_image']['name'], PATHINFO_EXTENSION);
        $new_img_name = 'uploads/' . uniqid() . '.' . $img_ext;

        if (move_uploaded_file($img_tmp, $new_img_name)) {
            // Обновляем путь к изображению в базе данных
            $stmt = $pdo->prepare("UPDATE users SET profile_image = ? WHERE username = ?");
            $stmt->execute([$new_img_name, $_SESSION['user']]);
            
            // Возвращаем успешный JSON-ответ
            echo json_encode(['success' => true, 'message' => 'Изображение успешно загружено']);
        } else {
            throw new Exception('Ошибка при загрузке файла.');
        }
    } catch (Exception $e) {
        // Логируем ошибку и возвращаем сообщение об ошибке
        error_log('Ошибка: ' . $e->getMessage());
        echo json_encode(['success' => false, 'message' => 'Ошибка при загрузке изображения']);
    }
    exit; // Завершаем выполнение скрипта
}
?>

<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Профиль - Магазин подарков</title>
    <link  href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.13/cropper.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <?php include 'header.php'; ?>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .image-crop-container {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: white;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0,0,0,0.3);
        z-index: 9999;
        max-width: 80vw; /* Максимальная ширина 80% от экрана */
        max-height: 80vh; /* Максимальная высота 80% от экрана */
        overflow: hidden;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    #image-to-crop {
        max-width: 100%;
        max-height: 60vh; /* Максимальная высота изображения */
    }

    .profile-img {
        width: 150px;
        height: 150px;
        object-fit: cover;
        border-radius: 50%;
        border: 2px dashed #ccc;
        cursor: pointer;
    }

    .save-button {
        margin-top: 10px;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    .save-button:hover {
        background-color: #0056b3;
    }
    </style>
</head>

<body>

    <div class="container">
        <div class="profile-container text-center">
            <h2>Профиль пользователя</h2>
            <form action="profile.php" method="POST" enctype="multipart/form-data">
                <label for="profile_image">
                    <img src="<?= $user['profile_image'] ?? 'uploads/orig.webp' ?>" class="profile-img" alt="Фото профиля"
                        id="profile-image-preview">
                </label>
                <input type="file" id="profile_image" name="profile_image" class="d-none"
                    onchange="handleFileSelect(event)">
            </form>
            <h3><?= htmlspecialchars($user['username']) ?></h3>
            <p>Email: <?= htmlspecialchars($user['email']) ?></p>
            <a href="favorites.php" class="btn btn-outline-primary">Избранное</a>
            <a href="cart.php" class="btn btn-outline-secondary">Корзина</a>
            <a href="logout.php" class="btn btn-danger">Выйти</a>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.13/cropper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script.js"></script>
</body>

</html>