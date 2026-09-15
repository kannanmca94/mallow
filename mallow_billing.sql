-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 15, 2026 at 12:25 PM
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
-- Database: `mallow_billing`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('mallow-billing-cache-plan:1', 'O:15:\"App\\Models\\Plan\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:5:\"plans\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:1;s:11:\"merchant_id\";i:1;s:4:\"name\";s:7:\"Starter\";s:10:\"base_price\";s:6:\"100.00\";s:13:\"billing_cycle\";s:7:\"monthly\";s:14:\"included_units\";i:1000;s:12:\"overage_rate\";s:6:\"0.1000\";s:10:\"created_at\";s:19:\"2026-09-15 10:11:21\";s:10:\"updated_at\";s:19:\"2026-09-15 10:11:21\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:1;s:11:\"merchant_id\";i:1;s:4:\"name\";s:7:\"Starter\";s:10:\"base_price\";s:6:\"100.00\";s:13:\"billing_cycle\";s:7:\"monthly\";s:14:\"included_units\";i:1000;s:12:\"overage_rate\";s:6:\"0.1000\";s:10:\"created_at\";s:19:\"2026-09-15 10:11:21\";s:10:\"updated_at\";s:19:\"2026-09-15 10:11:21\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:3:{s:10:\"base_price\";s:9:\"decimal:2\";s:12:\"overage_rate\";s:9:\"decimal:4\";s:14:\"included_units\";s:7:\"integer\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:6:{i:0;s:11:\"merchant_id\";i:1;s:4:\"name\";i:2;s:10:\"base_price\";i:3;s:13:\"billing_cycle\";i:4;s:14:\"included_units\";i:5;s:12:\"overage_rate\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}', 1789470694),
('mallow-billing-cache-plan:2', 'O:15:\"App\\Models\\Plan\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:5:\"plans\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:2;s:11:\"merchant_id\";i:1;s:4:\"name\";s:3:\"Pro\";s:10:\"base_price\";s:6:\"250.00\";s:13:\"billing_cycle\";s:7:\"monthly\";s:14:\"included_units\";i:5000;s:12:\"overage_rate\";s:6:\"0.0700\";s:10:\"created_at\";s:19:\"2026-09-15 10:11:21\";s:10:\"updated_at\";s:19:\"2026-09-15 10:11:21\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:2;s:11:\"merchant_id\";i:1;s:4:\"name\";s:3:\"Pro\";s:10:\"base_price\";s:6:\"250.00\";s:13:\"billing_cycle\";s:7:\"monthly\";s:14:\"included_units\";i:5000;s:12:\"overage_rate\";s:6:\"0.0700\";s:10:\"created_at\";s:19:\"2026-09-15 10:11:21\";s:10:\"updated_at\";s:19:\"2026-09-15 10:11:21\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:3:{s:10:\"base_price\";s:9:\"decimal:2\";s:12:\"overage_rate\";s:9:\"decimal:4\";s:14:\"included_units\";s:7:\"integer\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:6:{i:0;s:11:\"merchant_id\";i:1;s:4:\"name\";i:2;s:10:\"base_price\";i:3;s:13:\"billing_cycle\";i:4;s:14:\"included_units\";i:5;s:12:\"overage_rate\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}', 1789470694);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `merchant_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `merchant_id`, `name`, `email`, `created_at`, `updated_at`) VALUES
(1, 1, 'Customer 1', 'customer1@example.com', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(2, 1, 'Customer 2', 'customer2@example.com', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(3, 1, 'Customer 3', 'customer3@example.com', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(4, 1, 'Customer 4', 'customer4@example.com', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(5, 1, 'Customer 5', 'customer5@example.com', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(6, 1, 'Customer 6', 'customer6@example.com', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(7, 1, 'Customer 7', 'customer7@example.com', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(8, 1, 'Customer 8', 'customer8@example.com', '2026-09-15 04:41:22', '2026-09-15 04:41:22');

-- --------------------------------------------------------

--
-- Table structure for table `daily_usage`
--

CREATE TABLE `daily_usage` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `usage_date` date NOT NULL,
  `units` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `daily_usage`
--

INSERT INTO `daily_usage` (`id`, `customer_id`, `usage_date`, `units`, `created_at`, `updated_at`) VALUES
(1, 1, '2026-09-01', 820, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(2, 1, '2026-09-02', 910, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(3, 1, '2026-09-03', 750, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(4, 1, '2026-09-04', 680, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(5, 1, '2026-09-05', 430, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(6, 1, '2026-09-06', 310, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(7, 1, '2026-09-07', 870, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(8, 1, '2026-09-08', 940, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(9, 1, '2026-09-09', 220, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(10, 1, '2026-09-10', 760, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(11, 1, '2026-09-11', 890, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(12, 1, '2026-09-12', 650, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(13, 2, '2026-09-01', 300, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(14, 2, '2026-09-02', 410, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(15, 2, '2026-09-03', 280, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(16, 2, '2026-09-04', 350, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(17, 2, '2026-09-05', 190, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(18, 2, '2026-09-06', 420, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(19, 2, '2026-09-07', 310, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(20, 2, '2026-09-08', 380, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(21, 2, '2026-09-09', 270, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(22, 2, '2026-09-10', 340, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(23, 2, '2026-09-11', 300, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(24, 2, '2026-09-12', 260, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(25, 3, '2026-09-01', 600, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(26, 3, '2026-09-02', 550, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(27, 3, '2026-09-03', 720, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(28, 3, '2026-09-04', 680, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(29, 3, '2026-09-05', 490, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(30, 3, '2026-09-06', 380, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(31, 3, '2026-09-07', 510, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(32, 3, '2026-09-08', 430, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(33, 3, '2026-09-09', 620, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(34, 3, '2026-09-10', 700, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(35, 3, '2026-09-11', 580, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(36, 3, '2026-09-12', 470, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(37, 4, '2026-09-01', 950, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(38, 4, '2026-09-02', 880, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(39, 4, '2026-09-03', 770, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(40, 4, '2026-09-04', 920, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(41, 4, '2026-09-05', 610, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(42, 4, '2026-09-06', 530, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(43, 4, '2026-09-07', 840, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(44, 4, '2026-09-08', 910, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(45, 4, '2026-09-09', 730, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(46, 4, '2026-09-10', 870, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(47, 4, '2026-09-11', 960, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(48, 4, '2026-09-12', 800, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(49, 5, '2026-09-01', 120, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(50, 5, '2026-09-02', 90, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(51, 5, '2026-09-03', 150, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(52, 5, '2026-09-04', 80, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(53, 5, '2026-09-05', 200, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(54, 5, '2026-09-06', 110, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(55, 5, '2026-09-07', 160, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(56, 5, '2026-09-08', 70, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(57, 5, '2026-09-09', 130, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(58, 5, '2026-09-10', 180, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(59, 5, '2026-09-11', 100, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(60, 5, '2026-09-12', 140, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(61, 6, '2026-09-01', 1800, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(62, 6, '2026-09-02', 2100, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(63, 6, '2026-09-03', 1950, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(64, 6, '2026-09-04', 2300, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(65, 6, '2026-09-05', 1700, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(66, 6, '2026-09-06', 2050, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(67, 6, '2026-09-07', 2400, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(68, 6, '2026-09-08', 2200, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(69, 6, '2026-09-09', 1850, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(70, 6, '2026-09-10', 2150, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(71, 6, '2026-09-11', 2350, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(72, 6, '2026-09-12', 2000, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(73, 7, '2026-09-01', 400, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(74, 7, '2026-09-02', 350, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(75, 7, '2026-09-03', 480, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(76, 7, '2026-09-04', 520, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(77, 7, '2026-09-05', 310, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(78, 7, '2026-09-06', 290, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(79, 7, '2026-09-07', 410, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(80, 7, '2026-09-08', 380, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(81, 7, '2026-09-09', 350, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(82, 7, '2026-09-10', 460, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(83, 7, '2026-09-11', 390, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(84, 7, '2026-09-12', 340, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(85, 8, '2026-09-01', 2500, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(86, 8, '2026-09-02', 2800, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(87, 8, '2026-09-03', 2200, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(88, 8, '2026-09-04', 3100, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(89, 8, '2026-09-05', 1900, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(90, 8, '2026-09-06', 2600, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(91, 8, '2026-09-07', 2750, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(92, 8, '2026-09-08', 3000, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(93, 8, '2026-09-09', 2400, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(94, 8, '2026-09-10', 2900, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(95, 8, '2026-09-11', 3200, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(96, 8, '2026-09-12', 2550, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(97, 5, '2026-08-01', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(98, 5, '2026-08-02', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(99, 5, '2026-08-03', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(100, 5, '2026-08-04', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(101, 5, '2026-08-05', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(102, 5, '2026-08-06', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(103, 5, '2026-08-07', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(104, 5, '2026-08-08', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(105, 5, '2026-08-09', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(106, 5, '2026-08-10', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(107, 5, '2026-08-11', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(108, 5, '2026-08-12', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(109, 5, '2026-08-13', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(110, 5, '2026-08-14', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(111, 5, '2026-08-15', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(112, 5, '2026-08-16', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(113, 5, '2026-08-17', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(114, 5, '2026-08-18', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(115, 5, '2026-08-19', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(116, 5, '2026-08-20', 160, '2026-09-15 04:41:22', '2026-09-15 04:41:22');

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
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subscription_id` bigint(20) UNSIGNED NOT NULL,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `base_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `included_units` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `used_units` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `overage_units` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `overage_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` varchar(20) NOT NULL DEFAULT 'final',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `merchants`
--

CREATE TABLE `merchants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `merchants`
--

