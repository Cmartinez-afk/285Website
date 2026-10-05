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
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `id` int NOT NULL,
  `ingred` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`id`, `ingred`) VALUES
(1, 'Vegetable Oil'),
(2, 'Unsalted Butter'),
(3, 'Granulated Sugar'),
(4, 'Eggs'),
(5, 'Flour'),
(6, 'Baking Powder'),
(7, 'Salt'),
(8, 'Baking Soda'),
(9, 'Sour Cream'),
(10, 'Whole Milk'),
(11, 'Lemon Zest'),
(12, 'Lemon Extract'),
(13, 'Vanilla Extract');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
