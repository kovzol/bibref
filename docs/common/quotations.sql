create table authors (
 name text not null primary key,
 info text);

create table books (
 name text not null primary key,
 author text,
 info text,
 number int unique);

create table found_methods (
 name text not null primary key,
 info text);

create table quotations (
 ot_id int not null,
 nt_id int not null,
 ot_book text not null,
 psalm int,
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

insert into authors (name, info) values ('Moses', 'Moses');
insert into authors (name, info) values ('Job', 'Job');
insert into authors (name, info) values ('Isaiah', 'Isaiah');
insert into authors (name, info) values ('Jeremiah', 'Jeremiah');
insert into authors (name, info) values ('Ezekiel', 'Ezekiel');
insert into authors (name, info) values ('Joel', 'Joel');
insert into authors (name, info) values ('Amos', 'Amos');
insert into authors (name, info) values ('Hosea', 'Hosea');
insert into authors (name, info) values ('Micah', 'Micah');
insert into authors (name, info) values ('Habakkuk', 'Habakkuk');
insert into authors (name, info) values ('Haggai', 'Haggai');
insert into authors (name, info) values ('Various', 'Authors of Psalms');
insert into authors (name, info) values ('Malachi', 'Malachi');
insert into authors (name, info) values ('Zechariah', 'Zechariah');
insert into authors (name, info) values ('Samuel', 'Samuel');
insert into authors (name, info) values ('Solomon', 'King Solomon');

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

insert into books (name, author, info, number) values ('Genesis', 'Moses', 'Book of Genesis', 1);
insert into books (name, author, info, number) values ('Exodus', 'Moses', 'Book of Exodus', 2);
insert into books (name, author, info, number) values ('Leviticus', 'Moses', 'Book of Leviticus', 3);
insert into books (name, author, info, number) values ('Numbers', 'Moses', 'Book of Numbers', 4);
insert into books (name, author, info, number) values ('Deuteronomy', 'Moses', 'Book of Deuteronomy', 5);
insert into books (name, author, info, number) values ('II_Samuel', 'Samuel', 'The Second Book of Samuel', 10);
insert into books (name, author, info, number) values ('I_Kings', 'Samuel', 'The First Book of Kings', 11);
insert into books (name, author, info, number) values ('Job', 'Job', 'Book of Job', 18);
insert into books (name, author, info, number) values ('Psalms', 'Various', 'Book of Psalms', 19);
insert into books (name, author, info, number) values ('Proverbs', 'Solomon', 'Book of Proverbs', 20);
insert into books (name, author, info, number) values ('Isaiah', 'Isaiah', 'Book of Isaiah', 23);
insert into books (name, author, info, number) values ('Jeremiah', 'Jeremiah', 'Book of Jeremiah', 24);
insert into books (name, author, info, number) values ('Ezekiel', 'Ezekiel', 'Book of Ezekiel', 25);
insert into books (name, author, info, number) values ('Hosea', 'Hosea', 'Book of Hosea', 28);
insert into books (name, author, info, number) values ('Joel', 'Joel', 'Book of Joel', 29);
insert into books (name, author, info, number) values ('Amos', 'Amos', 'Book of Amos', 30);
insert into books (name, author, info, number) values ('Micah', 'Micah', 'Book of Micah', 33);
insert into books (name, author, info, number) values ('Habakkuk', 'Habakkuk', 'Book of Habakkuk', 35);
insert into books (name, author, info, number) values ('Haggai', 'Haggai', 'Book of Haggai', 37);
insert into books (name, author, info, number) values ('Zechariah', 'Zechariah', 'Book of Zechariah', 38);
insert into books (name, author, info, number) values ('Malachi', 'Malachi', 'Book of Malachi', 39);

insert into books (name, author, info, number) values ('Matthew', 'Matthew', 'Gospel of Matthew', 101);
insert into books (name, author, info, number) values ('Mark', 'Mark', 'Gospel of Mark', 102);
insert into books (name, author, info, number) values ('Luke', 'Luke', 'Gospel of Luke', 103);
insert into books (name, author, info, number) values ('John', 'John', 'Gospel of John', 104);
insert into books (name, author, info, number) values ('Acts', 'Luke', 'Acts of the Apostles', 105);
insert into books (name, author, info, number) values ('Romans', 'Paul', 'Epistle to the Romans', 106);
insert into books (name, author, info, number) values ('I_Corinthians', 'Paul', 'First Epistle to the Corinthians', 107);
insert into books (name, author, info, number) values ('II_Corinthians', 'Paul', 'Second Epistle to the Corinthians', 108);
insert into books (name, author, info, number) values ('Galatians', 'Paul', 'Epistle to the Galatians', 109);
insert into books (name, author, info, number) values ('Ephesians', 'Paul', 'Epistle to the Ephesians', 110);
insert into books (name, author, info, number) values ('I_Timothy', 'Paul', 'First Epistle to Timothy', 115);
insert into books (name, author, info, number) values ('II_Timothy', 'Paul', 'Second Epistle to Timothy', 116);
insert into books (name, author, info, number) values ('Hebrews', 'Unknown', 'Epistle to the Hebrews', 119);
insert into books (name, author, info, number) values ('James', 'James', 'Epistle of James', 120);
insert into books (name, author, info, number) values ('I_Peter', 'Peter', 'First Epistle of Peter', 121);
insert into books (name, author, info, number) values ('II_Peter', 'Peter', 'Second Epistle of Peter', 122);
insert into books (name, author, info, number) values ('Revelation_of_John', 'John', 'Revelation of John', 127);

insert into classifications (name, info) values ('quotation', 'first quotation with a direct reference given');
insert into classifications (name, info) values ('repeated quotation', 'repetition of a former quotation with reference');
insert into classifications (name, info) values ('repetition', 'repetition of a former quotation without reference');
-- Quotations are claimed if and only if there is a direct mentioning of an OT quotation in the NT part.
insert into classifications (name, info) values ('secondary quotation', 'direct reference given, but not longest match');
-- See Sung Kuk Kim: Psalms in the book of Revelation (PhD thesis, Univ. of Edinburgh, 2013), p. 12
insert into classifications (name, info) values ('strong allusion', 'textual affinity: clear, contextual affinity: clear');
insert into classifications (name, info) values ('probable allusion', 'textual affinity: less clear, contextual affinity: clear');
insert into classifications (name, info) values ('possible allusion', 'textual affinity: less clear, contextual affinity: less clear');
insert into classifications (name, info) values ('influence', 'textual affinity: found, contextual affinity: not clear');

insert into classification_subtypes (name, info) values ('exact', 'full literal match');
insert into classification_subtypes (name, info) values ('literal', 'full or almost full literal match');
insert into classification_subtypes (name, info) values ('superset', 'OT text is a superset of the NT text');
insert into classification_subtypes (name, info) values ('subset', 'OT text is a subset of the NT text');
insert into classification_subtypes (name, info) values ('grammatical-change', 'some parts are changed to match the grammatical context');
insert into classification_subtypes (name, info) values ('synonym', 'some parts are changed to synonyms');
insert into classification_subtypes (name, info) values ('fuzzy', 'fuzzy match');
insert into classification_subtypes (name, info) values ('far-fuzzy', 'fuzzy match that cannot be identified easily');
insert into classification_subtypes (name, info) values ('change', 'some parts are changed to have different meaning');
insert into classification_subtypes (name, info) values ('in-quotation', 'the quotation is inserted in another quotation');
insert into classification_subtypes (name, info) values ('puzzle', 'a possible puzzle is hidden in the match');
-- The entries are given as a comma separated list. This could be improved.

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1, 1, 'Psalms', 2, 'Psalms 2:1-2', 'Acts', 'Acts 4:25-26', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1, 1, 'Psalms', 2, 'LXX Psalms 2:1 2:2-8', 'Acts', 'SBLGNT Acts 4:25+54 4:26', 501, 131, 11592, 131, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1, 1, 'Psalms', 2, 'LXX Psalms 2:1 2:2-8', 'Acts', 'SBLGNT Acts 4:25+54 4:26', 501, 131, 11592, 131, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1, 1, 'Δαυιδ', 'ειπων'); -- ειπων = having spoken
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1, 1, 'quotation', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 1, 'Psalms', 2, 'Psalms 2:7', 'Acts', 'Acts 13:33', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 1, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Acts', 'SBLGNT Acts 13:33+88 13:33', 921, 32, 43844, 32, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 1, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Acts', 'SBLGNT Acts 13:33+88 13:33', 921, 32, 43844, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2, 1, 'εν τω ψαλμω ... τω δευτερω', 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2, 1, 'quotation', 'exact, literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 2, 'Psalms', 2, 'Psalms 2:7', 'Hebrews', 'Hebrews 1:5', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 2, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 1:5+26 1:5-53', 921, 32, 432, 32, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 2, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 1:5+26 1:5-53', 921, 32, 432, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2, 2, null, 'ειπεν'); -- ειπεν = did He say
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2, 2, 'quotation', 'exact, literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 3, 'Psalms', 2, 'Psalms 2:7', 'Hebrews', 'Hebrews 5:5', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 3, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 5:5+70 5:5', 921, 32, 6283, 32, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2, 3, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 5:5+70 5:5', 921, 32, 6283, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2, 3, null, 'λαλησας'); -- λαλησας = having said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2, 3, 'quotation', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 1, 'Psalms', 2, 'Psalms 2:9', 'Revelation_of_John', 'Revelation_of_John 2:27', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 1, 'Psalms', 2, 'LXX Psalms 2:9+9 2:9-30', 'Revelation_of_John', 'SBLGNT Revelation_of_John 2:27+11 2:27-28', 1040, 21, 4778, 21, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 1, 'Psalms', 2, 'LXX Psalms 2:9 2:9-6', 'Revelation_of_John', 'SBLGNT Revelation_of_John 2:27+3 2:27', 1031, 54, 4769, 57, 'manual');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 1, 'Psalms', 2, 'LXX Psalms 2:9 2:9-10', 'Revelation_of_John', 'SBLGNT Revelation_of_John 2:27+3 2:27-5', 1031, 50, 4769, 52, 'manual-mechanical');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classified_by) values
 (3, 1, 'strong allusion', 'Sung Kuk Kim');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3, 1, 'strong allusion', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 2, 'Psalms', 2, 'Psalms 2:9', 'Revelation_of_John', 'Revelation_of_John 12:5', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 2, 'Psalms', 2, 'LXX Psalms 2:9+15 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 12:5+47 12:5-55', 1046, 13, 22310, 13, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 2, 'Psalms', 2, 'LXX Psalms 2:9 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 12:5+26 12:5-55', 1031, 28, 22289, 34, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3, 2, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classified_by) values
 (3, 2, 'strong allusion', 'Sung Kuk Kim');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3, 2, 'strong allusion', 'literal, subset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 3, 'Psalms', 2, 'Psalms 2:9', 'Revelation_of_John', 'Revelation_of_John 19:15', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 3, 'Psalms', 2, 'LXX Psalms 2:9+9 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 19:15+81 19:15-68', 1040, 19, 38365, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3, 3, 'Psalms', 2, 'LXX Psalms 2:9 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 19:15+73 19:15-68', 1031, 28, 38357, 27, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3, 3, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classified_by) values
 (3, 3, 'strong allusion', 'Sung Kuk Kim');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3, 3, 'strong allusion', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4, 1, 'Psalms', 4, 'Psalms 4:4', 'Ephesians', 'Ephesians 4:26', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4, 1, 'Psalms', 4, 'LXX Psalms 4:4 4:4-63', 'Ephesians', 'SBLGNT Ephesians 4:26 4:26-33', 2163, 24, 7323, 24, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4, 1, 'Psalms', 4, 'LXX Psalms 4:4 4:4-63', 'Ephesians', 'SBLGNT Ephesians 4:26 4:26-33', 2163, 24, 7323, 24, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (4, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (4, 1, 'strong allusion', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (5, 1, 'Psalms', 5, 'Psalms 5:9', 'Romans', 'Romans 3:13', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (5, 1, 'Psalms', 5, 'LXX Psalms 5:9+52 5:9', 'Romans', 'SBLGNT Romans 3:13 3:13-25', 3173, 54, 10992, 54, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (5, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written (in Romans 3:10)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (5, 1, 'secondary quotation', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (6, 1, 'Psalms', 6, 'LXX Psalms 6:8 6:8-64', 'Luke', 'SBLGNT Luke 13:27+32 13:27-14', 3985, 20, 56625, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (6, 1, 'Psalms', 6, 'LXX Psalms 6:8 6:8-64', 'Luke', 'SBLGNT Luke 13:27+32 13:27-14', 3985, 20, 56625, 20, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (6, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (6, 1, 'possible allusion', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (7, 1, 'Psalms', 8, 'Psalms 8:2', 'Matthew', 'Matthew 21:16', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (7, 1, 'Psalms', 8, 'LXX Psalms 8:2 8:2-47', 'Matthew', 'SBLGNT Matthew 21:16+76 21:16', 5606, 43, 60218, 43, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (7, 1, 'Psalms', 8, 'LXX Psalms 8:2 8:2-47', 'Matthew', 'SBLGNT Matthew 21:16+76 21:16', 5606, 43, 60218, 43, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (7, 1, null, 'ουδεποτε ανεγνωτε'); -- ουδεποτε ανεγνωτε = did you never read
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (7, 1, 'quotation', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (8, 1, 'Psalms', 8, 'Psalms 8:4-6', 'Hebrews', 'Hebrews 2:6-8', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (8, 1, 'Psalms', 8, 'LXX Psalms 8:4 8:5', 'Hebrews', 'SBLGNT Hebrews 2:6+25 2:7', 5766, 120, 1770, 120, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (8, 1, 'Psalms', 8, 'LXX Psalms 8:6+39 8:6', 'Hebrews', 'SBLGNT Hebrews 2:8 2:8-84', 5925, 33, 1890, 33, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (8, 1, 'Psalms', 8, 'LXX Psalms 8:4 8:6', 'Hebrews', 'SBLGNT Hebrews 2:6+25 2:8-84', 5766, 192, 1770, 120+33, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (8, 1, 'που τις', 'λεγων'); -- που τις = somewhere someone, λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (8, 1, 'quotation', 'superset', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (9, 1, 'Psalms', 10, 'Psalms 10:7', 'Romans', 'Romans 3:14', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (9, 1, 'Psalms', 10, 'LXX Psalms 10:7+2 10:7-39', 'Romans', 'SBLGNT Romans 3:14+2 3:14', 8070, 31, 5977, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (9, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written (in Romans 3:10)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (9, 1, 'secondary quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10, 1, 'Psalms', 14, 'Psalms 14:2-3', 'Romans', 'Romans 3:11-18', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10, 1, 'Psalms', 14, 'LXX Psalms 14:2+71 14:4-100', 'Romans', 'SBLGNT Romans 3:11+24 3:19-91', 10911, 318, 5816, 318, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10, 1, 'Psalms', 14, 'LXX Psalms 14:2+59 14:3', 'Romans', 'SBLGNT Romans 3:11+3 3:18', 10900, 329, 5795, 339, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (10, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written (in Romans 3:10)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (10, 1, 'quotation', 'subset, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 1, 'Psalms', 16, 'Psalms 16:8-11', 'Acts', 'Acts 2:25-28', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 1, 'Psalms', 16, 'LXX Psalms 16:8+4 16:11-31', 'Acts', 'SBLGNT Acts 2:25+25 2:28', 12496, 282, 4837, 282, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 1, 'Psalms', 16, 'LXX Psalms 16:8 16:11-31', 'Acts', 'SBLGNT Acts 2:25+21 2:28', 12492, 286, 4833, 286, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (11, 1, 'Δαυιδ', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (11, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 2, 'Psalms', 16, 'Psalms 16:10', 'Acts', 'Acts 13:35', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 2, 'Psalms', 16, 'LXX Psalms 16:10+41 16:10', 'Acts', 'SBLGNT Acts 13:35+22 13:35', 12687, 31, 44003, 31, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 2, 'Psalms', 16, 'LXX Psalms 16:10+37 16:10', 'Acts', 'SBLGNT Acts 13:35+20 13:35', 12683, 35, 44001, 33, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (11, 2, 'εν ετερω ... Δαυιδ', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (11, 2, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (12, 1, 'Psalms', 18, 'Psalms 18:49', 'Romans', 'Romans 15:9', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (12, 1, 'Psalms', 18, 'LXX Psalms 18:49 18:49-25', 'Romans', 'SBLGNT Romans 15:9+46 15:9-19', 17409, 33, 30160, 33, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (12, 1, 'Psalms', 18, 'LXX Psalms 18:49+39 18:49', 'Romans', 'SBLGNT Romans 15:9+79 15:9', 17448, 19, 30193, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (12, 1, 'Psalms', 18, 'LXX Psalms 18:49', 'Romans', 'SBLGNT Romans 15:9+46 15:9', 17409, 58, 30160, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (12, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (12, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13, 1, 'Psalms', 19, 'Psalms 19:4', 'Romans', 'Romans 10:18', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13, 1, 'Psalms', 19, 'LXX Psalms 19:4 19:4-27', 'Romans', 'SBLGNT Romans 10:18+28 10:18', 17756, 74, 21811, 74, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13, 1, 'Psalms', 19, 'LXX Psalms 19:4 19:4-27', 'Romans', 'SBLGNT Romans 10:18+28 10:18', 17756, 74, 21811, 74, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (13, 1, null, 'μενουνγε'); -- μενουνγε = indeed
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (13, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 1, 'Psalms', 22, 'Psalms 22:18', 'Matthew', 'Matthew 27:35', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 1, 'Psalms', 22, 'LXX Psalms 22:18 22:18-43', 'Matthew', 'SBLGNT Matthew 27:35+19 27:35-20', 21363, 20, 85881, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 1, 'Psalms', 22, 'LXX Psalms 22:18 22:18', 'Matthew', 'SBLGNT Matthew 27:35+19 27:35', 21363, 63, 85881, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (14, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (14, 1, 'strong allusion', 'literal, superset', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 2, 'Psalms', 22, 'Psalms 22:18', 'John', 'John 19:24', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 2, 'Psalms', 22, 'LXX Psalms 22:18', 'John', 'SBLGNT John 19:24+88 19:24-31', 21363, 63, 63431, 63, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14, 2, 'Psalms', 22, 'LXX Psalms 22:18', 'John', 'SBLGNT John 19:24+88 19:24-31', 21363, 63, 63431, 63, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (14, 2, null, 'τινος εσται ινα η γραφη πληρωθη η λεγουσα'); -- τινος εσται ινα η γραφη πληρωθη η λεγουσα = whose it shall be: that the scripture might be fulfilled, which saith (KJV)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (14, 2, 'quotation', 'exact, literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (15, 1, 'Psalms', 22, 'Psalms 22:22', 'Hebrews', 'Hebrews 2:12', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (15, 1, 'Psalms', 22, 'LXX Psalms 22:22+10 22:22', 'Hebrews', 'SBLGNT Hebrews 2:12+13 2:12', 21616, 48, 2353, 48, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (15, 1, 'Psalms', 22, 'LXX Psalms 22:22+10 22:22', 'Hebrews', 'SBLGNT Hebrews 2:12+13 2:12', 21616, 48, 2353, 48, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (15, 1, null, 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (15, 1, 'quotation', 'exact, literal, synonym', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16, 1, 'Psalms', 24, 'Psalms 24:1', 'I_Corinthians', 'I_Corinthians 10:26', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16, 1, 'Psalms', 24, 'LXX Psalms 24:1+37 24:1-39', 'I_Corinthians', 'SBLGNT I_Corinthians 10:26+6 10:26', 23000, 20, 17817, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16, 1, 'Psalms', 24, 'LXX Psalms 24:1+28 24:1-39', 'I_Corinthians', 'SBLGNT I_Corinthians 10:26+6 10:26', 22992, 29, 17811, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (16, 1, null, 'γαρ'); -- γαρ = for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (16, 1, 'quotation', 'literal, subtext', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17, 1, 'Psalms', 31, 'Psalms 31:5', 'Luke', 'Luke 23:46', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17, 1, 'Psalms', 31, 'LXX Psalms 31:5 31:5-49', 'Luke', 'SBLGNT Luke 23:46+37 23:46-40', 29824, 16, 91002, 16, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17, 1, 'Psalms', 31, 'LXX Psalms 31:5+20 31:5-31', 'Luke', 'SBLGNT Luke 23:46+57 23:46-22', 29844, 14, 91022, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17, 1, 'Psalms', 31, 'LXX Psalms 31:5 31:5-31', 'Luke', 'SBLGNT Luke 23:46+37 23:46-22', 29824, 34, 91002, 34, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (17, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (17, 1, 'strong allusion', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18, 1, 'Psalms', 32, 'Psalms 32:1-2', 'Romans', 'Romans 4:7-8', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18, 1, 'Psalms', 32, 'LXX Psalms 32:1+15 32:2-29', 'Romans', 'SBLGNT Romans 4:7 4:9-101', 31468, 97, 7493, 97, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18, 1, 'Psalms', 32, 'LXX Psalms 32:1+15 32:2-30', 'Romans', 'SBLGNT Romans 4:7 4:8', 31468, 96, 7493, 96, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (18, 1, 'Δαυιδ', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (18, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (19, 1, 'Psalms', 34, 'Psalms 34:8', 'I_Peter', 'I_Peter 2:3', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (19, 1, 'Psalms', 34, 'LXX Psalms 34:8+15 34:8-28', 'I_Peter', 'SBLGNT I_Peter 2:3+10 2:3', 34264, 18, 2366, 18, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (19, 1, 'Psalms', 34, 'LXX Psalms 34:8 34:8-28', 'I_Peter', 'SBLGNT I_Peter 2:3+3 2:3', 34250, 33, 2359, 25, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (19, 1, null, 'ει'); -- ει = if indeed
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (19, 1, 'strong allusion', 'literal, superset', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 'Psalms', 34, 'Psalms 34:12-16', 'I_Peter', 'I_Peter 3:10-12', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 'Psalms', 34, 'LXX Psalms 34:12+17 34:12-19', 'I_Peter', 'SBLGNT I_Peter 3:10+4 3:10-72', 34528, 13, 5207, 13, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 'Psalms', 34, 'LXX Psalms 34:12+43 34:13-51', 'I_Peter', 'SBLGNT I_Peter 3:10+33 3:10-46', 34554, 10, 5236, 10, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 'Psalms', 34, 'LXX Psalms 34:13+19 34:13-20', 'I_Peter', 'SBLGNT I_Peter 3:10+56 3:10-17', 34579, 16, 5259, 16, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 'Psalms', 34, 'LXX Psalms 34:13+38 34:14-54', 'I_Peter', 'SBLGNT I_Peter 3:10+72 3:11-60', 34598, 23, 5275, 23, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 'Psalms', 34, 'LXX Psalms 34:14+26 34:14-23', 'I_Peter', 'SBLGNT I_Peter 3:11+30 3:11-25', 34641, 11, 5322, 11, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 'Psalms', 34, 'LXX Psalms 34:14+39 34:14-7', 'I_Peter', 'SBLGNT I_Peter 3:11+44 3:11-8', 34654, 14, 5336, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 'Psalms', 34, 'LXX Psalms 34:15 34:16-37', 'I_Peter', 'SBLGNT I_Peter 3:12+3 3:12', 34675, 82, 5361, 82, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20, 1, 'Psalms', 34, 'LXX Psalms 34:12+17 34:16-37', 'I_Peter', 'SBLGNT I_Peter 3:10+4 3:12', 34529, 229, 5207, 236, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (20, 1, null, 'ο γαρ'); -- ο γαρ = the one for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (20, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 'Psalms', 40, 'Psalms 40:6-8', 'Hebrews', 'Hebrews 10:5-7', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 'Psalms', 40, 'LXX Psalms 40:6 40:6-52', 'Hebrews', 'SBLGNT Hebrews 10:5+32 10:5-18', 44125, 29, 15576, 29, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 'Psalms', 40, 'LXX Psalms 40:6+32 40:6-24', 'Hebrews', 'SBLGNT Hebrews 10:5+64 10:6-29', 44157, 25, 15608, 25, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 'Psalms', 40, 'LXX Psalms 40:6+56 40:6-6', 'Hebrews', 'SBLGNT Hebrews 10:6+11 10:6-9', 44181, 19, 15634, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 'Psalms', 40, 'LXX Psalms 40:6+77 40:8-61', 'Hebrews', 'SBLGNT Hebrews 10:6+35 10:7-16', 44202, 64, 15656, 64, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 1, 'Psalms', 40, 'LXX Psalms 40:6 40:8-45', 'Hebrews', 'SBLGNT Hebrews 10:5+32 10:7', 44125, 157, 15576, 162, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (21, 1, null, 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (21, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 2, 'Psalms', 40, 'Psalms 40:6', 'Hebrews', 'Hebrews 10:8', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 2, 'Psalms', 40, 'LXX Psalms 40:6+6 40:6-64', 'Hebrews', 'SBLGNT Hebrews 10:8+16 10:8-83', 44131, 11, 15754, 11, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 2, 'Psalms', 40, 'LXX Psalms 40:6+56 40:6-5', 'Hebrews', 'SBLGNT Hebrews 10:8+42 10:8-48', 44181, 20, 15780, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 2, 'Psalms', 40, 'LXX Psalms 40:6', 'Hebrews', 'SBLGNT Hebrews 10:8+16 10:8-41', 44131, 81, 15780, 59, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (21, 2, null, 'ανωτερον λεγων οτι'); -- ανωτερον λεγων οτι = above saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (21, 2, 'quotation', 'literal, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 3, 'Psalms', 40, 'Psalms 40:7-8', 'Hebrews', 'Hebrews 10:9', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 3, 'Psalms', 40, 'LXX Psalms 40:7+8 40:7-34', 'Hebrews', 'SBLGNT Hebrews 10:9+10 10:9-54', 44214, 8, 15864, 8, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 3, 'Psalms', 40, 'LXX Psalms 40:8 40:8-50', 'Hebrews', 'SBLGNT Hebrews 10:9+18 10:9-33', 44256, 21, 15872, 21, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 3, 'Psalms', 40, 'LXX Psalms 40:7+9 40:8-50', 'Hebrews', 'SBLGNT Hebrews 10:9+11 10:9-33', 44256, 62, 15865, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (21, 3, null, 'τοτε ειρηκεν'); -- τοτε ειρηκεν = then he said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (21, 3, 'quotation', 'literal, superset', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22, 1, 'Psalms', 41, 'Psalms 41:9', 'John', 'John 13:18', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22, 1, 'Psalms', 41, 'LXX Psalms 41:9+45 41:9-5', 'John', 'SBLGNT John 13:18+68 13:18-7', 45860, 29, 46586, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (22, 1, null, 'αλλ ινα η γραφη πληρωθη'); -- αλλ ινα η γραφη πληρωθη = but the Scripture may be fulfilled
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (22, 1, 'quotation', 'far-fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (23, 1, 'Psalms', 44, 'Psalms 44:22', 'Romans', 'Romans 8:36', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (23, 1, 'Psalms', 44, 'LXX Psalms 44:22+8 44:22', 'Romans', 'SBLGNT Romans 8:36+23 8:36', 49276, 53, 17863, 53, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (23, 1, 'Psalms', 44, 'LXX Psalms 44:22', 'Romans', 'SBLGNT Romans 8:36+14 8:36', 49268, 61, 17854, 62, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (23, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (23, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 'Psalms', 45, 'Psalms 45:6', 'Hebrews', 'Hebrews 1:8', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 'Psalms', 45, 'LXX Psalms 45:6 45:6-37', 'Hebrews', 'SBLGNT Hebrews 1:8+13 1:8-43', 50076, 35, 713, 35, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 'Psalms', 45, 'LXX Psalms 45:6+50 45:6-12', 'Hebrews', 'SBLGNT Hebrews 1:8+51 1:8-30', 50126, 10, 751, 10, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 'Psalms', 45, 'LXX Psalms 45:6+40 45:6-22', 'Hebrews', 'SBLGNT Hebrews 1:8+60 1:8-21', 50116, 10, 760, 10, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 'Psalms', 45, 'LXX Psalms 45:6+51 45:7', 'Hebrews', 'SBLGNT Hebrews 1:8+70 1:9', 50127, 124, 770, 124, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24, 1, 'Psalms', 45, 'LXX Psalms 45:6 45:7', 'Hebrews', 'SBLGNT Hebrews 1:8+13 1:9', 50076, 175, 713, 181, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (24, 1, null, 'λεγει ... προς δε τον υιον'); -- λεγει ... προς δε τον υιον =  He says ... unto however the Son
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (24, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (25, 1, 'Psalms', 51, 'Psalms 51:4', 'Romans', 'Romans 3:4', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (25, 1, 'Psalms', 51, 'LXX Psalms 51:4+43 51:4-17', 'Romans', 'SBLGNT Romans 3:4+63 3:4-18', 56556, 38, 5291, 38, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (25, 1, 'Psalms', 51, 'LXX Psalms 51:4+82 51:4', 'Romans', 'SBLGNT Romans 3:4+103 3:4', 56595, 16, 5331, 16, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (25, 1, 'Psalms', 51, 'LXX Psalms 51:4+43 51:4', 'Romans', 'SBLGNT Romans 3:4+63 3:4', 56556, 55, 5291, 56, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (25, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (25, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (26, 1, 'Psalms', 68, 'Psalms 68:18', 'Ephesians', 'Ephesians 4:8', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (26, 1, 'Psalms', 68, 'LXX Psalms 68:18+5 68:18-86', 'Ephesians', 'SBLGNT Ephesians 4:8+13 4:8-38', 73401, 18, 5810, 18, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (26, 1, 'Psalms', 68, 'LXX Psalms 68:18 68:18-52', 'Ephesians', 'SBLGNT Ephesians 4:8+8 4:8', 73397, 57, 5805, 61, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (26, 1, null, 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (26, 1, 'quotation', 'fuzzy, change', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (27, 1, 'Psalms', 69, 'Psalms 69:9a', 'John', 'John 2:17', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (27, 1, 'Psalms', 69, 'LXX Psalms 69:9+3 69:9-53', 'John', 'SBLGNT John 2:17+43 2:17-10', 75406, 20, 5178, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (27, 1, 'Psalms', 69, 'LXX Psalms 69:9+3 69:9-45', 'John', 'SBLGNT John 2:17+43 2:17', 75406, 28, 5178, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (27, 1, null, 'γεγραμμενον εστιν'); -- γεγραμμενον εστιν = written it is
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (27, 1, 'quotation', 'literal, fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (28, 1, 'Psalms', 69, 'Psalms 69:9b', 'Romans', 'Romans 15:3', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (28, 1, 'Psalms', 69, 'LXX Psalms 69:9+32 69:9', 'Romans', 'SBLGNT Romans 15:3+44 15:3', 75435, 44, 29642, 44, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (28, 1, 'Psalms', 69, 'LXX Psalms 69:9+34 69:9', 'Romans', 'SBLGNT Romans 15:3+46 15:3', 75437, 42, 29644, 42, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (28, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (28, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 'Psalms', 69, 'Psalms 69:22-23', 'Romans', 'Romans 11:9-10', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 'Psalms', 69, 'LXX Psalms 69:22 69:22-52', 'Romans', 'SBLGNT Romans 11:9+13 11:9-56', 76385, 22, 22819, 22, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 'Psalms', 69, 'LXX Psalms 69:22+28 69:22-26', 'Romans', 'SBLGNT Romans 11:9+29 11:9-42', 76413, 20, 22835, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 'Psalms', 69, 'LXX Psalms 69:22+58 69:22', 'Romans', 'SBLGNT Romans 11:9+53 11:9-22', 76443, 16, 22859, 16, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 'Psalms', 69, 'LXX Psalms 69:22+42 69:22-18', 'Romans', 'SBLGNT Romans 11:9+69 11:9-8', 76427, 14, 22875, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 'Psalms', 69, 'LXX Psalms 69:23', 'Romans', 'SBLGNT Romans 11:10', 76459, 74, 22897, 74, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (29, 1, 'Psalms', 69, 'LXX Psalms 69:22 69:23', 'Romans', 'SBLGNT Romans 11:9+13 11:10', 76385, 148, 22819, 152, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (29, 1, 'Δαυιδ', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (29, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (30, 1, 'Psalms', 69, 'Psalms 69:25', 'Acts', 'Acts 1:20', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (30, 1, 'Psalms', 69, 'LXX Psalms 69:25 69:25-50', 'Acts', 'SBLGNT Acts 1:20+25 1:20-64', 76593, 19, 2050, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (30, 1, 'Psalms', 69, 'LXX Psalms 69:25+54 69:25', 'Acts', 'SBLGNT Acts 1:20+55 1:20-38', 76647, 15, 2080, 15, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (30, 1, 'Psalms', 69, 'LXX Psalms 69:25', 'Acts', 'SBLGNT Acts 1:20+25 1:20-38', 76593, 69, 2050, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (30, 1, 'εν βιβλω ψαλμων', 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (30, 1, 'quotation', 'literal, superset', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31, 1, 'Psalms', 78, 'Psalms 78:2', 'Matthew', 'Matthew 13:35', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31, 1, 'Psalms', 78, 'LXX Psalms 78:2 78:2-26', 'Matthew', 'SBLGNT Matthew 13:35+40 13:35-31', 87283, 28, 37391, 28, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31, 1, 'Psalms', 78, 'LXX Psalms 78:2 78:2-26', 'Matthew', 'SBLGNT Matthew 13:35+40 13:35-31', 87283, 28, 37391, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (31, 1, 'προφητου', 'ρηθεν ... λεγοντος'); -- ρηθεν ... λεγοντος = having been spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (31, 1, 'quotation', 'literal, exact', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (32, 1, 'Psalms', 82, 'Psalms 82:6', 'John', 'John 10:34', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (32, 1, 'Psalms', 82, 'LXX Psalms 82:6 82:6-20', 'John', 'SBLGNT John 10:34+55 10:34', 96136, 15, 36114, 15, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (32, 1, 'Psalms', 82, 'LXX Psalms 82:6 82:6-20', 'John', 'SBLGNT John 10:34+55 10:34', 96136, 15, 36114, 15, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (32, 1, 'εν τω νομω υμων', 'γεγραμμενον'); -- εν τω νομω υμων = in the law of you, γεγραμμενον = written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (32, 1, 'quotation', 'literal, exact', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 1, 'Psalms', 86, 'Psalms 86:9', 'Revelation_of_John', 'Revelation_of_John 15:4', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 1, 'Psalms', 86, 'LXX Psalms 86:9+56 86:9-15', 'Revelation_of_John', 'Revelation_of_John 15:4+13 15:4-103', 99742, 13, 28951, 13, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 1, 'Psalms', 86, 'LXX Psalms 86:9+22 86:9-28', 'Revelation_of_John', 'Revelation_of_John 15:4+65 15:4-30', 99708, 34, 29003, 34, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (33, 1, 'Psalms', 86, 'LXX Psalms 86:9', 'Revelation_of_John', 'Revelation_of_John 15:4+13 15:4-30', 99686, 84, 28951, 86, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (33, 1, 'την ωδην του αρνιου', 'αδουσιν ... λεγοντες'); -- την ωδην του αρνιου = the Song of the Lamb, αδουσιν ... λεγοντες = they are singing ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (33, 1, 'quotation', 'literal, fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (34, 1, 'Psalms', 91, 'Psalms 91:11-12', 'Matthew', 'Matthew 4:6', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (34, 1, 'Psalms', 91, 'LXX Psalms 91:11 91:11-35', 'Matthew', 'SBLGNT Matthew 4:6+54 4:6-55', 107355, 37, 6566, 37, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (34, 1, 'Psalms', 91, 'LXX Psalms 91:12 91:13-59', 'Matthew', 'SBLGNT Matthew 4:6+94 4:7-57', 107427, 53, 6606, 53, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (34, 1, 'Psalms', 91, 'LXX Psalms 91:11 91:12', 'Matthew', 'SBLGNT Matthew 4:6+54 4:6', 107355, 124, 6566, 92, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (34, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (34, 1, 'quotation', 'literal, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (34, 2, 'Psalms', 91, 'Psalms 91:11-12', 'Luke', 'Luke 4:10-11', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (34, 2, 'Psalms', 91, 'LXX Psalms 91:11 91:11-20', 'Luke', 'SBLGNT Luke 4:10+12 4:10', 107355, 52, 13761, 52, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (34, 2, 'Psalms', 91, 'LXX Psalms 91:12 91:12', 'Luke', 'SBLGNT Luke 4:11+6 4:11', 107427, 52, 13819, 52, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (34, 2, 'Psalms', 91, 'LXX Psalms 91:11 91:12', 'Luke', 'SBLGNT Luke 4:10+12 4:11', 107355, 124, 13761, 110, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (34, 2, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (34, 2, 'quotation', 'literal, superset', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (35, 1, 'Psalms', 94, 'Psalms 94:11', 'I_Corinthians', 'I_Corinthians 3:20', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (35, 1, 'Psalms', 94, 'LXX Psalms 94:10+45 94:11-23', 'I_Corinthians', 'SBLGNT I_Corinthians 3:20+6 3:20-20', 109642, 35, 5092, 35, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (35, 1, 'Psalms', 94, 'LXX Psalms 94:11+39 94:11', 'I_Corinthians', 'SBLGNT I_Corinthians 3:20+44 3:20', 109683, 17, 5130, 17, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (35, 1, 'Psalms', 94, 'LXX Psalms 94:11', 'I_Corinthians', 'SBLGNT I_Corinthians 3:20+8 3:20', 109644, 56, 5094, 53, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (35, 1, null, 'και παλιν'); -- και παλιν = and again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (35, 1, 'quotation', 'literal, change', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 1, 'Psalms', 95, 'Psalms 95:7-11', 'Hebrews', 'Hebrews 3:7-11', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 1, 'Psalms', 95, 'LXX Psalms 95:7+65 95:9-29', 'Hebrews', 'SBLGNT Hebrews 3:7+28 3:9-26', 110944, 133, 3418, 133, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 1, 'Psalms', 95, 'LXX Psalms 95:9+43 95:10-90', 'Hebrews', 'SBLGNT Hebrews 3:9+40 3:10-92', 111096, 14, 3567, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 1, 'Psalms', 95, 'LXX Psalms 95:10+15 95:10-62', 'Hebrews', 'SBLGNT Hebrews 3:10+18 3:10-61', 111121, 17, 3597, 17, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 1, 'Psalms', 95, 'LXX Psalms 95:10+45 95:10-29', 'Hebrews', 'SBLGNT Hebrews 3:10+48 3:10-28', 111151, 20, 3627, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 1, 'Psalms', 95, 'LXX Psalms 95:10+73 95:11', 'Hebrews', 'SBLGNT Hebrews 3:10+75 3:11', 111179, 73, 3654, 73, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 1, 'Psalms', 95, 'LXX Psalms 95:7+65 95:11', 'Hebrews', 'SBLGNT Hebrews 3:7+28 3:11', 110944, 308, 3418, 309, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 1, 'το πνευμα το αγιον', 'καθως λεγει'); -- το πνευμα το αγιον = the Holy Spirit, καθως λεγει = just as says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 2, 'Psalms', 95, 'Psalms 95:7-8', 'Hebrews', 'Hebrews 3:15', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 2, 'Psalms', 95, 'LXX Psalms 95:7+65 95:8-34', 'Hebrews', 'SBLGNT Hebrews 3:15+12 3:15', 110944, 75, 4005, 75, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 2, 'Psalms', 95, 'LXX Psalms 95:7+65 95:8-34', 'Hebrews', 'SBLGNT Hebrews 3:15+12 3:15', 110944, 75, 4005, 75, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 2, null, 'εν τω λεγεσθαι'); -- εν τω λεγεσθαι = as it is said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 3, 'Psalms', 95, 'Psalms 95:11', 'Hebrews', 'Hebrews 3:18', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 3, 'Psalms', 95, 'LXX Psalms 95:11+31 95:11-3', 'Hebrews', 'SBLGNT Hebrews 3:18+26 3:18-24', 111231, 18, 4254, 18, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 3, 'Psalms', 95, 'LXX Psalms 95:11+2 95:11-3', 'Hebrews', 'SBLGNT Hebrews 3:18+7 3:18-24', 111202, 47, 4235, 37, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 3, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 3, 'repetition', 'literal, supertext', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 4, 'Psalms', 95, 'Psalms 95:11', 'Hebrews', 'Hebrews 4:3', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 4, 'Psalms', 95, 'LXX Psalms 95:11', 'Hebrews', 'SBLGNT Hebrews 4:3+53 4:3-42', 111200, 52, 4606, 52, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 4, 'Psalms', 95, 'LXX Psalms 95:11', 'Hebrews', 'SBLGNT Hebrews 4:3+53 4:3-42', 111200, 52, 4606, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 4, null, 'καθως ειρηκεν'); -- καθως ειρηκεν = as He has said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 4, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 5, 'Psalms', 95, 'Psalms 95:11', 'Hebrews', 'Hebrews 4:5', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 5, 'Psalms', 95, 'LXX Psalms 95:11+18 95:11', 'Hebrews', 'SBLGNT Hebrews 4:5+15 4:5', 111218, 34, 4804, 34, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 5, 'Psalms', 95, 'LXX Psalms 95:11+18 95:11', 'Hebrews', 'SBLGNT Hebrews 4:5+15 4:5', 111218, 34, 4804, 34, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 5, null, 'και εν τουτω παλιν'); -- και εν τουτω παλιν = and in this again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 5, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 6, 'Psalms', 95, 'Psalms 95:7-8', 'Hebrews', 'Hebrews 4:7', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 6, 'Psalms', 95, 'LXX Psalms 95:7+65 95:8-52', 'Hebrews', 'SBLGNT Hebrews 4:7+73 4:7', 110944, 57, 5001, 57, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (36, 6, 'Psalms', 95, 'LXX Psalms 95:7+65 95:8-52', 'Hebrews', 'SBLGNT Hebrews 4:7+73 4:7', 110944, 57, 5001, 57, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 6, 'Δαυιδ', 'καθως προειρηται'); -- καθως προειρηται = just as it has been said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 6, 'quotation', 'literal, exact', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (37, 1, 'Psalms', 102, 'Psalms 102:25-27', 'Hebrews', 'Hebrews 1:10-12', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (37, 1, 'Psalms', 102, 'LXX Psalms 102:25+10 102:26-29', 'Hebrews', 'SBLGNT Hebrews 1:10+13 1:12-72', 117060, 133, 907, 133, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (37, 1, 'Psalms', 102, 'LXX Psalms 102:26+92 102:27', 'Hebrews', 'SBLGNT Hebrews 1:12+38 1:12', 117207, 52, 1060, 52, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (37, 1, 'Psalms', 102, 'LXX Psalms 102:25 102:27', 'Hebrews', 'SBLGNT Hebrews 1:10+3 1:12', 117060, 209, 907, 217, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (37, 1, 'θεος', 'προς δε τον υιον ... και'); -- προς δε τον υιον ... και = unto however the Son ... and
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (37, 1, 'quotation', 'literal, subset', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (38, 1, 'Psalms', 104, 'Psalms 104:4', 'Hebrews', 'Hebrews 1:7', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (38, 1, 'Psalms', 104, 'LXX Psalms 104:4 104:4-6', 'Hebrews', 'SBLGNT Hebrews 1:7+27 1:7-7', 119058, 57, 636, 57, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (38, 1, 'Psalms', 104, 'LXX Psalms 104:4', 'Hebrews', 'SBLGNT Hebrews 1:7+27 1:7', 119058, 63, 636, 64, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (38, 1, 'θεος', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (38, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (39, 1, 'Psalms', 109, 'Psalms 109:3', 'John', 'John 15:25', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (39, 1, 'Psalms', 109, 'LXX Psalms 109:3+35 109:3', 'John', 'SBLGNT John 15:25+49 15:25', 130560, 12, 52584, 12, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (39, 1, 'Psalms', 109, 'LXX Psalms 109:3+29 109:3', 'John', 'SBLGNT John 15:25+47 15:25', 130554, 19, 52582, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (39, 1, 'εν τω νομω αυτων', 'γεγραμμενος'); -- εν τω νομω αυτων γεγραμμενος = in the law of them having been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (39, 1, 'quotation', 'literal, change', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 1, 'Psalms', 110, 'Psalms 110:1', 'Luke', 'Luke 20:42-43', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 1, 'Psalms', 110, 'LXX Psalms 110:1+19 110:1', 'Luke', 'SBLGNT Luke 20:42+36 20:43', 132490, 73, 79150, 73, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 1, 'Psalms', 110, 'LXX Psalms 110:1+13 110:1', 'Luke', 'SBLGNT Luke 20:42+31 20:43', 132484, 79, 79145, 78, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 1, 'Δαυιδ ... εν βιβλω ψαλμων', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 2, 'Psalms', 110, 'Psalms 110:1', 'Acts', 'Acts 2:34-35', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 2, 'Psalms', 110, 'LXX Psalms 110:1+11 110:1', 'Acts', 'SBLGNT Acts 2:34+40 2:35', 132482, 81, 5652, 81, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 2, 'Psalms', 110, 'LXX Psalms 110:1+13 110:1', 'Acts', 'SBLGNT Acts 2:34+42 2:35', 132484, 79, 5654, 79, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 2, 'Δαυιδ', 'λεγει, exact'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 2, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 3, 'Psalms', 110, 'Psalms 110:1', 'Hebrews', 'Hebrews 1:13', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 3, 'Psalms', 110, 'LXX Psalms 110:1+35 110:1', 'Hebrews', 'SBLGNT Hebrews 1:13+31 1:13', 132506, 57, 1145, 57, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 3, 'Psalms', 110, 'LXX Psalms 110:1+35 110:1', 'Hebrews', 'SBLGNT Hebrews 1:13+31 1:13', 132506, 57, 1145, 57, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 3, 'θεος', 'ειρηκεν'); -- ειρηκεν = did He say
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 4, 'Psalms', 110, 'Psalms 110:1', 'Matthew', 'Matthew 22:44', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 4, 'Psalms', 110, 'LXX Psalms 110:1+19 110:1-17', 'Matthew', 'SBLGNT Matthew 22:44+5 22:44-15', 132490, 56, 66113, 56, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 4, 'Psalms', 110, 'LXX Psalms 110:1+13 110:1', 'Matthew', 'SBLGNT Matthew 22:44', 132484, 79, 66108, 76, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 4, 'Δαυιδ', 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 4, 'quotation', 'literal, synonym', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 5, 'Psalms', 110, 'Psalms 110:1', 'Mark', 'Mark 12:36', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 5, 'Psalms', 110, 'LXX Psalms 110:1+19 110:1-17', 'Mark', 'SBLGNT Mark 12:36+36 12:36-15', 132490, 56, 41472, 56, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 5, 'Psalms', 110, 'LXX Psalms 110:1+13 110:1', 'Mark', 'SBLGNT Mark 12:36+33 12:36', 132484, 79, 41469, 76, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 5, 'Δαυιδ', 'ειπεν'); -- ειπεν = said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 5, 'quotation', 'literal, synonym', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 6, 'Psalms', 110, 'Psalms 110:1', 'Hebrews', 'Hebrews 10:13', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 6, 'Psalms', 110, 'LXX Psalms 110:1+70 110:1-3', 'Hebrews', 'SBLGNT Hebrews 10:13+40 10:13-5', 132541, 19, 16225, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (40, 6, 'Psalms', 110, 'LXX Psalms 110:1+62 110:1-3', 'Hebrews', 'SBLGNT Hebrews 10:13+31 10:13-5', 132533, 27, 16216, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 6, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 6, 'repetition', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 1, 'Psalms', 110, 'Psalms 110:4', 'Hebrews', 'Hebrews 5:6', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 1, 'Psalms', 110, 'LXX Psalms 110:4+36 110:4', 'Hebrews', 'SBLGNT Hebrews 5:6+22 5:6', 132761, 39, 6337, 39, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 1, 'Psalms', 110, 'LXX Psalms 110:4+32 110:4', 'Hebrews', 'SBLGNT Hebrews 5:6+20 5:6', 132757, 43, 6335, 41, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (41, 1, 'ο λαλησας', 'λεγει'); -- ο λαλησας = the [One] having said, λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (41, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 2, 'Psalms', 110, 'Psalms 110:4', 'Hebrews', 'Hebrews 5:10', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 2, 'Psalms', 110, 'LXX Psalms 110:4+53 110:4', 'Hebrews', 'SBLGNT Hebrews 5:10+33 5:10', 132778, 22, 6667, 22, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 2, 'Psalms', 110, 'LXX Psalms 110:4+53 110:4', 'Hebrews', 'SBLGNT Hebrews 5:10+33 5:10', 132778, 22, 6667, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (41, 2, 'θεου', 'προσαγορευθεις'); -- προσαγορευθεις = having been designated
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (41, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 3, 'Psalms', 110, 'Psalms 110:4', 'Hebrews', 'Hebrews 7:17', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 3, 'Psalms', 110, 'LXX Psalms 110:4+36 110:4', 'Hebrews', 'SBLGNT Hebrews 7:17+19 7:17', 132761, 39, 10191, 39, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 3, 'Psalms', 110, 'LXX Psalms 110:4+32 110:4', 'Hebrews', 'SBLGNT Hebrews 7:17+17 7:17', 132757, 43, 10189, 41, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (41, 3, null, 'μαρτυρειται γαρ'); -- μαρτυρειται γαρ = it is testified for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (41, 3, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 4, 'Psalms', 110, 'Psalms 110:4', 'Hebrews', 'Hebrews 7:21', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 4, 'Psalms', 110, 'LXX Psalms 110:4 110:4-41', 'Hebrews', 'SBLGNT Hebrews 7:21+40 7:21-17', 132725, 34, 10475, 34, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 4, 'Psalms', 110, 'LXX Psalms 110:4+36 110:4-17', 'Hebrews', 'SBLGNT Hebrews 7:21+74 7:22-43', 132761, 22, 10509, 22, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41, 4, 'Psalms', 110, 'LXX Psalms 110:4 110:4-22', 'Hebrews', 'SBLGNT Hebrews 7:21+40 7:21', 132725, 53, 10475, 51, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (41, 4, 'του', 'λεγοντος'); -- του = the [One], λεγοντος = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (41, 4, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (42, 1, 'Psalms', 112, 'Psalms 112:9', 'II_Corinthians', 'II_Corinthians 9:9', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (42, 1, 'Psalms', 112, 'LXX Psalms 112:9 112:9-37', 'II_Corinthians', 'SBLGNT II_Corinthians 9:9+9 9:9', 134163, 59, 14356, 59, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (42, 1, 'Psalms', 112, 'LXX Psalms 112:9 112:9-37', 'II_Corinthians', 'SBLGNT II_Corinthians 9:9+9 9:9', 134163, 59, 14356, 59, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (42, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (42, 1, 'quotation', 'literal, exact', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (43, 1, 'Psalms', 116, 'Psalms 116:10', 'II_Corinthians', 'II_Corinthians 4:13', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (43, 1, 'Psalms', 116, 'LXX Psalms 116:10+9 116:10-22', 'II_Corinthians', 'SBLGNT II_Corinthians 4:13+48 4:13-32', 136803, 19, 6211, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (43, 1, 'Psalms', 116, 'LXX Psalms 116:10+9 116:10-22', 'II_Corinthians', 'SBLGNT II_Corinthians 4:13+48 4:13-32', 136803, 19, 6211, 19, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (43, 1, null, 'γεγραμμενον'); -- γεγραμμενον = having been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (43, 1, 'quotation', 'literal, exact', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (44, 1, 'Psalms', 117, 'Psalms 117:1', 'Romans', 'Romans 15:11', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (44, 1, 'Psalms', 117, 'LXX Psalms 117:1+36 117:1-18', 'Romans', 'SBLGNT Romans 15:11+37 15:11-21', 137243, 9, 30292, 9, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (44, 1, 'Psalms', 117, 'LXX Psalms 117:1+46 117:1', 'Romans', 'SBLGNT Romans 15:11+50 15:11', 137253, 17, 30305, 17, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (44, 1, 'Psalms', 117, 'LXX Psalms 117:1+9 117:1', 'Romans', 'SBLGNT Romans 15:11+8 15:11', 137226, 54, 30263, 60, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (44, 1, null, 'και παλιν'); -- και παλιν = and again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (44, 1, 'quotation', 'literal, fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (45, 1, 'Psalms', 118, 'Psalms 118:6', 'Hebrews', 'Hebrews 13:6', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (45, 1, 'Psalms', 118, 'LXX Psalms 118:5+55 118:6', 'Hebrews', 'SBLGNT Hebrews 13:6+23 13:6', 137636, 50, 24669, 50, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (45, 1, 'Psalms', 118, 'LXX Psalms 118:6', 'Hebrews', 'SBLGNT Hebrews 13:6+24 13:6', 137637, 49, 24670, 49, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (45, 1, null, 'ωστε θαρρουντας ημας λεγειν'); -- ωστε θαρρουντας ημας λεγειν = so are confident we to say
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (45, 1, 'quotation', 'literal, exact', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 1, 'Psalms', 118, 'Psalms 118:22-23', 'Matthew', 'Matthew 21:42', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 1, 'Psalms', 118, 'LXX Psalms 118:22 118:23', 'Matthew', 'SBLGNT Matthew 21:42+47 21:42', 138494, 114, 62687, 114, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 1, 'Psalms', 118, 'LXX Psalms 118:22 118:23', 'Matthew', 'SBLGNT Matthew 21:42+47 21:42', 138494, 114, 62687, 114, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (46, 1, 'εν ταις γραφαις', 'ανεγνωτε'); -- εν ταις γραφαις = in the Scriptures, ανεγνωτε = did you read
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (46, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 2, 'Psalms', 118, 'Psalms 118:22-23', 'Mark', 'Mark 12:10-11', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 2, 'Psalms', 118, 'LXX Psalms 118:22 118:23', 'Mark', 'SBLGNT Mark 12:10+27 12:11', 138494, 114, 39106, 114, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 2, 'Psalms', 118, 'LXX Psalms 118:22 118:23', 'Mark', 'SBLGNT Mark 12:10+27 12:11', 138494, 114, 39106, 114, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (46, 2, 'γραφην', 'ανεγνωτε'); -- γραφην = Scripture, ανεγνωτε = have you read
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (46, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 3, 'Psalms', 118, 'Psalms 118:22', 'Luke', 'Luke 20:17', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 3, 'Psalms', 118, 'LXX Psalms 118:22 118:23-50', 'Luke', 'SBLGNT Luke 20:17+50 20:18-62', 138494, 64, 77300, 64, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 3, 'Psalms', 118, 'LXX Psalms 118:22', 'Luke', 'SBLGNT Luke 20:17+50 20:17', 138494, 62, 77300, 62, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (46, 3, null, 'γεγραμμενον'); -- γεγραμμενον = has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (46, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 4, 'Psalms', 118, 'Psalms 118:22', 'I_Peter', 'I_Peter 2:7', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 4, 'Psalms', 118, 'LXX Psalms 118:22+5 118:22', 'I_Peter', 'SBLGNT I_Peter 2:7+44 2:7', 138499, 57, 2736, 57, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (46, 4, 'Psalms', 118, 'LXX Psalms 118:22', 'I_Peter', 'SBLGNT I_Peter 2:7+39 2:7', 138494, 62, 2731, 62, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (46, 4, 'εν γραφη', 'περιεχει ... δε'); -- εν γραφη = in Scripture, περιεχει ... δε = it is contained ... however
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (46, 4, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (47, 1, 'Psalms', 50, 'LXX Psalms 50:14', 'Matthew', 'SBLGNT Matthew 5:33b', 0, 0, 0, 0, 'traditional');

-- Non-psalms:

-- TODO: Add traditional data (eventually).
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (101, 1, 'Isaiah', null, 'LXX Isaiah 29:14+69 29:14-5', 'I_Corinthians', 'SBLGNT I_Corinthians 1:19+12 1:19-7', 55661, 45, 1391, 45, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (101, 1, 'Isaiah', null, 'LXX Isaiah 29:14+69 29:14-5', 'I_Corinthians', 'SBLGNT I_Corinthians 1:19+12 1:19-7', 55661, 45, 1391, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (101, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (101, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (102, 1, 'Isaiah', null, 'Isaiah 64:4', 'I_Corinthians', 'I_Corinthians 2:9', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (103, 1, 'Isaiah', null, 'LXX Isaiah 40:13+3 40:13-41', 'Romans', 'SBLGNT Romans 11:34+6 11:34-25', 79030, 14, 24739, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (103, 1, 'Isaiah', null, 'LXX Isaiah 40:13 40:13-14', 'Romans', 'SBLGNT Romans 11:34', 79028, 44, 24733, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (103, 1, null, 'γαρ'); -- γαρ = for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (103, 1, 'quotation', 'fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (103, 2, 'Isaiah', null, 'LXX Isaiah 40:13+3 40:13-41', 'I_Corinthians', 'SBLGNT I_Corinthians 2:16+6 2:16-41', 79031, 14, 3646, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (103, 2, 'Isaiah', null, 'LXX Isaiah 40:13', 'I_Corinthians', 'SBLGNT I_Corinthians 2:16 2:16-24', 79027, 58, 3640, 37, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (103, 2, null, 'γαρ'); -- γαρ = for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (103, 2, 'quotation', 'far-fuzzy, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (103, 3, 'Isaiah', null, 'LXX Isaiah 52:5+115 52:5', 'Romans', 'SBLGNT Romans 2:24+23 2:24-14', 106381, 25, 4605, 25, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (103, 3, 'Isaiah', null, 'LXX Isaiah 52:5+90 52:5', 'Romans', 'SBLGNT Romans 2:24 2:24-14', 106356, 50, 4582, 48, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (103, 3, null, 'γαρ, καθως γεγραπται'); -- γαρ = for, καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (103, 3, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (104, 1, 'Isaiah', null, 'LXX Isaiah 10:22+18 10:22-64', 'Romans', 'SBLGNT Romans 9:27+46 9:27-18', 22157, 27, 20031, 27, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (104, 1, 'Isaiah', null, 'LXX Isaiah 10:22+60 10:22-12', 'Romans', 'SBLGNT Romans 9:27+82 9:28-22', 22199, 37, 20067, 37, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (104, 1, 'Isaiah', null, 'LXX Isaiah 10:22+18 10:23-21', 'Romans', 'SBLGNT Romans 9:27+46 9:28-15', 22157, 119, 20067, 80, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (104, 1, 'Ησαιας', 'κραζει'); -- κραζει = cries out
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (104, 1, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (105, 1, 'Isaiah', null, 'LXX Isaiah 1:9+3 1:9', 'Romans', 'SBLGNT Romans 9:29+24 9:29', 809, 81, 20150, 81, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (105, 1, 'Isaiah', null, 'LXX Isaiah 1:9+3 1:9', 'Romans', 'SBLGNT Romans 9:29+24 9:29', 809, 81, 20150, 81, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (105, 1, 'Ησαιας', 'καθως προειρηκεν'); -- καθως προειρηκεν = as foretold
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (105, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (106, 1, 'Isaiah', null, 'LXX Isaiah 8:14+48 8:14-94', 'Romans', 'SBLGNT Romans 9:33+30 9:33-54', 16771, 16, 20459, 17, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (106, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (106, 1, 'quotation', 'literal, in-quotation', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (107, 1, 'Isaiah', null, 'LXX Isaiah 28:16+49 28:16-84', 'Romans', 'SBLGNT Romans 9:33+26 9:33-65', 52741, 10, 20455, 10, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (107, 1, 'Isaiah', null, 'LXX Isaiah 28:16+110 28:16-13', 'Romans', 'SBLGNT Romans 9:33+65 9:33-16', 52802, 20, 20494, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (107, 1, 'Isaiah', null, 'LXX Isaiah 28:16+24 28:16', 'Romans', 'SBLGNT Romans 9:33+14 9:33-5', 52716, 119, 20443, 82, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (107, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (107, 1, 'quotation', 'literal, change, far-fuzzy, superset, subset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (107, 2, 'Isaiah', null, 'LXX Isaiah 28:16+113 28:16-13', 'Romans', 'SBLGNT Romans 10:11+17 10:11-16', 52805, 17, 21315, 17, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (107, 2, 'Isaiah', null, 'LXX Isaiah 28:16+113 28:16', 'Romans', 'SBLGNT Romans 10:11+17 10:11-5', 52805, 30, 21315, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (107, 2, 'η γραφη', 'λεγει γαρ'); -- η γραφη = the Scripture, λεγει γαρ = says for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (107, 2, 'repeated quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (107, 3, 'Isaiah', null, 'LXX Isaiah 28:16+72 28:16-56', 'I_Peter', 'SBLGNT I_Peter 2:6+39 2:6-47', 52764, 15, 2630, 15, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (107, 3, 'Isaiah', null, 'LXX Isaiah 28:16+110 28:16', 'I_Peter', 'SBLGNT I_Peter 2:6+68 2:6', 52802, 33, 2659, 33, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (107, 3, 'Isaiah', null, 'LXX Isaiah 28:16+24 28:16', 'I_Peter', 'SBLGNT I_Peter 2:6+20 2:6', 52716, 119, 2611, 81, 'getrefs');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (107, 3, 'εν γραφη', 'περιεχει'); -- εν γραφη = in Scripture,  περιεχει = it is contained
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (107, 3, 'quotation', 'literal, fuzzy, change, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (108, 1, 'Isaiah', null, 'LXX Isaiah 52:7 52:7-58', 'Romans', 'SBLGNT Romans 10:15+44 10:15', 106484, 72, 21629, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (108, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (108, 1, 'quotation', 'far-fuzzy, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (109, 1, 'Isaiah', null, 'LXX Isaiah 53:1 53:1-31', 'Romans', 'SBLGNT Romans 10:16+45 10:16', 107401, 28, 21714, 28, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (109, 1, 'Isaiah', null, 'LXX Isaiah 53:1 53:1-31', 'Romans', 'SBLGNT Romans 10:16+45 10:16', 107401, 28, 21714, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (109, 1, 'Ησαιας', 'γαρ λεγει'); -- γαρ λεγει = for says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (109, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (109, 2, 'Isaiah', null, 'LXX Isaiah 52:15+123 53:1', 'John', 'SBLGNT John 12:38+39 12:38', 107400, 60, 44164, 60, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (109, 2, 'Isaiah', null, 'LXX Isaiah 53:1', 'John', 'SBLGNT John 12:38+38 12:38', 107401, 59, 44164, 59, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (109, 2, 'Ησαιας του προφητου', 'ον ειπεν'); -- Ησαιας του προφητου = Isaiah the prophet, ον ειπεν = that said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (109, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (110, 1, 'Isaiah', null, 'LXX Isaiah 65:1+32 65:1-61', 'Romans', 'SBLGNT Romans 10:20+24 10:20-53', 127360, 7, 22002, 7, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (110, 1, 'Isaiah', null, 'LXX Isaiah 65:1+14 65:1-67', 'Romans', 'SBLGNT Romans 10:20+32 10:20-33', 127342, 19, 22010, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (110, 1, 'Isaiah', null, 'LXX Isaiah 65:1+37 65:1-42', 'Romans', 'SBLGNT Romans 10:20+63 10:20', 127365, 21, 22041, 21, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (110, 1, 'Isaiah', null, 'LXX Isaiah 65:1 65:1-76', 'Romans', 'SBLGNT Romans 10:20+50 10:20-10', 127328, 24, 22028, 24, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (110, 1, 'Isaiah', null, 'LXX Isaiah 65:1 65:1-42', 'Romans', 'SBLGNT Romans 10:20+24 10:20', 127328, 58, 22002, 60, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (110, 1, 'Ησαιας', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (110, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (111, 1, 'Isaiah', null, 'LXX Isaiah 65:2+34 65:2-50', 'Romans', 'SBLGNT Romans 10:21+54 10:21', 127462, 32, 22116, 32, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (111, 1, 'Isaiah', null, 'LXX Isaiah 65:2 65:2-95', 'Romans', 'SBLGNT Romans 10:21+33 10:21-32', 127428, 21, 22095, 21, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (111, 1, 'Isaiah', null, 'LXX Isaiah 65:2 65:2-50', 'Romans', 'SBLGNT Romans 10:21+20 10:21', 127428, 66, 22082, 60, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (111, 1, 'Ησαιας ... προς ... Ισραηλ', 'λεγει'); -- προς ... Ισραηλ = as for ... Israel, λεγει = says (Isaiah is mentioned in 10:20)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (111, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (112, 1, 'Isaiah', null, 'LXX Isaiah 29:10+22 29:10-61', 'Romans', 'SBLGNT Romans 11:8+31 11:8-46', 55055, 41, 22732, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (112, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (112, 1, 'quotation', 'literal, in-quotation, grammatical-change, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (113, 1, 'Isaiah', null, 'LXX Isaiah 59:20+13 59:20-29', 'Romans', 'SBLGNT Romans 11:26+46 11:26-26', 119274, 13, 24253, 13, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (113, 1, 'Isaiah', null, 'LXX Isaiah 59:20+29 59:21-161', 'Romans', 'SBLGNT Romans 11:26+59 11:27-28', 119290, 54, 24266, 54, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (113, 1, 'Isaiah', null, 'LXX Isaiah 59:20+3 59:21-161', 'Romans', 'SBLGNT Romans 11:26+40 11:27-28', 119264, 80, 24247, 73, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (113, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (113, 1, 'quotation', 'literal, subset, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (114, 1, 'Isaiah', null, 'LXX Isaiah 27:9+59 27:9-147', 'Romans', 'SBLGNT Romans 11:27+28 11:27-16', 50477, 12, 24320, 12, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (114, 1, 'Isaiah', null, 'LXX Isaiah 27:9+59 27:9-132', 'Romans', 'SBLGNT Romans 11:27+28 11:27', 50477, 27, 24320, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (114, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written (in Romans 11:26)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (114, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (115, 1, 'Isaiah', null, 'LXX Isaiah 45:23+119 45:23-5', 'Romans', 'SBLGNT Romans 14:11+49 14:11-19', 93657, 12, 28552, 12, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (115, 1, 'Isaiah', null, 'LXX Isaiah 45:23+84 45:23-29', 'Romans', 'SBLGNT Romans 14:11+28 14:11-29', 93622, 23, 28531, 23, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (115, 1, 'Isaiah', null, 'LXX Isaiah 45:23+84 45:23', 'Romans', 'SBLGNT Romans 14:11+28 14:11', 93657, 52, 28531, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (115, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (115, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (116, 1, 'Isaiah', null, 'LXX Isaiah 11:10+23 11:10-27', 'Romans', 'SBLGNT Romans 15:12+24 15:12', 24107, 59, 30347, 59, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (116, 1, 'Isaiah', null, 'LXX Isaiah 11:10+3 11:10-27', 'Romans', 'SBLGNT Romans 15:12+19 15:12', 24087, 79, 30342, 64, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (116, 1, 'Ησαιας', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (116, 1, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (117, 1, 'Isaiah', null, 'LXX Isaiah 52:15+66 52:15', 'Romans', 'SBLGNT Romans 15:21+17 15:21', 107343, 58, 31215, 58, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (117, 1, 'Isaiah', null, 'LXX Isaiah 52:15+66 52:15', 'Romans', 'SBLGNT Romans 15:21+17 15:21', 107343, 58, 31215, 58, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (117, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (117, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (118, 1, 'Isaiah', null, 'LXX Isaiah 7:14+85 7:14', 'Matthew', 'SBLGNT Matthew 1:23+52 1:23-34', 14284, 21, 1974, 21, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (118, 1, 'Isaiah', null, 'LXX Isaiah 7:14+35 7:14-24', 'Matthew', 'SBLGNT Matthew 1:23 1:23-60', 14234, 47, 1922, 47, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (118, 1, 'Isaiah', null, 'LXX Isaiah 7:14+35 7:14', 'Matthew', 'SBLGNT Matthew 1:23 1:23-34', 14234, 71, 1922, 73, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (118, 1, 'δια του προφητου', 'το ρηθεν υπο κυριου ... λεγοντος'); -- δια του προφητου = through the prophet, το ρηθεν υπο κυριου ... λεγοντος = having been spoken by the Lord ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (118, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (119, 1, 'Isaiah', null, 'Aleppo Isaiah 11:1+16 11:1-10', 'Matthew', 'SBLGNT Matthew 2:23+76 2:23-14', null, 3, 4488, 5, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (119, 1, 'δια του προφητων', 'το ρηθεν ... οτι'); -- δια του προφητων = through the prophets, το ρηθεν ... οτι = that having been spoken ... that
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (119, 1, 'quotation', 'puzzle', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (120, 1, 'Isaiah', null, 'Isaiah 28:11+12 28:11', 'I_Corinthians', 'SBLGNT I_Corinthians 14:21+40 14:21-38', 52171, 46, 25551, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (120, 1, 'εν τω νομω', 'γεγραπται οτι'); -- εν τω νομω  = in the law, γεγραπται οτι = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (120, 1, 'quotation', 'far-fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (121, 1, 'Isaiah', null, 'LXX Isaiah 22:13+107 22:13', 'I_Corinthians', 'SBLGNT I_Corinthians 15:32+67 15:32', 41992, 37, 29178, 37, 'getrefs');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (121, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (121, 1, 'strong allusion', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (122, 1, 'Isaiah', null, 'LXX Isaiah 9:2+71 9:2-6', 'II_Corinthians', 'SBLGNT II_Corinthians 4:6+23 4:6-80', 17973, 9, 5634, 9, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (122, 1, 'Isaiah', null, 'LXX Isaiah 9:2+71 9:2-6', 'II_Corinthians', 'SBLGNT II_Corinthians 4:6+23 4:6-80', 17973, 9, 5634, 9, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (122, 1, 'θεος', 'ειπων'); -- ειπων = having said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (122, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (122, 2, 'Isaiah', null, 'LXX Isaiah 9:1+80 9:1-88', 'Matthew', 'SBLGNT Matthew 4:15+13 4:15-32', 17792, 22, 7230, 22, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (122, 2, 'Isaiah', null, 'LXX Isaiah 9:1+141 9:1-17', 'Matthew', 'SBLGNT Matthew 4:15+35 4:15', 17853, 32, 7252, 32, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (122, 2, 'Isaiah', null, 'LXX Isaiah 9:2+12 9:2-63', 'Matthew', 'SBLGNT Matthew 4:16+10 4:16-69', 17914, 11, 7294, 11, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (122, 2, 'Isaiah', null, 'LXX Isaiah 9:2+50 9:2-12', 'Matthew', 'SBLGNT Matthew 4:16+51 4:16-15', 17952, 24, 7335, 24, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (122, 2, 'Isaiah', null, 'LXX Isaiah 9:1+71 9:2-12', 'Matthew', 'SBLGNT Matthew 4:15+2 4:16-15', 17783, 193, 7219, 140, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (122, 2, 'Ησαΐου του προφητου', 'λεγοντος'); -- λεγοντος = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (122, 2, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (123, 1, 'Isaiah', null, 'LXX Isaiah 49:8+16 49:8-77', 'II_Corinthians', 'SBLGNT II_Corinthians 6:2+8 6:2-45', 99749, 50, 8510, 50, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (123, 1, 'Isaiah', null, 'LXX Isaiah 49:8+16 49:8-77', 'II_Corinthians', 'SBLGNT II_Corinthians 6:2+8 6:2-45', 99749, 50, 8510, 50, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (123, 1, 'θεου', 'λεγει γαρ'); -- λεγει γαρ = He says for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (123, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (124, 1, 'Isaiah', null, 'LXX Isaiah 40:3+27 40:3-35', 'John', 'SBLGNT John 1:23+31 1:23-25', 78225, 16, 1462, 16, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (124, 1, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-57', 'John', 'SBLGNT John 1:23+6 1:23-45', 78198, 21, 1437, 21, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (124, 1, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-35', 'John', 'SBLGNT John 1:23+6 1:23-25', 78198, 43, 1437, 41, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (124, 1, 'Ησαΐας ο προφητης', 'καθως ειπεν'); -- Ησαΐας ο προφητης = Isaiah the prophet, καθως ειπεν = as said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (124, 1, 'quotation', 'literal, fuzzy, change', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (124, 2, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-11', 'Luke', 'SBLGNT Luke 3:4+40 3:4-5', 78198, 67, 10557, 67, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (124, 2, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-11', 'Luke', 'SBLGNT Luke 3:4+40 3:4-5', 78198, 67, 10557, 67, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (124, 2, 'εν βιβλω λογων Ησαΐου του προφητου', 'ως γεγραπται'); -- εν βιβλω λογων Ησαΐου του προφητου = in the book of the words of Isaiah the prophet, ως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (124, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (124, 3, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-11', 'Mark', 'SBLGNT Mark 1:3 1:3-5', 78198, 67, 136, 67, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (124, 3, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-11', 'Mark', 'SBLGNT Mark 1:3 1:3-5', 78198, 67, 136, 67, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (124, 3, 'εν τω Ησαΐα τω προφητη', 'Καθως γεγραπται'); -- εν τω Ησαΐα τω προφητη = in Isaiah the prophet, Καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (124, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (124, 4, 'Isaiah', null, 'LXX Isaiah 40:2+145 40:3-11', 'Matthew', 'SBLGNT Matthew 3:3+47 3:3-5', 78197, 68, 4680, 68, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (124, 4, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-11', 'Matthew', 'SBLGNT Matthew 3:3+48 3:3-5', 78198, 67, 4681, 67, 'gmanual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (124, 4, 'δια Ησαΐου του προφητου', 'ρηθεις ... λεγοντος'); -- ρηθεις ... λεγοντος = having been spoken of ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (124, 4, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (125, 1, 'Isaiah', null, 'LXX Isaiah 52:11+72 52:11-23', 'II_Corinthians', 'SBLGNT II_Corinthians 6:17+26 6:17-50', 106991, 10, 9683, 10, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (125, 1, 'Isaiah', null, 'LXX Isaiah 52:11+52 52:11-35', 'II_Corinthians', 'SBLGNT II_Corinthians 6:17+3 6:17-65', 106971, 18, 9660, 18, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (125, 1, 'Isaiah', null, 'LXX Isaiah 52:11+31 52:11-53', 'II_Corinthians', 'SBLGNT II_Corinthians 6:17+47 6:17-18', 106950, 21, 9704, 21, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (125, 1, 'Isaiah', null, 'LXX Isaiah 52:11+31 52:11-23', 'II_Corinthians', 'SBLGNT II_Corinthians 6:17+3 6:17-18', 106950, 51, 9660, 65, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (125, 1, 'κυριος', 'διο ... λεγει'); -- διο ... λεγει = therefore ... says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (125, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (126, 1, 'Isaiah', null, 'LXX Isaiah 54:1 54:1-14', 'Galatians', 'SBLGNT Galatians 4:27+12 4:27', 108811, 102, 7727, 102, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (126, 1, 'Isaiah', null, 'LXX Isaiah 54:1 54:1-14', 'Galatians', 'SBLGNT Galatians 4:27+12 4:27', 108811, 102, 7727, 102, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (126, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (126, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (127, 1, 'Isaiah', null, 'LXX Isaiah 57:19+29 57:19-31', 'Ephesians', 'SBLGNT Ephesians 2:17+51 2:18-65', 115041, 10, 3440, 10, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (127, 1, 'Isaiah', null, 'LXX Isaiah 57:19+9 57:19-50', 'Ephesians', 'SBLGNT Ephesians 2:17+44 2:17-5', 115021, 11, 3433, 11, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (127, 1, 'Isaiah', null, 'LXX Isaiah 57:19 57:19-32', 'Ephesians', 'SBLGNT Ephesians 2:17+20 2:17', 115012, 38, 3409, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (127, 1, null, 'ευηγγελισατο'); -- ευηγγελισατο = He proclaimed the gospel
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (127, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (128, 1, 'Isaiah', null, 'LXX Isaiah 8:18 8:18-78', 'Hebrews', 'SBLGNT Hebrews 2:13+39 2:13', 17131, 33, 2440, 33, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (128, 1, 'Isaiah', null, 'LXX Isaiah 8:17+67 8:18-78', 'Hebrews', 'SBLGNT Hebrews 2:13+11 2:13', 17111, 53, 2412, 61, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (128, 1, null, 'και παλιν ... και παλιν'); -- και παλιν = and again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (128, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (129, 1, 'Isaiah', null, 'LXX Isaiah 26:20+66 26:20-23', 'Hebrews', 'SBLGNT Hebrews 10:37+6 10:37-27', 49503, 14, 18038, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (129, 1, 'Isaiah', null, 'LXX Isaiah 26:20+66 26:20-23', 'Hebrews', 'SBLGNT Hebrews 10:37+6 10:37-27', 49503, 14, 18038, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (129, 1, null, 'ετι γαρ'); -- ετι γαρ = yet for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (129, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (130, 1, 'Isaiah', null, 'LXX Isaiah 40:6+40 40:6-20', 'I_Peter', 'SBLGNT I_Peter 1:24+15 1:24-50', 78495, 18, 2065, 18, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (130, 1, 'Isaiah', null, 'LXX Isaiah 40:6+65 40:8-27', 'I_Peter', 'SBLGNT I_Peter 1:24+37 1:25-61', 78520, 54, 2087, 54, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (130, 1, 'Isaiah', null, 'LXX Isaiah 40:6+32 40:8', 'I_Peter', 'SBLGNT I_Peter 1:24+5 1:25-39', 78487, 114, 2055, 108, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (130, 1, null, 'διοτι'); -- διοτι = because
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (130, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (131, 1, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7', 'Mark', 'SBLGNT Mark 11:17+42 11:17-36', 112775, 48, 36988, 48, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (131, 1, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7', 'Mark', 'SBLGNT Mark 11:17+42 11:17-36', 112775, 48, 36988, 48, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (131, 1, null, 'Ου γεγραπται οτι'); -- Ου γεγραπται οτι = not has it been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (131, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (131, 2, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7-16', 'Matthew', 'SBLGNT Matthew 21:13+24 21:13-33', 112775, 32, 59893, 32, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (131, 2, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7-16', 'Matthew', 'SBLGNT Matthew 21:13+24 21:13-33', 112775, 32, 59893, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (131, 2, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (131, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (131, 3, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7-26', 'Luke', 'SBLGNT Luke 19:46+29 19:46-35', 112775, 22, 75711, 22, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (131, 3, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7-26', 'Luke', 'SBLGNT Luke 19:46+29 19:46-35', 112775, 22, 75711, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (131, 3, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (131, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (132, 1, 'Isaiah', null, 'LXX Isaiah 53:9+78 53:9', 'I_Peter', 'SBLGNT I_Peter 2:22+7 2:22', 108358, 45, 4028, 45, 'getrefs');
-- The non-literal quotation is longer: I_Peter 2:22-25 cites and summarizes Isaiah 53:5-9. Extend...
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (132, 1, 'Isaiah', null, 'LXX Isaiah 53:9+78 53:9', 'I_Peter', 'SBLGNT I_Peter 2:22+7 2:22', 108358, 45, 4028, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (132, 1, null, 'υπολιμπανων υπογραμμον ινα επακολουθησητε'); -- υπολιμπανων υπογραμμον ινα επακολουθησητε = leaving an example that you should follow after
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (132, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (133, 1, 'Isaiah', null, 'LXX Isaiah 66:24+68 66:24-58', 'Mark', 'SBLGNT Mark 9:48+5 9:48-20', 133191, 19, 31052, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (133, 1, 'Isaiah', null, 'LXX Isaiah 66:24+68 66:24-28', 'Mark', 'SBLGNT Mark 9:48+5 9:48', 133191, 49, 31052, 39, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (133, 1, null, 'υπολιμπανων υπογραμμον ινα επακολουθησητε'); -- υπολιμπανων υπογραμμον ινα επακολουθησητε = leaving an example that you should follow after
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (133, 1, 'strong allusion', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (134, 1, 'Isaiah', null, 'LXX Isaiah 53:4', 'Matthew', 'Matthew 8:17', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (135, 1, 'Isaiah', null, 'LXX Isaiah 42:1+77 42:1-23', 'Matthew', 'SBLGNT Matthew 12:18+59 12:18-28', 83409, 19, 31171, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (135, 1, 'Isaiah', null, 'LXX Isaiah 42:1+95 42:1-7', 'Matthew', 'SBLGNT Matthew 12:18+80 12:18-9', 83427, 17, 31192, 17, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (135, 1, 'Isaiah', null, 'LXX Isaiah 42:2+19 42:2-20', 'Matthew', 'SBLGNT Matthew 12:19+19 12:19-33', 83470, 12, 31237, 12, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (135, 1, 'Isaiah', null, 'LXX Isaiah 42:2+46 42:3-78', 'Matthew', 'SBLGNT Matthew 12:19+59 12:20-77', 83497, 12, 31277, 12, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (135, 1, 'Isaiah', null, 'LXX Isaiah 42:3+27 42:3-48', 'Matthew', 'SBLGNT Matthew 12:20+29 12:20-45', 83529, 10, 31311, 10, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (135, 1, 'Isaiah', null, 'LXX Isaiah 42:3+43 42:3-28', 'Matthew', 'SBLGNT Matthew 12:20+42 12:20-28', 83545, 14, 31324, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (135, 1, 'Isaiah', null, 'LXX Isaiah 42:4+53 42:4', 'Matthew', 'SBLGNT Matthew 12:21+2 12:21', 83640, 28, 31368, 28, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (135, 1, 'Isaiah', null, 'LXX Isaiah 42:4+53 42:4', 'Matthew', 'SBLGNT Matthew 12:21+2 12:21', 83640, 28, 31368, 28, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (135, 1, 'Isaiah', null, 'LXX Isaiah 42:1+5 42:4', 'Matthew', 'SBLGNT Matthew 12:18+4 12:21', 83337, 331, 31116, 280, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (135, 1, 'Ησαΐου του προφητου', 'ρηθεν ... λεγοντος'); -- το ρηθεν ... λεγοντος = having been spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (135, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (136, 1, 'Isaiah', null, 'LXX Isaiah 6:10+96 6:10-66', 'John', 'SBLGNT John 12:40+59 12:40-44', 12595, 22, 44330, 22, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (136, 1, 'Isaiah', null, 'LXX Isaiah 6:10+164 6:10', 'John', 'SBLGNT John 12:40+105 12:40', 12663, 20, 44376, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (136, 1, 'Isaiah', null, 'LXX Isaiah 6:10+96 6:10', 'John', 'SBLGNT John 12:40+59 12:40', 12663, 88, 44376, 66, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (136, 1, 'Ησαΐας', 'ειπεν'); -- ειπεν = said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (136, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (136, 2, 'Isaiah', null, 'LXX Isaiah 6:9+35 6:10-142', 'Acts', 'SBLGNT Acts 28:26+39 28:27-137', 12443, 98, 95163, 98, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (136, 2, 'Isaiah', null, 'LXX Isaiah 6:10+46 6:10', 'Acts', 'SBLGNT Acts 28:27+41 28:27', 12545, 138, 95260, 138, 'getrefs');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (136, 2, 'Ησαΐου του προφητου', 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (136, 2, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (136, 3, 'Isaiah', null, 'LXX Isaiah 6:9+35 6:10-142', 'Matthew', 'SBLGNT Matthew 13:14+45 13:15-137', 12443, 98, 35214, 98, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (136, 3, 'Isaiah', null, 'LXX Isaiah 6:10+46 6:10', 'Matthew', 'SBLGNT Matthew 13:15+41 13:15', 12545, 138, 35311, 138, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (136, 3, 'Isaiah', null, 'LXX Isaiah 6:9+35 6:10', 'Matthew', 'SBLGNT Matthew 13:14+45 13:15', 12545, 240, 35311, 235, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (136, 3, 'η προφητεια Ησαΐου', 'η λεγουσα'); -- η λεγουσα = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (136, 3, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (137, 1, 'Isaiah', null, 'LXX Isaiah 29:13+24 29:13-104', 'Matthew', 'SBLGNT Matthew 15:8 15:8-37', 55467, 22, 42765, 22, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (137, 1, 'Isaiah', null, 'LXX Isaiah 29:13+60 29:13-31', 'Matthew', 'SBLGNT Matthew 15:8+28 15:9-28', 55503, 59, 42793, 59, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (137, 1, 'Isaiah', null, 'LXX Isaiah 29:13+118 29:13-11', 'Matthew', 'SBLGNT Matthew 15:9+38 15:10-51', 55561, 21, 42862, 21, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (137, 1, 'Isaiah', null, 'LXX Isaiah 29:13+139 29:13', 'Matthew', 'SBLGNT Matthew 15:9+28 15:9-17', 55582, 11, 42852, 11, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (137, 1, 'Isaiah', null, 'LXX Isaiah 29:13+24 29:13', 'Matthew', 'SBLGNT Matthew 15:8 15:9', 55467, 126, 42765, 115, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (137, 1, 'Ησαΐας', 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (137, 1, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (137, 2, 'Isaiah', null, 'LXX Isaiah 29:13+32 29:13-104', 'Mark', 'SBLGNT Mark 7:6+79 7:6-37', 55475, 14, 21322, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (137, 2, 'Isaiah', null, 'LXX Isaiah 29:13+60 29:13-31', 'Mark', 'SBLGNT Mark 7:6+99 7:7-28', 55503, 59, 21342, 59, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (137, 2, 'Isaiah', null, 'LXX Isaiah 29:13+118 29:13-14', 'Mark', 'SBLGNT Mark 7:7+38 7:7', 55561, 18, 21411, 18, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (137, 2, 'Isaiah', null, 'LXX Isaiah 29:13+139 29:13', 'Mark', 'SBLGNT Mark 7:7+28 7:7-17', 55582, 11, 21401, 11, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (137, 2, 'Isaiah', null, 'LXX Isaiah 29:13+32 29:13', 'Mark', 'SBLGNT Mark 7:6+79 7:7', 55467, 126, 21314, 115, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (137, 2, 'Ησαΐας', 'γεγραπται οτι'); -- γεγραπται οτι = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (137, 2, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (138, 1, 'Isaiah', null, 'LXX Isaiah 62:11+44 62:11-65', 'Matthew', 'SBLGNT Matthew 21:4+52 21:5-71', 124178, 24, 59120, 24, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (138, 1, 'Isaiah', null, 'LXX Isaiah 62:11+45 62:11-65', 'Matthew', 'SBLGNT Matthew 21:5 21:5-71', 124179, 23, 59121, 23, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (138, 1, 'του προφητου', 'ρηθεν ... λεγοντος'); -- having been spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (138, 1, 'quotation', 'literal', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 1, 'Jeremiah', null, 'LXX Jeremiah 31:15+50 31:15-64', 'Matthew', 'SBLGNT Matthew 2:18+25 2:18-66', 80265, 9, 3951, 9, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 1, 'Jeremiah', null, 'LXX Jeremiah 31:15+14 31:15-90', 'Matthew', 'SBLGNT Matthew 2:17+47 2:18-83', 80229, 19, 3924, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 1, 'Jeremiah', null, 'LXX Jeremiah 31:15+16 31:15', 'Matthew', 'SBLGNT Matthew 2:18', 80231, 107, 3926, 100, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (201, 1, 'δια Ιερεμιου του προφητου', 'το ρηθεν ... λεγοντος'); -- δια Ιερεμιου του προφητου = by Jeremiah the prophet, το ρηθεν ... λεγοντος = having been spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (201, 1, 'quotation', 'far-fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:31+63 31:32-152', 'Hebrews', 'SBLGNT Hebrews 8:8+96 8:9-149', 81873, 38, 11896, 38, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:32+27 31:32-27', 'Hebrews', 'SBLGNT Hebrews 8:9+26 8:9-25', 81919, 117, 11941, 117, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:32+146 31:32-11', 'Hebrews', 'SBLGNT Hebrews 8:9+143 8:9-11', 82038, 14, 12058, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:32+165 31:33-125', 'Hebrews', 'SBLGNT Hebrews 8:9+162 8:10-124', 82057, 65, 12077, 65, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:33+64 31:33-108', 'Hebrews', 'SBLGNT Hebrews 8:10+64 8:10-107', 82127, 12, 12147, 12, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:33+80 31:33-58', 'Hebrews', 'SBLGNT Hebrews 8:10+76 8:10-61', 82143, 46, 12159, 46, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:33+126 31:34-86', 'Hebrews', 'SBLGNT Hebrews 8:10+125 8:11-15', 82189, 170, 12208, 170, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:34+120 31:35-134', 'Hebrews', 'SBLGNT Hebrews 8:11+112 8:13-76', 82367, 79, 12378, 79, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:31+63 31:35-134', 'Hebrews', 'SBLGNT Hebrews 8:8+96 8:13-76', 81810, 636, 11824, 633, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (202, 1, null, 'λεγει'); -- λεγει = He says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (202, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (203, 1, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Luke', 'SBLGNT Luke 19:46+72 19:46', 19391, 14, 75754, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (203, 1, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Luke', 'SBLGNT Luke 19:46+72 19:46', 19391, 14, 75754, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (203, 1, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (203, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (203, 2, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Mark', 'SBLGNT Mark 11:17+112 11:17', 19391, 14, 37058, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (203, 2, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Mark', 'SBLGNT Mark 11:17+112 11:17', 19391, 14, 37058, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (203, 2, null, 'Ου γεγραπται οτι'); -- Ου γεγραπται οτι = not has it been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (203, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (203, 3, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Matthew', 'SBLGNT Matthew 21:13+75 21:13', 19391, 14, 59944, 14, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (203, 3, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Matthew', 'SBLGNT Matthew 21:13+75 21:13', 19391, 14, 59944, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (203, 3, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (203, 3, 'quotation', 'literal, exact', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (301, 1, 'Ezekiel', null, 'LXX Ezekiel 37:27+47 37:27-14', 'II_Corinthians', 'SBLGNT II_Corinthians 6:16+125 6:16-14', 104701, 12, 9631, 12, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (301, 1, 'Ezekiel', null, 'LXX Ezekiel 37:27+32 37:27', 'II_Corinthians', 'SBLGNT II_Corinthians 6:16+111 6:16', 104686, 41, 9617, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (301, 1, 'θεος', 'καθως ειπεν'); -- καθως ειπεν = as has said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (301, 1, 'quotation', 'literal, fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1001, 1, 'Habakkuk', null, 'LXX Habakkuk 2:4+39 2:4-10', 'Romans', 'SBLGNT Romans 1:17+68 1:17-7', 2126, 19, 1330, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1001, 1, 'Habakkuk', null, 'LXX Habakkuk 2:4+39 2:4', 'Romans','SBLGNT Romans 1:17+68 1:17', 2126, 29, 1330, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1001, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1001, 1, 'quotation', 'literal, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1001, 2, 'Habakkuk', null, 'LXX Habakkuk 2:4+42 2:4-10', 'Galatians', 'SBLGNT Galatians 3:11+45 3:11-7', 2129, 16, 4515, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1001, 2, 'Habakkuk', null, 'LXX Habakkuk 2:4+39 2:4', 'Galatians', 'SBLGNT Galatians 3:11+44 3:11', 2126, 29, 4514, 27, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1001, 2, null, 'οτι'); -- οτι = because
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1001, 2, 'quotation', 'literal, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1001, 3, 'Habakkuk', null, 'LXX Habakkuk 2:3+84 2:3-9', 'Hebrews', 'SBLGNT Hebrews 10:37+21 10:37-8', 2060, 18, 18053, 18, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1001, 3, 'Habakkuk', null, 'LXX Habakkuk 2:4 2:4-29', 'Hebrews', 'SBLGNT Hebrews 10:38+32 10:38', 2087, 39, 18111, 39, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1001, 3, 'Habakkuk', null, 'LXX Habakkuk 2:4+49 2:4-10', 'Hebrews', 'SBLGNT Hebrews 10:38+13 10:38-49', 2136, 9, 18092, 9, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1001, 3, 'Habakkuk', null, 'LXX Habakkuk 2:3+84 2:4-10', 'Hebrews', 'SBLGNT Hebrews 10:37+21 10:38-49', 2060, 85, 18053, 97, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1001, 3, null, 'κομισησθε την επαγγελιαν / ετι γαρ'); -- κομισησθε την επαγγελιαν / ετι γαρ = you may receive the promise / yet for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1001, 3, 'quotation', 'fuzzy, subset', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1101, 1, 'Malachi', null, 'LXX Malachi 1:3 1:3-68', 'Romans', 'SBLGNT Romans 9:13+29 9:13', 173, 16, 19060, 16, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1101, 1, 'Malachi', null, 'LXX Malachi 1:3 1:3-68', 'Romans', 'SBLGNT Romans 9:13+29 9:13', 159, 31, 19045, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1101, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1101, 1, 'quotation', 'literal, fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1201, 1, 'Haggai', null, 'LXX Haggai 2:6+31 2:6-44', 'Hebrews', 'SBLGNT Hebrews 12:26+46 12:26-30', 2323, 15, 24091, 15, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1201, 1, 'Haggai', null, 'LXX Haggai 2:6+31 2:6-25', 'Hebrews', 'SBLGNT Hebrews 12:26+46 12:26', 2323, 34, 24091, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1201, 1, null, 'επηγγελται λεγων'); -- επηγγελται λεγων = He has promised saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1201, 1, 'quotation', 'literal, fuzzy, subset', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1301, 1, 'Hosea', null, 'ABPGRK Hosea 2:23+38 2:23-34', 'Romans', 'SBLGNT Romans 9:25+24 9:25-10', null, 39, 19864, 38, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1301, 1, 'Ωσηε', 'λεγει'); -- Ωσηε = Hosea, λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1301, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1302, 1, 'Hosea', null, 'LXX Hosea 1:10+82 1:10', 'Romans', 'SBLGNT Romans 9:26 9:26', 1055, 73, 19912, 73, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1302, 1, 'Hosea', null, 'LXX Hosea 1:10+82 1:10', 'Romans', 'SBLGNT Romans 9:26', 1055, 73, 19912, 73, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1302, 1, 'Ωσηε', 'λεγει'); -- Ωσηε = Hosea, λεγει = says (in Romans 9:25)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1302, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1303, 1, 'Hosea', null, 'LXX Hosea 1:10+5 1:10-110', 'Romans', 'SBLGNT Romans 9:27+31 9:27-20', 978, 40, 20016, 40, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1303, 1, 'Hosea', null, 'LXX Hosea 1:10+5 1:10-110', 'Romans', 'SBLGNT Romans 9:27+31 9:27-20', 978, 40, 20016, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1303, 1, 'Ωσηε', 'λεγει'); -- Ωσηε = Hosea, λεγει = says (in Romans 9:25)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1303, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1304, 1, 'Hosea', null, 'LXX Hosea 11:1+38 1:11-11', 'Matthew', 'SBLGNT Matthew 2:15+77 2:15-9', 15030, 21, 3672, 18, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1304, 1, 'δια του προφητου', 'το ρηθεν υπο κυριου ... λεγοντος'); -- δια του προφητου = through the prophet, το ρηθεν υπο κυριου ... λεγοντος = having been spoken by the Lord ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1304, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1305, 1, 'Hosea', null, 'LXX Hosea 13:14+61 13:14-51', 'I_Corinthians', 'SBLGNT I_Corinthians 15:55+22 15:55-9', 18605, 9, 30849, 9, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1305, 1, 'Hosea', null, 'LXX Hosea 13:14+73 13:14-39', 'I_Corinthians', 'SBLGNT I_Corinthians 15:55+31 15:55', 18617, 9, 30858, 9, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1305, 1, 'Hosea', null, 'LXX Hosea 13:14+61 13:14-39', 'I_Corinthians', 'SBLGNT I_Corinthians 15:55+19 15:55', 18605, 21, 30846, 21, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1305, 1, null, 'γεγραμμενος'); -- γεγραμμενος = having been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1305, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1306, 1, 'Hosea', null, 'LXX Hosea 6:6+5 6:6-29', 'Matthew', 'SBLGNT Matthew 9:13+26 9:13-39', 8273, 20, 21658, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1306, 1, 'Hosea', null, 'LXX Hosea 6:6+5 6:6-29', 'Matthew', 'SBLGNT Matthew 9:13+26 9:13-39', 8273, 20, 21658, 20, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1306, 1, null, 'πορευθεντες δε μαθετε τι εστιν'); -- πορευθεντες δε μαθετε τι εστιν = having gone however learn what is
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1306, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1306, 2, 'Hosea', null, 'LXX Hosea 6:6+5 6:6-29', 'Matthew', 'SBLGNT Matthew 12:7+20 12:7-30', 8273, 20, 30379, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1306, 2, 'Hosea', null, 'LXX Hosea 6:6+5 6:6-29', 'Matthew', 'SBLGNT Matthew 12:7+20 12:7-30', 8273, 20, 30379, 20, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1306, 2, null, 'ει δε εγνωκειτε τι εστιν'); -- ει δε εγνωκειτε τι εστιν = if however you had known what is
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1306, 2, 'quotation', 'literal, exact', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 1, 'Joel', null, 'LXX Joel 2:32+11 2:32-103', 'Romans', 'SBLGNT Romans 10:13+6 10:13', 5577, 38, 21452, 38, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 1, 'Joel', null, 'LXX Joel 2:32+8 2:32-103', 'Romans', 'SBLGNT Romans 10:13', 5577, 41, 21452, 44, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1401, 1, null, 'γαρ'); -- γαρ = for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1401, 1, 'quotation', 'literal, exact, subset', 'Z.K.'); -- subset because of insertion of "γαρ"
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:29+52 2:29', 'Acts', 'SBLGNT Acts 2:17+38 2:17-135', 5393, 24, 4005, 24, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:28+20 2:28-70', 'Acts', 'SBLGNT Acts 2:17+39 2:17-72', 5185, 86, 4006, 86, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:28+144 2:29-73', 'Acts', 'SBLGNT Acts 2:17+120 2:17-42', 5309, 35, 4087, 35, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:28+101 2:28-49', 'Acts', 'SBLGNT Acts 2:17+152 2:17-19', 5266, 26, 4119, 26, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:28+128 2:28-29', 'Acts', 'SBLGNT Acts 2:17+181 2:18-98', 5293, 19, 4148, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:29+17 2:29-44', 'Acts', 'SBLGNT Acts 2:18+22 2:18-64', 5358, 15, 4186, 15, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:29+32 2:30-57', 'Acts', 'SBLGNT Acts 2:18+40 2:18-14', 5373, 47, 4204, 47, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:28+56 2:28-103', 'Acts', 'SBLGNT Acts 2:18+84 2:18', 5221, 17, 4248, 17, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:30 2:30-37', 'Acts', 'SBLGNT Acts 2:19 2:19-50', 5417, 23, 4265, 23, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:30+35 2:31-38', 'Acts', 'SBLGNT Acts 2:19+48 2:20-39', 5452, 76, 4313, 76, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:31+51 2:32-139', 'Acts', 'SBLGNT Acts 2:20+52 2:21-37', 5528, 51, 4390, 51, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:32+13 2:32-103', 'Acts', 'SBLGNT Acts 2:21+14 2:21', 5579, 36, 4442, 36, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 2, 'Joel', null, 'LXX Joel 2:28 2:32-103', 'Acts', 'SBLGNT Acts 2:17 2:21', 5165, 450, 3967, 511, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1401, 2, 'προφητου Ιωηλ', 'ειρημενον'); -- προφητου Ιωηλ = prophet Joel, ειρημενον = having been spoken
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1401, 2, 'quotation', 'literal, fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1501, 1, 'Micah', null, 'LXX Micah 5:2 5:2-132', 'Matthew', 'SBLGNT Matthew 2:6 2:6-103', 6563, 12, 2608, 12, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1501, 1, 'Micah', null, 'LXX Micah 5:2+52 5:2-79', 'Matthew', 'SBLGNT Matthew 2:6+47 2:6-55', 6615, 13, 2655, 13, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1501, 1, 'Micah', null, 'LXX Micah 5:2 5:2-79', 'Matthew', 'SBLGNT Matthew 2:6 2:6-55', 6563, 65, 2608, 60, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1501, 1, 'δια του προφητου', 'γαρ γεγραπται'); -- γαρ γεγραπται, δια του προφητου = for has it been written, through the prophet
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1501, 1, 'quotation', 'far-fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1601, 1, 'Amos', null, 'LXX Amos 5:26+51 5:26-24', 'Acts', 'SBLGNT Acts 7:43+47 7:43-60', 9273, 16, 22213, 16, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1601, 1, 'Amos', null, 'LXX Amos 5:26+85 5:27-45', 'Acts', 'SBLGNT Acts 7:43+85 7:43-9', 9307, 29, 22251, 29, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1601, 1, 'Amos', null, 'LXX Amos 5:25 5:25-34', 'Acts', 'SBLGNT Acts 7:42+93 7:42-34', 9155, 33, 22099, 33, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1601, 1, 'Amos', null, 'LXX Amos 5:25+56 5:26-44', 'Acts', 'SBLGNT Acts 7:42+149 7:43-76', 9211, 58, 22155, 58, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1601, 1, 'Amos', null, 'LXX Amos 5:25 5:27-45', 'Acts', 'SBLGNT Acts 7:42+93 7:43-9', 9155, 181, 22099, 181, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1601, 1, 'εν βιβλω των προφητων', 'καθως γεγραπται'); -- εν βιβλω των προφητων = in the book of the prophets, καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1601, 1, 'quotation', 'literal, fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1701, 1, 'Zechariah', null, 'LXX Zechariah 9:9+46 9:9-62', 'Matthew', 'SBLGNT Matthew 21:5+19 21:5-49', 14394, 26, 59140, 26, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1701, 1, 'Zechariah', null, 'LXX Zechariah 9:9+92 9:9-21', 'Matthew', 'SBLGNT Matthew 21:5+45 21:5-28', 14440, 21, 59166, 21, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1701, 1, 'Zechariah', null, 'LXX Zechariah 9:9+46 9:9', 'Matthew', 'SBLGNT Matthew 21:5+19 21:5', 14394, 88, 59140, 75, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1701, 1, 'του προφητου', 'ρηθεν ... λεγοντος'); -- having been spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1701, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1701, 2, 'Zechariah', null, 'LXX Zechariah 9:9+46 9:9-65', 'John', 'SBLGNT John 12:15+18 12:15-21', 14394, 23, 42229, 23, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1701, 2, 'Zechariah', null, 'LXX Zechariah 9:9+11 9:9', 'John', 'SBLGNT John 12:15+7 12:15', 14359, 123, 42218, 55, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1701, 2, null, 'καθως εστιν γεγραμμενον'); -- καθως εστιν γεγραμμενον = as it is written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1701, 2, 'quotation', 'literal, far-fuzzy, superset', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2001, 1, 'Genesis', null, 'LXX Genesis 15:6+16 15:6', 'Romans', 'SBLGNT Romans 4:3+32 4:3', 34471, 36, 7233, 36, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2001, 1, 'Genesis', null, 'LXX Genesis 15:6+3 15:6', 'Romans', 'SBLGNT Romans 4:3+16 4:3', 34458, 49, 7217, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 1, 'η γραφη', 'λεγει'); -- η γραφη = the Scripture, λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2001, 2, 'Genesis', null, 'LXX Genesis 15:6+18 15:6', 'Galatians', 'SBLGNT Galatians 3:6+21 3:6', 34473, 34, 4109, 34, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2001, 2, 'Genesis', null, 'LXX Genesis 15:6+3 15:6', 'Galatians', 'SBLGNT Galatians 3:6+5 3:6', 34458, 49, 4093, 50, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 2, null, 'καθως'); -- καθως = so also
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 2, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2001, 3, 'Genesis', null, 'LXX Genesis 15:6+16 15:6', 'James', 'SBLGNT James 2:23+41 2:23-18', 34471, 36, 3924, 34, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2001, 3, 'Genesis', null, 'LXX Genesis 15:6+3 15:6', 'James', 'SBLGNT James 2:23+25 2:23-18', 34458, 49, 3908, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 3, 'η γραφη', 'λεγουσα'); -- η γραφη = the Scripture, λεγουσα = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 3, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2001, 4, 'Genesis', null, 'LXX Genesis 15:6+3 15:6', 'Romans', 'SBLGNT Romans 4:9+65 4:9', 34458, 49, 7654, 37, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 4, null, 'λεγομεν γαρ'); -- λεγομεν γαρ = we are saying for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 4, 'repeated quotation', 'far-fuzzy, supertext', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2001, 5, 'Genesis', null, 'LXX Genesis 15:6+26 15:6', 'Romans', 'SBLGNT Romans 4:22+3 4:22', 34458, 26, 8856, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 5, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 5, 'repetition', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2001, 6, 'Genesis', null, 'LXX Genesis 15:6+26 15:6', 'Romans', 'SBLGNT Romans 4:23+26 4:23', 34482, 12, 8908, 12, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 6, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 6, 'repetition', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2002, 1, 'Genesis', null, 'LXX Genesis 17:5+57 17:6-65', 'Romans', 'SBLGNT Romans 4:17+14 4:17-75', 37722, 31, 8407, 31, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2002, 1, 'Genesis', null, 'LXX Genesis 17:5+57 17:6-67', 'Romans', 'SBLGNT Romans 4:17+14 4:17-77', 37722, 29, 8407, 29, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2002, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2002, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2002, 2, 'Genesis', null, 'LXX Genesis 17:5+60 17:5-9', 'Romans', 'SBLGNT Romans 4:18+47 4:18-36', 37725, 17, 8560, 17, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2002, 2, 'Genesis', null, 'LXX Genesis 17:5+60 17:5-9', 'Romans', 'SBLGNT Romans 4:18+47 4:18-36', 37725, 17, 8560, 17, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2002, 2, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2002, 2, 'repetition', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2003, 1, 'Genesis', null, 'LXX Genesis 15:5+109 15:6-49', 'Romans', 'SBLGNT Romans 4:18+78 4:19-104', 34433, 25, 8591, 25, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2003, 1, 'Genesis', null, 'LXX Genesis 15:5+109 15:5', 'Romans', 'SBLGNT Romans 4:18+78 4:18', 34434, 21, 8592, 21, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2003, 1, null, 'κατα το ειρημενον'); -- κατα το ειρημενον = according to that having spoken
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2003, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2004, 1, 'Genesis', null, 'LXX Genesis 21:12+127 21:12', 'Romans', 'SBLGNT Romans 9:7+37 9:7', 50388, 26, 18644, 26, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2004, 1, 'Genesis', null, 'LXX Genesis 21:12+127 21:12', 'Romans', 'SBLGNT Romans 9:7+37 9:7', 50388, 26, 18644, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2004, 1, 'ο λογος του θεου', 'ου γαρ ... ουδ οτι ... αλλ'); -- ο λογος του θεου = the word of God, ου γαρ ... ουδ οτι ... αλλ = not for ... nor because ... rather
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2004, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2004, 2, 'Genesis', null, 'LXX Genesis 21:12+124 21:12', 'Hebrews', 'SBLGNT Hebrews 11:18+13 11:18', 50385, 29, 19944, 29, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2004, 2, 'Genesis', null, 'LXX Genesis 21:12+124 21:12', 'Hebrews', 'SBLGNT Hebrews 11:18+13 11:18', 50385, 29, 19944, 29, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2004, 2, null, 'ελαληθη οτι'); -- ελαληθη οτι = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2004, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2005, 1, 'Genesis', null, 'LXX Genesis 18:10+28 18:10-79', 'Romans', 'SBLGNT Romans 9:9+24 9:9-27', 40961, 20, 18780, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2005, 1, 'Genesis', null, 'LXX Genesis 18:14+63 18:14', 'Romans', 'SBLGNT Romans 9:9+52 9:9', 41367, 19, 18808, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2005, 1, 'Genesis', null, 'LXX Genesis 18:10+28 18:14', 'Romans', 'SBLGNT Romans 9:9+24 9:9', 40961, 425, 18780, 47, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2005, 1, null, 'επαγγελιας γαρ ο λογος ουτος'); -- επαγγελιας γαρ ο λογος ουτος = of the promise for the word is this
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2005, 1, 'quotation', 'literal, superset, synonym', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2006, 1, 'Genesis', null, 'LXX Genesis 25:23+103 25:24-64', 'Romans', 'SBLGNT Romans 9:12+39 9:13-43', 65834, 29, 19004, 29, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2006, 1, 'Genesis', null, 'LXX Genesis 25:23+103 25:24-64', 'Romans', 'SBLGNT Romans 9:12+39 9:13-43', 65834, 27, 19004, 27, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2006, 1, 'Ρεβεκκα ... αυτη', 'ερρεθη'); -- Ρεβεκκα ... αυτη = Rebecca ... to her, ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2006, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 1, 'Genesis', null, 'LXX Genesis 2:24+109 2:24', 'I_Corinthians', 'SBLGNT I_Corinthians 6:16+57 6:16', 5595, 17, 9366, 17, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 1, 'Genesis', null, 'LXX Genesis 2:24+102 2:24', 'I_Corinthians', 'SBLGNT I_Corinthians 6:16+42 6:16', 5588, 24, 9351, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2007, 1, null, 'γαρ φησιν'); -- γαρ φησιν = for it says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2007, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 2, 'Genesis', null, 'LXX Genesis 2:24+6 2:24-87', 'Ephesians', 'SBLGNT Ephesians 5:31+4 5:31-72', 5492, 33, 9802, 33, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 2, 'Genesis', null, 'LXX Genesis 2:24+61 2:24-46', 'Ephesians', 'SBLGNT Ephesians 5:31+49 5:31-41', 5547, 19, 9847, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 2, 'Genesis', null, 'LXX Genesis 2:24+94 2:24', 'Ephesians', 'SBLGNT Ephesians 5:31+77 5:31', 5580, 32, 9875, 32, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 2, 'Genesis', null, 'LXX Genesis 2:24', 'Ephesians', 'SBLGNT Ephesians 5:31', 5486, 126, 9798, 109, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2007, 2, null, 'το μυστηριον τουτο μεγα εστιν, εγω δε λεγω εις Χριστον και εις την εκκλησιαν'); -- το μυστηριον τουτο μεγα εστιν, εγω δε λεγω εις Χριστον και εις την εκκλησιαν = This is a great mystery: but I speak concerning Christ and the church.
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2007, 2, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 3, 'Genesis', null, 'LXX Genesis 2:24+94 2:24', 'Matthew', 'SBLGNT Matthew 19:5+82 19:5', 5580, 32, 53857, 32, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 3, 'Genesis', null, 'LXX Genesis 2:24+6 2:24-87', 'Matthew', 'SBLGNT Matthew 19:5+13 19:5-68', 5492, 33, 53788, 33, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 3, 'Genesis', null, 'LXX Genesis 2:24 2:24', 'Matthew', 'SBLGNT Matthew 19:5+8 19:5', 5486, 126, 53775, 106, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2007, 3, 'ο κτισας απ αρχης', 'Ουκ ανεγνωτε οτι'); -- ο κτισας απ αρχης = the One having created from the beginning, Ουκ ανεγνωτε οτι = Not have you read that (in Matthew 19:4)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2007, 3, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 4, 'Genesis', null, 'LXX Genesis 2:24 2:24-70', 'Mark', 'SBLGNT Mark 10:7 10:7-38', 5486, 56, 31613, 56, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 4, 'Genesis', null, 'LXX Genesis 2:24+61 2:24', 'Mark', 'SBLGNT Mark 10:7+56 10:8-29', 5547, 65, 31669, 65, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2007, 4, 'Genesis', null, 'LXX Genesis 2:24 2:24', 'Mark', 'SBLGNT Mark 10:7 10:8-29', 5486, 126, 31613, 121, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2007, 4, 'απο ... αρχης κτισεως', 'δε'); -- απο δε αρχης κτισεως = from ... the beginning of creation, δε = however (in Mark 10:6)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2007, 4, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2008, 1, 'Genesis', null, 'LXX Genesis 1:27+53 1:27', 'Mark', 'SBLGNT Mark 10:6+17 10:6', 2703, 26, 31587, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2008, 1, 'απο ... αρχης κτισεως', 'δε'); -- απο δε αρχης κτισεως = from ... the beginning of creation, δε = however
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2008, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2008, 2, 'Genesis', null, 'LXX Genesis 1:27+53 1:27', 'Matthew', 'SBLGNT Matthew 19:4+46 19:4', 2703, 26, 53749, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2008, 2, 'ο κτισας απ αρχης', 'Ουκ ανεγνωτε οτι'); -- ο κτισας απ αρχης = the One having created from the beginning, Ουκ ανεγνωτε οτι = Not have you read that
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2008, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2009, 1, 'Genesis', null, 'LXX Genesis 2:7+98 2:7', 'I_Corinthians', 'SBLGNT I_Corinthians 15:45+43 15:45-30', 3957, 13, 30073, 13, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2009, 1, 'Genesis', null, 'LXX Genesis 2:7+82 2:7', 'I_Corinthians', 'SBLGNT I_Corinthians 15:45+17 15:45-30', 3941, 29, 30047, 39, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2009, 1, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2009, 1, 'quotation', 'literal, subtext, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2010, 1, 'Genesis', null, 'LXX Genesis 12:7+32 12:7-68', 'Galatians', 'SBLGNT Galatians 3:16+59 3:16-52', 28321, 13, 4940, 13, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2010, 1, null, 'ου λεγει ... αλλ'); -- ου λεγει ... αλλ = not it does say ... but
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2010, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2011, 1, 'Genesis', null, 'LXX Genesis 21:10+93 21:10-8', 'Galatians', 'SBLGNT Galatians 4:30+84 4:30-12', 50185, 13, 8016, 13, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2011, 1, 'Genesis', null, 'LXX Genesis 21:10+16 21:10-80', 'Galatians', 'SBLGNT Galatians 4:30+17 4:30-74', 50108, 18, 7949, 18, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2011, 1, 'Genesis', null, 'LXX Genesis 21:10+38 21:10-54', 'Galatians', 'SBLGNT Galatians 4:30+33 4:30-54', 50130, 22, 7965, 22, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2011, 1, 'Genesis', null, 'LXX Genesis 21:10+60 21:10-25', 'Galatians', 'SBLGNT Galatians 4:30+57 4:30-23', 50152, 29, 7989, 29, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2011, 1, 'Genesis', null, 'LXX Genesis 21:10+60 21:10-25', 'Galatians', 'SBLGNT Galatians 4:30+57 4:30-23', 50152, 29, 7989, 29, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2011, 1, 'Genesis', null, 'LXX Genesis 21:10+16 21:10-8', 'Galatians', 'SBLGNT Galatians 4:30+17 4:30-12', 50108, 90, 7949, 80, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2011, 1, null, 'αλλα τι λεγει η γραφη'); -- αλλα τι λεγει η γραφη = but what says the Scripture
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2011, 1, 'quotation', 'literal, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2012, 1, 'Genesis', null, 'LXX Genesis 2:2+11 2:2-83', 'Hebrews', 'SBLGNT Hebrews 4:4+42 4:4-27', 3379, 20, 4742, 20, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2012, 1, 'Genesis', null, 'LXX Genesis 2:2+64 2:2-10', 'Hebrews', 'SBLGNT Hebrews 4:4+49 4:4', 3432, 40, 4749, 40, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2012, 1, 'Genesis', null, 'LXX Genesis 2:2+14 2:2-10', 'Hebrews', 'SBLGNT Hebrews 4:4+32 4:4', 3482, 90, 4732, 57, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2012, 1, 'που περι της εβδομης', 'ειρηκεν γαρ'); -- που περι της εβδομης = somewhere concering the seventh day, ειρηκεν γαρ = He has spoken for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2012, 1, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2013, 1, 'Genesis', null, 'LXX Genesis 22:17+1 22:17-121', 'Hebrews', 'SBLGNT Hebrews 6:14+7 6:14-2', 54247, 38, 8206, 38, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2013, 1, 'Genesis', null, 'LXX Genesis 22:17+1 22:17-121', 'Hebrews', 'SBLGNT Hebrews 6:14+7 6:14-2', 54247, 38, 8206, 38, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2013, 1, null, 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2013, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2014, 1, 'Genesis', null, 'LXX Genesis 14:17+62 14:17-82', 'Hebrews', 'SBLGNT Hebrews 7:1+84 7:1-27', 33237, 12, 8855, 12, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2014, 1, 'Genesis', null, 'LXX Genesis 14:18+3 14:18-50', 'Hebrews', 'SBLGNT Hebrews 7:1+9 7:1-91', 33334, 23, 8780, 23, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2014, 1, 'Genesis', null, 'LXX Genesis 14:18+53 14:18', 'Hebrews', 'SBLGNT Hebrews 7:1+32 7:1-68', 33384, 23, 8803, 23, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2014, 1, 'Genesis', null, 'LXX Genesis 14:20+77 14:21-66', 'Hebrews', 'SBLGNT Hebrews 7:2+4 7:2-99', 33569, 17, 8898, 17, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2014, 1, 'Genesis', null, 'LXX Genesis 14:17+62 14:20', 'Hebrews', 'SBLGNT Hebrews 7:1+9 7:2-100', 33237, 348, 8780, 134, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2014, 1, null, 'Ουτος γαρ'); -- Ουτος γαρ = this for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2014, 1, 'quotation', 'superset, far-fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2101, 1, 'Exodus', null, 'LXX Exodus 33:19+86 33:19', 'Romans', 'SBLGNT Romans 9:15+15 9:15', 99825, 38, 19129, 38, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2101, 1, 'Exodus', null, 'LXX Exodus 33:19+87 33:19', 'Romans', 'SBLGNT Romans 9:15+16 9:15', 99826, 37, 19130, 37, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2101, 1, 'τω Μωυσει', 'γαρ λεγει'); -- τω Μωυσει = to Moses, γαρ λεγει = for He says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2101, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2102, 1, 'Exodus', null, 'LXX Exodus 9:16+28 9:16-43', 'Romans', 'SBLGNT Romans 9:17+50 9:17-45', 24278, 18, 19271, 18, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2102, 1, 'Exodus', null, 'LXX Exodus 9:16+50 9:16', 'Romans', 'SBLGNT Romans 9:17+74 9:17', 24300, 39, 19295, 39, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2102, 1, 'Exodus', null, 'LXX Exodus 9:16+28 9:16', 'Romans', 'SBLGNT Romans 9:17+50 9:17', 24278, 61, 19271, 63, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2102, 1, 'τω Φαραω', 'λεγει γαρ η γραφη'); -- τω Φαραω = to Pharaoh, λεγει γαρ η γραφη = says for the Scripture
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2102, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
-- The Ten Commandments:
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2103, 1, 'Exodus', null, 'LXX Exodus 20:13 20:15', 'Romans', 'SBLGNT Romans 13:9+5 13:9-96', 57313, 32, 27194, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 1, 'νομον', 'το γαρ'); -- νομον = the Law (in Romans 13:8), το γαρ = for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2103, 2, 'Exodus', null, 'LXX Exodus 20:12+27 20:12-63', 'Ephesians', 'SBLGNT Ephesians 6:2+58 6:3-24', 57231, 19, 10174, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2103, 2, 'Exodus', null, 'LXX Exodus 20:12 20:12-35', 'Ephesians', 'SBLGNT Ephesians 6:2 6:3', 57204, 74, 10116, 101, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 2, 'εντολη', null); -- εντολη = commandment
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 2, 'quotation', 'literal, exact, subset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2103, 3, 'Exodus', null, 'LXX Exodus 20:12 20:12-81', 'Mark', 'SBLGNT Mark 7:10+14 7:10-44', 57204, 28, 21570, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 3, 'Μωυσης', 'γαρ ειπεν'); -- γαρ ειπεν = for said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2103, 4, 'Exodus', null, 'LXX Exodus 20:12 20:16-31', 'Mark', 'SBLGNT Mark 10:19+15 10:9', 57204, 159, 32466, 87, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 4, 'τας εντολας', 'οιδας'); -- τας εντολας οιδας = the commandments you know
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 4, 'quotation', 'literal, far-fuzzy, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2103, 5, 'Exodus', null, 'LXX Exodus 20:12 20:16-31', 'Luke', 'SBLGNT Luke 18:20+15 18:20', 57204, 159, 70598, 74, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 5, 'τας εντολας', 'οιδας'); -- τας εντολας οιδας = the commandments you know
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 5, 'quotation', 'literal, far-fuzzy, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2103, 6, 'Exodus', null, 'LXX Exodus 20:13 20:14', 'James', 'SBLGNT James 2:11+9 2:11-46', 57313, 23, 3015, 29, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 6, null, 'ο γαρ ειπων ... ειπεν και'); -- ο γαρ ειπων = the One for having said, ειπεν και = said also
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 6, 'quotation', 'literal, far-fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2103, 7, 'Exodus', null, 'LXX Exodus 20:13 20:13', 'Matthew', 'SBLGNT Matthew 5:21+29 5:21-31', 57313, 11, 9907, 11, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 7, null, 'ερρεθη'); -- ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 7, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2103, 8, 'Exodus', null, 'LXX Exodus 20:12 20:16-31', 'Matthew', 'SBLGNT Matthew 19:18+30 19:19-34', 57204, 159, 54982, 75, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 8, 'τας εντολας', null); -- τας εντολας = the commandments
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 8, 'quotation', 'literal, exact, far-fuzzy, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2103, 9, 'Exodus', null, 'LXX Exodus 20:14 20:14', 'Matthew', 'SBLGNT Matthew 5:27+17 5:27', 57324, 12, 10489, 12, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 9, null, 'ερρεθη'); -- ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 9, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2103, 10, 'Exodus', null, 'LXX Exodus 20:12 20:14', 'Matthew', 'SBLGNT Matthew 15:4+13 15:4-41', 57204, 28, 42524, 25, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 10, 'θεος', 'ειπεν'); -- ειπεν = commanded
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 10, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
-- End of the Ten Commandments.
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2104, 1, 'Exodus', null, 'LXX Exodus 13:12+10 13:12-91', 'Luke', 'SBLGNT Luke 2:23+29 2:23-10', 37422, 35, 7753, 35, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2104, 1, 'εν νομω κυριου', 'καθως γεγραπται'); -- εν νομω κυριου = in the law of the Lord, καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2104, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2105, 1, 'Exodus', null, 'LXX Exodus 32:6+98 32:6', 'I_Corinthians', 'SBLGNT I_Corinthians 10:7+75 10:7', 94513, 22, 16541, 22, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2105, 1, 'Exodus', null, 'LXX Exodus 32:6+72 32:6-23', 'I_Corinthians', 'SBLGNT I_Corinthians 10:7+50 10:7-22', 94487, 25, 16516, 25, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2105, 1, 'Exodus', null, 'LXX Exodus 32:6+72 32:6', 'I_Corinthians', 'SBLGNT I_Corinthians 10:7+50 10:7', 94487, 48, 16516, 47, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2105, 1, null, 'ωσπερ γεγραπται'); -- ωσπερ γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2105, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2106, 1, 'Exodus', null, 'LXX Exodus 20:5+2 20:5-115', 'Matthew', 'SBLGNT Matthew 4:10+59 4:10-3', 56471, 31, 6932, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2106, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2106, 1, 'quotation', 'literal, changed, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2106, 2, 'Exodus', null, 'LXX Exodus 20:5+2 20:5-115', 'Luke', 'SBLGNT Luke 4:8+54 4:8-3', 56471, 31, 13608, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2106, 2, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2106, 2, 'quotation', 'literal, changed, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2107, 1, 'Exodus', null, 'LXX Exodus 16:18+21 16:18-75', 'II_Corinthians', 'SBLGNT II_Corinthians 8:15+21 8:15-26', 47144, 13, 12704, 13, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2107, 1, 'Exodus', null, 'LXX Exodus 16:18+52 16:18-41', 'II_Corinthians', 'SBLGNT II_Corinthians 8:15+44 8:15', 47175, 16, 12727, 16, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2107, 1, 'Exodus', null, 'LXX Exodus 16:18+21 16:18-41', 'II_Corinthians', 'SBLGNT II_Corinthians 8:15+14 8:15', 47144, 47, 12704, 46, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2107, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2107, 1, 'quotation', 'literal, synonym, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2108, 1, 'Exodus', null, 'LXX Exodus 25:40+11 25:40-20', 'Hebrews', 'SBLGNT Hebrews 8:5+114 8:5-18', 73209, 17, 11599, 17, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2108, 1, 'Exodus', null, 'LXX Exodus 25:40+3 25:40', 'Hebrews', 'SBLGNT Hebrews 8:5+101 8:5', 73201, 45, 11586, 48, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2108, 1, 'Μωυσης', 'καθως κεχρηματισται ... φησιν'); -- καθως κεχρηματισται ... φησιν = as was divinely instructed ... He says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2108, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2109, 1, 'Exodus', null, 'LXX Exodus 24:8+50 24:8-45', 'Hebrews', 'SBLGNT Hebrews 9:20+10 9:20-23', 68770, 19, 14382, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2109, 1, 'Exodus', null, 'LXX Exodus 24:8+50 24:8-24', 'Hebrews', 'SBLGNT Hebrews 9:20+10 9:20-5', 68770, 40, 14382, 37, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2109, 1, null, 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2109, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2110, 1, 'Exodus', null, 'LXX Exodus 21:24 21:24-28', 'Matthew', 'SBLGNT Matthew 5:38+17 5:38', 60430, 37, 11387, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2110, 1, null, 'ερρεθη'); -- ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2110, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2111, 1, 'Exodus', null, 'LXX Exodus 23:20+1 23:20-54', 'Matthew', 'SBLGNT Matthew 11:10+23 11:10-36', 66260, 45, 28147, 45, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2111, 1, 'Exodus', null, 'LXX Exodus 23:20+1 23:20-54', 'Matthew', 'SBLGNT Matthew 11:10+23 11:10-36', 66260, 45, 28147, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2111, 1, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2111, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2112, 1, 'Exodus', null, 'LXX Exodus 21:17 21:17-33', 'Matthew', 'SBLGNT Matthew 15:4+41 15:4-22', 59825, 16, 42552, 16, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2112, 1, 'Exodus', null, 'LXX Exodus 21:17', 'Matthew', 'SBLGNT Matthew 15:4+41 15:4', 59825, 49, 42552, 38, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2112, 1, 'θεος', 'ειπεν'); -- ειπεν = commanded
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2112, 1, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2112, 2, 'Exodus', null, 'LXX Exodus 21:17 21:17-33', 'Mark', 'SBLGNT Mark 7:10+48 7:10-22', 59825, 16, 21604, 16, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2112, 2, 'Exodus', null, 'LXX Exodus 21:17', 'Mark', 'SBLGNT Mark 7:10+48 7:10', 59825, 49, 21604, 38, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2112, 2, 'Μωυσης', 'γαρ ειπεν'); -- γαρ ειπεν = for said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2112, 2, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2113, 1, 'Exodus', null, 'LXX Exodus 3:6+12 3:6-70', 'Matthew', 'SBLGNT Matthew 22:32 22:32-29', 4990, 58, 65497, 44, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2113, 1, 'θεου', 'λεγοντος'); -- λεγοντος = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2113, 1, 'quotation', 'literal, superset, fuzzy', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2201, 1, 'Leviticus', null, 'LXX Leviticus 18:5+69 18:5-21', 'Romans', 'SBLGNT Romans 10:5+46 10:5-1', 57053, 27, 20844, 27, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2201, 1, 'Leviticus', null, 'LXX Leviticus 18:5+69 18:5-21', 'Romans', 'SBLGNT Romans 10:5+46 10:5-1', 57053, 27, 20844, 27, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2201, 1, 'Μωυσης', 'γαρ γραφει'); -- γαρ γραφει = for writes
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2201, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2201, 2, 'Leviticus', null, 'LXX Leviticus 18:5+64 18:5-18', 'Galatians', 'SBLGNT Galatians 3:12+29 3:12', 57048, 35, 4567, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2201, 2, null, 'αλλ'); -- αλλ = rather
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2201, 2, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 1, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-22', 'Matthew', 'SBLGNT Matthew 5:43+17 5:43-23', 60912, 22, 11699, 22, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 1, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-22', 'Matthew', 'SBLGNT Matthew 5:43+17 5:43-23', 60912, 22, 11699, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 1, null, 'ερρεθη'); -- ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 2, 'Leviticus', null, 'LXX Leviticus 19:18+66 19:18-12', 'Luke', 'SBLGNT Luke 10:27+120 10:28-41', 60921, 23, 43138, 23, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 2, 'Leviticus', null, 'LXX Leviticus 19:18+66 19:18-12', 'Luke', 'SBLGNT Luke 10:27+120 10:28-41', 60921, 22, 43138, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 2, 'Εν τω νομω', 'γεγραπται'); -- Εν τω νομω = in the law, γεγραπται = has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 3, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'James', 'SBLGNT James 2:8+42 2:8-12', 60912, 31, 2835, 31, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 3, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'James', 'SBLGNT James 2:8+42 2:8-12', 60912, 31, 2835, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 3, 'νομον', 'κατα την γραφην'); -- νομον = law, κατα την γραφην = according to the Scripture
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 4, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Mark', 'SBLGNT Mark 12:31+11 12:31-30', 60912, 31, 40933, 31, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 4, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Mark', 'SBLGNT Mark 12:31+11 12:31-30', 60912, 31, 40933, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 4, 'εντολη', 'αυτη'); -- εντολη = commandment, αυτη = this
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 4, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 5, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Romans', 'SBLGNT Romans 13:9+102 13:9', 60912, 31, 27291, 31, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 5, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Romans', 'SBLGNT Romans 13:9+102 13:9', 60912, 31, 27291, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 5, 'εντολη', 'ανακεφαλαιουται εν τω'); -- εντολη = commandment, ανακεφαλαιουται εν τω = it is summed up in the
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 5, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 6, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-12', 'Galatians', 'SBLGNT Galatians 5:14+35 5:15-58', 60912, 32, 8944, 32, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 6, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Galatians', 'SBLGNT Galatians 5:14+35 5:14', 60912, 31, 8944, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 6, 'νομος', 'πεπληρωται εν τω'); -- νομος = Law, πεπληρωται εν τω = is fulfilled in this
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 6, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 7, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-12', 'Matthew', 'SBLGNT Matthew 22:39+18 22:40-56', 60912, 32, 65856, 32, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 7, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Matthew', 'SBLGNT Matthew 22:39+18 22:39', 60912, 31, 65856, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 7, 'εντολη ... εν τω νομω', 'αυτη εστιν ... δε ομοια αυτη'); -- εντολη ... εν τω νομω = commandment ... in the law, αυτη εστιν ... δε ομοια αυτη = this is ... also is like it
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 7, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 8, 'Leviticus', null, 'LXX Leviticus 19:18+54 19:18-13', 'Matthew', 'SBLGNT Matthew 19:19+25 19:19', 60909, 34, 55057, 34, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2202, 8, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Matthew', 'SBLGNT Matthew 19:19+28 19:19', 60912, 31, 55060, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 8, 'τας εντολας', 'Το'); -- τας εντολας = the commandments, Το = the
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 8, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2203, 1, 'Leviticus', null, 'LXX Leviticus 12:8+51 12:8-82', 'Luke', 'SBLGNT Luke 2:24+47 2:24', 33446, 33, 7845, 35, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2203, 1, 'εν τω νομω κυριου', 'το ειρημενον'); -- εν τω νομω κυριου = in the law of the Lord, το ειρημενον = that having been said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2203, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2204, 1, 'Leviticus', null, 'LXX Leviticus 26:11+53 26:12-44', 'II_Corinthians', 'SBLGNT II_Corinthians 6:16+95 6:16-40', 84290, 16, 9601, 16, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2204, 1, 'Leviticus', null, 'LXX Leviticus 26:12 26:12-44', 'II_Corinthians', 'SBLGNT II_Corinthians 6:16+96 6:16-40', 84291, 59, 9602, 55, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2204, 1, 'θεος', 'καθως ειπεν'); -- καθως ειπεν = as has said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2204, 1, 'quotation', 'literal, far-fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2205, 1, 'Leviticus', null, 'LXX Leviticus 19:2+48 19:2-14', 'I_Peter', 'SBLGNT I_Peter 1:16+17 1:17-107', 59515, 23, 1440, 23, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2205, 1, 'Leviticus', null, 'LXX Leviticus 19:2+48 19:2-14', 'I_Peter', 'SBLGNT I_Peter 1:16+17 1:17-107', 59515, 22, 1440, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2205, 1, null, 'διοτι γεγραπται οτι'); -- διοτι γεγραπται οτι = because it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2205, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2206, 1, 'Leviticus', null, 'LXX Leviticus 19:12', 'Matthew', 'Matthew 5:33a', 0, 0, 0, 0, 'traditional');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2301, 1, 'Numbers', null, 'LXX Numbers 16:5+73 16:5-75', 'II_Timothy', 'SBLGNT II_Timothy 2:19+65 2:19-43', 57258, 19, 2818, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2301, 1, 'Numbers', null, 'LXX Numbers 16:5+66 16:5-78', 'II_Timothy', 'SBLGNT II_Timothy 2:19+57 2:19-46', 57251, 23, 2810, 24, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2301, 1, null, 'εχων την σφραγιδα ταυτην'); -- εχων την σφραγιδα ταυτην = having the seal this
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2301, 1, 'quotation', 'literal, synonym', 'Z.K.');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2401, 1, 'Deuteronomy', null, 'LXX Deuteronomy 30:14+25 30:14-28', 'Romans', 'SBLGNT Romans 10:8+30 10:8-36', 94465, 30, 21067, 30, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2401, 1, 'Deuteronomy', null, 'LXX Deuteronomy 30:12+26 30:14-28', 'Romans', 'SBLGNT Romans 10:6+52 10:8-21', 94236, 259, 20924, 188, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2401, 1, 'Μωυσης', 'λεγει'); -- λεγει = says (Moses was already mentioned in Romans 10:5)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2401, 1, 'quotation', 'literal, subset, superset, far-fuzzy, change', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2402, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:21+58 32:21-44', 'Romans', 'SBLGNT Romans 10:19+41 10:19-40', 101516, 12, 21926, 12, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2402, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:21+75 32:21-6', 'Romans', 'SBLGNT Romans 10:19+56 10:19-4', 101533, 33, 21941, 33, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2402, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:21+56 32:21-44', 'Romans', 'SBLGNT Romans 10:19+41 10:19-40', 101514, 58, 21926, 53, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2402, 1, 'Μωυσης', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2402, 1, 'quotation', 'literal, fuzzy, grammatical-change', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2403, 1, 'Deuteronomy', null, 'LXX Deuteronomy 29:4+53 29:4-25', 'Romans', 'SBLGNT Romans 11:8+61 11:8-31', 89881, 13, 22762, 13, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2403, 1, 'Deuteronomy', null, 'LXX Deuteronomy 29:4+66 29:4-12', 'Romans', 'SBLGNT Romans 11:8+79 11:8-13', 89894, 13, 22780, 13, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2403, 1, 'Deuteronomy', null, 'LXX Deuteronomy 29:4+6 29:4-6', 'Romans', 'SBLGNT Romans 11:8+14 11:8', 89834, 79, 22715, 91, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2403, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2403, 1, 'quotation', 'literal, fuzzy, subset, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2404, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:35', 'Romans', 'Romans 12:19', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2404, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:35+7 32:35-73', 'Romans', 'SBLGNT Romans 12:19+63 12:19-11', 102578, 20, 26272, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2404, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2404, 1, 'quotation', 'fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2404, 2, 'Deuteronomy', null, 'LXX Deuteronomy 32:35-36', 'Hebrews', 'Hebrews 10:30', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2404, 2, 'Deuteronomy', null, 'LXX Deuteronomy 32:35+7 32:36-102', 'Hebrews', 'SBLGNT Hebrews 10:30+24 10:30', 102578, 120, 17508, 54, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2404, 2, 'τον', 'ειποντα ... και παλιν'); -- τον = the One, ειποντα = having said, και παλιν = and again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2404, 2, 'quotation', 'fuzzy, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2405, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:43+60 32:43-169', 'Romans', 'SBLGNT Romans 15:10+13 15:11-65', 103458, 33, 30225, 33, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2405, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:43+60 32:43-172', 'Romans', 'SBLGNT Romans 15:10+13 15:11-65', 103458, 30, 30225, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2405, 1, null, 'λεγει'); -- λεγει = it says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2405, 1, 'quotation', 'literal', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2405, 2, 'Deuteronomy', null, 'LXX Deuteronomy 32:43+24 32:43-210', 'Hebrews', 'SBLGNT Hebrews 1:6+53 1:6-11', 103422, 28, 570, 28, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2405, 2, 'Deuteronomy', null, 'LXX Deuteronomy 32:43+99 32:43-135', 'Hebrews', 'SBLGNT Hebrews 1:6+64 1:6', 103497, 28, 581, 28, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2405, 2, 'Deuteronomy', null, 'LXX Deuteronomy 32:43+24 32:43-135', 'Hebrews', 'SBLGNT Hebrews 1:6+53 1:6', 103422, 103, 570, 39, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2405, 2, null, 'λεγει'); -- λεγει = it says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2405, 2, 'quotation', 'literal, far-fuzzy, superset', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2406, 1, 'Deuteronomy', null, 'LXX Deuteronomy 24:1+100 24:1-60', 'Mark', 'SBLGNT Mark 10:4+24 10:4-11', 72306, 27, 31465, 23, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2406, 1, 'Μωυσης', 'εγραψεν'); -- εγραψεν = he wrote
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2406, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2406, 2, 'Deuteronomy', null, 'LXX Deuteronomy 24:1+110 24:1-60', 'Matthew', 'SBLGNT Matthew 19:7+39 19:7-16', 72316, 17, 53994, 17, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2406, 2, 'Μωυσης', 'ενετειλατο'); -- ενετειλατο = did command
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2406, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2406, 3, 'Deuteronomy', null, 'LXX Deuteronomy 24:1+117 24:1-52', 'Matthew', 'SBLGNT Matthew 5:31+34 5:31', 72323, 18, 10880, 18, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2406, 3, null, 'Ερρεθη'); -- Ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2406, 3, 'quotation', 'far-fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2407, 1, 'Deuteronomy', null, 'LXX Deuteronomy 25:4+4 25:4', 'I_Corinthians', 'SBLGNT I_Corinthians 9:9+31 9:9-19', 75102, 17, 14457, 17, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2407, 1, 'Deuteronomy', null, 'LXX Deuteronomy 25:4', 'I_Corinthians', 'SBLGNT I_Corinthians 9:9+31 9:9-19', 75098, 21, 14453, 21, 'getrefs');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2407, 1, 'εν ... τω Μωυσεως νομω ', 'γαρ ... γεγραπται'); -- εν γαρ τω Μωυσεως νομω γεγραπται = in for the of Moses law it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2407, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2407, 2, 'Deuteronomy', null, 'LXX Deuteronomy 25:4 25:4-11', 'I_Timothy', 'SBLGNT I_Timothy 5:18+25 5:18-30', 75098, 10, 6301, 10, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2407, 2, 'Deuteronomy', null, 'LXX Deuteronomy 25:4+10 25:4', 'I_Timothy', 'SBLGNT I_Timothy 5:18+14 5:18-40', 75108, 11, 6290, 11, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2407, 2, 'Deuteronomy', null, 'LXX Deuteronomy 25:4', 'I_Timothy', 'SBLGNT I_Timothy 5:18+14 5:18-30', 75098, 21, 6290, 21, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2407, 2, 'η γραφη', 'λεγει γαρ'); -- η γραφη = the Scripture, λεγει γαρ = says for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2407, 2, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2408, 1, 'Deuteronomy', null, 'LXX Deuteronomy 6:16 6:16-33', 'Luke', 'SBLGNT Luke 4:12+39 4:12', 23212, 30, 13910, 30, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2408, 1, 'Deuteronomy', null, 'LXX Deuteronomy 6:16 6:16-33', 'Luke', 'SBLGNT Luke 4:12+39 4:12', 23212, 30, 13910, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2408, 1, null, 'Ειρηται'); -- Ειρηται = it has been said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2408, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2408, 2, 'Deuteronomy', null, 'LXX Deuteronomy 6:16 6:16-33', 'Matthew', 'SBLGNT Matthew 4:7+28 4:7', 23212, 30, 6686, 30, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2408, 2, 'Deuteronomy', null, 'LXX Deuteronomy 6:16 6:16-33', 'Matthew', 'SBLGNT Matthew 4:7+28 4:7', 23212, 30, 6686, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2408, 2, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2408, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2409, 1, 'Deuteronomy', null, 'LXX Deuteronomy 8:3+140 8:3-16', 'Matthew', 'SBLGNT Matthew 4:4+73 4:4', 27931, 27, 6402, 27, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2409, 1, 'Deuteronomy', null, 'LXX Deuteronomy 8:3+91 8:3-45', 'Matthew', 'SBLGNT Matthew 4:4+26 4:4-27', 27882, 47, 6355, 47, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2409, 1, 'Deuteronomy', null, 'LXX Deuteronomy 8:3+91 8:3-16', 'Matthew', 'SBLGNT Matthew 4:4+26 4:4', 27882, 76, 6355, 74, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2409, 1, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2409, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2409, 2, 'Deuteronomy', null, 'LXX Deuteronomy 8:3+88 8:3-62', 'Luke', 'SBLGNT Luke 4:4+35 4:4', 27879, 33, 13302, 33, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2409, 2, 'Deuteronomy', null, 'LXX Deuteronomy 8:3+88 8:3-62', 'Luke', 'SBLGNT Luke 4:4+35 4:4', 27879, 33, 13302, 33, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2409, 2, null, 'γεγραπται οτι'); -- γεγραπται οτι = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2409, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2410, 1, 'Deuteronomy', null, 'LXX Deuteronomy 6:13 6:13-41', 'Matthew', 'SBLGNT Matthew 4:10+43 4:10', 22967, 41, 6916, 49, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2410, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2410, 1, 'quotation', 'literal, changed, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2410, 2, 'Deuteronomy', null, 'LXX Deuteronomy 6:13 6:13-41', 'Luke', 'SBLGNT Luke 4:8+38 4:8', 22967, 41, 13592, 49, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2410, 2, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2410, 2, 'quotation', 'literal, changed, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2411, 1, 'Deuteronomy', null, 'LXX Deuteronomy 27:26+22 27:26-72', 'Galatians', 'SBLGNT Galatians 3:10+68 3:10-53', 81686, 13, 4404, 13, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2411, 1, 'Deuteronomy', null, 'LXX Deuteronomy 27:26 27:26-92', 'Galatians', 'SBLGNT Galatians 3:10+54 3:10-65', 81664, 15, 4390, 15, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2411, 1, 'Deuteronomy', null, 'LXX Deuteronomy 27:26 27:26-28', 'Galatians', 'SBLGNT Galatians 3:10+54 3:10-1', 81664, 79, 4390, 79, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2411, 1, null, 'γεγραπται γαρ οτι'); -- γεγραπται γαρ οτι = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2411, 1, 'quotation', 'literal, grammatical-change, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2412, 1, 'Deuteronomy', null, 'LXX Deuteronomy 21:23+100 21:23-52', 'Galatians', 'SBLGNT Galatians 3:13+92 3:13', 66388, 18, 4685, 18, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2412, 1, 'Deuteronomy', null, 'LXX Deuteronomy 21:23+100 21:23-52', 'Galatians', 'SBLGNT Galatians 3:13+92 3:13', 66388, 18, 4685, 18, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2412, 1, null, 'οτι γεγραπται'); -- οτι γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2412, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2413, 1, 'Deuteronomy', null, 'LXX Deuteronomy 9:19+3 9:19-102', 'Hebrews', 'SBLGNT Hebrews 12:21+41 12:21-11', 32201, 11, 23637, 11, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2413, 1, 'Deuteronomy', null, 'LXX Deuteronomy 9:19+3 9:19-102', 'Hebrews', 'SBLGNT Hebrews 12:21+41 12:21-11', 32201, 11, 23637, 11, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2413, 1, 'Μωυσης', 'ειπεν'); -- ειπεν = said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2413, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2414, 1, 'Deuteronomy', null, 'LXX Deuteronomy 31:6+104 31:6-19', 'Hebrews', 'SBLGNT Hebrews 13:5+54 13:5-20', 96097, 9, 24617, 9, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2414, 1, 'Deuteronomy', null, 'LXX Deuteronomy 31:6+105 31:6', 'Hebrews', 'SBLGNT Hebrews 13:5+55 13:5', 96098, 27, 24618, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2414, 1, null, 'αυτος γαρ ειρηκεν'); -- αυτος γαρ ειρηκεν = He Himself for has said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2414, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2415, 1, 'Deuteronomy', null, 'LXX Deuteronomy 19:15+105 19:15-41', 'II_Corinthians', 'SBLGNT II_Corinthians 13:1+26 13:1-22', 60565, 25, 21157, 25, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2415, 1, 'Deuteronomy', null, 'LXX Deuteronomy 19:15+152 19:15', 'II_Corinthians', 'SBLGNT II_Corinthians 13:1+54 13:1', 60612, 19, 21185, 19, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2415, 1, 'Deuteronomy', null, 'LXX Deuteronomy 19:15+105 19:15', 'II_Corinthians', 'SBLGNT II_Corinthians 13:1+26 13:1', 60565, 66, 21157, 47, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2415, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2415, 1, 'strong allusion', 'literal, fuzzy, supertext', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2415, 2, 'Deuteronomy', null, 'LXX Deuteronomy 19:15+105 19:15-44', 'Matthew', 'SBLGNT Matthew 18:16+41 18:16-18', 60565, 22, 51782, 22, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2415, 2, 'Deuteronomy', null, 'LXX Deuteronomy 19:15+105 19:15', 'Matthew', 'SBLGNT Matthew 18:16+41 18:16', 60565, 66, 51782, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2415, 2, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2415, 2, 'strong allusion', 'literal, fuzzy, supertext', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2416, 1, 'Deuteronomy', null, 'LXX Deuteronomy 25:5', 'Matthew', 'SBLGNT Matthew 22:24', null, null, null, null, 'traditional');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3001, 1, 'Job', null, 'Job 5:12-13', 'I_Corinthians', 'I_Corinthians 3:19', null, null, null, null, 'traditional');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3001, 1, 'Job', null, 'LXX Job 5:13+13 5:13-35', 'I_Corinthians', 'SBLGNT I_Corinthians 3:19+71 3:19-14', 8399, 10, 5062, 10, 'getrefs');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3101, 1, 'Proverbs', null, 'LXX Proverbs 25:21 25:21-28', 'Romans', 'SBLGNT Romans 12:20+4 12:20-82', 47241, 18, 26309, 18, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3101, 1, 'Proverbs', null, 'LXX Proverbs 25:21+22 25:22-28', 'Romans', 'SBLGNT Romans 12:20+27 12:20', 47263, 77, 26332, 77, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3101, 1, 'Proverbs', null, 'LXX Proverbs 25:21 25:22-28', 'Romans', 'SBLGNT Romans 12:20+4 12:20', 47241, 99, 26309, 100, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3101, 1, null, 'αλλα'); -- αλλα = on the contrary
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3101, 1, 'quotation', 'literal, fuzzy, synonym', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3102, 1, 'Proverbs', null, 'LXX Proverbs 3:11+3 3:12', 'Hebrews', 'SBLGNT Hebrews 12:5+57 12:6', 4276, 108, 22327, 108, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3102, 1, 'Proverbs', null, 'LXX Proverbs 3:11+3 3:12', 'Hebrews', 'SBLGNT Hebrews 12:5+57 12:6', 4273, 111, 22321, 114, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3102, 1, null, 'παρακλησεως'); -- παρακλησεως = exhortation
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3102, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3103, 1, 'Proverbs', null, 'LXX Proverbs 3:34+4 3:34', 'James', 'SBLGNT James 4:6+32 4:6', 5754, 48, 6153, 48, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3103, 1, 'Proverbs', null, 'LXX Proverbs 3:34', 'James', 'SBLGNT James 4:6+28 4:6', 5750, 52, 6151, 50, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3103, 1, null, 'διο λεγει'); -- διο λεγει = therefore it says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3103, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3103, 2, 'Proverbs', null, 'LXX Proverbs 3:34+4 3:34', 'I_Peter', 'SBLGNT I_Peter 5:5+87 5:5', 5754, 48, 8328, 48, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3103, 2, 'Proverbs', null, 'LXX Proverbs 3:34', 'I_Peter', 'SBLGNT I_Peter 5:5+85 5:5', 5750, 52, 8326, 50, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3103, 2, null, 'οτι'); -- οτι = because
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3103, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3104, 1, 'Proverbs', null, 'LXX Proverbs 26:11', 'II_Peter', 'II_Peter 2:22', null, null, null, null, 'traditional');

insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4101, 1, 'II_Samuel', null, 'LXX II_Samuel 7:14 7:14-71', 'Hebrews', 'SBLGNT Hebrews 1:5+66 1:5', 20344, 45, 472, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (4101, 1, null, 'και παλιν'); -- και παλιν = and again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (4101, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4201, 1, 'I_Kings', null, 'LXX I_Kings 19:10+72 19:10-94', 'Romans', 'SBLGNT Romans 11:3+30 11:3-39', 75874, 28, 22368, 28, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4201, 1, 'I_Kings', null, 'LXX I_Kings 19:10+72 19:10-11', 'Romans', 'SBLGNT Romans 11:3+5 11:3', 75874, 111, 22343, 92, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (4201, 1, 'εν Ηλια ... η γραφη', 'λεγει'); -- εν Ηλια ... η γραφη = in Elijah ... the Scripture, λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (4201, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4202, 1, 'I_Kings', null, 'LXX I_Kings 19:18+60 19:18-35', 'Romans', 'SBLGNT Romans 11:4+77 11:4-5', 77001, 7, 22512, 7, 'getrefs');
insert into quotations (ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (4202, 1, 'I_Kings', null, 'LXX I_Kings 19:18+3 19:18-30', 'Romans', 'SBLGNT Romans 11:4+27 11:4', 76944, 69, 22462, 62, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (4202, 1, 'αυτω ... ο χρηματισμος', 'λεγει'); -- λεγει = spoken, αυτω ... ο χρηματισμος = to him [Elijah] ... the divine answer
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (4202, 1, 'quotation', 'far-fuzzy, synonym', 'Z.K.');
