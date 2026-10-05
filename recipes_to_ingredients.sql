-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: student-databases.cvode4s4cwrc.us-west-2.rds.amazonaws.com
-- Generation Time: Apr 16, 2026 at 07:18 PM
-- Server version: 8.0.42
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `CAMRYNMARTINEZ`
--

-- --------------------------------------------------------

--
-- Table structure for table `recipes_to_ingredients`
--

CREATE TABLE `recipes_to_ingredients` (
  `id` int NOT NULL,
  `recipe_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  `amount` varchar(255) NOT NULL,
  `measurement` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `recipes_to_ingredients`
--

INSERT INTO `recipes_to_ingredients` (`id`, `recipe_id`, `ingredient_id`, `amount`, `measurement`) VALUES
(1, 1, 1, '2/3', 'cup'),
(2, 1, 2, '1/3', 'cup'),
(3, 1, 3, '1 1/2', 'cup'),
(4, 1, 4, '3', 'large'),
(5, 1, 5, '2 3/4', 'cups'),
(6, 1, 6, '1 1/2', 'tsp'),
(7, 1, 7, '1', 'tsp'),
(8, 1, 8, '1/2', 'tsp'),
(9, 1, 9, '1 1/4', 'cup'),
(10, 1, 10, '1/3', 'cup'),
(11, 1, 11, '1', 'tbsp'),
(12, 1, 12, '1 1/2', 'tsp'),
(13, 1, 13, '1', 'tsp'),
(14, 1, 3, '1 1/2', 'cup'),
(15, 1, 4, '3', 'large'),
(16, 1, 5, '2 3/4', 'cups'),
(17, 1, 6, '1 1/2', 'tsp'),
(18, 1, 7, '1', 'tsp'),
(19, 1, 8, '1/2', 'tsp'),
(20, 1, 9, '1 1/4', 'cup'),
(21, 1, 10, '1/3', 'cup'),
(22, 1, 11, '1', 'tbsp'),
(23, 1, 12, '1 1/2', 'tsp'),
(24, 1, 13, '1', 'tsp');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `recipes_to_ingredients`
--
ALTER TABLE `recipes_to_ingredients`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `recipes_to_ingredients`
--
ALTER TABLE `recipes_to_ingredients`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
