CREATE TABLE `test_users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL default '',
  `country` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`)
);

INSERT INTO `test_users` VALUES (1,'John','USA');
INSERT INTO `test_users` VALUES (2,'Mark','Canada');
INSERT INTO `test_users` VALUES (3,'Lukas','Germany');
INSERT INTO `test_users` VALUES (4,'Ingrid','Sweden');