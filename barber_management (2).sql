-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 08, 2025 at 03:25 PM
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
-- Table structure for table `email_verifications`
--

CREATE TABLE `email_verifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `otp` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(7, '2025_08_18_062546_create_bookings_table', 1),
(8, '2025_08_22_130007_create_working_hours_table', 1),
(9, '2025_08_23_071926_create_shop_images_table', 1),
(10, '2025_09_02_073337_create_email_verifications_table', 2),
(11, '2025_09_02_111315_create_pending_verifications_table', 3),
(12, '2025_09_03_131547_create_password_resets_table', 4),
(14, '2025_08_18_060318_create_shop_members_table', 6),
(15, '2025_08_18_060156_create_shops_table', 7),
(17, '2025_09_09_073019_create_services_table', 9),
(18, '2025_10_07_074814_create_service_categories_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `pending_verifications`
--

CREATE TABLE `pending_verifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `otp` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pending_verifications`
--

INSERT INTO `pending_verifications` (`id`, `name`, `email`, `password`, `otp`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'vishal', 'vsiahal@gmail.con', '$2y$12$IlA/Nat/Fy5QvyQtp2LvTeijacPUO8w5KoaoUw5H.EGRRxk8eb6Ze', '271166', '2025-09-02 07:31:05', '2025-09-02 07:21:05', '2025-09-02 07:21:05'),
(3, 'namdeo', 'dhebej@gmwil.com', '$2y$12$CVJrg0IKX91bfvh.r.24Iu6c6.6shZLzW6R3e.nzHDX/DnVAHW7.S', '959353', '2025-09-02 07:42:18', '2025-09-02 07:32:18', '2025-09-02 07:32:18'),
(4, 'vishal', 'vsiddl@gmail.com', '$2y$12$Wv34WA.CNAXdikgrlFVlC.3Ndvu4I535KmBASZipgnKb37DrwlHf2', '669105', '2025-09-02 08:00:03', '2025-09-02 07:36:35', '2025-09-02 07:50:03'),
(5, 'vsidksl', 'vddkrk@gmail.com', '$2y$12$L2kmNsxPT4KHsQUUyYI5Deso46GpU/aGbjRPeeu4nkzyWMha/.BZu', '580210', '2025-09-02 07:56:05', '2025-09-02 07:41:54', '2025-09-02 07:46:05'),
(7, 'vsidga', 'aaditya1.appdev@gmail.com', '$2y$12$Dj3c4GO1dJpaxKzQ63bPd.PXuTf6Y2fBbAQXnq10Nxt5/aj4Rb7HO', '495347', '2025-09-03 07:40:49', '2025-09-03 06:09:24', '2025-09-03 07:30:49'),
(8, 'hk4vssah', 'hk4vssahu@gmail.com', '$2y$12$4dh7yRsNIr6k5UZctB0NGO5L5KKqHc83Z8/7dSZsmKQE62vPjVuta', '553930', '2025-09-03 06:25:32', '2025-09-03 06:14:21', '2025-09-03 06:15:32'),
(9, 'viakamr', 'visha@gmail.com', '$2y$12$iUTeZ95Iq39ALplZ4V4bE.XQiyLU566xJ/xfteFOijxJ4MriZUiYC', '893545', '2025-09-03 06:46:20', '2025-09-03 06:34:08', '2025-09-03 06:36:20');

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
(22, 'App\\Models\\User', 4, 'auth_token', '3caf2ff98e339a9c0c146b82f63dc51021471a9a56ba2811dd1610c6bf1a5a13', '[\"*\"]', NULL, NULL, '2025-09-23 01:13:53', '2025-09-23 01:13:53'),
(30, 'App\\Models\\User', 1, 'auth_token', '815f0daa0b8c20d053dbcc4961b7e6918400dc88be9a379aaf4b6fb13c4a08b8', '[\"*\"]', '2025-10-06 07:39:33', NULL, '2025-10-06 01:15:52', '2025-10-06 07:39:33'),
(36, 'App\\Models\\User', 3, 'auth_token', '785bc2915a9f19762db6ea7d22ede892b8b2b6badad297ebce4768dadaf37906', '[\"*\"]', '2025-10-07 15:46:45', NULL, '2025-10-07 15:44:00', '2025-10-07 15:46:45');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(8,2) NOT NULL,
  `duration` int(11) NOT NULL,
  `product_cost` decimal(8,2) DEFAULT NULL,
  `special_price` decimal(8,2) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `category_id`, `name`, `description`, `price`, `duration`, `product_cost`, `special_price`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 'Classic Haircut', 'A precise, clean-cut style tailored to your preference, from traditional short back and sides to a modern taper. Includes a complimentary neck shave and a finish with premium styling products, ensuring a sharp and timeless look that\'s easy to maintain.', 25.00, 30, 2.50, 22.50, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(2, 1, 'Fade & Design', 'Expertly crafted skin or zero fade that seamlessly blends into your hair\'s length. This service includes detailed hairline shaping and an optional, simple custom hair design, perfect for a high-contrast and contemporary urban style.', 35.00, 45, 3.00, 31.50, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(3, 1, 'Executive Scissor Cut', 'Ideal for longer or thicker hair, this all-scissor cut provides maximum texture, volume, and natural flow. It focuses on sophisticated layering and shaping, finishing with a blow-dry style for a professional, distinguished, and polished appearance.', 40.00, 50, 3.50, NULL, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(4, 2, 'Basic Beard Line-Up', 'A quick, clean line-up to define the neck and cheek lines using trimmers. This service maintains your existing beard shape, giving it a neat, well-groomed border without altering the length significantly for a tidy daily look.', 15.00, 15, 1.00, 13.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(5, 2, 'Sculpted Beard Trim', 'A detailed service to reshape and reduce the volume of your beard and mustache. Our barbers use clippers and scissors to create perfect symmetry and a well-defined silhouette, finished with nourishing beard oil and a balm for superior conditioning.', 25.00, 30, 2.50, 22.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(6, 2, 'Full Beard & Goatee Shaping', 'A comprehensive service dedicated to intricate shaping for complex styles like full beards or specialized goatees. Includes full shaping, length reduction, hot towel conditioning, and precision cheek and neck line razor finish for maximum definition.', 30.00, 40, 3.50, NULL, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(7, 3, 'Traditional Hot Lather Shave', 'Experience the classic straight razor shave. It begins with a steaming hot towel to soften the hair, followed by a close, single-pass shave, and ends with a cool towel and aftershave balm to soothe and protect your skin.', 35.00, 35, 3.50, 32.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(8, 3, 'Head Shave', 'A full-head straight razor shave for a perfectly smooth, clean finish. This service uses multiple hot towels and specialized shaving creams to minimize irritation, concluding with a moisturizing head balm to keep the scalp hydrated.', 45.00, 45, 4.50, NULL, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(9, 3, 'Express Shave', 'A quick yet smooth straight razor shave for those on a tight schedule. This service focuses on efficiency while still providing a close shave, complete with a quick application of aftershave gel for a refreshing finish.', 25.00, 20, 2.00, 22.50, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(10, 4, 'Permanent Grey Coverage', 'Fully conceal grey hair with a permanent color match to your natural shade. Our professional formula is blended to provide natural-looking results that last until your next cut, giving you a consistently youthful and uniform color.', 60.00, 75, 12.00, 55.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(11, 4, 'Subtle Highlights (Sunkissed)', 'Add dimension with natural-looking, hand-painted highlights that mimic a sun-kissed effect. This technique subtly brightens your hair, enhancing your texture and movement without a dramatic change, perfect for a modern, refined look.', 85.00, 90, 18.00, NULL, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(12, 4, 'Fashion Color Application', 'A bold, full-head color application for a complete change. Choose from a wide range of vibrant or deep fashion shades. Consultation is included to ensure the desired intensity and longevity of your new, statement color.', 100.00, 120, 25.00, 90.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(13, 5, 'Express Facial Cleanup', 'A fast, efficient treatment to quickly refresh your skin. Includes a deep cleanse, light exfoliation to remove dead skin cells, and a moisturizing finish. Perfect for removing surface dirt and oil when time is limited.', 30.00, 25, 4.00, 27.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(14, 5, 'Signature Pore Detox Cleanup', 'A specialized treatment focusing on unclogging congested pores. Includes a steam session, deep-cleansing mask, gentle blackhead removal, and a refreshing toner to minimize pores and prevent future breakouts.', 50.00, 45, 8.00, 45.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(15, 5, 'Anti-Acne & Oil Control Cleanup', 'Targeted facial cleanup using products specifically formulated to control excess oil and soothe acne-prone skin. It calms inflammation, promotes healing, and rebalances the skin\'s natural moisture barrier for a clearer complexion.', 55.00, 50, 9.50, NULL, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(16, 6, 'Stress-Relief Head Massage', 'A gentle 20-minute massage focused on the scalp, neck, and shoulders. This treatment uses fingertip pressure to relieve tension and stress headaches, promoting deep relaxation and a sense of calm and well-being.', 20.00, 20, 1.50, 18.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(17, 6, 'Oil Infusion Head Massage', 'A therapeutic massage using warm, essential-oil-infused oils chosen for your specific scalp needs. It stimulates blood flow to the hair follicles, deeply nourishes the scalp, and improves hair health and strength while relaxing the muscles.', 35.00, 30, 4.50, 32.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(18, 6, 'Deluxe Head, Neck & Shoulder Massage', 'An extended session combining the benefits of a stimulating head massage with targeted work on the neck and shoulder areas. This comprehensive treatment is designed for maximum tension release and total physical relaxation.', 45.00, 45, 2.00, NULL, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(19, 7, 'Hydrating Hair Spa', 'Deeply moisturize dry, brittle hair with a specialized hydrating mask. The treatment is applied under a steamer for maximum penetration, restoring essential moisture and leaving your hair significantly softer, smoother, and manageable.', 50.00, 60, 10.00, 45.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(20, 7, 'Anti-Dandruff Hair Spa', 'A targeted treatment to address flaky, itchy scalp conditions. It uses an anti-fungal mask and specialized massage techniques to cleanse the scalp, control dandruff, and soothe irritation for a healthier hair foundation.', 55.00, 60, 11.50, NULL, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(21, 7, 'Keratin Strength Hair Spa', 'Reinforce weak or damaged hair with a protein-rich keratin mask. This spa treatment works to repair the hair shaft from within, improving elasticity, reducing breakage, and restoring natural body and shine to dull hair.', 70.00, 75, 15.00, 65.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(22, 8, 'Express D-Tan Face Pack', 'A quick, effective treatment to remove superficial tan and dullness caused by sun exposure. A professional D-tan pack is applied for a short duration, instantly restoring a fresher and more uniform skin tone.', 25.00, 20, 5.00, 22.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(23, 8, 'Full Face & Neck D-Tan', 'An intensive service covering the face and the often-neglected neck area. The multi-step process cleanses, applies a deep-acting D-Tan mask, and finishes with a brightening serum, significantly reducing tanning and hyperpigmentation for a visible glow.', 45.00, 40, 9.00, 40.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(24, 8, 'D-Tan & Brightening Cleanup Combo', 'This combined service includes a full D-Tan treatment immediately followed by a mild facial cleanup. It\'s the ultimate solution for tan removal and deep pore cleansing, leaving the skin radiant, smooth, and completely rejuvenated.', 60.00, 60, 13.00, 55.00, 1, '2025-10-07 14:15:13', '2025-10-07 14:15:13'),
(25, 1, 'Buzz Cut & Edge Up', 'A low-maintenance, uniform cut using clippers on a single guard setting. It includes a precise line-up around the temples and neck to keep the edges sharp and clean, offering a simple, crisp, and no-fuss look.', 20.00, 20, 1.50, 18.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(26, 1, 'Father & Son Haircut Combo', 'A convenient package for both an adult and child haircut (up to 12 years old). Enjoy professional styling for both, ensuring two sharp, coordinated looks. This is a great, time-saving family deal.', 55.00, 60, 4.00, 50.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(27, 1, 'Restyle Consultation & Cut', 'For those seeking a dramatic change, this includes an in-depth consultation with a senior barber. We\'ll assess your face shape and hair texture before executing a completely new, transformative style for a striking update.', 50.00, 65, 4.50, NULL, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(28, 2, 'Beard & Mustache Trim Combo', 'Focuses on shaping both the beard and the mustache for perfect harmony. Includes trimming, outlining with trimmers, and using a specialized wax to style and hold the mustache, keeping it neat and symmetrical.', 28.00, 35, 3.00, 25.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(29, 2, 'Beard Hydration Treatment', 'A deep conditioning service for dry, coarse, or itchy beards. We use a professional hot oil treatment and steam to soften the hair and moisturize the skin beneath, followed by a light trim to remove split ends.', 35.00, 30, 5.00, 32.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(30, 2, 'Razor-Sharp Beard Outline', 'Elevate your beard with a precision straight razor finish on the cheek and neck lines. This creates the sharpest possible definition, making the edges pop and giving your entire beard a clean, professional, and refined aesthetic.', 30.00, 30, 2.50, NULL, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(31, 3, 'Royal Shave Experience', 'The ultimate indulgence, featuring multiple hot and cold towels, a pre-shave oil application, two passes with a straight razor for the closest shave, and a rejuvenating facial massage with premium post-shave balm.', 50.00, 50, 6.00, 45.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(32, 3, 'Clean-Up & Neck Shave', 'A quick service to clean up the neckline and stray hairs on the upper back and around the ears using a straight razor. Perfect between full haircuts to maintain a perpetually clean and tidy look.', 18.00, 15, 1.00, NULL, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(33, 3, 'Sensitive Skin Shave', 'A specialized shaving service using hypoallergenic, non-comedogenic creams and razors. The technique minimizes passes and reduces friction, ideal for clients prone to razor bumps or skin irritation for a comfortable, close shave.', 40.00, 40, 4.50, 36.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(34, 4, 'Beard Coloring/Tinting', 'Enhance the density and uniformity of your beard color or discreetly cover grey hairs. We use a semi-permanent tint matched to your hair color, applied quickly for a natural, fuller-looking beard and a more defined jawline.', 45.00, 45, 9.00, 40.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(35, 4, 'Root Touch-Up', 'Maintain your existing hair color by treating only the new growth at the roots. This precise service is essential for seamless blending and extending the life of your global color or grey coverage, keeping your hair consistent.', 40.00, 60, 7.00, NULL, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(36, 4, 'Toner/Gloss Application', 'A quick, low-commitment service to refresh or modify existing color, eliminate brassiness, or add shine to dull hair. A toner closes the hair cuticle for smoothness and adds a healthy, polished gloss.', 35.00, 40, 6.00, 32.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(37, 5, 'Deep Cleansing Blackhead Removal', 'An intensive treatment focused on extracting stubborn blackheads and whiteheads, especially around the nose and T-zone. Includes steaming, exfoliation, and a calming mask to reduce redness and tighten pores for clearer skin.', 40.00, 40, 6.50, 36.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(38, 5, 'Eye Puffiness & Dark Circle Treatment', 'A focused facial add-on that targets the delicate under-eye area. Using cold globes and a specialized serum rich in antioxidants, it reduces puffiness, minimizes dark circles, and refreshes tired-looking eyes for a more alert appearance.', 20.00, 15, 3.00, NULL, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(39, 5, 'Gentlemen\'s Hydration Boost', 'Perfect for dry or windburned skin. This cleanup uses an intense hyaluronic acid serum and a moisture-locking cream to replenish hydration, soothe dryness, and restore the skin\'s protective barrier, leaving it soft and supple.', 45.00, 45, 7.50, 40.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(40, 6, 'Scalp Scrub & Stimulating Massage', 'A dual treatment that first exfoliates the scalp to remove product buildup and dead skin. This is followed by a rigorous, stimulating massage to boost blood circulation, which promotes hair growth and minimizes flakiness and itching.', 40.00, 40, 6.00, 36.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(41, 6, 'Post-Shave Tension Relief', 'A focused massage on the temples, jawline, and back of the neck immediately following a shave. This gentle pressure work releases muscle tightness and soothes any post-shave sensitivity for maximum comfort and relaxation.', 15.00, 10, 0.50, NULL, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(42, 6, 'Migraine Relief Head Massage', 'Utilizes specific acupressure points on the scalp and temples known to alleviate migraine and chronic headache pain. Gentle, sustained pressure and cooling essential oils are used to ease discomfort and induce a deeper state of calm.', 30.00, 25, 2.50, 27.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(43, 7, 'Damage Repair Hair Spa', 'A specialized spa treatment for hair damaged by chemical processes, heat styling, or environmental stress. It uses protein bonds and restorative lipids to dramatically reduce frizz, seal split ends, and rebuild hair strength and elasticity.', 65.00, 70, 14.00, 60.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(44, 7, 'Volumizing Hair Spa', 'Designed for clients with fine or thinning hair, this treatment uses lightweight ingredients to gently lift the roots and add substantial body and fullness to the hair shaft. It provides volume without weighing down your style.', 50.00, 55, 10.50, 45.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(45, 7, 'Color Protection Hair Spa', 'Essential for maintaining vibrancy after a coloring service. This spa treatment uses pH-balanced formulas to lock in color pigments and prevent premature fading, leaving your treated hair shiny, soft, and protected from environmental damage.', 60.00, 60, 12.00, NULL, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(46, 8, 'D-Tan Hand & Forearm Treatment', 'Extends the D-Tan benefits beyond the face, targeting the hands and forearms, which are often heavily exposed to the sun. The treatment brightens and evens out skin tone on the hands, reducing visible tan lines and sunspots.', 35.00, 30, 7.00, 30.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(47, 8, 'Anti-Pollution D-Tan', 'A treatment formulated specifically to combat the effects of city pollution and grime. It deeply cleanses the skin of micro-pollutants and heavy metals while actively removing sun tan, ideal for urban dwellers needing a deep skin reset.', 50.00, 45, 10.00, 45.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(48, 8, 'Shoulder & Back D-Tan', 'A comprehensive D-Tan service applied to the upper back and shoulders, areas prone to severe sun exposure and tanning. It evens out the skin tone, exfoliates roughness, and clears breakouts in hard-to-reach areas for confident, clear skin.', 65.00, 60, 15.00, 60.00, 1, '2025-10-07 14:18:42', '2025-10-07 14:18:42'),
(49, 9, 'Classic Trim & Blowout', 'Maintain your current style with a precise dry trim of up to one inch. This service includes a professional wash, scalp massage, and classic voluminous blow-dry finish, ensuring your hair looks healthy, shiny, and perfectly styled.', 35.00, 45, 4.00, 32.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(50, 9, 'Layered Restyle & Finish', 'A transformative cut for a completely new look, such as adding face-framing layers or significant length reduction. It involves an in-depth consultation and a detailed blow-dry to showcase the new shape and movement.', 60.00, 75, 6.50, 55.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(51, 9, 'Fringe/Bangs Trim', 'A quick, complimentary service to reshape and trim existing bangs or fringe. Keeps your key feature looking sharp and neat without needing a full haircut appointment, maintaining definition around the face.', 10.00, 15, 1.00, NULL, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(52, 9, 'Luxury Silk Press', 'A high-heat, non-chemical straightening service for natural hair textures, resulting in a smooth, bone-straight, and glossy finish. Includes deep conditioning treatment to protect the hair from heat damage and keep it healthy.', 80.00, 90, 9.00, 75.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(53, 9, 'Braids & Updo Styling', 'Custom formal styling for events, including intricate updos, elegant chignons, or sophisticated braids. Perfect for weddings, proms, or special occasions where a long-lasting, detailed hairstyle is required for maximum impact.', 75.00, 90, 7.00, NULL, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(54, 10, 'Global Root Color Application', 'Color application focused solely on new hair growth at the roots to cover grey or match existing color. This helps in maintaining your current style and preventing harsh lines for a consistent, seamless color blend and touch-up.', 65.00, 90, 15.00, 60.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(55, 10, 'Full Balayage & Tone', 'A customized freehand painting technique creating a soft, natural gradation of lightness. This service includes a bonding treatment and a final toner for a sun-kissed, low-maintenance, and beautifully blended dimension.', 180.00, 180, 40.00, 165.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(56, 10, 'Partial Highlights', 'Highlights applied to the top section and sides of the head for brightening the face-frame and crown. Ideal for adding subtle dimension and making the biggest impact without coloring the entire head for a natural pop.', 110.00, 120, 25.00, NULL, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(57, 10, 'Creative Vivid Color', 'A multi-step process for bold, non-traditional hair colors (e.g., pink, blue, purple). Requires pre-lightening and multiple color applications for a vibrant, head-turning result. Consultation required before booking.', 250.00, 240, 60.00, 225.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(58, 10, 'Color Correction Service', 'Consultation and technical service to fix unwanted hair color results, such as brassiness or uneven tones. This complex process uses specialized treatments to safely neutralize or remove old color and re-color the hair.', 300.00, 300, 80.00, NULL, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(59, 11, 'Deep Hydrating Facial', 'A facial designed to restore moisture to dry and dehydrated skin. Includes gentle steaming, a hyaluronic acid mask, and a lymphatic drainage massage, leaving the skin plump, soft, and visibly dewy and refreshed.', 65.00, 60, 10.00, 60.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(60, 11, 'Anti-Aging Collagen Facial', 'Focuses on firming and reducing the appearance of fine lines and wrinkles. Features a specialized collagen mask and targeted massage techniques to boost elasticity and promote a smoother, more youthful complexion.', 90.00, 75, 15.00, NULL, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(61, 11, 'Acne & Blemish Control Facial', 'Therapeutic facial using salicylic acid and soothing botanicals to target breakouts, inflammation, and oiliness. Includes gentle extractions and a calming mask to promote healing and achieve clearer, healthier skin.', 75.00, 70, 12.00, 68.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(62, 11, 'Brightening Vitamin C Facial', 'A facial treatment to combat dullness and hyperpigmentation. High concentrations of Vitamin C and antioxidants fade dark spots, even out skin tone, and leave the skin with a vibrant, luminous, and visibly brightened glow.', 80.00, 75, 13.00, 72.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(63, 11, 'Express Mini Facial', 'A condensed, 30-minute version of our signature facial. Includes a quick cleanse, exfoliation, and targeted serum application, perfect for a skin boost during a lunch break or before a last-minute event.', 40.00, 30, 6.00, 35.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(64, 12, 'Eyebrow Threading & Shaping', 'Precision hair removal using the threading technique to create a perfect arch and clean, defined shape for your eyebrows. This method is gentle on the skin and allows for highly accurate results.', 15.00, 15, 0.50, 12.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(65, 12, 'Full Face Threading (Excluding Neck)', 'Removes unwanted hair from the forehead, cheeks, upper lip, and chin using threading. Ideal for clients with sensitive skin who want to avoid chemicals, leaving the entire face smooth and ready for makeup application.', 35.00, 30, 1.00, 30.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(66, 12, 'Full Arm Waxing', 'Removes hair from the entire arm, from shoulder to wrist, using a premium, gentle wax. Includes a soothing post-wax oil application to calm the skin and prevent irritation for a smooth, clean finish.', 40.00, 40, 5.00, 36.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(67, 12, 'Full Leg Waxing', 'Complete hair removal on the full leg, from the ankle to the upper thigh. We use a strip or stripless wax based on your skin type, ensuring a long-lasting, smooth result with minimal discomfort and irritation.', 60.00, 60, 8.00, 55.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(68, 12, 'Bikini Wax (Standard)', 'Tidy up the bikini line, removing hair that would show outside a standard bikini bottom. This quick service uses a sensitive-formula wax to ensure comfort and minimize redness in this delicate area.', 30.00, 20, 4.00, NULL, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(69, 13, 'Classic Manicure', 'Includes soaking, shaping, buffing the nails, cuticle care, a hand massage, and a polish application (or buff to shine). Leaves your hands and nails looking neat, healthy, and professionally groomed.', 25.00, 30, 3.00, 22.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(70, 13, 'Deluxe Spa Pedicure', 'An extended foot treatment including a warm aromatherapy soak, deep exfoliation scrub, callus removal, nourishing foot mask, extended foot and lower leg massage, and polish. Ultimate relaxation for tired feet.', 55.00, 60, 7.00, 50.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(71, 13, 'Gel Polish Application (Hands)', 'Application of chip-resistant, long-lasting gel polish cured under UV/LED light. Includes nail prep and shaping. Ideal for a durable, high-gloss finish that stays perfect for up to two weeks without chipping.', 40.00, 45, 6.00, 35.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(72, 13, 'Paraffin Wax Treatment (Add-on)', 'An intensive moisturizing add-on for hands or feet. Warm paraffin wax is applied to deeply hydrate and soften rough, dry skin, relieving joint stiffness and promoting superior moisture absorption after the main service.', 15.00, 15, 2.00, NULL, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(73, 13, 'Gentle Callus Removal Pedicure', 'A focused treatment for rough, callused heels and soles. It involves a gentle chemical softener and specialized filing to safely reduce hard skin, followed by a deeply moisturizing cream for smoothness.', 45.00, 45, 5.00, 40.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(74, 14, 'Intense Repair Hair Spa', 'A deeply penetrating treatment for severely damaged, over-processed, or brittle hair. Uses a rich protein mask and a heat cap to rebuild the hair\'s internal structure, reducing breakage and restoring resilience and shine.', 60.00, 60, 12.00, 55.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(75, 14, 'Oil Control Hair Spa', 'Designed for oily scalps and hair. This spa uses clarifying natural extracts to regulate sebum production and deeply cleanse the follicles, ensuring a balanced, fresh, and lightweight feel without stripping the hair.', 50.00, 50, 9.00, 45.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(76, 14, 'Frizz Control & Smoothing Spa', 'Perfect for humid weather or coarse hair prone to frizz. This treatment uses specialized serums and masks to smooth the cuticle, lock out humidity, and provide a sleek, glossy, and beautifully manageable finish.', 70.00, 75, 15.00, 65.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(77, 14, 'Hair Loss & Growth Stimulating Spa', 'A revitalizing treatment using stimulating essential oils and a scalp massage to increase circulation to the hair roots. It strengthens weak hair and encourages new growth for clients experiencing thinning or shedding.', 55.00, 55, 11.00, 50.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(78, 14, 'Keratin Express Hair Spa', 'A quick, temporary keratin infusion that coats the hair for immediate smoothing and shine. Reduces styling time and frizz for up to 6 washes, great for a quick fix before a vacation or special occasion.', 45.00, 45, 8.00, NULL, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(79, 15, 'De-Tan Facial Bleach', 'A professional, gentle bleaching service to lighten facial hair and reduce the appearance of tan and dark spots on the skin. It brightens the complexion for an immediate, noticeable glow and more uniform tone.', 30.00, 30, 6.00, 27.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(80, 15, 'Back & Shoulder D-Tan', 'An extensive D-Tan application covering the upper back and shoulders, areas often severely affected by sun exposure. It exfoliates and lightens the skin tone, restoring evenness for low-cut outfits and beachwear.', 55.00, 50, 10.00, 50.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(81, 15, 'Radiance Cleanup & D-Tan Combo', 'The ultimate skin reset, combining a deep pore-cleansing facial cleanup with an intensive D-Tan mask. This treatment removes impurities, brightens the complexion, and ensures your skin is left radiant and refreshed.', 70.00, 70, 14.00, 65.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(82, 15, 'Underarm D-Tan', 'A specialized treatment to address hyperpigmentation and darkening in the underarm area, often caused by friction or chemical products. It gently lightens the skin tone for a more confident and even appearance.', 25.00, 20, 4.00, NULL, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(83, 15, 'Pollution Defence Cleanup', 'A cleanup service specifically formulated with anti-pollution agents and charcoal-based masks. It deeply extracts toxins and environmental residue from the pores, leaving the skin detoxified, clean, and healthy-looking.', 45.00, 40, 7.50, 40.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(84, 16, 'Everyday Soft Glam Makeup', 'A polished, natural makeup look focusing on flawless base, light contour, subtle eye shadow, and a nude lip. Perfect for business meetings, interviews, or professional events where you need a subtle enhancement.', 85.00, 60, 15.00, 78.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(85, 16, 'Event & Party Makeup', 'Full coverage makeup for evening events, including dramatic eye looks, smoky eyes, or defined cut creases. This long-wear application ensures your look lasts through any celebration and photographs beautifully.', 120.00, 90, 22.00, 110.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(86, 16, 'Bridal/Wedding Makeup Trial', 'A mandatory consultation and full makeup trial run before the wedding day. This ensures the final look is perfectly tailored to your dress, theme, and preferences, providing complete peace of mind.', 150.00, 120, 25.00, NULL, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(87, 16, 'Hair Straightening & Ironing', 'Professional use of flat irons to achieve a sleek, perfectly straight, and glossy finish. Includes a heat protection serum application to shield the hair from damage and ensure a long-lasting, smooth style.', 45.00, 45, 6.00, 40.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(88, 16, 'Temporary Hair Curls & Waves', 'Styling service using curling irons or wands to create soft, romantic waves or defined, bouncy curls. Finished with a light-hold spray for movement and longevity, perfect for adding texture and volume to any hair length.', 50.00, 50, 7.00, 45.00, 1, '2025-10-07 14:20:17', '2025-10-07 14:20:17'),
(89, 9, 'Intricate Hair Coloring Design', 'Custom hand-painted hair art or specialized techniques like foilyage or high-contrast money pieces. This service is ideal for creating unique, visually complex designs that require advanced skill and careful placement.', 95.00, 105, 10.00, 85.00, 1, '2025-10-07 14:22:52', '2025-10-07 14:22:52'),
(90, 9, 'Natural Curl Shaping & Diffusion', 'A specialized dry cutting technique tailored to enhance natural curls and waves. The service includes a proper product application method and diffusion drying to reduce frizz and maximize curl definition and bounce.', 50.00, 60, 5.50, NULL, 1, '2025-10-07 14:22:52', '2025-10-07 14:22:52'),
(91, 10, 'Lowlights & Depth Creation', 'Applying darker tones back into previously highlighted or lighter hair to add dimension and richness. This technique creates a natural shadow effect, making the overall color look thicker and more dynamic.', 100.00, 105, 20.00, 90.00, 1, '2025-10-07 14:22:52', '2025-10-07 14:22:52'),
(92, 11, 'Microdermabrasion Facial', 'A non-invasive treatment that uses gentle exfoliation to remove the top layer of dead skin cells. This reduces the appearance of mild scarring, fine lines, and sun damage, revealing smoother, more vibrant skin.', 110.00, 75, 18.00, 100.00, 1, '2025-10-07 14:22:52', '2025-10-07 14:22:52'),
(93, 12, 'Half Leg Waxing (Lower)', 'Hair removal using wax from the ankle up to just above the knee. A quick and efficient service that keeps the lower legs smooth and hair-free. Includes soothing oil application to reduce post-wax redness.', 35.00, 30, 4.00, 30.00, 1, '2025-10-07 14:22:52', '2025-10-07 14:22:52'),
(94, 13, 'Polish Change (Fingers or Toes)', 'A quick service to remove old polish, reshape the nails with a file, and apply a fresh coat of new regular nail polish color. Does not include a soak, massage, or cuticle care for a fast update.', 15.00, 20, 2.00, NULL, 1, '2025-10-07 14:22:52', '2025-10-07 14:22:52'),
(95, 14, 'Aromatherapy Stress-Relief Spa', 'A relaxing hair spa experience using custom essential oil blends tailored for calming the mind. The treatment includes an extended scalp, neck, and shoulder massage to release tension and soothe the nervous system.', 60.00, 65, 10.00, 55.00, 1, '2025-10-07 14:22:52', '2025-10-07 14:22:52'),
(96, 15, 'Hand Brightening D-Tan', 'A specialized treatment to reduce tan and dark patches on the hands, restoring youthful brightness and evening out skin tone. Includes gentle exfoliation and a deep moisturizing hand mask for soft skin.', 20.00, 20, 3.00, 18.00, 1, '2025-10-07 14:22:52', '2025-10-07 14:22:52'),
(97, 16, 'Hair Extensions Styling (Add-on)', 'Professional blending and styling of clip-in or tape-in hair extensions for a full, voluminous look. This ensures the extensions match your natural hair and the style stays secure for the duration of your event.', 30.00, 30, 2.50, NULL, 1, '2025-10-07 14:22:52', '2025-10-07 14:22:52'),
(98, 16, 'Bridal Makeup Application', 'Full, bespoke makeup application for the wedding day itself, including waterproof products, high-definition finishes, and custom lashes. This luxury service is designed to look stunning in person and flawless in photos.', 250.00, 120, 40.00, 225.00, 1, '2025-10-07 14:22:52', '2025-10-07 14:22:52');

-- --------------------------------------------------------

--
-- Table structure for table `service_categories`
--

CREATE TABLE `service_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `gender` enum('male','female','other') NOT NULL DEFAULT 'male',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `service_categories`
--

