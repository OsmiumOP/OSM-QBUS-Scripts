USE `brp`;

CREATE TABLE `invest` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) COLLATE utf8mb4_bin NOT NULL,
  `amount` float NOT NULL,
  `rate` float NOT NULL,
  `job` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sold` datetime DEFAULT NULL,
  `soldAmount` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

ALTER TABLE `invest`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `invest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;COMMIT;


CREATE TABLE `companies` (
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `investRate` float DEFAULT NULL,
  `rate` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT 'stale'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `companies` (`name`, `label`, `investRate`, `rate`) VALUES
('24/7', 'TNYFVN', NULL, 'stale'),
('Ammu-Nation', 'AMNA', NULL, 'stale'),
('Augury Insurance', 'AUGIN', NULL, 'stale'),
('Downtown Cab Co.', 'DCC', NULL, 'stale'),
('ECola', 'ECLA', NULL, 'stale'),
('Fleeca', 'FLCA', NULL, 'stale'),
('Globe Oil', 'GLBO', NULL, 'stale'),
('GoPostal', 'GPSTL', NULL, 'stale'),
('Lifeinvader', 'LIVDR', NULL, 'stale'),
('Los Santos Air', 'LSA', NULL, 'stale'),
('Los Santos Customs', 'LSC', NULL, 'stale'),
('Los Santos Transit', 'LST', NULL, 'stale'),
('Maze Bank', 'MBANK', NULL, 'stale'),
('Post OP', 'PSTP', NULL, 'stale'),
('RON', 'RON', NULL, 'stale'),
('Up-n-Atom Burger', 'UNAB', NULL, 'stale'),
('Weazel', 'NEWS', NULL, 'stale');

ALTER TABLE `companies`
  ADD PRIMARY KEY (`name`);
COMMIT;