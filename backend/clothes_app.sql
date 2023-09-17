-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 24, 2023 at 05:04 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clothes_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `admin_name` varchar(50) NOT NULL,
  `admin_email` varchar(50) NOT NULL,
  `admin_password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_name`, `admin_email`, `admin_password`) VALUES
(1, 'admin', 'admin@gmail.com', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `color` varchar(100) NOT NULL,
  `size` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `item_id`, `quantity`, `color`, `size`) VALUES
(13, 1, 7, 1, '[red', '[small'),
(14, 1, 8, 1, '[black]', '[small'),
(15, 1, 6, 1, '[red', '[s'),
(16, 1, 13, 1, '[red', '[small'),
(20, 3, 8, 4, '[black]', ' big'),
(21, 3, 11, 98, ' yellow', ' large'),
(23, 3, 8, 2, '[black]', '[small');

-- --------------------------------------------------------

--
-- Table structure for table `favourite`
--

CREATE TABLE `favourite` (
  `favourite_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `favourite`
--

INSERT INTO `favourite` (`favourite_id`, `user_id`, `item_id`) VALUES
(5, 2, 13),
(6, 2, 10),
(7, 2, 7),
(8, 2, 9),
(9, 2, 6),
(11, 3, 6),
(12, 3, 12),
(13, 3, 11);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `rating` double NOT NULL,
  `tags` varchar(100) NOT NULL,
  `price` double NOT NULL,
  `sizes` varchar(100) NOT NULL,
  `colors` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `name`, `rating`, `tags`, `price`, `sizes`, `colors`, `description`, `image`) VALUES
(6, 'Eze Mazi', 4.2, '[hp,  SSD,  mini]', 1500, '[s, m, xl, l]', '[red, black]', 'It\'s time to enter into the next chapter. Hyperfast 5G connection takes your everyday mobile experiences and vastly enhances them with next-level speed. Feel truly connected with seamless streaming, instant sharing, and the power to transfer your thoughts to action in a blink.', 'image/product/calico.jpg'),
(7, 'shirt 👕 for male', 4.5, '[shit, male, unsex]', 1300, '[small,  large, big]', '[red,  yellow, black]', 'It\'s time to enter into the next chapter. Hyperfast 5G connection takes your everyday mobile experiences and vastly enhances them with next-level speed. Feel truly connected with seamless streaming, instant sharing, and the power to transfer your thoughts to action in a blink.', 'image/product/Red_Fantails.jpg'),
(8, 'big man Eze', 4.8, '[bella, man,  humans ]', 150, '[small,  big, large]', '[black]', 'It\'s time to enter into the next chapter. Hyperfast 5G connection takes your everyday mobile experiences and vastly enhances them with next-level speed. Feel truly connected with seamless streaming, instant sharing, and the power to transfer your thoughts to action in a blink.', 'image/product/Standard_Fin_Koi_.jpg'),
(9, 'The clothes', 3.8, '[bella, man,  humans ]', 150, '[small,  big, large]', '[black]', 'It\'s time to enter into the next chapter. Hyperfast 5G connection takes your everyday mobile experiences and vastly enhances them with next-level speed. Feel truly connected with seamless streaming, instant sharing, and the power to transfer your thoughts to action in a blink.', 'image/product/flower horn.jpg'),
(10, 'shirt 👕 for female', 3, '[shit, male, unsex]', 1300, '[small,  large, big]', '[red,  yellow, black]', 'this one is good for male and female', 'image/product/fish net.jfif'),
(11, 'Vero Cloths', 3, '[shit, male, unsex]', 1300, '[small,  large, big]', '[red,  yellow, black]', 'It\'s time to enter into the next chapter. Hyperfast 5G connection takes your everyday mobile experiences and vastly enhances them with next-level speed. Feel truly connected with seamless streaming, instant sharing, and the power to transfer your thoughts to action in a blink.', 'image/product/air stone.jfif'),
(12, 'Eze Shoe', 3, '[shit, male, unsex]', 1700, '[small,  large, big]', '[red,  yellow, black]', 'It\'s time to enter into the next chapter. Hyperfast 5G connection takes your everyday mobile experiences and vastly enhances them with next-level speed. Feel truly connected with seamless streaming, instant sharing, and the power to transfer your thoughts to action in a blink.', 'image/product/magnetic.jfif'),
(13, 'Ejeh Cars', 3, '[shit, male, unsex]', 37000, '[small,  large, big]', '[red,  yellow, black]', 'It\'s time to enter into the next chapter. Hyperfast 5G connection takes your everyday mobile experiences and vastly enhances them with next-level speed. Feel truly connected with seamless streaming, instant sharing, and the power to transfer your thoughts to action in a blink.', 'image/product/sub pump.jfif');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_email`, `user_password`) VALUES
(1, 'EJEH', 'mazi@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b'),
(2, 'ejeh', 'ejeh@gmail.com', '08e6902a40caf465cd0bfe1db04f893e'),
(3, 'red', 'red@gmail.com', 'bda9643ac6601722a28f238714274da4');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`);

--
-- Indexes for table `favourite`
--
ALTER TABLE `favourite`
  ADD PRIMARY KEY (`favourite_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `favourite`
--
ALTER TABLE `favourite`
  MODIFY `favourite_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
