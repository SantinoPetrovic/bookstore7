-- phpMyAdmin SQL Dump
-- version 4.2.8
-- http://www.phpmyadmin.net
--
-- Värd: localhost
-- Tid vid skapande: 27 nov 2014 kl 11:00
-- Serverversion: 5.6.15
-- PHP-version: 5.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databas: `sjuansbokhandel`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `books`
--

CREATE TABLE IF NOT EXISTS `books` (
  `isbn` bigint(13) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `books_prices`
--

CREATE TABLE IF NOT EXISTS `books_prices` (
`id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isbn` bigint(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `book_shelfs`
--

CREATE TABLE IF NOT EXISTS `book_shelfs` (
  `isbn` bigint(13) NOT NULL,
  `shelfs_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `deliveries`
--

CREATE TABLE IF NOT EXISTS `deliveries` (
`id` int(11) NOT NULL,
  `f_price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isbn` bigint(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `sales`
--

CREATE TABLE IF NOT EXISTS `sales` (
`id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isbn` bigint(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `shelfs`
--

CREATE TABLE IF NOT EXISTS `shelfs` (
`id` int(11) NOT NULL,
  `code` char(1) NOT NULL,
  `number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `books`
--
ALTER TABLE `books`
 ADD PRIMARY KEY (`isbn`);

--
-- Index för tabell `books_prices`
--
ALTER TABLE `books_prices`
 ADD PRIMARY KEY (`id`), ADD KEY `books_prices_books` (`isbn`);

--
-- Index för tabell `book_shelfs`
--
ALTER TABLE `book_shelfs`
 ADD PRIMARY KEY (`isbn`), ADD KEY `book_shelfs_shelfs` (`shelfs_id`);

--
-- Index för tabell `deliveries`
--
ALTER TABLE `deliveries`
 ADD PRIMARY KEY (`id`), ADD KEY `deliveries_books` (`isbn`);

--
-- Index för tabell `sales`
--
ALTER TABLE `sales`
 ADD PRIMARY KEY (`id`), ADD KEY `sales_books` (`isbn`);

--
-- Index för tabell `shelfs`
--
ALTER TABLE `shelfs`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `books_prices`
--
ALTER TABLE `books_prices`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `deliveries`
--
ALTER TABLE `deliveries`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `sales`
--
ALTER TABLE `sales`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `shelfs`
--
ALTER TABLE `shelfs`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `books_prices`
--
ALTER TABLE `books_prices`
ADD CONSTRAINT `books_prices_books` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`);

--
-- Restriktioner för tabell `book_shelfs`
--
ALTER TABLE `book_shelfs`
ADD CONSTRAINT `book_shelfs_shelfs` FOREIGN KEY (`shelfs_id`) REFERENCES `shelfs` (`id`),
ADD CONSTRAINT `book_shelfs_books` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`);

--
-- Restriktioner för tabell `deliveries`
--
ALTER TABLE `deliveries`
ADD CONSTRAINT `deliveries_books` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`);

--
-- Restriktioner för tabell `sales`
--
ALTER TABLE `sales`
ADD CONSTRAINT `sales_books` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