INSERT INTO `service_categories` (`id`, `name`, `description`, `gender`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Haircut', 'Get a sharp, stylish haircut that suits your face and lifestyle. Our expert barbers craft classic or trendy looks with precision, ensuring you walk out feeling confident, clean, and fresh every time.', 'male', 1, '2025-10-07 13:28:08', '2025-10-07 13:28:08'),
(2, 'Beard Trim', 'Keep your beard perfectly shaped and neat with our detailed trimming service. We contour and style your beard using premium tools, enhancing your features while maintaining a polished, masculine look.', 'male', 1, '2025-10-07 13:28:27', '2025-10-07 13:28:27'),
(3, 'Shaving', 'Enjoy a luxurious hot towel shave with a straight razor for a smooth finish. The process includes cleansing, lathering, and aftershave care to leave your skin refreshed and irritation-free.', 'male', 1, '2025-10-07 13:28:37', '2025-10-07 13:28:37'),
(4, 'Hair Coloring', 'Upgrade your look or cover greys with professional men’s hair coloring. We use high-quality, ammonia-free products that deliver rich color, shine, and natural results that suit your tone and style.', 'male', 1, '2025-10-07 13:28:51', '2025-10-07 13:28:51'),
(5, 'Facial Cleanup', 'Remove dirt, oil, and impurities with a deep facial cleanup. This treatment unclogs pores, reduces acne, and leaves your skin looking bright, clean, and rejuvenated after every session.', 'male', 1, '2025-10-07 13:29:03', '2025-10-07 13:29:03'),
(6, 'Head Massage', 'Relax with a soothing head massage that reduces stress and improves blood circulation. Using warm oils and gentle pressure, it relieves tension and promotes healthy scalp and hair growth.', 'male', 1, '2025-10-07 13:29:15', '2025-10-07 13:29:15'),
(7, 'Hair Spa', 'Revive dry or damaged hair with our nourishing hair spa treatment. It deeply conditions, strengthens roots, reduces dandruff, and restores softness and shine for healthier-looking hair.', 'male', 1, '2025-10-07 13:29:28', '2025-10-07 13:29:28'),
(8, 'D-Tan Treatment', 'Remove tan, pollution, and dullness with our D-Tan treatment. It brightens your skin tone, clears impurities, and restores freshness, giving your face a clean and confident glow.', 'male', 1, '2025-10-07 13:29:40', '2025-10-07 13:29:40'),
(9, 'Haircut & Styling', 'Transform your look with a personalized haircut and styling session. From soft layers to bold cuts, our stylists craft shapes that flatter your face and enhance your natural beauty.', 'female', 1, '2025-10-07 13:29:53', '2025-10-07 13:29:53'),
(10, 'Hair Coloring', 'Add shine, depth, or a whole new look with our premium coloring services. Choose highlights, balayage, or global shades that complement your tone using safe, ammonia-free colors.', 'female', 1, '2025-10-07 13:30:11', '2025-10-07 13:30:11'),
(11, 'Facial', 'Refresh and hydrate your skin with our customized facials. This relaxing treatment cleanses, exfoliates, and rejuvenates dull skin, leaving your face soft, smooth, and glowing.', 'female', 1, '2025-10-07 13:30:21', '2025-10-07 13:30:21'),
(12, 'Threading & Waxing', 'Achieve smooth, hair-free skin with gentle threading and waxing services. We ensure precise eyebrow shaping and safe, hygienic waxing for face and body.', 'female', 1, '2025-10-07 13:30:31', '2025-10-07 13:30:31'),
(13, 'Manicure & Pedicure', 'Pamper your hands and feet with cleansing, exfoliation, and massage. Our manicure and pedicure sessions leave your skin soft and your nails neat, shiny, and beautiful.', 'female', 1, '2025-10-07 13:30:52', '2025-10-07 13:30:52'),
(14, 'Hair Spa', 'Repair and nourish your hair with our deep-conditioning hair spa. It restores moisture, reduces frizz, strengthens roots, and enhances natural shine for a soft, silky finish.', 'female', 1, '2025-10-07 13:31:03', '2025-10-07 13:31:03'),
(15, 'D-Tan & Cleanup', 'Restore brightness with our D-Tan and Cleanup treatment. It removes tan, clears pores, and evens skin tone, giving you a smooth and radiant complexion.', 'female', 1, '2025-10-07 13:31:15', '2025-10-07 13:31:15'),
(16, 'Makeup & Styling', 'Look flawless for any event with our makeup and hairstyling services. From soft glam to bridal beauty, we enhance your features using premium, long-lasting products.', 'female', 1, '2025-10-07 13:31:25', '2025-10-07 13:31:25');

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `owner_id` bigint(20) UNSIGNED NOT NULL,
  `current_step` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `open` time NOT NULL,
  `close` time NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `owner_id`, `current_step`, `name`, `profile_image`, `address`, `city`, `state`, `postal_code`, `latitude`, `longitude`, `phone`, `open`, `close`, `description`, `is_active`, `status`, `created_at`, `updated_at`) VALUES
