CREATE TABLE `codes` (
	`code` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`type` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`amount` INT(11) NOT NULL,
	`status` INT(11) NULL DEFAULT '0',
	`madeby` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`usedby` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci'
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
