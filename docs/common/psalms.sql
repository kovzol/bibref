create table authors (
 name text not null primary key,
 info text);

create table books (
 name text not null primary key,
 author text,
 info text);

create table found_methods (
 name text not null primary key,
 info text);

create table quotations (
 ot_id int not null,
 nt_id int not null,
 psalm int not null,
 ot_passage text not null,
 nt_book text not null,
 nt_passage text not null,
 ot_startpos int,
 ot_length int,
 nt_startpos int,
 nt_length int,
 found_method text);

insert into authors (name, info) values ('Matthew', 'Matthew the Apostle');
insert into authors (name, info) values ('Mark', 'Mark the Evangelist');
insert into authors (name, info) values ('Luke', 'Luke the Evangelist');
insert into authors (name, info) values ('John', 'John the Apostle');
insert into authors (name, info) values ('Paul', 'Paul the Apostle');
insert into authors (name, info) values ('Peter', 'Peter the Apostle');
insert into authors (name, info) values ('Unknown', 'Author of Hebrews');

insert into found_methods (name, info) values ('traditional', 'known by tradition');
insert into found_methods (name, info) values ('getrefs', 'found by the getrefs algorithm');
insert into found_methods (name, info) values ('manual', 'confirmed manually');

insert into books (name, author, info) values ('Matthew', 'Matthew', 'Gospel of Matthew');
insert into books (name, author, info) values ('Luke', 'Luke', 'Gospel of Luke');
insert into books (name, author, info) values ('Acts', 'Luke', 'Acts of the Apostles');
insert into books (name, author, info) values ('Romans', 'Paul', 'Epistle to the Romans');
insert into books (name, author, info) values ('Ephesians', 'Paul', 'Epistle to the Ephesians');
insert into books (name, author, info) values ('Hebrews', 'Unknown', 'Epistle to the Hebrews');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1, 1, 2, 'Psalms 2:1-2', 'Acts', 'Acts 4:25-26', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1, 1, 2, 'LXX Psalms 2:1 2:2-8', 'Acts', 'SBLGNT Acts 4:25+54 4:26', 501, 131, null, 131, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1, 1, 2, 'LXX Psalms 2:1 2:2-8', 'Acts', 'SBLGNT Acts 4:25+54 4:26', 501, 131, null, 131, 'manual');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 1, 2, 'Psalms 2:7', 'Acts', 'Acts 13:33', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 1, 2, 'LXX Psalms 2:7+44 2:7', 'Acts', 'SBLGNT Acts 13:33+83 13:33', 921, 32, null, 32, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 1, 2, 'LXX Psalms 2:7+44 2:7', 'Acts', 'SBLGNT Acts 13:33+83 13:33', 921, 32, null, 32, 'manual');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 2, 2, 'Psalms 2:7', 'Hebrews', 'Hebrews 1:5', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 2, 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 1:5+26 1:5-53', 921, 32, null, 32, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 2, 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 1:5+26 1:5-53', 921, 32, null, 32, 'manual');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 3, 2, 'Psalms 2:7', 'Hebrews', 'Hebrews 5:5', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 3, 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 5:5+70 5:5', 921, 32, null, 32, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 3, 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 5:5+70 5:5', 921, 32, null, 32, 'manual');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 1, 4, 'Psalms 4:4', 'Ephesians', 'Ephesians 4:26', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 1, 4, 'LXX Psalms 4:4 4:4-63', 'Ephesians', 'SBLGNT Ephesians 4:26 4:26-33', 2163, 24, null, 24, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 1, 4, 'LXX Psalms 4:4 4:4-63', 'Ephesians', 'SBLGNT Ephesians 4:26 4:26-33', 2163, 24, null, 24, 'manual');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4, 1, 6, 'LXX Psalms 6:8 6:8-64', 'Luke', 'SBLGNT Luke 13:27+32 13:27-14', 3985, 20, null, 20, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4, 1, 6, 'LXX Psalms 6:8 6:8-64', 'Luke', 'SBLGNT Luke 13:27+32 13:27-14', 3985, 20, null, 20, 'manual');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (5, 1, 8, 'Psalms 8:2', 'Matthew', 'Matthew 21:16', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (5, 1, 8, 'LXX Psalms 8:2 8:2-47', 'Matthew', 'SBLGNT Matthew 21:16+76 21:16', 5606, 43, null, 43, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (5, 1, 8, 'LXX Psalms 8:2 8:2-47', 'Matthew', 'SBLGNT Matthew 21:16+76 21:16', 5606, 43, null, 43, 'manual');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (6, 1, 8, 'Psalms 8:4-6', 'Hebrews', 'Hebrews 2:6-8', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (6, 1, 8, 'LXX Psalms 8:4 8:5', 'Hebrews', 'SBLGNT Hebrews 2:6+25 2:7', 5766, 120, null, 120, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (6, 1, 8, 'LXX Psalms 8:6+39 8:6', 'Hebrews', 'SBLGNT Hebrews 2:8 2:8-84', 5925, 33, null, 33, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (6, 1, 8, 'LXX Psalms 8:4 8:6', 'Hebrews', 'SBLGNT Hebrews 2:6+25 2:8-84', 5766, 192, null, 120+33, 'manual');
