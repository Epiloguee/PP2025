<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start(); // Убедимся, что сессия запущена
}
?>
<link rel="icon" href="images/gift.webp" type="image/webp">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.php">🎁 Подарки и Сувениры</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <!-- Разные элементы для гостей и пользователей -->
                <?php if (isset($_SESSION['user'])): ?>
                    <!-- Меню для зарегистрированных пользователей -->
                    <li class="nav-item"><a class="nav-link" href="add_product.php">✨ Добавить</a></li>
                    <li class="nav-item"><a class="nav-link" href="favorites.php">❤️ Избранное</a></li>
                    <li class="nav-item"><a class="nav-link" href="cart.php">🛒 Корзина</a></li>
                    <li class="nav-item"><a class="nav-link" href="profile.php">👤 Профиль</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.php">🚪 Выход</a></li>
                <?php else: ?>
                    <!-- Меню для гостей -->
                    <li class="nav-item"><a class="nav-link" href="login.php">🔑 Вход</a></li>
                    <li class="nav-item"><a class="nav-link" href="register.php">📝 Регистрация</a></li>
                <?php endif; ?>
            </ul>
        </div>
    </div>
</nav>
