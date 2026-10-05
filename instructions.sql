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
-- Table structure for table `instructions`
--

CREATE TABLE `instructions` (
  `id` int NOT NULL,
  `instructions` text NOT NULL,
  `recipe_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `instructions`
--

INSERT INTO `instructions` (`id`, `instructions`, `recipe_id`) VALUES
(1, '1. Start by preheating your oven to 325°F then liberally spray 2 (8-inch) round cake pans with non-stick baking spray.\r\n2. In your mixer bowl, add oil and butter and beat for 2 minutes on high speed. Slowly add in sugar and beat on high speed for an additional 4-5 minutes until very pale yellow and fluffy. Next, add eggs, one at a time, combining well after each addition and scraping down the sides as needed.\r\n3. Turn your mixer down to its lowest speed, and slowly add flour into batter in two increments then add baking powder, salt and baking soda. Be careful not to over beat.\r\n4. Lastly, add sour cream, milk, lemon zest, lemon and vanilla extracts, scrape down sides and mix until just combined and turn off mixer.\r\n5. Evenly pour cake batter into prepared baking pans and place in oven to bake for 30-40 minutes or until a toothpick inserted into the center of the cake comes just barely clean but don\'t over bake (crucial not to over bake this cake)!!  I personally start checking the cakes around 27 minutes just to ensure.\r\n6. Remove cakes from oven and rest in pans for 10-15 minutes. Invert cakes from pans onto cooling racks until cooled.', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `instructions`
--
ALTER TABLE `instructions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `instructions`
--
ALTER TABLE `instructions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
