-Tarea 2, emails-

-primero hacemos la tabla emails

create table hero_emails (
nombres varchar(100),
email varchar(100));


insert into hero_emails (nombres, email) values 
('Wanda Maximoff',	'wanda.maximoff@avengers.org'),
('Pietro Maximoff',	'pietro@mail.sokovia.ru'),
('Erik Lensherr',	'fuck_you_charles@brotherhood.of.evil.mutants.space'),
('Charles Xavier',	'i.am.secretely.filled.with.hubris@xavier-school-4-gifted-youngste.'),
('Anthony Edward Stark',	'iamironman@avengers.gov'),
('Steve Rogers',	'americas_ass@anti_avengers'),
('The Vision',	'vis@westview.sword.gov'),
('Clint Barton',	'bul@lse.ye'),
('Natasja Romanov',	'blackwidow@kgb.ru'),
('Thor',	'god_of_thunder-^_^@royalty.asgard.gov'),
('Logan',	'wolverine@cyclops_is_a_jerk.com'),
('Ororo Monroe',	'ororo@weather.co'),
('Scott Summers',	'o@x'),
('Nathan Summers',	'cable@xfact.or'),
('Groot',	'iamgroot@asgardiansofthegalaxyledbythor.quillsux'),
('Nebula',	'idonthaveelektras@complex.thanos'),
('Gamora',	'thefiercestwomaninthegalaxy@thanos.'),
('Rocket',	'shhhhhhhh@darknet.ru');


select nombres, email from hero_emails h where h.email not like '%_@%_.%_';

-implica que debe haber una estuctura tipo algo@algo.algo-