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

create table quotations_properties (
 quotation_ot_id int not null,
 quotation_nt_id int not null,
 source_given text,
 as_it_is_written text);

create table classifications (
 name text not null primary key,
 info text);

create table classification_subtypes (
 name text not null primary key,
 info text);

create table quotations_classifications (
 quotation_ot_id int not null,
 quotation_nt_id int not null,
 classification text,
 classification_subtype text,
 classified_by text);

insert into authors (name, info) values ('Matthew', 'Matthew the Apostle');
insert into authors (name, info) values ('Mark', 'Mark the Evangelist');
insert into authors (name, info) values ('Luke', 'Luke the Evangelist');
insert into authors (name, info) values ('John', 'John the Apostle');
insert into authors (name, info) values ('Paul', 'Paul the Apostle');
insert into authors (name, info) values ('Peter', 'Peter the Apostle');
insert into authors (name, info) values ('Unknown', 'Author of Hebrews');

insert into found_methods (name, info) values ('traditional', 'known by tradition');
insert into found_methods (name, info) values ('getrefs', 'found by the getrefs algorithm');
insert into found_methods (name, info) values ('manual', 'confirmed manually (with understanding of Greek)');
insert into found_methods (name, info) values ('manual-mechanical', 'confirmed manually (with no understanding of Greek)');

insert into books (name, author, info) values ('Matthew', 'Matthew', 'Gospel of Matthew');
insert into books (name, author, info) values ('Luke', 'Luke', 'Gospel of Luke');
insert into books (name, author, info) values ('Acts', 'Luke', 'Acts of the Apostles');
insert into books (name, author, info) values ('Romans', 'Paul', 'Epistle to the Romans');
insert into books (name, author, info) values ('Ephesians', 'Paul', 'Epistle to the Ephesians');
insert into books (name, author, info) values ('Hebrews', 'Unknown', 'Epistle to the Hebrews');
insert into books (name, author, info) values ('Revelation_of_John', 'John', 'Revelation of John');

insert into classifications (name, info) values ('quotation', 'direct reference given');
insert into classifications (name, info) values ('secondary quotation', 'direct reference given, but not longest match');
-- See Sung Kuk Kim: Psalms in the book of Revelation (PhD thesis, Univ. of Edinburgh, 2013), p. 12
insert into classifications (name, info) values ('strong allusion', 'textual affinity: clear, contextual affinity: clear');
insert into classifications (name, info) values ('probable allusion', 'textual affinity: less clear, contextual affinity: clear');
insert into classifications (name, info) values ('possible allusion', 'textual affinity: less clear, contextual affinity: less clear');
insert into classifications (name, info) values ('influence', 'textual affinity: found, contextual affinity: not clear');

