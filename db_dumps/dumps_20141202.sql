-- phpMyAdmin SQL Dump
-- version 4.2.0
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 02, 2014 at 02:01 PM
-- Server version: 5.6.17
-- PHP Version: 5.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bookstore7`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE IF NOT EXISTS `authors` (
`author_id` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE IF NOT EXISTS `books` (
  `isbn` bigint(13) NOT NULL DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `book_author_id` int(11) DEFAULT NULL,
  `shelf_id` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE IF NOT EXISTS `deliveries` (
`delivery_id` int(11) NOT NULL,
  `isbn` bigint(13) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `delivery_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `f_price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `price_history`
--

CREATE TABLE IF NOT EXISTS `price_history` (
`price_id` int(11) NOT NULL,
  `isbn` bigint(13) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `change_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE IF NOT EXISTS `sales` (
`sale_id` int(11) NOT NULL,
  `isbn` bigint(13) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `sale_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `shelves`
--

CREATE TABLE IF NOT EXISTS `shelves` (
  `shelf_id` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
 ADD PRIMARY KEY (`author_id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
 ADD PRIMARY KEY (`isbn`), ADD UNIQUE KEY `isbn` (`isbn`), ADD KEY `book_author_id` (`book_author_id`), ADD KEY `shelf_id` (`shelf_id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
 ADD PRIMARY KEY (`delivery_id`), ADD KEY `isbn` (`isbn`);

--
-- Indexes for table `price_history`
--
ALTER TABLE `price_history`
 ADD PRIMARY KEY (`price_id`), ADD KEY `isbn` (`isbn`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
 ADD PRIMARY KEY (`sale_id`), ADD KEY `isbn` (`isbn`);

--
-- Indexes for table `shelves`
--
ALTER TABLE `shelves`
 ADD PRIMARY KEY (`shelf_id`), ADD UNIQUE KEY `shelf_id` (`shelf_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
MODIFY `author_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
MODIFY `delivery_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `price_history`
--
ALTER TABLE `price_history`
MODIFY `price_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
MODIFY `sale_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
ADD CONSTRAINT `books_ibfk_2` FOREIGN KEY (`shelf_id`) REFERENCES `shelves` (`shelf_id`),
ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`book_author_id`) REFERENCES `authors` (`author_id`);

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
ADD CONSTRAINT `deliveries_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`);

--
-- Constraints for table `price_history`
--
ALTER TABLE `price_history`
ADD CONSTRAINT `price_history_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
