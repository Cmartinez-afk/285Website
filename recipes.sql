-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: student-databases.cvode4s4cwrc.us-west-2.rds.amazonaws.com
-- Generation Time: Mar 17, 2026 at 06:54 PM
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
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `food_category` varchar(255) NOT NULL,
  `user_inputting` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`id`, `name`, `food_category`, `user_inputting`) VALUES
(1, 'Lemon Cake', 'Desert', 'Cam'),
(2, 'Buttermilk Biscuits', 'Breakfast', 'Cam'),
(3, 'Korean Fried Chicken', 'Lunch/Dinner', 'Cam'),
(4, 'Spam Musubi', 'Lunch/Dinner', 'Cam'),
(5, 'Chocolate Oatmeal Bars', 'Desert', 'Cam');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