INSERT INTO `merchants` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Demo Merchant', '2026-09-15 04:41:21', '2026-09-15 04:41:21');

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
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '001_create_merchants_table', 1),
(5, '002_create_plans_table', 1),
(6, '003_create_customers_table', 1),
(7, '004_create_subscriptions_table', 1),
(8, '005_create_subscription_segments_table', 1),
(9, '006_create_usage_events_table', 1),
(10, '007_create_daily_usage_table', 1),
(11, '008_create_invoices_table', 1);

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
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `merchant_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `base_price` decimal(12,2) NOT NULL,
  `billing_cycle` varchar(20) NOT NULL DEFAULT 'monthly',
  `included_units` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `overage_rate` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `merchant_id`, `name`, `base_price`, `billing_cycle`, `included_units`, `overage_rate`, `created_at`, `updated_at`) VALUES
(1, 1, 'Starter', 100.00, 'monthly', 1000, 0.1000, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(2, 1, 'Pro', 250.00, 'monthly', 5000, 0.0700, '2026-09-15 04:41:21', '2026-09-15 04:41:21');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('pWKbY3GLKsxN3gqGkuDhlArib8zfp50kq2A1mpj5', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiekU3Y0JkbWpsd0xjWjRFWlBhZGxSYzZ4U0NFZFg5bWZOaUhWMFFBbyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1789467403);

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `customer_id`, `plan_id`, `starts_at`, `ends_at`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-09-01 00:00:00', NULL, 'active', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(2, 2, 1, '2026-09-01 00:00:00', NULL, 'active', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(3, 3, 1, '2026-09-01 00:00:00', NULL, 'active', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(4, 4, 1, '2026-09-01 00:00:00', NULL, 'active', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(5, 5, 1, '2026-09-01 00:00:00', NULL, 'active', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(6, 6, 2, '2026-09-01 00:00:00', NULL, 'active', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(7, 7, 2, '2026-09-01 00:00:00', NULL, 'active', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(8, 8, 2, '2026-09-01 00:00:00', NULL, 'active', '2026-09-15 04:41:22', '2026-09-15 04:41:22');

-- --------------------------------------------------------

--
-- Table structure for table `subscription_segments`
--

CREATE TABLE `subscription_segments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subscription_id` bigint(20) UNSIGNED NOT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `effective_from` datetime NOT NULL,
  `effective_to` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscription_segments`
