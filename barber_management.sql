-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 01, 2025 at 09:08 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barber_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shop_id` bigint(20) UNSIGNED NOT NULL,
  `shop_member_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `status` enum('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(9, '2014_10_12_000000_create_users_table', 1),
(10, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(11, '2019_08_19_000000_create_failed_jobs_table', 1),
(12, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(13, '2025_08_18_060156_create_shops_table', 1),
(14, '2025_08_18_060318_create_shop_members_table', 1),
(15, '2025_08_18_062546_create_bookings_table', 1),
(16, '2025_08_22_130007_create_working_hours_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(9, 'App\\Models\\User', 2, 'auth_token', 'd056947d514aeb808ecc49a8c980d5557c4208faef52ca489719da30a07a5f9b', '[\"*\"]', '2025-08-28 03:43:28', NULL, '2025-08-28 03:37:13', '2025-08-28 03:43:28'),
(10, 'App\\Models\\User', 1, 'auth_token', '3332e5d1d957d13398534eaf218a9810bb6cdfbfc3fe4106f8ef6478adfd9099', '[\"*\"]', '2025-08-28 04:18:49', NULL, '2025-08-28 03:45:56', '2025-08-28 04:18:49');

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `owner_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `owner_id`, `name`, `profile_image`, `address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES
(1, 2, 'store 1', 'shops/KKd5EaqSEqDPbLxEhGbHbh7IQo7uC68i2CCgkP7i.jpg', 'dumar talab raipur', 70.7085500, -12.8865100, '2025-08-25 05:31:58', '2025-08-25 05:31:58'),
(2, 2, 'store 1', NULL, 'dumar talab raipur', 70.7085500, -12.8865100, '2025-08-25 05:46:23', '2025-08-25 05:46:23'),
(3, 2, 'store 1', NULL, 'dumar talab raipur', 70.7085500, -12.8865100, '2025-08-25 05:47:03', '2025-08-25 05:47:03'),
(4, 2, 'store 1', 'shops/QbHdKd2gLwoUyKqqnYLOYFhVyupYmAj3bwZ4zO7W.jpg', 'dumar talab raipur', 70.7085500, -12.8865100, '2025-08-25 05:47:48', '2025-08-25 05:47:48'),
(5, 2, 'store 1', '/storage/shops/J7YnbAqKsukkuHtYJ2gaErJd431WHCfLZC6UvEUJ.jpg', 'dumar talab raipur', 70.7085500, -12.8865100, '2025-08-25 05:49:01', '2025-08-25 05:49:01'),
(6, 2, 'store 1', 'shops/rQwzhs8Pn0T2KjHlwX4dO67GoVvdO298uoyXX6oH.jpg', 'dumar talab raipur', 70.7085500, -12.8865100, '2025-08-25 06:00:07', '2025-08-25 06:00:07'),
(7, 2, 'store 1', 'shops/xefFEbvux5xDJ1hHciOGzgen7JMvutkicoLOvizm.jpg', 'dumar talab raipur', 70.7085500, -12.8865100, '2025-08-25 06:05:44', '2025-08-25 06:05:44'),
(8, 2, 'store 10', 'shops/EIw0RtGL56RWMWDBOF5yZnPUZcCuVBHN7J6j4TFC.jpg', 'dumar talab raipur', 70.7085500, -12.8865100, '2025-08-28 03:16:11', '2025-08-28 03:16:11'),
(9, 2, 'store 10', 'shops/3P1G6ZEdmjZP9NmTaRDEy8dbhaX68yFT6qnynk8j.jpg', 'dumar talab raipur', 70.7085500, -12.8865100, '2025-08-28 03:17:31', '2025-08-28 03:17:31');

-- --------------------------------------------------------

--
-- Table structure for table `shop_members`
--

CREATE TABLE `shop_members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shop_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `specialty` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shop_members`
--

INSERT INTO `shop_members` (`id`, `shop_id`, `name`, `profile_image`, `specialty`, `created_at`, `updated_at`) VALUES
(1, 2, 'store 1', NULL, NULL, '2025-08-28 03:37:48', '2025-08-28 03:37:48'),
(2, 2, 'store 1', 'shop_members/OuaWOVISQLREhdYG9K8yNyHZFTUzQHKCNa4x4GDO.jpg', 'specialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialty', '2025-08-28 03:42:18', '2025-08-28 03:42:18'),
(3, 2, 'store 1', 'shop_members/9cWxthA8GRuW5yH2aZq4jug7Zrm0jT10f590B0b5.jpg', 'specialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialty', '2025-08-28 03:43:00', '2025-08-28 03:43:00'),
(4, 4, 'store 1', 'shop_members/bfauqnibnUgoEixIeePa5cEV97Yuy81Df5xW5MvC.jpg', 'specialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialtyspecialty', '2025-08-28 03:43:16', '2025-08-28 03:43:16');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'customer',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Vikram', 'vik@gmail.com', NULL, '$2y$12$Bj51Kz9YWc4MNvwWvOqjx.siJ4vjU6SI4Sre026M7xaY46ZYt6XK2', 'customer', NULL, '2025-08-23 01:33:23', '2025-08-23 01:33:23'),
(2, 'Vikram', 'vik1@gmail.com', NULL, '$2y$12$KmC2F4uCj56P3tLBaNomcuaD.KgbFh771ts19bQIkFHSuZFnRqe.e', 'owner', NULL, '2025-08-23 01:34:20', '2025-08-23 01:34:20');

-- --------------------------------------------------------

--
-- Table structure for table `working_hours`
--

CREATE TABLE `working_hours` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shop_id` bigint(20) UNSIGNED NOT NULL,
  `day_of_week` tinyint(4) NOT NULL,
  `open_time` time NOT NULL,
  `close_time` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_shop_id_foreign` (`shop_id`),
  ADD KEY `bookings_shop_member_id_foreign` (`shop_member_id`),
  ADD KEY `bookings_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shops_owner_id_foreign` (`owner_id`);

--
-- Indexes for table `shop_members`
--
ALTER TABLE `shop_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_members_shop_id_foreign` (`shop_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `working_hours`
--
ALTER TABLE `working_hours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `working_hours_shop_id_foreign` (`shop_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `shop_members`
--
ALTER TABLE `shop_members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `working_hours`
--
ALTER TABLE `working_hours`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_shop_id_foreign` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_shop_member_id_foreign` FOREIGN KEY (`shop_member_id`) REFERENCES `shop_members` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `shops`
--
ALTER TABLE `shops`
  ADD CONSTRAINT `shops_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `shop_members`
--
ALTER TABLE `shop_members`
  ADD CONSTRAINT `shop_members_shop_id_foreign` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `working_hours`
--
ALTER TABLE `working_hours`
  ADD CONSTRAINT `working_hours_shop_id_foreign` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
