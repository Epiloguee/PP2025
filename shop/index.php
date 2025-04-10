<?php
session_start();
require 'config.php';
?>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Магазин подарков</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet">
    <?php include 'header.php'; ?>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .card img {
            height: 250px;
            object-fit: contain;
        }
        .filter-section {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h1 class="text-center mb-4">Каталог товаров</h1>
        <div class="filter-section mb-4">
            <form id="filterForm">
                <label for="categories" class="form-label">Выберите категории:</label>
                <select name="categories[]" id="categories" class="form-select select2" multiple>
                    <option value="all" selected>Все категории</option>
                    <?php
                    $stmt = $pdo->query("SELECT * FROM categories");
                    while ($category = $stmt->fetch(PDO::FETCH_ASSOC)):
                    ?>
                        <option value="<?= $category['id'] ?>">
                            <?= $category['name'] ?>
                        </option>
                    <?php endwhile; ?>
                </select>
                <button type="submit" class="btn btn-primary mt-3">Применить фильтр</button>
            </form>
        </div>
        <div class="row" id="products-container">
            <!-- Товары будут подгружаться сюда через AJAX -->
        </div>
        <div id="loading" class="text-center" style="display: none;">
            <p>Загрузка...</p>
        </div>
    </div>

    <!-- Подключение библиотек -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        $(document).ready(function () {
            $('.select2').select2({
                placeholder: "Выберите категории",
                allowClear: true
            });

            let currentPage = 1;
            let loading = false;
            let endOfProducts = false; // Флаг, что товары закончились

            // Функция загрузки товаров
            function loadProducts(page) {
                if (loading || endOfProducts) return;
                loading = true;
                $('#loading').show();

                // Собираем данные фильтрации и добавляем к ним номер текущей страницы для AJAX
                let formData = $('#filterForm').serializeArray();
                formData.push({ name: 'page', value: page });

                // AJAX-запрос для подгрузки товаров
                $.ajax({
                    url: 'load_products.php',
                    method: 'GET',
                    data: formData,
                    success: function (data) {
                        if($.trim(data) === ''){
                            endOfProducts = true;
                        } else {
                            $('#products-container').append(data);
                            currentPage++;
                        }
                    },
                    error: function () {
                        console.error('Ошибка загрузки товаров');
                    },
                    complete: function () {
                        loading = false;
                        $('#loading').hide();
                    }
                });
            }

            // Начальная загрузка товаров
            loadProducts(currentPage);

            // Обработка скролла для подгрузки следующих товаров
            $(window).on('scroll', function () {
                if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
                    loadProducts(currentPage);
                }
            });

            // При отправке формы фильтрации сбрасываем текущие данные и подгружаем товары по новым фильтрам
            $('#filterForm').on('submit', function (e) {
                e.preventDefault();
                $('#products-container').html('');
                currentPage = 1;
                endOfProducts = false;
                loadProducts(currentPage);
            });
        });
    </script>
</body>
</html>