--

INSERT INTO `subscription_segments` (`id`, `subscription_id`, `plan_id`, `effective_from`, `effective_to`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-09-01 00:00:00', NULL, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(2, 2, 1, '2026-09-01 00:00:00', NULL, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(3, 3, 1, '2026-09-01 00:00:00', NULL, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(4, 4, 1, '2026-09-01 00:00:00', NULL, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(5, 5, 1, '2026-09-01 00:00:00', NULL, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(6, 6, 2, '2026-09-01 00:00:00', NULL, '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(7, 7, 2, '2026-09-01 00:00:00', NULL, '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(8, 8, 2, '2026-09-01 00:00:00', NULL, '2026-09-15 04:41:22', '2026-09-15 04:41:22');

-- --------------------------------------------------------

--
-- Table structure for table `usage_events`
--

CREATE TABLE `usage_events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `usage_date` date NOT NULL,
  `units` bigint(20) UNSIGNED NOT NULL,
  `idempotency_key` varchar(120) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `usage_events`
--

INSERT INTO `usage_events` (`id`, `customer_id`, `usage_date`, `units`, `idempotency_key`, `created_at`, `updated_at`) VALUES
(1, 1, '2026-09-01', 820, 'bfeab4cd-4671-4f97-ad36-791055f90db7', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(2, 1, '2026-09-02', 910, '42f9a1dd-640e-4766-a1a9-3764b89936c0', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(3, 1, '2026-09-03', 750, 'f6da4b30-69be-4a94-98b0-0d16ebfea8ad', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(4, 1, '2026-09-04', 680, '1a282c18-d779-4581-ade9-9af80cd12c19', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(5, 1, '2026-09-05', 430, 'd664f8e7-1dae-418a-a097-7baab5b9e776', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(6, 1, '2026-09-06', 310, 'a58bd142-2e20-4737-8be4-46c8c355eb4f', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(7, 1, '2026-09-07', 870, '0fdeb091-f855-4b5f-b6a0-c838b62036dd', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(8, 1, '2026-09-08', 940, '876761b9-c147-4035-bf3a-5f7e562d073f', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(9, 1, '2026-09-09', 220, 'd97256c6-17cf-482b-8538-e7c44968fbf5', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(10, 1, '2026-09-10', 760, '6d9c6740-6efa-49d6-8923-ebd3d8036f1c', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(11, 1, '2026-09-11', 890, '44d893e7-12d7-43aa-b02d-1b790f2e8753', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(12, 1, '2026-09-12', 650, 'a7600d7d-bfaa-4108-8eed-9715b5a9b618', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(13, 2, '2026-09-01', 300, '86f308ce-369e-4863-9c37-6e9b66a21685', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(14, 2, '2026-09-02', 410, '1c54b989-3767-4df5-88d5-3d274e6fcbad', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(15, 2, '2026-09-03', 280, 'de4a55a8-9171-430a-97a8-eb7ff70b270f', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(16, 2, '2026-09-04', 350, '8612270b-44e9-49d5-a2ac-7b791bfdebe2', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(17, 2, '2026-09-05', 190, '5bb131a7-93a8-4c58-9f72-b16c0c83d122', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(18, 2, '2026-09-06', 420, '3bac99cb-dbf4-48e9-b8b4-e5fc9918c9c2', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(19, 2, '2026-09-07', 310, 'a9a6d896-0532-48cc-8e22-9101d19c5b74', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(20, 2, '2026-09-08', 380, '258c7c15-5615-4505-83d8-b563f6f06030', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(21, 2, '2026-09-09', 270, '4763ced7-eaa0-4636-87ac-eb80fc605f30', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(22, 2, '2026-09-10', 340, 'd7436124-dd4c-4dc6-afd2-4b2cf26ff109', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(23, 2, '2026-09-11', 300, 'b15c55d0-da8f-4bb6-b8c6-78633bb15936', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(24, 2, '2026-09-12', 260, '4214a04e-3f9f-40ba-9970-3194370c2dc6', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(25, 3, '2026-09-01', 600, '6efd8054-7dec-4302-b802-53101d300866', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(26, 3, '2026-09-02', 550, '65f6a4a1-96bd-4e64-bb98-0c0c2985810e', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(27, 3, '2026-09-03', 720, '0a34b972-4ce5-4b99-b7c8-0e5f81dbdbcd', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(28, 3, '2026-09-04', 680, 'efd7a816-5af4-4ee8-b796-6e7925427c05', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(29, 3, '2026-09-05', 490, 'dc2f4f96-b2ff-436b-ae23-e9e0b4d487c5', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(30, 3, '2026-09-06', 380, 'f7354ce8-4147-44bb-9c78-eaef5e28d3ae', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(31, 3, '2026-09-07', 510, 'fdaa9687-eeed-44ed-bf42-5f22351c5d58', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(32, 3, '2026-09-08', 430, '83d66396-351b-4bb5-a30d-2cb4737dfb44', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(33, 3, '2026-09-09', 620, '3c7e4ac6-a521-4ac4-b2e8-f28458be455f', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(34, 3, '2026-09-10', 700, '4693c474-0a5b-421a-8a1f-6205d60d1390', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(35, 3, '2026-09-11', 580, 'f393497a-f079-496d-ae99-ef8def724c1f', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(36, 3, '2026-09-12', 470, 'f5cf12cc-9c4e-4691-ba41-6270f1438b34', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(37, 4, '2026-09-01', 950, '963323ef-170b-44c1-a0cd-77706f9af112', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(38, 4, '2026-09-02', 880, '2e34c453-e9ca-4e09-9fd3-9a466c2c2a40', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(39, 4, '2026-09-03', 770, '639b6de6-2001-4c0a-b9fb-4d4c2fe15a3c', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(40, 4, '2026-09-04', 920, 'e5621efb-4279-4436-813a-d78143a86155', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(41, 4, '2026-09-05', 610, '68495698-ee6c-4c42-ae3b-d9170b0192ad', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(42, 4, '2026-09-06', 530, '6994bd75-e92e-482f-a093-ed35aa07a78d', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(43, 4, '2026-09-07', 840, 'c2ac9be3-7484-4f29-9a23-903048dcc038', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(44, 4, '2026-09-08', 910, 'a45cf4fb-774a-4ef9-ad7f-88684f15acd1', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(45, 4, '2026-09-09', 730, '755978fe-58c6-4471-9584-adb3a0f40643', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(46, 4, '2026-09-10', 870, '945d6d05-bf01-4619-82de-af8263260010', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(47, 4, '2026-09-11', 960, 'ecc713e5-149b-485e-8d49-ba7797ad0ef2', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(48, 4, '2026-09-12', 800, 'ba65e682-7dfa-4bb2-8ad3-a1ad27aaa739', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(49, 5, '2026-09-01', 120, 'c841d6b0-c71c-4732-a33f-58a3f978e860', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(50, 5, '2026-09-02', 90, '0c690b75-6646-49ae-bd39-fe66a17ec20c', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(51, 5, '2026-09-03', 150, '72fa8410-f530-407f-a354-f43d6cb33387', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(52, 5, '2026-09-04', 80, 'c59c5b4b-6ced-4c7b-9f29-aa0366927ce7', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(53, 5, '2026-09-05', 200, '613a8664-8fbb-4a85-87db-f9bc8c8059eb', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(54, 5, '2026-09-06', 110, '653da045-ee10-4367-9906-ef8f5bb2dd3e', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(55, 5, '2026-09-07', 160, '39676803-8d06-4cbc-9217-d069423a9376', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(56, 5, '2026-09-08', 70, '5fbddc57-ea17-4935-a4f9-c421a696c68c', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(57, 5, '2026-09-09', 130, 'f47b6d4d-b6f3-424c-93a0-cc9c07b37cea', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(58, 5, '2026-09-10', 180, '06b30c09-8c12-4c27-8240-f4fe022a9a1f', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(59, 5, '2026-09-11', 100, '9a3d6711-ed16-465c-89c6-63b8c9536b70', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(60, 5, '2026-09-12', 140, '0606e33a-a410-4ef4-8afc-9cf27fdd050e', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(61, 6, '2026-09-01', 1800, '002cb7ff-0643-45f8-9c27-580c8a0e1549', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(62, 6, '2026-09-02', 2100, '8ad06768-5080-457f-8f5b-139c782b0fb9', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(63, 6, '2026-09-03', 1950, '9c63a131-794f-403d-b7ca-ae7eee0039b4', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(64, 6, '2026-09-04', 2300, 'e3ef6544-841c-4346-85d2-556be0a852f0', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(65, 6, '2026-09-05', 1700, '3d4779fb-2e7a-496f-be05-51b4a8f949fd', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(66, 6, '2026-09-06', 2050, '932dfd79-5054-495a-b3b2-9847c7de2362', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(67, 6, '2026-09-07', 2400, 'defa9223-aae1-491b-9bf9-078b4f58719f', '2026-09-15 04:41:21', '2026-09-15 04:41:21'),
(68, 6, '2026-09-08', 2200, '4999dff6-de60-4b12-9847-f28cb40042c2', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(69, 6, '2026-09-09', 1850, 'f3a51b67-9d6d-4cd1-b2c4-c1a4a9ba8829', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(70, 6, '2026-09-10', 2150, 'eb1d2939-8898-4403-8a4c-b2f614a6885a', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(71, 6, '2026-09-11', 2350, '669cde3c-eea9-43de-9f74-ee957cc8b303', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(72, 6, '2026-09-12', 2000, '5ef89c70-c315-4bdf-8e02-a91237d083e4', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(73, 7, '2026-09-01', 400, 'ec456246-480f-4c7f-b390-4cbe88e7aeee', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(74, 7, '2026-09-02', 350, '7c449c02-728a-4939-a46e-3d0d8dabe046', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(75, 7, '2026-09-03', 480, '36b861b0-45c8-4074-80fa-af6a10bddb1d', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(76, 7, '2026-09-04', 520, '4933c1ba-3e93-400a-8b51-a16a1d8f05c3', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(77, 7, '2026-09-05', 310, '33539735-98c9-4dc2-afd7-f7013bf9d5be', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(78, 7, '2026-09-06', 290, 'f1550bac-18ba-4fd5-802b-c96ec3ab170f', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(79, 7, '2026-09-07', 410, 'e1287a08-5abe-4e0f-9aa7-5c607643ec90', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(80, 7, '2026-09-08', 380, '229c5958-7973-4140-b2b3-3a1aa0f4ad35', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(81, 7, '2026-09-09', 350, 'fcd2eb8e-7526-400a-9530-25e848c04d8b', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(82, 7, '2026-09-10', 460, 'e503140d-82f8-4aa1-89cb-2cc07c70ff6b', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(83, 7, '2026-09-11', 390, '4835a7b5-8722-4d1c-b698-855ecf4e60f3', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(84, 7, '2026-09-12', 340, '2fd36d72-2beb-4e2f-a353-11597ff69cf5', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(85, 8, '2026-09-01', 2500, 'ad846963-9f4a-4fb4-a435-5de321786380', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(86, 8, '2026-09-02', 2800, '2669a1b2-be9e-4674-a4d3-852c5ff22aa0', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(87, 8, '2026-09-03', 2200, '4c4218ce-1cb9-461a-8af7-7d43f02ba053', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(88, 8, '2026-09-04', 3100, '7ff95684-564b-4bca-bbf9-35d772cbd839', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(89, 8, '2026-09-05', 1900, '263a24b2-5af8-4737-91ff-0d8ac738ef0d', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(90, 8, '2026-09-06', 2600, '05bf42ee-043d-4837-a122-84a3dccadfb5', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(91, 8, '2026-09-07', 2750, 'be12e4d4-7e04-4d0f-9f84-efc39b21b105', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(92, 8, '2026-09-08', 3000, '2d2e0bd6-1d1f-46ae-8ece-e1a034dd6cbc', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(93, 8, '2026-09-09', 2400, 'c4d57013-725c-4f18-bab7-c4a91bfebc8a', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(94, 8, '2026-09-10', 2900, '95c90c5e-ea73-454e-8dbc-ed79def10457', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(95, 8, '2026-09-11', 3200, '4c11f57a-f781-4ccf-800f-15cc14961deb', '2026-09-15 04:41:22', '2026-09-15 04:41:22'),
(96, 8, '2026-09-12', 2550, 'd952ca79-ecb6-4c88-af01-504fd1353f2a', '2026-09-15 04:41:22', '2026-09-15 04:41:22');

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
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customers_merchant_id_id_index` (`merchant_id`,`id`),
  ADD KEY `customers_email_index` (`email`);

--
-- Indexes for table `daily_usage`
--
ALTER TABLE `daily_usage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `daily_usage_customer_id_usage_date_unique` (`customer_id`,`usage_date`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoices_subscription_id_period_start_period_end_unique` (`subscription_id`,`period_start`,`period_end`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `merchants`
--
ALTER TABLE `merchants`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plans_merchant_id_billing_cycle_index` (`merchant_id`,`billing_cycle`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscriptions_customer_id_status_index` (`customer_id`,`status`),
  ADD KEY `subscriptions_plan_id_starts_at_index` (`plan_id`,`starts_at`);

--
-- Indexes for table `subscription_segments`
--
ALTER TABLE `subscription_segments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscription_segments_subscription_id_effective_from_index` (`subscription_id`,`effective_from`),
  ADD KEY `subscription_segments_plan_id_effective_from_index` (`plan_id`,`effective_from`);

--
-- Indexes for table `usage_events`
--
ALTER TABLE `usage_events`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usage_events_idempotency_key_unique` (`idempotency_key`),
  ADD KEY `usage_events_customer_id_usage_date_index` (`customer_id`,`usage_date`),
  ADD KEY `usage_events_usage_date_customer_id_index` (`usage_date`,`customer_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `daily_usage`
--
ALTER TABLE `daily_usage`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `merchants`
--
ALTER TABLE `merchants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `subscription_segments`
--
ALTER TABLE `subscription_segments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `usage_events`
--
ALTER TABLE `usage_events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_merchant_id_foreign` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `daily_usage`
--
ALTER TABLE `daily_usage`
  ADD CONSTRAINT `daily_usage_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `plans`
--
ALTER TABLE `plans`
  ADD CONSTRAINT `plans_merchant_id_foreign` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscriptions_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`);

--
-- Constraints for table `subscription_segments`
--
ALTER TABLE `subscription_segments`
  ADD CONSTRAINT `subscription_segments_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`),
  ADD CONSTRAINT `subscription_segments_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `usage_events`
--
ALTER TABLE `usage_events`
  ADD CONSTRAINT `usage_events_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
