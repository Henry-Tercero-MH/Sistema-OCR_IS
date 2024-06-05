-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-05-2024 a las 07:07:14
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `farmacia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `brands`
--

CREATE TABLE `brands` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(255) NOT NULL,
  `brand_active` int(11) NOT NULL DEFAULT 0,
  `brand_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `brands`
--

INSERT INTO `brands` (`brand_id`, `brand_name`, `brand_active`, `brand_status`) VALUES
(1, 'Cipla', 1, 2),
(2, 'Mankind', 1, 2),
(3, 'Sunpharma', 1, 2),
(4, 'MicroLabs', 1, 1),
(5, 'Pfizer', 1, 1),
(6, 'SELECPHARMA', 1, 1),
(7, 'Alifarmat', 1, 1),
(8, 'Infasa', 1, 1),
(9, 'Pharmalat', 1, 1),
(10, 'Mediproducts', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `categories_id` int(11) NOT NULL,
  `categories_name` varchar(255) NOT NULL,
  `categories_active` int(11) NOT NULL DEFAULT 0,
  `categories_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`categories_id`, `categories_name`, `categories_active`, `categories_status`) VALUES
(1, 'Tabletas', 1, 1),
(2, 'Jarabe', 1, 1),
(3, 'Inyecciones', 1, 1),
(4, 'Bebibles', 1, 1),
(5, 'Capsulas', 1, 1),
(6, 'Suspensión', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE `orders` (
  `id` int(15) NOT NULL,
  `uno` varchar(50) NOT NULL,
  `orderDate` date NOT NULL,
  `clientName` text NOT NULL,
  `projectName` varchar(30) NOT NULL,
  `clientContact` int(15) NOT NULL,
  `address` varchar(30) NOT NULL,
  `subTotal` int(100) NOT NULL,
  `totalAmount` int(100) NOT NULL,
  `discount` int(100) NOT NULL,
  `grandTotalValue` int(100) NOT NULL,
  `gstn` int(100) NOT NULL,
  `paid` int(100) NOT NULL,
  `dueValue` int(100) NOT NULL,
  `paymentType` int(15) NOT NULL,
  `paymentStatus` int(15) NOT NULL,
  `paymentPlace` int(5) NOT NULL,
  `delete_status` tinyint(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orders`
--

INSERT INTO `orders` (`id`, `uno`, `orderDate`, `clientName`, `projectName`, `clientContact`, `address`, `subTotal`, `totalAmount`, `discount`, `grandTotalValue`, `gstn`, `paid`, `dueValue`, `paymentType`, `paymentStatus`, `paymentPlace`, `delete_status`) VALUES
(1, 'INV-0001', '2024-02-28', 'Lucho Florez', '', 2147483647, '', 100, 10, 108, 49, 0, 49, 49, 2, 1, 0, 0),
(2, 'INV-0002', '2024-03-24', 'Bernardo Galán', '', 2147483647, '', 300, 354, 354, 354, 18, 354, 354, 1, 1, 1, 0),
(3, 'INV-0003', '2024-04-15', 'Fredy Patricio', '', 2147483647, '', 860, 1015, 10, 1005, 155, 500, 505, 2, 2, 1, 0),
(4, 'INV-0004', '2024-04-15', 'Pedro Cliente', '', 2147483647, '', 60, 71, 0, 71, 11, 50, 21, 5, 2, 1, 0),
(5, 'INV-0005', '2024-05-01', 'Juan Cliente', '', 2147483647, '', 200, 236, 0, 236, 36, 300, -64, 2, 1, 1, 0),
(6, 'INV-0006', '2024-05-01', 'Eleazar Cifuentes', '', 2147483647, '', 250, 295, 0, 295, 45, 300, -5, 2, 1, 2, 0),
(7, 'INV-0007', '2024-05-03', 'Pedro García', '', 2147483647, '', 250, 295, 0, 295, 45, 300, -5, 2, 1, 1, 0),
(8, 'INV-0008', '2024-05-09', 'Gerson López', '', 2147483647, '', 100, 118, 10, 108, 18, 108, 0, 2, 1, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order_item`
--

CREATE TABLE `order_item` (
  `id` int(15) NOT NULL,
  `productName` int(100) NOT NULL,
  `quantity` varchar(255) NOT NULL,
  `rate` varchar(255) NOT NULL,
  `total` varchar(255) NOT NULL,
  `lastid` int(50) NOT NULL,
  `added_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `order_item`
--

INSERT INTO `order_item` (`id`, `productName`, `quantity`, `rate`, `total`, `lastid`, `added_date`) VALUES
(5, 2, '1', '100', '100.00', 1, '2024-05-11'),
(7, 1, '2', '30', '60.00', 3, '2024-04-15'),
(8, 2, '4', '150', '600.00', 3, '2024-04-15'),
(9, 3, '1', '200', '200.00', 3, '2024-04-15'),
(10, 1, '2', '30', '60.00', 4, '2024-04-15'),
(13, 2, '2', '150', '300.00', 2, '2024-04-15'),
(14, 3, '1', '200', '200.00', 5, '2024-05-01'),
(15, 5, '1', '250', '250.00', 6, '2024-05-01'),
(16, 5, '1', '250', '250.00', 7, '2024-05-03'),
(17, 6, '1', '100', '100.00', 8, '2024-05-09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_image` text NOT NULL,
  `brand_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL,
  `quantity` varchar(255) NOT NULL,
  `rate` varchar(255) NOT NULL,
  `mrp` int(100) NOT NULL,
  `bno` varchar(50) NOT NULL,
  `expdate` date NOT NULL,
  `added_date` date NOT NULL,
  `active` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `product_image`, `brand_id`, `categories_id`, `quantity`, `rate`, `mrp`, `bno`, `expdate`, `added_date`, `active`, `status`) VALUES
(1, 'ACETAMINOFEN TAB*500GR', 'tab.jpg', 1, 1, '50', 'Q.30', 40, '307002', '2045-02-28', '2024-02-28', 1, 1),
(2, 'FRONTA TAB*20GR', 'tab1.jpg', 2, 1, '30', 'Q.150', 200, '307003', '2024-02-16', '2025-02-28', 1, 1),
(3, 'RAPAZOL TAB*800GR', 'tab3.jpg', 2, 1, '70', 'Q.200', 250, '307004', '2026-03-13', '2024-02-28', 1, 1),
(4, 'ESCRIPV 450*10TABLETAS', 'tab4.jpg', 4, 1, '500', 'Q.25', 30, '307005', '2050-05-31', '2024-04-15', 1, 1),
(5, 'VACUNA PFIZER', 'vacuna pfizer.webp', 5, 6, '2500', 'Q.2000', 2500, '307006', '2031-06-18', '2024-05-01', 1, 1),
(6, 'FLAMYDOL 120ml', 'flamydol.jpg', 8, 2, '50', 'Q.100', 150, '307007', '2026-03-16', '2024-05-09', 1, 1),
(7, 'ACETAMINOFEN BEBES MK', '', 8, 6, '30', 'Q. 54', 60, '307008', '2026-06-26', '2024-05-05', 1, 1),
(8, 'ACETAMINOFEN MK NIÑOS1', '', 9, 2, '50', 'Q. 26', 30, '307008', '2026-05-25', '2024-05-26', 1, 1),
(9, 'ATICEF I.M. 0.5 GR * 1 AM', '', 4, 3, '50', 'Q.99', 100, '307010', '2028-06-16', '2024-05-24', 1, 1),
(10, 'ATICEF 1G * 1 AMP+1 VIAL', '', 4, 3, '60', 'Q.126', 150, '307011', '2026-05-25', '2024-04-15', 1, 1),
(11, 'ENANTYUM 25 MG * 10 COMPRI', '', 10, 2, '20', 'Q.179', 185, '307011', '2028-06-16', '2024-05-11', 1, 1),
(12, 'FILINAR G GEL 5MG/ML * 120 M', '', 9, 5, '50', 'Q.163', 175, '307012', '2026-05-25', '2024-05-26', 1, 1),
(13, 'OSTEOCARE SUSPENSION*20', '', 8, 6, '20', 'Q.131.2', 150, '307013', '2027-06-10', '2024-05-27', 1, 1),
(14, 'CEBION 100MG/ML SOLUCION', '', 10, 6, '20', 'Q56.20', 70, '307014', '2025-08-20', '2024-05-27', 1, 1),
(15, 'HIDRAVIDA MORA AZUL*625 M', '', 7, 4, '100', 'Q. 16.8', 18, '307015', '2026-05-15', '2024-05-27', 1, 1),
(16, 'HIDRAVIDA MARACUYA*625 M', '', 7, 4, '100', 'Q. 16.70', 19, '307016', '2025-05-14', '2024-05-27', 1, 1),
(17, 'SUERO PEDIALYTE SABOR CEREZA 500 ML', '', 7, 4, '100', 'Q.23', 24, '307017', '2025-05-20', '2024-05-27', 1, 1),
(18, 'SUERO PEDIAYTE SABOR MANZANA 500 ML', '', 7, 4, '100', 'Q.23', 24, '307018', '2025-05-14', '2024-05-27', 1, 1),
(19, 'SUERO PEDIALYTE SABOR UVA 500 ML', '', 7, 4, '100', 'Q.23', 24, '307019', '2025-05-14', '2024-05-27', 1, 1),
(20, 'SUERO PEDIALYTE SABOR FRESA 500 ML', '', 7, 4, '100', 'Q.23', 24, '307020', '2025-05-14', '2024-05-27', 1, 1),
(21, 'ENTEROLAN*60 ML SUSPENSION', '', 9, 6, '20', 'Q.44.80', 50, '307021', '2026-05-06', '2024-05-27', 1, 1),
(22, 'RABANO YODADO C/HIERRO * VITAMINA', '', 7, 2, '20', 'Q.28', 30, '307022', '2025-05-13', '2024-05-27', 1, 1),
(23, 'LAVERINA LAVERAN*360 ML ', '', 3, 2, '30', 'Q.35', 40, '307023', '2025-05-08', '2024-05-27', 1, 1),
(24, 'PULMICORT 0.50*5 AMPOLLAS', '', 6, 3, '10', 'Q.235', 250, '307024', '2026-05-06', '2024-05-27', 1, 1),
(25, 'PREDNICET 15 15MG/5ML*100', '', 7, 4, '20', 'Q.175', 180, '307025', '2025-05-15', '2024-05-27', 1, 1),
(26, 'ENTEROLAN*60 ML SUSPENSION', '', 10, 6, '20', 'Q. 44.80', 48, '307026', '2025-05-27', '2024-05-27', 1, 1),
(27, 'RABANO YODADO C/HIERRO * VITAMINA', '', 2, 2, '20', 'Q. 28.90', 30, '307027', '2025-05-26', '2024-05-26', 1, 1),
(28, 'LAVERINA LAVERAN*360 ML ', '', 4, 4, '20', 'Q. 35', 40, '307028', '2025-05-26', '2024-05-18', 1, 1),
(29, 'PULMICORT 0.50*5 AMPOLLAS', '', 8, 3, '50', 'Q. 235.75', 240, '307029', '2027-05-25', '2024-05-20', 1, 1),
(30, 'PREDNICET 15 15MG/5ML*100', '', 6, 6, '', 'Q. 175.60', 180, '307030', '2026-05-18', '2024-05-19', 1, 1),
(31, 'AEROVAN SP IPRAK 750 KIT P', '', 4, 6, '10', 'Q. 317.30', 350, '307031', '2026-05-20', '2024-05-27', 1, 1),
(32, 'NAN 2 OPTIPRO HMO LATA*36', '', 8, 6, '20', 'Q. 90.90', 105, '307032', '2026-05-12', '2024-05-01', 1, 1),
(33, 'NAN 1 OPTIPRO HMO LATA*36', '', 0, 0, '', 'Q. 94', 100, '307033', '2026-05-12', '2024-05-27', 1, 1),
(34, 'GLUCERNA VAINILLA 237 ML Beb', '', 8, 4, '10', 'Q. 38.45', 42, '307034', '2026-05-13', '2024-05-27', 1, 1),
(35, 'PEDIASURE PLUS TRIPLE VAIN', '', 7, 6, '10', 'Q. 391', 402, '307035', '2025-05-05', '2024-05-27', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`) VALUES
(1, 'Admin1', '751cb3f4aa17c36186f4856c8982bf27', 'hola@configura.com');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brand_id`);

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categories_id`);

--
-- Indices de la tabla `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `categories_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `order_item`
--
ALTER TABLE `order_item`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
