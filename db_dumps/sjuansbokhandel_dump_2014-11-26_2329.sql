-- phpMyAdmin SQL Dump
-- version 4.2.8
-- http://www.phpmyadmin.net
--
-- Värd: localhost
-- Tid vid skapande: 26 nov 2014 kl 22:28
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

--
-- Dumpning av Data i tabell `books`
--

INSERT INTO `books` (`isbn`, `title`, `author`) VALUES
(9780132350884, 'Clean Code', 'Robert C. Martin'),
(9781292018232, 'Java Software Solutions: Global Edition', 'John Lewis'),
(9789187301834, 'Generation 64 : Commodore 64 gjorde mig till den jag är', 'Jimmy Wilhelmsson');

-- --------------------------------------------------------

--
-- Tabellstruktur `books_prices`
--

CREATE TABLE IF NOT EXISTS `books_prices` (
`id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isbn` bigint(13) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `books_prices`
--

INSERT INTO `books_prices` (`id`, `price`, `date`, `isbn`) VALUES
(1, '238.00', '2014-11-26 21:49:00', 9780132350884),
(2, '704.00', '2014-11-26 21:50:00', 9781292018232),
(3, '267.00', '2014-11-26 21:51:00', 9789187301834);

-- --------------------------------------------------------

--
-- Tabellstruktur `book_shelfs`
--

CREATE TABLE IF NOT EXISTS `book_shelfs` (
  `isbn` bigint(13) NOT NULL,
  `shelfs_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `book_shelfs`
--

INSERT INTO `book_shelfs` (`isbn`, `shelfs_id`) VALUES
(9780132350884, 1),
(9781292018232, 2),
(9789187301834, 3);

-- --------------------------------------------------------

--
-- Tabellstruktur `deliveries`
--

CREATE TABLE IF NOT EXISTS `deliveries` (
`id` int(11) NOT NULL,
  `f_price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isbn` bigint(13) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `deliveries`
--

INSERT INTO `deliveries` (`id`, `f_price`, `quantity`, `date`, `isbn`) VALUES
(1, '132.00', 200, '2014-11-26 21:48:00', 9780132350884),
(2, '391.00', 200, '2014-11-26 21:48:00', 9781292018232),
(3, '148.00', 200, '2014-11-26 21:48:00', 9789187301834);

-- --------------------------------------------------------

--
-- Tabellstruktur `sales`
--

CREATE TABLE IF NOT EXISTS `sales` (
`id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `date` date NOT NULL,
  `isbn` bigint(13) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `sales`
--

INSERT INTO `sales` (`id`, `quantity`, `date`, `isbn`) VALUES
(1, 20, '2014-11-27', 9780132350884),
(2, 1, '2014-11-27', 9780132350884),
(3, 10, '2014-11-27', 9781292018232),
(4, 2, '2014-11-27', 9781292018232),
(5, 15, '2014-11-27', 9789187301834);

-- --------------------------------------------------------

--
-- Tabellstruktur `shelfs`
--

CREATE TABLE IF NOT EXISTS `shelfs` (
`id` int(11) NOT NULL,
  `code` char(1) NOT NULL,
  `number` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `shelfs`
--

INSERT INTO `shelfs` (`id`, `code`, `number`) VALUES
(1, 'A', 1),
(2, 'A', 2),
(3, 'A', 3);

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
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT för tabell `deliveries`
--
ALTER TABLE `deliveries`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT för tabell `sales`
--
ALTER TABLE `sales`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT för tabell `shelfs`
--
ALTER TABLE `shelfs`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
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
