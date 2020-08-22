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
insert into books (name, author, info) values ('Mark', 'Mark', 'Gospel of Mark');
insert into books (name, author, info) values ('Luke', 'Luke', 'Gospel of Luke');
insert into books (name, author, info) values ('John', 'John', 'Gospel of John');
insert into books (name, author, info) values ('Acts', 'Luke', 'Acts of the Apostles');
insert into books (name, author, info) values ('Romans', 'Paul', 'Epistle to the Romans');
insert into books (name, author, info) values ('I_Corinthians', 'Paul', 'First Epistle to the Corinthians');
insert into books (name, author, info) values ('Ephesians', 'Paul', 'Epistle to the Ephesians');
insert into books (name, author, info) values ('Hebrews', 'Unknown', 'Epistle to the Hebrews');
insert into books (name, author, info) values ('I_Peter', 'Peter', 'First Epistle of Peter');
insert into books (name, author, info) values ('Revelation_of_John', 'John', 'Revelation of John');

insert into classifications (name, info) values ('quotation', 'direct reference given');
-- Quotations are claimed if and only if there is a direct mentioning of an OT quotation in the NT part.
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
insert into classification_subtypes (name, info) values ('synonym', 'some parts are changed to synonyms');
insert into classification_subtypes (name, info) values ('fuzzy', 'fuzzy match');
insert into classification_subtypes (name, info) values ('far-fuzzy', 'fuzzy match that cannot be identified easily');
insert into classification_subtypes (name, info) values ('change', 'some parts are changed to have different meaning');
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

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 1, 22, 'Psalms 22:18', 'Matthew', 'Matthew 27:35', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 1, 22, 'LXX Psalms 22:18 22:18-43', 'Matthew', 'SBLGNT Matthew 27:35+19 27:35-20', 21363, 20, 85881, 20, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 1, 22, 'LXX Psalms 22:18 22:18', 'Matthew', 'SBLGNT Matthew 27:35+19 27:35', 21363, 63, 85881, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (14, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (14, 1, 'strong allusion', 'literal, superset', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 2, 22, 'Psalms 22:18', 'John', 'John 19:24', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 2, 22, 'LXX Psalms 22:18', 'John', 'SBLGNT John 19:24+88 19:24-31', 21363, 63, 63431, 63, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 2, 22, 'LXX Psalms 22:18', 'John', 'SBLGNT John 19:24+88 19:24-31', 21363, 63, 63431, 63, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (14, 2, null, 'τινος εσται ινα η γραφη πληρωθη η λεγουσα'); -- τινος εσται ινα η γραφη πληρωθη η λεγουσα = whose it shall be: that the scripture might be fulfilled, which saith (KJV)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (14, 2, 'quotation', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (15, 1, 22, 'Psalms 22:22', 'Hebrews', 'Hebrews 2:12', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (15, 1, 22, 'Psalms 22:22+10 22:22', 'Hebrews', 'SBLGNT Hebrews 2:12+13 2:12', 21616, 48, 2353, 48, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (15, 1, 22, 'Psalms 22:22+10 22:22', 'Hebrews', 'SBLGNT Hebrews 2:12+13 2:12', 21616, 48, 2353, 48, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (15, 1, null, 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (15, 1, 'quotation', 'exact, literal, synonym', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16, 1, 24, 'Psalms 24:1', 'I_Corinthians', 'I_Corinthians 10:26', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16, 1, 24, 'LXX Psalms 24:1+37 24:1-39', 'I_Corinthians', 'SBLGNT I_Corinthians 10:26+6 10:26', 23000, 20, 17817, 20, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16, 1, 24, 'LXX Psalms 24:1+28 24:1-39', 'I_Corinthians', 'SBLGNT I_Corinthians 10:26+6 10:26', 22992, 29, 17811, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (16, 1, null, 'γαρ'); -- γαρ = for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (16, 1, 'quotation', 'literal, subtext', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17, 1, 31, 'Psalms 31:5', 'Luke', 'Luke 23:46', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17, 1, 31, 'LXX Psalms 31:5 31:5-49', 'Luke', 'SBLGNT Luke 23:46+37 23:46-40', 29824, 16, 91002, 16, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17, 1, 31, 'LXX Psalms 31:5+20 31:5-31', 'Luke', 'SBLGNT Luke 23:46+57 23:46-22', 29844, 14, 91022, 14, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17, 1, 31, 'LXX Psalms 31:5 31:5-31', 'Luke', 'SBLGNT Luke 23:46+37 23:46-22', 29824, 34, 91002, 34, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (17, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (17, 1, 'strong allusion', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18, 1, 32, 'Psalms 31:1-2', 'Romans', 'Romans 4:7-8', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18, 1, 32, 'LXX Psalms 32:1+15 32:2-29', 'Romans', 'SBLGNT Romans 4:7 4:9-101', 31468, 97, 7493, 97, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18, 1, 32, 'LXX Psalms 32:1+15 32:2-30', 'Romans', 'SBLGNT Romans 4:7 4:8', 31468, 96, 7493, 96, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (18, 1, 'Δαυιδ', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (18, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (19, 1, 34, 'Psalms 34:8', 'I_Peter', 'I_Peter 2:3', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (19, 1, 34, 'LXX Psalms 34:8+15 34:8-28', 'I_Peter', 'SBLGNT I Peter 2:3+10 2:3', 34264, 18, 2366, 18, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (19, 1, 34, 'LXX Psalms 34:8 34:8-28', 'I_Peter', 'SBLGNT I Peter 2:3+3 2:3', 34250, 33, 2359, 25, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (19, 1, null, 'ει'); -- ει = if indeed
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (19, 1, 'strong allusion', 'literal, superset', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 34, 'Psalms 34:12-16', 'I_Peter', 'I_Peter 3:10-12', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 34, 'LXX Psalms 34:12+17 34:12-19', 'I_Peter', 'SBLGNT I_Peter 3:10+4 3:10-72', 34528, 13, 5207, 13, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 34, 'LXX Psalms 34:12+43 34:13-51', 'I_Peter', 'SBLGNT I_Peter 3:10+33 3:10-46', 34554, 10, 5236, 10, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 34, 'LXX Psalms 34:13+19 34:13-20', 'I_Peter', 'SBLGNT I_Peter 3:10+56 3:10-17', 34579, 16, 5259, 16, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 34, 'LXX Psalms 34:13+38 34:14-54', 'I_Peter', 'SBLGNT I_Peter 3:10+72 3:11-60', 34598, 23, 5275, 23, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 34, 'LXX Psalms 34:14+26 34:14-23', 'I_Peter', 'SBLGNT I_Peter 3:11+30 3:11-25', 34641, 11, 5322, 11, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 34, 'LXX Psalms 34:14+39 34:14-7', 'I_Peter', 'SBLGNT I_Peter 3:11+44 3:11-8', 34654, 14, 5336, 14, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 34, 'LXX Psalms 34:15 34:16-37', 'I_Peter', 'SBLGNT I_Peter 3:12+3 3:12', 34675, 82, 5361, 82, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 34, 'LXX Psalms 34:12+17 34:16-37', 'I_Peter', 'SBLGNT I_Peter 3:10+4 3:12', 34529, 229, 5207, 236, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (20, 1, null, 'ο γαρ'); -- ο γαρ = the one for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (20, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 40, 'Psalms 40:6-8', 'Hebrews', 'Hebrews 10:5-7', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 40, 'LXX Psalms 40:6 40:6-52', 'Hebrews', 'SBLGNT Hebrews 10:5+32 10:5-18', 44125, 29, 15576, 29, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 40, 'LXX Psalms 40:6+32 40:6-24', 'Hebrews', 'SBLGNT Hebrews 10:5+64 10:6-29', 44157, 25, 15608, 25, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 40, 'LXX Psalms 40:6+56 40:6-6', 'Hebrews', 'SBLGNT Hebrews 10:6+11 10:6-9', 44181, 19, 15634, 19, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 40, 'LXX Psalms 40:6+77 40:8-61', 'Hebrews', 'SBLGNT Hebrews 10:6+35 10:7-16', 44202, 64, 15656, 64, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 40, 'LXX Psalms 40:6 40:8-45', 'Hebrews', 'SBLGNT Hebrews 10:5+32 10:7', 44125, 157, 15576, 162, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (21, 1, null, 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (21, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 2, 40, 'Psalms 40:6', 'Hebrews', 'Hebrews 10:8', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 2, 40, 'LXX Psalms 40:6+6 40:6-64', 'Hebrews', 'SBLGNT Hebrews 10:8+16 10:8-83', 44131, 11, 15754, 11, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 2, 40, 'LXX Psalms 40:6+56 40:6-5', 'Hebrews', 'SBLGNT Hebrews 10:8+42 10:8-48', 44181, 20, 15780, 20, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 2, 40, 'LXX Psalms 40:6', 'Hebrews', 'SBLGNT Hebrews 10:8+16 10:8-41', 44131, 81, 15780, 59, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (21, 2, null, 'ανωτερον λεγων οτι'); -- ανωτερον λεγων οτι = above saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (21, 2, 'quotation', 'literal, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 3, 40, 'Psalms 40:7-8', 'Hebrews', 'Hebrews 10:9', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 3, 40, 'LXX Psalms 40:7+8 40:7-34', 'Hebrews', 'SBLGNT Hebrews 10:9+10 10:9-54', 44214, 8, 15864, 8, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 3, 40, 'LXX Psalms 40:8 40:8-50', 'Hebrews', 'SBLGNT Hebrews 10:9+18 10:9-33', 44256, 21, 15872, 21, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 3, 40, 'LXX Psalms 40:7+9 40:8-50', 'Hebrews', 'SBLGNT Hebrews 10:9+11 10:9-33', 44256, 62, 15865, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (21, 3, null, 'τοτε ειρηκεν'); -- τοτε ειρηκεν = then he said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (21, 3, 'quotation', 'literal, superset', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22, 1, 41, 'Psalms 41:9', 'John', 'John 13:18', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22, 1, 41, 'LXX Psalms 41:9+45 41:9-5', 'John', 'SBLGNT John 13:18+68 13:18-7', 45860, 29, 46586, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (22, 1, null, 'αλλ ινα η γραφη πληρωθη'); -- αλλ ινα η γραφη πληρωθη = but the Scripture may be fulfilled
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (22, 1, 'quotation', 'far-fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (23, 1, 44, 'Psalms 44:22', 'Romans', 'Romans 8:36', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (23, 1, 44, 'LXX Psalms 44:22+8 44:22', 'Romans', 'SBLGNT Romans 8:36+23 8:36', 49276, 53, 17863, 53, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (23, 1, 44, 'LXX Psalms 44:22', 'Romans', 'SBLGNT Romans 8:36+14 8:36', 49268, 61, 17854, 62, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (23, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (23, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 45, 'Psalms 45:6', 'Hebrews', 'Hebrews 1:8', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 45, 'LXX Psalms 45:6 45:6-37', 'Hebrews', 'SBLGNT Hebrews 1:8+13 1:8-43', 50076, 35, 713, 35, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 45, 'LXX Psalms 45:6+50 45:6-12', 'Hebrews', 'SBLGNT Hebrews 1:8+51 1:8-30', 50126, 10, 751, 10, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 45, 'LXX Psalms 45:6+40 45:6-22', 'Hebrews', 'SBLGNT Hebrews 1:8+60 1:8-21', 50116, 10, 760, 10, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 45, 'LXX Psalms 45:6+51 45:7', 'Hebrews', 'SBLGNT Hebrews 1:8+70 1:9', 50127, 124, 770, 124, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 45, 'LXX Psalms 45:6 45:7', 'Hebrews', 'SBLGNT Hebrews 1:8+13 1:9', 50076, 175, 713, 181, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (24, 1, null, 'λεγει ... προς δε τον υιον'); -- λεγει ... προς δε τον υιον =  He says ... unto however the Son
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (24, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (25, 1, 51, 'Psalms 51:4', 'Romans', 'Romans 3:4', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (25, 1, 51, 'LXX Psalms 51:4+43 51:4-17', 'Romans', 'SBLGNT Romans 3:4+63 3:4-18', 56556, 38, 5291, 38, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (25, 1, 51, 'LXX Psalms 51:4+82 51:4', 'Romans', 'SBLGNT Romans 3:4+103 3:4', 56595, 16, 5331, 16, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (25, 1, 51, 'LXX Psalms 51:4+43 51:4', 'Romans', 'SBLGNT Romans 3:4+63 3:4', 56556, 55, 5291, 56, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (25, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (25, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (26, 1, 68, 'Psalms 68:18', 'Ephesians', 'Ephesians 4:8', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (26, 1, 68, 'LXX Psalms 68:18+5 68:18-86', 'Ephesians', 'SBLGNT Ephesians 4:8+13 4:8-38', 73401, 18, 5810, 18, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (26, 1, 68, 'LXX Psalms 68:18 68:18-52', 'Ephesians', 'SBLGNT Ephesians 4:8+8 4:8', 73397, 57, 5805, 61, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (26, 1, null, 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (26, 1, 'quotation', 'fuzzy, change', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (27, 1, 69, 'Psalms 69:9a', 'John', 'John 2:17', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (27, 1, 69, 'LXX Psalms 69:9+3 69:9-53', 'John', 'SBLGNT John 2:17+43 2:17-10', 75406, 20, 5178, 20, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (27, 1, 69, 'LXX Psalms 69:9+3 69:9-45', 'John', 'SBLGNT John 2:17+43 2:17', 75406, 28, 5178, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (27, 1, null, 'γεγραμμενον εστιν'); -- γεγραμμενον εστιν = written it is
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (27, 1, 'quotation', 'literal, fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (28, 1, 69, 'Psalms 69:9b', 'Romans', 'Romans 15:3', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (28, 1, 69, 'LXX Psalms 69:9+32 69:9', 'Romans', 'SBLGNT Romans 15:3+44 15:3', 75435, 44, 29642, 44, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (28, 1, 69, 'LXX Psalms 69:9+34 69:9', 'Romans', 'SBLGNT Romans 15:3+46 15:3', 75437, 42, 29644, 42, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (28, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (28, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 69, 'Psalms 69:22-23', 'Romans', 'Romans 11:9-10', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 69, 'LXX Psalms 69:22 69:22-52', 'Romans', 'SBLGNT Romans 11:9+13 11:9-56', 76385, 22, 22819, 22, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 69, 'LXX Psalms 69:22+28 69:22-26', 'Romans', 'SBLGNT Romans 11:9+29 11:9-42', 76413, 20, 22835, 20, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 69, 'LXX Psalms 69:22+58 69:22', 'Romans', 'SBLGNT Romans 11:9+53 11:9-22', 76443, 16, 22859, 16, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 69, 'LXX Psalms 69:22+42 69:22-18', 'Romans', 'SBLGNT Romans 11:9+69 11:9-8', 76427, 14, 22875, 14, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 69, 'LXX Psalms 69:23', 'Romans', 'SBLGNT Romans 11:10', 76459, 74, 22897, 74, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 69, 'LXX Psalms 69:22 69:23', 'Romans', 'SBLGNT Romans 11:9+13 11:10', 76385, 148, 22819, 152, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (29, 1, 'Δαυιδ', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (29, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (30, 1, 69, 'Psalms 69:25', 'Acts', 'Acts 1:20', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (30, 1, 69, 'LXX Psalms 69:25 69:25-50', 'Acts', 'SBLGNT Acts 1:20+25 1:20-64', 76593, 19, 2050, 19, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (30, 1, 69, 'LXX Psalms 69:25+54 69:25', 'Acts', 'SBLGNT Acts 1:20+55 1:20-38', 76647, 15, 2080, 15, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (30, 1, 69, 'LXX Psalms 69:25', 'Acts', 'SBLGNT Acts 1:20+25 1:20-38', 76593, 69, 2050, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (30, 1, 'εν βιβλω ψαλμων', 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (30, 1, 'quotation', 'literal, superset', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31, 1, 78, 'Psalms 78:2', 'Matthew', 'Matthew 13:35', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31, 1, 78, 'LXX Psalms 78:2 78:2-26', 'Matthew', 'SBLGNT Matthew 13:35+40 13:35-31', 87283, 28, 37391, 28, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31, 1, 78, 'LXX Psalms 78:2 78:2-26', 'Matthew', 'SBLGNT Matthew 13:35+40 13:35-31', 87283, 28, 37391, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (31, 1, 'προφητου', 'ρηθεν ... λεγοντος'); -- ρηθεν ... λεγοντος = having been spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (31, 1, 'quotation', 'literal, exact', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (32, 1, 82, 'Psalms 78:2', 'John', 'John 10:34', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (32, 1, 82, 'LXX Psalms 82:6 82:6-20', 'John', 'SBLGNT John 10:34+55 10:34', 96136, 15, 36114, 15, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (32, 1, 82, 'LXX Psalms 82:6 82:6-20', 'John', 'SBLGNT John 10:34+55 10:34', 96136, 15, 36114, 15, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (32, 1, 'εν τω νομω υμων', 'γεγραμμενον'); -- εν τω νομω υμων = in the law of you, γεγραμμενον = written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (32, 1, 'quotation', 'literal, exact', 'Z.K.');

insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 1, 91, 'Psalms 91:11-12', 'Matthew', 'Matthew 4:6', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 1, 91, 'LXX Psalms 91:11 91:11-35', 'Matthew', 'SBLGNT Matthew 4:6+54 4:6-55', 107355, 37, 6566, 37, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 1, 91, 'LXX Psalms 91:12 91:13-59', 'Matthew', 'SBLGNT Matthew 4:6+94 4:7-57', 107427, 53, 6606, 53, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 1, 91, 'LXX Psalms 91:11 91:12', 'Matthew', 'SBLGNT Matthew 4:6+54 4:6', 107355, 124, 6566, 92, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (33, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (33, 1, 'quotation', 'literal, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 2, 91, 'Psalms 91:11-12', 'Luke', 'Luke 4:10-11', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 2, 91, 'LXX Psalms 91:11 91:11-20', 'Luke', 'SBLGNT Luke 4:10+12 4:10', 107355, 52, 13761, 52, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 2, 91, 'LXX Psalms 91:12 91:12', 'Luke', 'SBLGNT Luke 4:11+6 4:11', 107427, 52, 13819, 52, 'getrefs');
insert into quotations (ot_id, nt_id, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 2, 91, 'LXX Psalms 91:11 91:12', 'Luke', 'SBLGNT Luke 4:10+12 4:11', 107355, 124, 13761, 110, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (33, 2, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (33, 2, 'quotation', 'literal, superset', 'Z.K.');
