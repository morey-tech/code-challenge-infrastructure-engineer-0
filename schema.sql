CREATE TABLE `user` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`first_name` VARCHAR CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
	`last_name` VARCHAR CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
	`email` VARCHAR CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
	PRIMARY KEY (`id`)
);