(2, 1, 1, 'store 10', 'shops/KQOvxfSK9glQhgNeCP5v0PnrlyNKf9axZsNFuv77.jpg', 'dumar talab raipur', 'Raipur', 'Chhattisgarh', '492099', 70.7085500, -12.8865100, '1234567890', '09:00:00', '18:00:00', 'asdfsd asfsadfas asdfsadf', 0, 'pending', '2025-09-21 07:22:16', '2025-09-21 07:22:16'),
(3, 1, 1, 'store 10', 'shops/qD4UHaBI6wmRIvpMwyW8R2lfqGu28F03eCJLhDwx.jpg', 'dumar talab raipur', 'Raipur', 'Chhattisgarh', '492099', 70.7085500, -12.8865100, '1234567890', '09:00:00', '18:00:00', 'asdfsd asfsadfas asdfsadf', 0, 'pending', '2025-09-23 01:30:32', '2025-09-23 01:30:32'),
(4, 1, 1, 'store 10', 'shops/iPBqf1WexV5ACaBPpDRqpXbIs2ej52kphCT7iBrC.jpg', 'dumar talab raipur', 'Raipur', 'Chhattisgarh', '492099', 70.7085500, -12.8865100, '1234567890', '09:00:00', '18:00:00', 'asdfsd asfsadfas asdfsadf', 0, 'pending', '2025-09-23 01:32:54', '2025-09-23 01:32:54'),
(5, 1, 1, 'Aadim janajati', NULL, 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '492001', 21.2476215, 81.6301399, '8956499564', '09:00:00', '22:00:00', 'fhdbdjssjd d ear ke liye bolna hai bol de eaise hi ladke ke sath me hai to vah apane aap', 0, 'pending', '2025-09-23 01:47:42', '2025-09-23 01:47:42'),
(6, 1, 1, 'Dhiwer', 'shops/PnvGvoA5VHCRfe2JKby1sF1mbGQkzgNY2ofuXlba.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '492001', 21.2470232, 81.6299506, '8956495686', '09:00:00', '22:00:00', 'fir bhi kuchh aisa hi ek film ki shooting ke sath lge rho chapter ke sath hi', 0, 'pending', '2025-09-24 07:17:40', '2025-09-24 07:17:40'),
(7, 1, 2, 'habib', 'shops/O6YKmLikgBRMSfbNHCZ0TBIPQiYFhJ1Q8lcVEZkn.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '492001', 21.2457836, 81.6301643, '8956495319', '00:00:00', '09:00:00', 'to fir kya tha man to kya hua tha aur man to y I will send it to you in hinglish', 0, 'pending', '2025-09-26 00:28:49', '2025-09-26 00:28:49'),
(8, 1, 2, 'Saloni Saloan', 'shops/f0BUYak6VuugBl1nVFiPBUV3k0LuMGxUt6YqHQ4N.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '494335', 21.2541019, 81.5900396, '8956495656', '10:00:00', '22:00:00', 't a t a l m a b c and e hai na tu to fir bhi tujhe u r my best to get a chance of rain', 0, 'pending', '2025-09-26 01:07:50', '2025-09-26 01:07:50'),
(9, 1, 2, 'Saloni Saloan', 'shops/revpW51gCkcVdHe41KQ5IPxkgaLfSOFbZnkZDXrE.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '494335', 21.2541019, 81.5900396, '8956495656', '10:00:00', '22:00:00', 't a t a l m a b c and e hai na tu to fir bhi tujhe u r my best to get a chance of rain', 0, 'pending', '2025-09-26 01:10:09', '2025-09-26 01:10:09'),
(10, 1, 2, 'My saloon', 'shops/i5TMqMwR3qy3NRhWUixSNgdM0tf2ADYI081FrAtE.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '494335', 21.2542756, 81.5897338, '8956495619', '00:00:00', '21:00:00', 'gh ke sath hi unhone to fir pahli to fir pahli tin aur logon ko bhi is bat ka pata lagaya ja sakta hu', 0, 'pending', '2025-09-26 01:12:54', '2025-09-26 01:12:54'),
(11, 1, 2, 'My saloon', 'shops/dfiHcVuWRHmySONz5GjnKOZoVR8fjK31rVzx0J0I.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '494335', 21.2542756, 81.5897338, '8956495619', '00:00:00', '21:00:00', 'gh ke sath hi unhone to fir pahli to fir pahli tin aur logon ko bhi is bat ka pata lagaya ja sakta hu', 0, 'pending', '2025-09-26 01:15:13', '2025-09-26 01:15:13'),
(12, 1, 2, 'My saloon', 'shops/9RlY0JownFAeCJshyCCw1CGvCAA0JrQK5u5b7rxX.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '494335', 21.2542756, 81.5897338, '8956495619', '00:00:00', '21:00:00', 'gh ke sath hi unhone to fir pahli to fir pahli tin aur logon ko bhi is bat ka pata lagaya ja sakta hu', 0, 'pending', '2025-09-26 01:15:58', '2025-09-26 01:15:58'),
(13, 1, 2, 'My saloon', 'shops/bkZOvt6XuBsrEA3A92iG0yf0NT8Bb0pGO6rCvVgp.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '494335', 21.2542756, 81.5897338, '8956495619', '00:00:00', '21:00:00', 'gh ke sath hi unhone to fir pahli to fir pahli tin aur logon ko bhi is bat ka pata lagaya ja sakta hu', 0, 'pending', '2025-09-26 01:16:43', '2025-09-26 01:16:43'),
(14, 1, 2, 'Shop 10', 'shops/g3OkOhxVs22dSjd8hkAGo60brmmhCFTnsLW3VT9l.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '492001', 21.2510450, 81.6300534, '8956492656', '00:00:00', '21:00:00', 'Sb hi hai ki baat hai ki nahi kar sakte hai bs eaisi rahul gandhi to kya tu mere', 0, 'pending', '2025-10-06 00:55:40', '2025-10-06 00:55:40'),
(15, 1, 2, 'store 10', 'shops/WqHcxuIklNft2OrlR0rnhsjwkUwx4Rcl3aba712E.jpg', 'dumar talab raipur', 'Raipur', 'Chhattisgarh', '492099', 70.7085500, -12.8865100, '1234567890', '09:00:00', '18:00:00', 'asdfsd asfsadfas asdfsadf', 0, 'pending', '2025-10-06 01:12:11', '2025-10-06 01:12:11'),
(16, 3, 2, 'store 1', 'shops/0d34is6bBWEjdERmJtLivtDaQgTBw5C5CckWOuf4.jpg', 'dumar talab raipur', 'Raipur', 'Chhattisgarh', '492099', 70.7085500, -12.8865100, '1234567890', '09:00:00', '18:00:00', 'asdfsd asfsadfas asdfsadf', 0, 'pending', '2025-10-06 01:53:19', '2025-10-06 01:53:19'),
(17, 1, 2, 'Shop 16', 'shops/UMVKPrs9zhZNDhVJx8BAWKPATI9tc6WtkuLvtX4A.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '494335', 21.2541132, 81.5900296, '8956192389', '00:00:00', '09:00:00', 'fir bhi man men bhi to fir pahli baar to fir bhi nahi pta nhi hai na ki baat kar', 0, 'pending', '2025-10-06 01:55:32', '2025-10-06 01:55:32'),
(18, 1, 2, 'Shop 16', 'shops/OfMSOwoquTOqMQHVuJx34GYSeE1e3uRNDdOyPyFo.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '494335', 21.2541132, 81.5900296, '8956192389', '00:00:00', '09:00:00', 'fir bhi man men bhi to fir pahli baar to fir bhi nahi pta nhi hai na ki baat kar', 0, 'pending', '2025-10-06 01:56:18', '2025-10-06 01:56:18'),
(19, 1, 2, 'Shop 16', 'shops/UE7KCS7n7TmdbWAAac7aOfQqyLf3h7EAtiHVx8Ue.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '494335', 21.2541132, 81.5900296, '8956192389', '00:00:00', '09:00:00', 'fir bhi man men bhi to fir pahli baar to fir bhi nahi pta nhi hai na ki baat kar', 0, 'pending', '2025-10-06 01:57:06', '2025-10-06 01:57:06'),
(20, 3, 2, 'store 1', 'shops/vuZFeanRiQs9uDcefNO8fsPm0b2gw09BZlNqYp8Z.jpg', 'dumar talab raipur', 'Raipur', 'Chhattisgarh', '492099', 70.7085500, -12.8865100, '1234567890', '09:00:00', '18:00:00', 'asdfsd asfsadfas asdfsadf', 0, 'pending', '2025-10-06 02:24:00', '2025-10-06 02:24:00'),
(21, 1, 2, 'Shop 16', 'shops/w8VWi338A2d4TviliYOe6f2Wg99zdgCnaxXm9RKp.jpg', 'Raipur, Raipur Tahsil, Raipur, Chhattisgarh, India', 'Raipur', 'Chhattisgarh', '494335', 21.2541142, 81.5900271, '8956492359', '00:00:00', '12:00:00', 'to fir kya hua tha vo dekhna hai ki nahi balki hai', 0, 'pending', '2025-10-06 07:39:36', '2025-10-06 07:39:36');

-- --------------------------------------------------------

--
-- Table structure for table `shop_images`
--

CREATE TABLE `shop_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shop_id` bigint(20) UNSIGNED NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop_members`
--

CREATE TABLE `shop_members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shop_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `specialty` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'staff',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'Vikram', 'vik1@gmail.com', NULL, '$2y$12$nHixoRnUshv/YooMV03nQOFrCcMAqRc44QA.haspS747MGBPm0vg.', 'owner', NULL, '2025-09-01 07:25:30', '2025-09-12 05:44:44'),
(2, 'cndbdb', 'cbdbddb@gmaul.com', NULL, '$2y$12$rh4BA5ijzaapEjD7R4FL8OSQ//.v1j4eBuRMVlCEAfx1ErD4xcHjS', 'customer', NULL, '2025-09-02 08:00:09', '2025-09-02 08:00:09'),
(3, 'aaditya', 'aaditya.appdev@gmail.com', NULL, '$2y$12$gzly0FQ5634jqpBdYxBly.mJddH.qNDPiE.H21QEHdyGbZBzTGEkS', 'owner', NULL, '2025-09-03 04:59:34', '2025-09-05 04:16:40'),
(4, 'My Saloon Owner', 'mysaloon@gmail.com', NULL, '$2y$12$KimcK.2MgQm4KiQ0trom2uqfsxabYgD8sNQYp3Q.YlgSjBYEW8rfy', 'customer', NULL, '2025-09-08 03:43:30', '2025-09-08 03:43:30');

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
-- Indexes for table `email_verifications`
--
ALTER TABLE `email_verifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email_verifications_email_index` (`email`);

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
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pending_verifications`
--
ALTER TABLE `pending_verifications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pending_verifications_email_unique` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_category_id_foreign` (`category_id`);

--
-- Indexes for table `service_categories`
--
ALTER TABLE `service_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shops_owner_id_foreign` (`owner_id`);

--
-- Indexes for table `shop_images`
--
ALTER TABLE `shop_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_images_shop_id_foreign` (`shop_id`);

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
-- AUTO_INCREMENT for table `email_verifications`
--
ALTER TABLE `email_verifications`
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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pending_verifications`
--
ALTER TABLE `pending_verifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `service_categories`
--
ALTER TABLE `service_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `shop_images`
--
ALTER TABLE `shop_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop_members`
--
ALTER TABLE `shop_members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `service_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `shops`
--
ALTER TABLE `shops`
  ADD CONSTRAINT `shops_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `shop_images`
--
ALTER TABLE `shop_images`
  ADD CONSTRAINT `shop_images_shop_id_foreign` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`) ON DELETE CASCADE;

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