insert into classification_subtypes (name, info) values ('exact', 'full literal match');
insert into classification_subtypes (name, info) values ('literal', 'full or almost full literal match');
insert into classification_subtypes (name, info) values ('superset', 'NT text is a superset of the OT text');
insert into classification_subtypes (name, info) values ('subset', 'NT text is a subset of the OT text');
-- The entries are given as a comma separated list. This could be improved.

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1, 1, 2, 'Psalms 2:1-2', 'Acts', 'Acts 4:25-26', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1, 1, 2, 'LXX Psalms 2:1 2:2-8', 'Acts', 'SBLGNT Acts 4:25+54 4:26', 501, 131, 11592, 131, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1, 1, 2, 'LXX Psalms 2:1 2:2-8', 'Acts', 'SBLGNT Acts 4:25+54 4:26', 501, 131, 11592, 131, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1, 1, 'Δαυιδ', 'ειπων'); -- ειπων = having spoken
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1, 1, 'quotation', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 1, 2, 'Psalms 2:7', 'Acts', 'Acts 13:33', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 1, 2, 'LXX Psalms 2:7+44 2:7', 'Acts', 'SBLGNT Acts 13:33+88 13:33', 921, 32, 43844, 32, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 1, 2, 'LXX Psalms 2:7+44 2:7', 'Acts', 'SBLGNT Acts 13:33+88 13:33', 921, 32, 43844, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2, 1, 'εν τω ψαλμω ... τω δευτερω', 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2, 1, 'quotation', 'exact, literal', 'Z.K.');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 2, 2, 'Psalms 2:7', 'Hebrews', 'Hebrews 1:5', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 2, 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 1:5+26 1:5-53', 921, 32, 432, 32, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 2, 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 1:5+26 1:5-53', 921, 32, 432, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2, 2, null, 'ειπεν'); -- ειπεν = did He say
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2, 2, 'quotation', 'exact, literal', 'Z.K.');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 3, 2, 'Psalms 2:7', 'Hebrews', 'Hebrews 5:5', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 3, 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 5:5+70 5:5', 921, 32, 6283, 32, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 3, 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 5:5+70 5:5', 921, 32, 6283, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2, 3, null, 'λαλησας'); -- λαλησας = having said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2, 3, 'quotation', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 1, 2, 'Psalms 2:9', 'Revelation_of_John', 'Revelation_of_John 2:27', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 1, 2, 'LXX Psalms 2:9+9 2:9-30', 'Revelation_of_John', 'SBLGNT Revelation_of_John 2:27+11 2:27-28', 1040, 21, 4778, 21, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 1, 2, 'LXX Psalms 2:9 2:9-6', 'Revelation_of_John', 'SBLGNT Revelation_of_John 2:27+3 2:27', 1031, 54, 4769, 57, 'manual');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 1, 2, 'LXX Psalms 2:9 2:9-10', 'Revelation_of_John', 'SBLGNT Revelation_of_John 2:27+3 2:27-5', 1031, 50, 4769, 52, 'manual-mechanical');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classified_by) values
 (3, 1, 'strong allusion', 'Sung Kuk Kim');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3, 1, 'strong allusion', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 2, 2, 'Psalms 2:9', 'Revelation_of_John', 'Revelation_of_John 12:5', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 2, 2, 'LXX Psalms 2:9+15 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 12:5+47 12:5-55', 1046, 13, 22310, 13, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 2, 2, 'LXX Psalms 2:9 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 12:5+26 12:5-55', 1031, 28, 22289, 34, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3, 2, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classified_by) values
 (3, 2, 'strong allusion', 'Sung Kuk Kim');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3, 2, 'strong allusion', 'literal, subset', 'Z.K.');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 3, 2, 'Psalms 2:9', 'Revelation_of_John', 'Revelation_of_John 19:15', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 3, 2, 'LXX Psalms 2:9+9 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 19:15+81 19:15-68', 1040, 19, 38365, 19, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 3, 2, 'LXX Psalms 2:9 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 19:15+73 19:15-68', 1031, 28, 38357, 27, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3, 3, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classified_by) values
 (3, 3, 'strong allusion', 'Sung Kuk Kim');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3, 3, 'strong allusion', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4, 1, 4, 'Psalms 4:4', 'Ephesians', 'Ephesians 4:26', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4, 1, 4, 'LXX Psalms 4:4 4:4-63', 'Ephesians', 'SBLGNT Ephesians 4:26 4:26-33', 2163, 24, 7323, 24, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4, 1, 4, 'LXX Psalms 4:4 4:4-63', 'Ephesians', 'SBLGNT Ephesians 4:26 4:26-33', 2163, 24, 7323, 24, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (4, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (4, 1, 'strong allusion', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (5, 1, 5, 'Psalms 5:9', 'Romans', 'Romans 3:13', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (5, 1, 5, 'LXX Psalms 5:9+52 5:9', 'Romans', 'SBLGNT Romans 3:13 3:13-25', 3173, 54, 10992, 54, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (5, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written (in Romans 3:10)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (5, 1, 'secondary quotation', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (6, 1, 6, 'LXX Psalms 6:8 6:8-64', 'Luke', 'SBLGNT Luke 13:27+32 13:27-14', 3985, 20, 56625, 20, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (6, 1, 6, 'LXX Psalms 6:8 6:8-64', 'Luke', 'SBLGNT Luke 13:27+32 13:27-14', 3985, 20, 56625, 20, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (6, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (6, 1, 'possible allusion', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (7, 1, 8, 'Psalms 8:2', 'Matthew', 'Matthew 21:16', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (7, 1, 8, 'LXX Psalms 8:2 8:2-47', 'Matthew', 'SBLGNT Matthew 21:16+76 21:16', 5606, 43, 60218, 43, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (7, 1, 8, 'LXX Psalms 8:2 8:2-47', 'Matthew', 'SBLGNT Matthew 21:16+76 21:16', 5606, 43, 60218, 43, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (7, 1, null, 'ουδεποτε ανεγνωτε'); -- ουδεποτε ανεγνωτε = did you never read
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (7, 1, 'quotation', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (8, 1, 8, 'Psalms 8:4-6', 'Hebrews', 'Hebrews 2:6-8', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (8, 1, 8, 'LXX Psalms 8:4 8:5', 'Hebrews', 'SBLGNT Hebrews 2:6+25 2:7', 5766, 120, 1770, 120, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (8, 1, 8, 'LXX Psalms 8:6+39 8:6', 'Hebrews', 'SBLGNT Hebrews 2:8 2:8-84', 5925, 33, 1890, 33, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (8, 1, 8, 'LXX Psalms 8:4 8:6', 'Hebrews', 'SBLGNT Hebrews 2:6+25 2:8-84', 5766, 192, 1770, 120+33, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (8, 1, 'που τις', 'λεγων'); -- που τις = somewhere someone, λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (8, 1, 'quotation', 'superset', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (9, 1, 10, 'Psalms 10:7', 'Romans', 'Romans 3:14', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (9, 1, 10, 'LXX Psalms 10:7+2 10:7-39', 'Romans', 'SBLGNT Romans 3:14+2 3:14', 8070, 31, 5977, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (9, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written (in Romans 3:10)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (9, 1, 'secondary quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10, 1, 14, 'Psalms 14:2-3', 'Romans', 'Romans 3:11-18', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10, 1, 14, 'LXX Psalms 14:2+71 14:4-100', 'Romans', 'SBLGNT Romans 3:11+24 3:19-91', 10911, 318, 5816, 318, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10, 1, 14, 'LXX Psalms 14:2+59 14:3', 'Romans', 'SBLGNT Romans 3:11+3 3:18', 10900, 329, 5795, 339, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (10, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written (in Romans 3:10)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (10, 1, 'quotation', 'subset, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 1, 16, 'Psalms 16:8-11', 'Acts', 'Acts 2:25-28', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 1, 16, 'LXX Psalms 16:8+4 16:11-31', 'Acts', 'SBLGNT Acts 2:25+25 2:28', 12496, 282, 4837, 282, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 1, 16, 'LXX Psalms 16:8 16:11-31', 'Acts', 'SBLGNT Acts 2:25+21 2:28', 12492, 286, 4833, 286, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (11, 1, 'Δαυιδ', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (11, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 2, 16, 'Psalms 16:10', 'Acts', 'Acts 13:35', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 2, 16, 'LXX Psalms 16:10+41 16:10', 'Acts', 'SBLGNT Acts 13:35+22 13:35', 12687, 31, 44003, 31, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 2, 16, 'LXX Psalms 16:10+37 16:10', 'Acts', 'SBLGNT Acts 13:35+20 13:35', 12683, 35, 44001, 33, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (11, 2, 'εν ετερω ... Δαυιδ', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (11, 2, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (12, 1, 18, 'Psalms 18:49', 'Romans', 'Romans 15:9', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (12, 1, 18, 'LXX Psalms 18:49 18:49-25', 'Romans', 'SBLGNT Romans 15:9+46 15:9-19', 17409, 33, 30160, 33, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (12, 1, 18, 'LXX Psalms 18:49+39 18:49', 'Romans', 'SBLGNT Romans 15:9+79 15:9', 17448, 19, 30193, 19, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (12, 1, 18, 'LXX Psalms 18:49', 'Romans', 'SBLGNT Romans 15:9+46', 17409, 58, 30160, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (12, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (12, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13, 1, 19, 'Psalms 19:4', 'Romans', 'Romans 10:18', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13, 1, 19, 'LXX Psalms 19:4 19:4-27', 'Romans', 'SBLGNT Romans 10:18+28 10:18', 17756, 74, 21811, 74, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13, 1, 19, 'LXX Psalms 19:4 19:4-27', 'Romans', 'SBLGNT Romans 10:18+28 10:18', 17756, 74, 21811, 74, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (13, 1, null, 'μενουνγε'); -- μενουνγε = indeed
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (13, 1, 'quotation', 'literal', 'Z.K.');
