-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Апр 09 2025 г., 11:31
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `zhilyop7_shop`
--

-- --------------------------------------------------------

--
-- Структура таблицы `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `product_id`, `quantity`, `added_at`) VALUES
(7, 1, 10, 1, '2025-01-30 06:21:30'),
(8, 1, 4, 4, '2025-01-30 06:22:38'),
(9, 1, 3, 1, '2025-01-30 09:02:59'),
(10, 1, 12, 1, '2025-01-30 09:03:07'),
(11, 1, 15, 1, '2025-01-30 09:03:14');

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `name`, `parent_id`) VALUES
(1, 'Праздничные', NULL),
(2, 'Тематические', NULL),
(3, 'Религиозные', NULL),
(4, 'Другие', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `product_id`, `added_at`) VALUES
(4, 1, 4, '2025-01-28 15:44:25'),
(5, 1, 11, '2025-01-28 15:44:45');

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `stock` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `image`, `stock`, `created_at`) VALUES
(3, 1, 'Плюшевый мишка', 'Очаровательный мягкий мишка \"Me to You\" в новогоднем наряде станет идеальным подарком для ваших близких! Этот серый пушистый мишка с заплатками на лапках одет в праздничный красный колпак Санты и держит в объятиях яркий рождественский сапожок, украшенный подарком и веточкой остролиста.', 2400.00, 'NEW_YEAR.webp', 1, '2025-01-28 14:45:20'),
(4, 1, 'Набор брелоков \"Haloween\"', 'Эти очаровательные брелоки, выполненные в стиле Хэллоуина, украсят ключи, сумку или станут идеальным подарком для фанатов мрачных и волшебных историй. На тыквенной основе представлены персонажи, которые создают атмосферу праздника: от жуткого до милого. Это не просто аксессуар, а маленький мир, который будет радовать каждый день!', 800.00, 'Haloween.webp', 1, '2025-01-28 14:46:10'),
(5, 1, 'Шляпа лепрекона', 'Шляпа лепрекона в ярко-зеленых тонах с клевером — символ удачи и праздника Святого Патрика. Идеальный аксессуар для тематической вечеринки или чтобы добавить немного ирландского колорита в свой образ!', 1200.00, 'SaintPatrick.webp', 1, '2025-01-28 14:46:41'),
(6, 2, 'Подарочный набор \"HarryPotter\"', 'Элегантный подарочный набор для поклонников мира Гарри Поттера! В стильной коробке вас ждут тематические сладости, аксессуары и сувениры. Идеальный выбор для тех, кто верит в магию!', 1600.00, 'HarryPotter.webp', 1, '2025-01-28 14:47:23'),
(7, 2, 'Подарочный набор \"StarWars\"', 'Подарочный набор для истинных фанатов Star Wars! Внутри кружка с тематическим дизайном, какао, наклейки, значок и блокнот с героями вселенной. Пусть сила всегда будет с вами!', 1600.00, 'StarWars.webp', 1, '2025-01-28 14:47:52'),
(8, 2, 'Подарочный набор \"Avengers\"', 'Подарочный набор для поклонников Мстителей! Внутри вас ждут крутые тематические аксессуары, игрушки, сладости и сувениры с любимыми героями Marvel, такими как Железный Человек, Капитан Америка и другие. Идеальный выбор для настоящего фаната супергероев!', 2600.00, 'Avengers.webp', 1, '2025-01-28 14:48:31'),
(9, 2, 'Подарочный набор \"Anime\"', 'Подарочный набор для настоящих фанатов аниме! Внутри вас ждет 18 стильных предметов, включая уникальные постеры, кружку, наклейки и многое другое с изображениями любимых персонажей. Этот набор создан для тех, кто хочет порадовать себя или близких яркими аксессуарами и сувенирами. Отличный подарок на любой случай!', 1600.00, 'Anime.webp', 1, '2025-01-28 14:49:20'),
(10, 3, 'Религиозный подарок \"Христианство\"', 'Классическая Библия с золотым крестом на обложке — символ веры и вдохновения, идеальный подарок для важного события или духовного пути.', 3333.00, 'Christianity.webp', 1, '2025-01-28 14:49:56'),
(11, 3, 'Религиозный подарок \"Ислам\"', 'Изысканная миниатюра священной Каабы с окружающими элементами из стекла и позолоты. Этот декоративный сувенир станет великолепным символом уважения к исламу и украсит любой дом или офис.', 4400.00, 'Islam.webp', 1, '2025-01-28 14:50:36'),
(12, 3, 'Религиозный подарок \"Индуизм\"', 'Изящная статуэтка, изображающая Брахму, бога-творца, сидящего на лотосе. Детальная проработка и изысканная отделка делают её идеальным элементом декора или подарком для ценителей индийской культуры и духовности.', 1200.00, 'Hinduism.webp', 1, '2025-01-28 14:51:07'),
(13, 3, 'Религиозный подарок \"Буддизм\"', 'Элегантная статуэтка Будды в медитативной позе – символ гармонии, просветления и внутреннего покоя. Ее утонченный дизайн с золотыми и бронзовыми акцентами идеально дополнит ваш интерьер, привнеся атмосферу умиротворения и духовного баланса. Прекрасный выбор для украшения дома, офиса или в качестве подарка.', 1200.00, 'Buddhism.webp', 1, '2025-01-28 14:51:30'),
(14, 4, 'Романтический подарок', 'Романтический подарок для любимого человека! В наборе кружка с милым рисунком, шоколад, сладости, какао и открытка с признанием. Идеальный способ выразить свои чувства и создать теплую атмосферу.', 2000.00, 'Romantic.webp', 1, '2025-01-28 14:51:58'),
(15, 4, 'Интеллектуальный подарок', 'Элегантный сундук с книгами — идеальный подарок для любителей литературы. Роскошный дизайн с имитацией кожи и золотыми деталями делает его стильным украшением интерьера, а книги внутри подарят незабываемые часы чтения.', 2500.00, 'Intellectual.webp', 1, '2025-01-28 14:52:26'),
(16, 4, 'Косметический подарок', 'Подарочный набор для ухода за бородой и волосами BARBARO — идеальный выбор для современных мужчин, ценящих стиль и заботу о себе. В элегантной деревянной коробке собрано всё необходимое: шампунь, бальзамы, масло и аксессуары для ухода. Прекрасный подарок, который подчеркнет внимание и заботу о его индивидуальном образе.', 1800.00, 'Cosmetic.webp', 1, '2025-01-28 14:53:10'),
(17, 4, 'Кулинарный подарок', 'Набор деликатесов с оливковым маслом, оливками и закусками — изысканный подарок для ценителей средиземноморской кухни.', 1900.00, 'Culinary.webp', 1, '2025-01-28 14:53:39'),
(19, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(20, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(21, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(22, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(23, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(24, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54'),
(25, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(26, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(27, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(28, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(29, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3464.00, 'arts (16).webp', 46, '2025-02-04 11:47:02'),
(30, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2356.00, 'arts (17).webp', 23, '2025-02-04 11:47:18'),
(31, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2355.00, 'arts (18).webp', 35, '2025-02-04 11:47:35'),
(32, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (7).webp', 23, '2025-02-04 11:47:54'),
(33, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (14).webp', 68, '2025-02-04 11:48:20'),
(34, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (21).webp', 32, '2025-02-04 11:48:37'),
(35, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3267.00, 'arts (28).webp', 43, '2025-02-04 11:48:55'),
(36, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(37, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4589.00, 'arts (13).webp', 35, '2025-02-04 11:49:35'),
(38, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4357.00, 'arts (20).webp', 45, '2025-02-04 11:49:50'),
(39, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(40, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(41, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(42, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(43, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(44, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(45, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(46, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(47, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(48, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(49, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54'),
(50, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(51, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(52, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(53, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(54, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3464.00, 'arts (16).webp', 46, '2025-02-04 11:47:02'),
(55, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2356.00, 'arts (17).webp', 23, '2025-02-04 11:47:18'),
(56, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2355.00, 'arts (18).webp', 35, '2025-02-04 11:47:35'),
(57, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (7).webp', 23, '2025-02-04 11:47:54'),
(58, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (14).webp', 68, '2025-02-04 11:48:20'),
(59, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (21).webp', 32, '2025-02-04 11:48:37'),
(60, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3267.00, 'arts (28).webp', 43, '2025-02-04 11:48:55'),
(61, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(62, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4589.00, 'arts (13).webp', 35, '2025-02-04 11:49:35'),
(63, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4357.00, 'arts (20).webp', 45, '2025-02-04 11:49:50'),
(64, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(65, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(66, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(67, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(68, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(69, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(70, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(71, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(72, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(73, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(74, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(75, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(76, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(77, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(78, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(79, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(80, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54'),
(81, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(82, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(83, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(84, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(85, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(86, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4589.00, 'arts (13).webp', 35, '2025-02-04 11:49:35'),
(87, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4357.00, 'arts (20).webp', 45, '2025-02-04 11:49:50'),
(88, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(89, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(90, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(91, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(92, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(93, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(94, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(95, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(96, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(97, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(98, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54'),
(99, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(100, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(101, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(102, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(103, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(104, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4589.00, 'arts (13).webp', 35, '2025-02-04 11:49:35'),
(105, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4357.00, 'arts (20).webp', 45, '2025-02-04 11:49:50'),
(106, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(107, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(108, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(109, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(110, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(111, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(112, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(113, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(114, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(115, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(116, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54'),
(117, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(118, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(119, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(120, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(121, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(122, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(123, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4589.00, 'arts (13).webp', 35, '2025-02-04 11:49:35'),
(124, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4357.00, 'arts (20).webp', 45, '2025-02-04 11:49:50'),
(125, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(126, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(127, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(128, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(129, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(130, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(131, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(132, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(133, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(134, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(135, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54'),
(136, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(137, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(138, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(139, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(140, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(141, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(142, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(143, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4589.00, 'arts (13).webp', 35, '2025-02-04 11:49:35'),
(144, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4357.00, 'arts (20).webp', 45, '2025-02-04 11:49:50'),
(145, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(146, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(147, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(148, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(149, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(150, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(151, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(152, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(153, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(154, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(155, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54'),
(156, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(157, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(158, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(159, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(160, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(161, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(162, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(163, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4589.00, 'arts (13).webp', 35, '2025-02-04 11:49:35'),
(164, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4357.00, 'arts (20).webp', 45, '2025-02-04 11:49:50'),
(165, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(166, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(167, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(168, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(169, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(170, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(171, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(172, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(173, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(174, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(175, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54'),
(176, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(177, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(178, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(179, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(180, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(181, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(182, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(183, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4589.00, 'arts (13).webp', 35, '2025-02-04 11:49:35'),
(184, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4357.00, 'arts (20).webp', 45, '2025-02-04 11:49:50'),
(185, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(186, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(187, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(188, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(189, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(190, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(191, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(192, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(193, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(194, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(195, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54'),
(196, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(197, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(198, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(199, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(200, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(201, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(202, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(203, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4589.00, 'arts (13).webp', 35, '2025-02-04 11:49:35'),
(204, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4357.00, 'arts (20).webp', 45, '2025-02-04 11:49:50'),
(205, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(206, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(207, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(208, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(209, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(210, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(211, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(212, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(213, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(214, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(215, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54');
INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `image`, `stock`, `created_at`) VALUES
(216, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(217, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(218, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(219, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(220, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(221, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(222, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(223, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4589.00, 'arts (13).webp', 35, '2025-02-04 11:49:35'),
(224, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4357.00, 'arts (20).webp', 45, '2025-02-04 11:49:50'),
(225, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(226, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(227, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(228, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(229, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(230, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(231, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(232, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(233, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(234, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(235, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54'),
(236, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(237, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(238, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(239, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(240, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(241, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(242, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19'),
(243, 2, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4589.00, 'arts (13).webp', 35, '2025-02-04 11:49:35'),
(244, 3, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4357.00, 'arts (20).webp', 45, '2025-02-04 11:49:50'),
(245, 4, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 4368.00, 'arts (20).webp', 67, '2025-02-04 11:50:08'),
(246, 1, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (5).webp', 34, '2025-02-04 11:50:39'),
(247, 2, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 5678.00, 'arts (12).webp', 56, '2025-02-04 11:50:53'),
(248, 3, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3578.00, 'arts (19).webp', 34, '2025-02-04 11:51:05'),
(249, 4, 'Lorem', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3679.00, 'arts (26).webp', 45, '2025-02-04 11:51:19'),
(250, 1, 'erhehdsfhgdf', '3fwsdgsdghsrh', 1004.00, 'arts (2).webp', 2, '2025-02-04 11:43:20'),
(251, 2, 'erherherh', 'erherjrhtygwergdf', 2355.00, 'arts (2).webp', 45, '2025-02-04 11:43:36'),
(252, 3, 'wegdsfsdgvdsgd', 'gsdgsdgdsgsd', 23523.00, 'arts (3).webp', 345, '2025-02-04 11:43:58'),
(253, 4, 'sagfasfsaf', 'safasfsagfasga', 3433.00, 'arts (4).webp', 23, '2025-02-04 11:44:10'),
(254, 1, 'qsedgsedtr', 'edqasdfsd', 3435.00, 'arts (8).webp', 34, '2025-02-04 11:44:44'),
(255, 2, 'ewgfwegdsgf', 'dsgdsfdsgsd', 3245.00, 'arts (9).webp', 34, '2025-02-04 11:44:54'),
(256, 2, 'sdfsdgsdfvgds', 'sdgdsgsdgsedg', 3254.00, 'arts (9).webp', 23, '2025-02-04 11:45:06'),
(257, 3, 'sdgsdcvsdvsd', 'sdgdsgsd', 3456.00, 'arts (10).webp', 45, '2025-02-04 11:45:18'),
(258, 4, 'Lorem, ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 2423.00, 'arts (11).webp', 24, '2025-02-04 11:46:28'),
(259, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3456.00, 'arts (15).webp', 56, '2025-02-04 11:46:46'),
(260, 1, 'Lorem ipsum', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nihil numquam voluptatibus commodi exercitationem voluptas quas tempora consequuntur minus? Voluptatem ex placeat dolore totam at necessitatibus voluptatum libero nam sapiente quidem.', 3467.00, 'arts (6).webp', 50, '2025-02-04 11:49:19');

-- --------------------------------------------------------

--
-- Структура таблицы `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL CHECK (`rating` between 1 and 5),
  `comment` text NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `product_id`, `rating`, `comment`, `created_at`) VALUES
(3, 1, 3, 4, 'Классный подарок, сестре понравился! Покупал ей на др. Правда стирать слишком часто его не советую...', '2025-01-28 16:25:48'),
(4, 1, 152, 4, 'Воу дороговато, но своих денег стоит!', '2025-02-04 13:57:19');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `profile_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`, `profile_image`) VALUES
(1, 'Froctis', 'a@a.a', '$2y$10$/ZvgVdVILa2d2k3/r6ItqeSa8pBBzhrsSnl1iNhlsWAPZN/knWWVy', '2025-01-24 06:32:08', 'uploads/67f4c2dd28d93.png');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Индексы таблицы `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Индексы таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=261;

--
-- AUTO_INCREMENT для таблицы `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
