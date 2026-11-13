-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Ноя 13 2026 г., 13:51
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `online_school`
--

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `active_enrollments`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `active_enrollments` (
`full_name` varchar(150)
,`course_name` varchar(150)
,`payment_date` date
,`status` varchar(50)
);

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Программирование'),
(2, 'Дизайн');

-- --------------------------------------------------------

--
-- Структура таблицы `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(150) NOT NULL,
  `duration_months` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `courses`
--

INSERT INTO `courses` (`course_id`, `course_name`, `duration_months`, `price`, `category_id`, `teacher_id`) VALUES
(1, 'Базы данных и SQL', 3, 25000.00, 1, 1),
(2, 'Веб-дизайн в Figma', 2, 18000.00, 2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `enrollments`
--

CREATE TABLE `enrollments` (
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `payment_date` date NOT NULL,
  `status` varchar(50) DEFAULT 'Новый'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `enrollments`
--

INSERT INTO `enrollments` (`student_id`, `course_id`, `payment_date`, `status`) VALUES
(1, 1, '2026-10-01', 'Оплачено'),
(1, 2, '2026-11-13', 'Оплачено'),
(2, 2, '2026-10-05', 'Оплачено');

-- --------------------------------------------------------

--
-- Структура таблицы `lessons`
--

CREATE TABLE `lessons` (
  `lesson_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `lesson_order` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `is_live_webinar` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `lessons`
--

INSERT INTO `lessons` (`lesson_id`, `course_id`, `lesson_order`, `title`, `video_url`, `is_live_webinar`) VALUES
(1, 1, 1, 'Введение в реляционные БД', NULL, 0),
(2, 1, 2, 'Основы оператора SELECT', NULL, 0),
(3, 2, 1, 'Знакомство с интерфейсом Figma', NULL, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `progress`
--

CREATE TABLE `progress` (
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `grade` varchar(20) DEFAULT 'Не сдано',
  `commentary` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `progress`
--

INSERT INTO `progress` (`student_id`, `course_id`, `lesson_id`, `grade`, `commentary`) VALUES
(1, 1, 1, 'Отлично', 'Задание выполнено полностью без ошибок!');

-- --------------------------------------------------------

--
-- Структура таблицы `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `birth_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `students`
--

INSERT INTO `students` (`student_id`, `full_name`, `email`, `phone`, `birth_date`) VALUES
(1, 'Алексей Петров', 'alex@mail.ru', '+79991112233', '2001-05-15'),
(2, 'Мария Сидорова', 'maria@yandex.ru', '+79994445566', '2002-11-23');

-- --------------------------------------------------------

--
-- Структура таблицы `teachers`
--

CREATE TABLE `teachers` (
  `teacher_id` int(11) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(100) NOT NULL,
  `specialization` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `teachers`
--

INSERT INTO `teachers` (`teacher_id`, `full_name`, `email`, `specialization`) VALUES
(1, 'Иван Иванов', 'ivan@school.ru', 'Python & SQL');

-- --------------------------------------------------------

--
-- Структура для представления `active_enrollments`
--
DROP TABLE IF EXISTS `active_enrollments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `active_enrollments`  AS SELECT `students`.`full_name` AS `full_name`, `courses`.`course_name` AS `course_name`, `enrollments`.`payment_date` AS `payment_date`, `enrollments`.`status` AS `status` FROM ((`enrollments` join `students` on(`enrollments`.`student_id` = `students`.`student_id`)) join `courses` on(`enrollments`.`course_id` = `courses`.`course_id`)) ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Индексы таблицы `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `fk_course_category` (`category_id`),
  ADD KEY `fk_course_teacher` (`teacher_id`),
  ADD KEY `idx_course_name` (`course_name`);

--
-- Индексы таблицы `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`student_id`,`course_id`),
  ADD KEY `fk_enroll_course` (`course_id`);

--
-- Индексы таблицы `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`lesson_id`),
  ADD KEY `fk_lesson_course` (`course_id`);

--
-- Индексы таблицы `progress`
--
ALTER TABLE `progress`
  ADD PRIMARY KEY (`student_id`,`course_id`,`lesson_id`),
  ADD KEY `fk_progress_lesson` (`lesson_id`);

--
-- Индексы таблицы `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Индексы таблицы `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacher_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `lessons`
--
ALTER TABLE `lessons`
  MODIFY `lesson_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `teachers`
--
ALTER TABLE `teachers`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `fk_course_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `fk_course_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`);

--
-- Ограничения внешнего ключа таблицы `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `fk_enroll_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  ADD CONSTRAINT `fk_enroll_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

--
-- Ограничения внешнего ключа таблицы `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `fk_lesson_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

--
-- Ограничения внешнего ключа таблицы `progress`
--
ALTER TABLE `progress`
  ADD CONSTRAINT `fk_progress_enroll` FOREIGN KEY (`student_id`,`course_id`) REFERENCES `enrollments` (`student_id`, `course_id`),
  ADD CONSTRAINT `fk_progress_lesson` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`lesson_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
