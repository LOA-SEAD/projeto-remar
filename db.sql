create database if not exists forca;
grant all on forca.* to 'forca'@'localhost' identified by 'forca';
grant select on remar.user to 'forca'@'localhost';
grant select on remar.role to 'forca'@'localhost';
grant select on remar.user_role to 'forca'@'localhost';	

create database if not exists mathjong;
grant all on mathjong.* to 'mathjong'@'localhost' identified by 'mathjong';
grant select on remar.user to 'mathjong'@'localhost';
grant select on remar.role to 'mathjong'@'localhost';
grant select on remar.user_role to 'mathjong'@'localhost';

create database if not exists escolamagica;
grant all on escolamagica.* to 'escolamagica'@'localhost' identified by 'escolamagica';
grant select on remar.user to 'escolamagica'@'localhost';
grant select on remar.role to 'escolamagica'@'localhost';
grant select on remar.user_role to 'escolamagica'@'localhost';

