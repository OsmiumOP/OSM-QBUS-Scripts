ALTER TABLE `player_vehicles` ADD `finance_owed` INT(255) NULL DEFAULT 0;
ALTER TABLE `player_vehicles` ADD `finperc` INT(255) NULL DEFAULT NULL;
ALTER TABLE `players` ADD `pending_finance` INT(255) NULL DEFAULT 0;