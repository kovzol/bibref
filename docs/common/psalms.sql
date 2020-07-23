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

insert into authors (name, info) values ('Paul', 'Paul the Apostle');
insert into authors (name, info) values ('Matthew', 'Matthew the Apostle');
insert into authors (name, info) values ('Luke', 'Luke the Evangelist');
insert into authors (name, info) values ('Peter', 'Peter the Apostle');
insert into authors (name, info) values ('John', 'John the Apostle');
insert into authors (name, info) values ('Mark', 'Mark the Evangelist');
insert into authors (name, info) values ('Unknown', 'Author of Hebrews');

insert into found_methods (name, info) values ('traditional', 'known by tradition');
insert into found_methods (name, info) values ('getrefs', 'found by the getrefs algorithm');
insert into found_methods (name, info) values ('manual', 'confirmed manually');

insert into books (name, author, info) values ('Romans', 'Paul', 'Epistle to the Romans');
insert into books (name, author, info) values ('Hebrews', 'Unknown', 'Epistle to the Hebrews');
insert into books (name, author, info) values ('Acts', 'Luke', 'Acts of the Apostles');

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
