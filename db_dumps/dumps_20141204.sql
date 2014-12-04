-- phpMyAdmin SQL Dump
-- version 4.2.0
-- http://www.phpmyadmin.net
--
-- Värd: localhost
-- Tid vid skapande: 04 dec 2014 kl 14:41
-- Serverversion: 5.6.17
-- PHP-version: 5.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databas: `bookstore7`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `authors`
--

CREATE TABLE IF NOT EXISTS `authors` (
`author_id` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumpning av Data i tabell `authors`
--

INSERT INTO `authors` (`author_id`, `firstname`, `lastname`) VALUES
(3, 'fdsoijsdfjio', 'fssodisdfjio'),
(4, 'sdohshdfho', 'ssodfhisdf'),
(5, 'sdohshdfho', 'ssodfhisdf');

-- --------------------------------------------------------

--
-- Tabellstruktur `books`
--

CREATE TABLE IF NOT EXISTS `books` (
  `isbn` bigint(13) NOT NULL DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `book_author_id` int(11) DEFAULT NULL,
  `shelf_id` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `books`
--

INSERT INTO `books` (`isbn`, `title`, `description`, `book_author_id`, `shelf_id`) VALUES
(1234567890123, 'sfoso', 'sfdho', 4, 'H2');

-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `books_with_authors`
--
CREATE TABLE IF NOT EXISTS `books_with_authors` (
`isbn` bigint(13)
,`title` varchar(255)
,`shelf_id` varchar(2)
,`author_firstname` varchar(255)
,`author_lastname` varchar(255)
,`description` text
);
-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `current_prices`
--
CREATE TABLE IF NOT EXISTS `current_prices` (
`isbn` bigint(13)
,`price` bigint(11)
);
-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `current_prices_with_vat`
--
CREATE TABLE IF NOT EXISTS `current_prices_with_vat` (
`isbn` bigint(13)
,`price` bigint(11)
,`price_with_vat` decimal(22,2)
);
-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `delivered_and_sold`
--
CREATE TABLE IF NOT EXISTS `delivered_and_sold` (
`isbn` bigint(13)
,`delivered` decimal(32,0)
,`sold` decimal(32,0)
);
-- --------------------------------------------------------

--
-- Tabellstruktur `deliveries`
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
-- Ersättningsstruktur för vy `deliveries_avg_costs`
--
CREATE TABLE IF NOT EXISTS `deliveries_avg_costs` (
`delivery_id` int(11)
,`isbn` bigint(13)
,`quantity` int(11)
,`delivery_date` timestamp
,`f_price` int(11)
,`cost` bigint(21)
,`sum_quantity` decimal(32,0)
,`sum_cost` decimal(42,0)
,`avg_cost_per_book` decimal(46,4)
);
-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `deliveries_costs`
--
CREATE TABLE IF NOT EXISTS `deliveries_costs` (
`delivery_id` int(11)
,`isbn` bigint(13)
,`quantity` int(11)
,`delivery_date` timestamp
,`f_price` int(11)
,`cost` bigint(21)
);
-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `deliveries_summed`
--
CREATE TABLE IF NOT EXISTS `deliveries_summed` (
`delivery_id` int(11)
,`isbn` bigint(13)
,`quantity` int(11)
,`delivery_date` timestamp
,`f_price` int(11)
,`cost` bigint(21)
,`sum_quantity` decimal(32,0)
,`sum_cost` decimal(42,0)
);
-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `in_stock`
--
CREATE TABLE IF NOT EXISTS `in_stock` (
`isbn` bigint(13)
,`delivered` decimal(32,0)
,`sold` decimal(32,0)
,`in_stock` decimal(33,0)
);
-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `in_stock_verbose`
--
CREATE TABLE IF NOT EXISTS `in_stock_verbose` (
`isbn` bigint(13)
,`delivered` decimal(32,0)
,`sold` decimal(32,0)
,`in_stock` decimal(33,0)
,`title` varchar(255)
,`shelf_id` varchar(2)
,`author_firstname` varchar(255)
,`author_lastname` varchar(255)
,`description` text
);
-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `in_stock_verbose_with_current_prices`
--
CREATE TABLE IF NOT EXISTS `in_stock_verbose_with_current_prices` (
`isbn` bigint(13)
,`price` bigint(11)
,`price_with_vat` decimal(22,2)
,`delivered` decimal(32,0)
,`sold` decimal(32,0)
,`in_stock` decimal(33,0)
,`title` varchar(255)
,`shelf_id` varchar(2)
,`author_firstname` varchar(255)
,`author_lastname` varchar(255)
,`description` text
);
-- --------------------------------------------------------

--
-- Tabellstruktur `price_history`
--

CREATE TABLE IF NOT EXISTS `price_history` (
`price_id` int(11) NOT NULL,
  `isbn` bigint(13) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `change_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellstruktur `sales`
--

CREATE TABLE IF NOT EXISTS `sales` (
`sale_id` int(11) NOT NULL,
  `isbn` bigint(13) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `sale_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `sales_with_prices`
--
CREATE TABLE IF NOT EXISTS `sales_with_prices` (
`sale_id` int(11)
,`isbn` bigint(13)
,`quantity` int(11)
,`sale_date` timestamp
,`selling_price` bigint(11)
,`avg_f_price` decimal(45,2)
);
-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `sales_with_vat_and_profits`
--
CREATE TABLE IF NOT EXISTS `sales_with_vat_and_profits` (
`sale_id` int(11)
,`isbn` bigint(13)
,`quantity` int(11)
,`sale_date` timestamp
,`selling_pric_inc_vat` decimal(22,2)
,`vat` decimal(22,2)
,`selling_price` bigint(11)
,`avg_f_price` decimal(45,2)
,`profit` decimal(56,2)
);
-- --------------------------------------------------------

--
-- Tabellstruktur `shelves`
--

CREATE TABLE IF NOT EXISTS `shelves` (
  `shelf_id` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `shelves`
--

INSERT INTO `shelves` (`shelf_id`) VALUES
('H2');

-- --------------------------------------------------------

--
-- Struktur för vy `books_with_authors`
--
DROP TABLE IF EXISTS `books_with_authors`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `books_with_authors` AS select `books`.`isbn` AS `isbn`,`books`.`title` AS `title`,`books`.`shelf_id` AS `shelf_id`,`authors`.`firstname` AS `author_firstname`,`authors`.`lastname` AS `author_lastname`,`books`.`description` AS `description` from (`books` join `authors`) where (`books`.`book_author_id` = `authors`.`author_id`);

-- --------------------------------------------------------

--
-- Struktur för vy `current_prices`
--
DROP TABLE IF EXISTS `current_prices`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `current_prices` AS select `books`.`isbn` AS `isbn`,(select `price_history`.`price` from `price_history` where (`price_history`.`isbn` = `books`.`isbn`) order by `price_history`.`change_date` desc limit 1) AS `price` from `books`;

-- --------------------------------------------------------

--
-- Struktur för vy `current_prices_with_vat`
--
DROP TABLE IF EXISTS `current_prices_with_vat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `current_prices_with_vat` AS select `current_prices`.`isbn` AS `isbn`,`current_prices`.`price` AS `price`,round((`current_prices`.`price` * 1.06),2) AS `price_with_vat` from `current_prices`;

-- --------------------------------------------------------

--
-- Struktur för vy `delivered_and_sold`
--
DROP TABLE IF EXISTS `delivered_and_sold`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `delivered_and_sold` AS select `books`.`isbn` AS `isbn`,(select sum(`deliveries`.`quantity`) from `deliveries` where (`deliveries`.`isbn` = `books`.`isbn`)) AS `delivered`,(select sum(`sales`.`quantity`) from `sales` where (`sales`.`isbn` = `books`.`isbn`)) AS `sold` from `books`;

-- --------------------------------------------------------

--
-- Struktur för vy `deliveries_avg_costs`
--
DROP TABLE IF EXISTS `deliveries_avg_costs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `deliveries_avg_costs` AS select `deliveries_summed`.`delivery_id` AS `delivery_id`,`deliveries_summed`.`isbn` AS `isbn`,`deliveries_summed`.`quantity` AS `quantity`,`deliveries_summed`.`delivery_date` AS `delivery_date`,`deliveries_summed`.`f_price` AS `f_price`,`deliveries_summed`.`cost` AS `cost`,`deliveries_summed`.`sum_quantity` AS `sum_quantity`,`deliveries_summed`.`sum_cost` AS `sum_cost`,(`deliveries_summed`.`sum_cost` / `deliveries_summed`.`sum_quantity`) AS `avg_cost_per_book` from `deliveries_summed`;

-- --------------------------------------------------------

--
-- Struktur för vy `deliveries_costs`
--
DROP TABLE IF EXISTS `deliveries_costs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `deliveries_costs` AS select `deliveries`.`delivery_id` AS `delivery_id`,`deliveries`.`isbn` AS `isbn`,`deliveries`.`quantity` AS `quantity`,`deliveries`.`delivery_date` AS `delivery_date`,`deliveries`.`f_price` AS `f_price`,(`deliveries`.`f_price` * `deliveries`.`quantity`) AS `cost` from `deliveries`;

-- --------------------------------------------------------

--
-- Struktur för vy `deliveries_summed`
--
DROP TABLE IF EXISTS `deliveries_summed`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `deliveries_summed` AS select `t`.`delivery_id` AS `delivery_id`,`t`.`isbn` AS `isbn`,`t`.`quantity` AS `quantity`,`t`.`delivery_date` AS `delivery_date`,`t`.`f_price` AS `f_price`,`t`.`cost` AS `cost`,(select sum(`deliveries_costs`.`quantity`) from `deliveries_costs` where ((`deliveries_costs`.`isbn` = `t`.`isbn`) and (`deliveries_costs`.`delivery_date` <= `t`.`delivery_date`))) AS `sum_quantity`,(select sum(`deliveries_costs`.`cost`) from `deliveries_costs` where ((`deliveries_costs`.`isbn` = `t`.`isbn`) and (`deliveries_costs`.`delivery_date` <= `t`.`delivery_date`))) AS `sum_cost` from `deliveries_costs` `t` order by `t`.`isbn`,`t`.`delivery_date`;

-- --------------------------------------------------------

--
-- Struktur för vy `in_stock`
--
DROP TABLE IF EXISTS `in_stock`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `in_stock` AS select `delivered_and_sold`.`isbn` AS `isbn`,`delivered_and_sold`.`delivered` AS `delivered`,`delivered_and_sold`.`sold` AS `sold`,(`delivered_and_sold`.`delivered` - `delivered_and_sold`.`sold`) AS `in_stock` from `delivered_and_sold`;

-- --------------------------------------------------------

--
-- Struktur för vy `in_stock_verbose`
--
DROP TABLE IF EXISTS `in_stock_verbose`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `in_stock_verbose` AS select `in_stock`.`isbn` AS `isbn`,`in_stock`.`delivered` AS `delivered`,`in_stock`.`sold` AS `sold`,`in_stock`.`in_stock` AS `in_stock`,`books_with_authors`.`title` AS `title`,`books_with_authors`.`shelf_id` AS `shelf_id`,`books_with_authors`.`author_firstname` AS `author_firstname`,`books_with_authors`.`author_lastname` AS `author_lastname`,`books_with_authors`.`description` AS `description` from (`in_stock` join `books_with_authors` on((`in_stock`.`isbn` = `books_with_authors`.`isbn`)));

-- --------------------------------------------------------

--
-- Struktur för vy `in_stock_verbose_with_current_prices`
--
DROP TABLE IF EXISTS `in_stock_verbose_with_current_prices`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `in_stock_verbose_with_current_prices` AS select `current_prices_with_vat`.`isbn` AS `isbn`,`current_prices_with_vat`.`price` AS `price`,`current_prices_with_vat`.`price_with_vat` AS `price_with_vat`,`in_stock_verbose`.`delivered` AS `delivered`,`in_stock_verbose`.`sold` AS `sold`,`in_stock_verbose`.`in_stock` AS `in_stock`,`in_stock_verbose`.`title` AS `title`,`in_stock_verbose`.`shelf_id` AS `shelf_id`,`in_stock_verbose`.`author_firstname` AS `author_firstname`,`in_stock_verbose`.`author_lastname` AS `author_lastname`,`in_stock_verbose`.`description` AS `description` from (`current_prices_with_vat` join `in_stock_verbose` on((`current_prices_with_vat`.`isbn` = `in_stock_verbose`.`isbn`)));

-- --------------------------------------------------------

--
-- Struktur för vy `sales_with_prices`
--
DROP TABLE IF EXISTS `sales_with_prices`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sales_with_prices` AS select `sales`.`sale_id` AS `sale_id`,`sales`.`isbn` AS `isbn`,`sales`.`quantity` AS `quantity`,`sales`.`sale_date` AS `sale_date`,(select `price_history`.`price` from `price_history` where ((`price_history`.`isbn` = `sales`.`isbn`) and (`price_history`.`change_date` <= `sales`.`sale_date`)) order by `price_history`.`change_date` desc limit 1) AS `selling_price`,round((select `deliveries_avg_costs`.`avg_cost_per_book` from `deliveries_avg_costs` where ((`deliveries_avg_costs`.`isbn` = `sales`.`isbn`) and (`deliveries_avg_costs`.`delivery_date` <= `sales`.`sale_date`)) order by `deliveries_avg_costs`.`delivery_date` desc limit 1),2) AS `avg_f_price` from `sales` order by `sales`.`isbn`;

-- --------------------------------------------------------

--
-- Struktur för vy `sales_with_vat_and_profits`
--
DROP TABLE IF EXISTS `sales_with_vat_and_profits`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sales_with_vat_and_profits` AS select `sales_with_prices`.`sale_id` AS `sale_id`,`sales_with_prices`.`isbn` AS `isbn`,`sales_with_prices`.`quantity` AS `quantity`,`sales_with_prices`.`sale_date` AS `sale_date`,round((`sales_with_prices`.`selling_price` * 1.06),2) AS `selling_pric_inc_vat`,round((`sales_with_prices`.`selling_price` * 0.06),2) AS `vat`,`sales_with_prices`.`selling_price` AS `selling_price`,`sales_with_prices`.`avg_f_price` AS `avg_f_price`,((`sales_with_prices`.`selling_price` - `sales_with_prices`.`avg_f_price`) * `sales_with_prices`.`quantity`) AS `profit` from `sales_with_prices`;

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `authors`
--
ALTER TABLE `authors`
 ADD PRIMARY KEY (`author_id`);

--
-- Index för tabell `books`
--
ALTER TABLE `books`
 ADD PRIMARY KEY (`isbn`), ADD UNIQUE KEY `isbn` (`isbn`), ADD KEY `book_author_id` (`book_author_id`), ADD KEY `shelf_id` (`shelf_id`);

--
-- Index för tabell `deliveries`
--
ALTER TABLE `deliveries`
 ADD PRIMARY KEY (`delivery_id`), ADD KEY `isbn` (`isbn`);

--
-- Index för tabell `price_history`
--
ALTER TABLE `price_history`
 ADD PRIMARY KEY (`price_id`), ADD KEY `isbn` (`isbn`);

--
-- Index för tabell `sales`
--
ALTER TABLE `sales`
 ADD PRIMARY KEY (`sale_id`), ADD KEY `isbn` (`isbn`);

--
-- Index för tabell `shelves`
--
ALTER TABLE `shelves`
 ADD PRIMARY KEY (`shelf_id`), ADD UNIQUE KEY `shelf_id` (`shelf_id`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `authors`
--
ALTER TABLE `authors`
MODIFY `author_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT för tabell `deliveries`
--
ALTER TABLE `deliveries`
MODIFY `delivery_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `price_history`
--
ALTER TABLE `price_history`
MODIFY `price_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `sales`
--
ALTER TABLE `sales`
MODIFY `sale_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `books`
--
ALTER TABLE `books`
ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`book_author_id`) REFERENCES `authors` (`author_id`),
ADD CONSTRAINT `books_ibfk_2` FOREIGN KEY (`shelf_id`) REFERENCES `shelves` (`shelf_id`);

--
-- Restriktioner för tabell `deliveries`
--
ALTER TABLE `deliveries`
ADD CONSTRAINT `deliveries_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`);

--
-- Restriktioner för tabell `price_history`
--
ALTER TABLE `price_history`
ADD CONSTRAINT `price_history_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`);

--
-- Restriktioner för tabell `sales`
--
ALTER TABLE `sales`
ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
