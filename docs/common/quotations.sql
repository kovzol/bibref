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

create table nt_quotation_introductions (
 nt_quotation_id int not null,
 nt_book,
 nt_passage text not null,
 nt_startpos int,
 nt_endpos int,
 alternative bool default false);

create table quotations (
 nt_quotation_id int,
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

create table clasps (
 nt_quotation_id int,
 ot_id int not null,
 nt_id int not null,
 ot_book text not null,
 ot_passage text not null,
 nt_book text not null,
 nt_passage text not null,
 ot_startpos int,
 ot_length int,
 nt_startpos int,
 nt_length int
 );


insert into authors (name, info) values ('Moses', 'Moses');
insert into authors (name, info) values ('Job', 'Job');
insert into authors (name, info) values ('Isaiah', 'Isaiah');
insert into authors (name, info) values ('Jeremiah', 'Jeremiah');
insert into authors (name, info) values ('Ezekiel', 'Ezekiel');
insert into authors (name, info) values ('Joel', 'Joel');
insert into authors (name, info) values ('Amos', 'Amos');
insert into authors (name, info) values ('Hosea', 'Hosea');
insert into authors (name, info) values ('Jonah', 'Jonah');
insert into authors (name, info) values ('Micah', 'Micah');
insert into authors (name, info) values ('Habakkuk', 'Habakkuk');
insert into authors (name, info) values ('Haggai', 'Haggai');
insert into authors (name, info) values ('Various', 'Authors of Psalms');
insert into authors (name, info) values ('Malachi', 'Malachi');
insert into authors (name, info) values ('Zechariah', 'Zechariah');
insert into authors (name, info) values ('Samuel', 'Samuel');
insert into authors (name, info) values ('Solomon', 'King Solomon');
insert into authors (name, info) values ('Daniel', 'Daniel');

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
insert into books (name, author, info, number) values ('Joshua', 'Joshua', 'Book of Joshua', 6);
insert into books (name, author, info, number) values ('Judges', 'Samuel', 'Book of Judges', 7);
insert into books (name, author, info, number) values ('Ruth', 'Samuel', 'Book of Ruth', 8);
insert into books (name, author, info, number) values ('I_Samuel', 'Samuel', 'The Second Book of Samuel', 9);
insert into books (name, author, info, number) values ('II_Samuel', 'Samuel', 'The Second Book of Samuel', 10);
insert into books (name, author, info, number) values ('I_Kings', 'Samuel', 'The First Book of Kings', 11);
insert into books (name, author, info, number) values ('II_Kings', 'Samuel', 'The Second Book of Kings', 12);
insert into books (name, author, info, number) values ('I_Chronicles', 'Ezra', 'The First Book of Chronicles', 13);
insert into books (name, author, info, number) values ('II_Chronicles', 'Ezra', 'The Second Book of Chronicles', 14);
insert into books (name, author, info, number) values ('Ezra', 'Ezra', 'The Book of Ezra', 15);
insert into books (name, author, info, number) values ('Nehemiah', 'Nehemiah', 'The Book of Nehemiah', 16);
insert into books (name, author, info, number) values ('Esther', 'Mordecai', 'The Book of Esther', 17);
insert into books (name, author, info, number) values ('Job', 'Job', 'Book of Job', 18);
insert into books (name, author, info, number) values ('Psalms', 'Various', 'Book of Psalms', 19);
insert into books (name, author, info, number) values ('Proverbs', 'Solomon', 'Book of Proverbs', 20);
insert into books (name, author, info, number) values ('Ecclesiastes', 'Solomon', 'Ecclesiastes', 21);
insert into books (name, author, info, number) values ('Song_of_Solomon', 'Solomon', 'Song of Solomon', 22);
insert into books (name, author, info, number) values ('Isaiah', 'Isaiah', 'Book of Isaiah', 23);
insert into books (name, author, info, number) values ('Jeremiah', 'Jeremiah', 'Book of Jeremiah', 24);
insert into books (name, author, info, number) values ('Lamentations', 'Jeremiah', 'Book of Lamentations', 25);
insert into books (name, author, info, number) values ('Ezekiel', 'Ezekiel', 'Book of Ezekiel', 26);
insert into books (name, author, info, number) values ('Daniel', 'Daniel', 'Book of Daniel', 27);
insert into books (name, author, info, number) values ('Hosea', 'Hosea', 'Book of Hosea', 28);
insert into books (name, author, info, number) values ('Joel', 'Joel', 'Book of Joel', 29);
insert into books (name, author, info, number) values ('Amos', 'Amos', 'Book of Amos', 30);
insert into books (name, author, info, number) values ('Obadiah', 'Obadiah', 'Book of Obadiah', 31);
insert into books (name, author, info, number) values ('Jonah', 'Jonah', 'Book of Jonah', 32);
insert into books (name, author, info, number) values ('Micah', 'Micah', 'Book of Micah', 33);
insert into books (name, author, info, number) values ('Nahum', 'Nahum', 'Book of Nahum', 34);
insert into books (name, author, info, number) values ('Habakkuk', 'Habakkuk', 'Book of Habakkuk', 35);
insert into books (name, author, info, number) values ('Zephaniah', 'Zephaniah', 'Book of Zephaniah', 36);
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
insert into books (name, author, info, number) values ('Philippians', 'Paul', 'Epistle to the Philippians', 111);
insert into books (name, author, info, number) values ('Colossians', 'Paul', 'Epistle to the Colossians', 112);
insert into books (name, author, info, number) values ('I_Thessalonians', 'Paul', 'First Epistle to the Thessalonians', 113);
insert into books (name, author, info, number) values ('II_Thessalonians', 'Paul', 'Second Epistle to the Thessalonians', 114);
insert into books (name, author, info, number) values ('I_Timothy', 'Paul', 'First Epistle to Timothy', 115);
insert into books (name, author, info, number) values ('II_Timothy', 'Paul', 'Second Epistle to Timothy', 116);
insert into books (name, author, info, number) values ('Titus', 'Paul', 'Epistle to Titus', 117);
insert into books (name, author, info, number) values ('Philemon', 'Paul', 'Epistle to Philemon', 118);
insert into books (name, author, info, number) values ('Hebrews', 'Unknown', 'Epistle to the Hebrews', 119);
insert into books (name, author, info, number) values ('James', 'James', 'Epistle of James', 120);
insert into books (name, author, info, number) values ('I_Peter', 'Peter', 'First Epistle of Peter', 121);
insert into books (name, author, info, number) values ('II_Peter', 'Peter', 'Second Epistle of Peter', 122);
insert into books (name, author, info, number) values ('I_John', 'John', 'First Epistle of John', 123);
insert into books (name, author, info, number) values ('II_John', 'John', 'Second Epistle of John', 124);
insert into books (name, author, info, number) values ('III_John', 'John', 'Third Epistle of John', 125);
insert into books (name, author, info, number) values ('Jude', 'Jude', 'Epistle of Jude', 126);
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

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 1, 1, 'Psalms', 2, 'Psalms 2:1-2', 'Acts', 'Acts 4:25-26', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 1, 1, 'Psalms', 2, 'LXX Psalms 2:1 2:2-8', 'Acts', 'SBLGNT Acts 4:25+58 4:26', 502, 131, 11601, 131, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11, 1, 1, 'Psalms', 2, 'LXX Psalms 2:1 2:2-8', 'Acts', 'SBLGNT Acts 4:25+58 4:26', 502, 131, 11601, 131, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1, 1, 'Δαυιδ', 'ειπων'); -- ειπων = having spoken
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1, 1, 'quotation', 'exact, literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (11, 'Acts', 'SBLGNT Acts 4:25 4:25-38', 11543, 11600);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (11, 1, 1, 'Psalms', 'LXX Psalms 2:1 2:2-8', 'Acts', 'SBLGNT Acts 4:25+58 4:26', 502, 131, 11601, 131); -- perfect!

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 2, 1, 'Psalms', 2, 'Psalms 2:7', 'Acts', 'Acts 13:33', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 2, 1, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Acts', 'SBLGNT Acts 13:33+88 13:33', 922, 32, 43856, 32, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21, 2, 1, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Acts', 'SBLGNT Acts 13:33+88 13:33', 922, 32, 43856, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2, 1, 'εν τω ψαλμω ... τω δευτερω', 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2, 1, 'quotation', 'exact, literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21, 'Acts', 'SBLGNT Acts 13:33+61 13:33-32', 43829, 43855);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21, 2, 1, 'Psalms', 'LXX Psalms 2:7+44 2:7', 'Acts', 'SBLGNT Acts 13:33+88 13:33', 922, 32, 43856, 32); -- perfect!
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22, 2, 2, 'Psalms', 2, 'Psalms 2:7', 'Hebrews', 'Hebrews 1:5', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22, 2, 2, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 1:5+26 1:5-53', 922, 32, 432, 32, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22, 2, 2, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 1:5+26 1:5-53', 922, 32, 432, 32, 'manual');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22, 'Hebrews', 'SBLGNT Hebrews 1:5 1:5-85', 406, 431);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22, 2, 2, 'Psalms', 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 1:5+26 1:5-53', 922, 32, 432, 32); -- perfect!
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2, 2, null, 'ειπεν'); -- ειπεν = did He say
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2, 2, 'quotation', 'exact, literal', 'Z.K.');
-- We assume that this is a repeated quotation of 22, but it is considered as a different object (to simplify visualization):
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (23, 2, 3, 'Psalms', 2, 'Psalms 2:7', 'Hebrews', 'Hebrews 5:5', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (23, 2, 3, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 5:5+70 5:5', 922, 32, 6283, 32, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (23, 2, 3, 'Psalms', 2, 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 5:5+70 5:5', 922, 32, 6283, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2, 3, 'ὁ', 'λαλησας'); -- ὁ = the One, λαλησας = having said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2, 3, 'repeated quotation', 'exact, literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (23, 'Hebrews', 'SBLGNT Hebrews 5:5+53 5:5-32', 6266, 6282);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (23, 2, 3, 'Psalms', 'LXX Psalms 2:7+44 2:7', 'Hebrews', 'SBLGNT Hebrews 5:5+70 5:5', 922, 32, 6283, 32); -- perfect!

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 3, 1, 'Psalms', 2, 'Psalms 2:9', 'Revelation_of_John', 'Revelation_of_John 2:27', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 3, 1, 'Psalms', 2, 'LXX Psalms 2:9+9 2:9-30', 'Revelation_of_John', 'SBLGNT Revelation_of_John 2:27+11 2:27-28', 1041, 21, 4778, 21, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 3, 1, 'Psalms', 2, 'LXX Psalms 2:9 2:9-6', 'Revelation_of_John', 'SBLGNT Revelation_of_John 2:27+3 2:27', 1032, 54, 4769, 57, 'manual');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 3, 1, 'Psalms', 2, 'LXX Psalms 2:9 2:9-10', 'Revelation_of_John', 'SBLGNT Revelation_of_John 2:27+3 2:27-5', 1032, 50, 4769, 52, 'manual-mechanical');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classified_by) values
 (3, 1, 'strong allusion', 'Sung Kuk Kim');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3, 1, 'strong allusion', 'literal', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 3, 2, 'Psalms', 2, 'Psalms 2:9', 'Revelation_of_John', 'Revelation_of_John 12:5', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 3, 2, 'Psalms', 2, 'LXX Psalms 2:9+15 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 12:5+47 12:5-55', 1047, 13, 22310, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 3, 2, 'Psalms', 2, 'LXX Psalms 2:9 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 12:5+26 12:5-55', 1032, 28, 22289, 34, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3, 2, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classified_by) values
 (3, 2, 'strong allusion', 'Sung Kuk Kim');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3, 2, 'strong allusion', 'literal, subset', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 3, 3, 'Psalms', 2, 'Psalms 2:9', 'Revelation_of_John', 'Revelation_of_John 19:15', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 3, 3, 'Psalms', 2, 'LXX Psalms 2:9+9 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 19:15+81 19:15-68', 1041, 19, 38365, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 3, 3, 'Psalms', 2, 'LXX Psalms 2:9 2:9-32', 'Revelation_of_John', 'SBLGNT Revelation_of_John 19:15+73 19:15-68', 1032, 28, 38357, 27, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3, 3, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classified_by) values
 (3, 3, 'strong allusion', 'Sung Kuk Kim');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3, 3, 'strong allusion', 'literal', 'Z.K.');

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 4, 1, 'Psalms', 4, 'Psalms 4:4', 'Ephesians', 'Ephesians 4:26', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 4, 1, 'Psalms', 4, 'LXX Psalms 4:4 4:4-63', 'Ephesians', 'SBLGNT Ephesians 4:26 4:26-33', 2164, 24, 7323, 24, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 4, 1, 'Psalms', 4, 'LXX Psalms 4:4 4:4-63', 'Ephesians', 'SBLGNT Ephesians 4:26 4:26-33', 2164, 24, 7323, 24, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (4, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (4, 1, 'strong allusion', 'exact, literal', 'Z.K.');

-- TODO: Decide how to put this into the system. Since this is a secondary quotation, it does not have an NT quotation ID (51).
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 5, 1, 'Psalms', 5, 'Psalms 5:9', 'Romans', 'Romans 3:13', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 5, 1, 'Psalms', 5, 'LXX Psalms 5:9+52 5:9', 'Romans', 'SBLGNT Romans 3:13 3:13-25', 3173, 54, 10992, 54, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (5, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written (in Romans 3:10)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (5, 1, 'secondary quotation', 'exact, literal', 'Z.K.');

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 6, 1, 'Psalms', 6, 'LXX Psalms 6:8 6:8-64', 'Luke', 'SBLGNT Luke 13:27+32 13:27-14', 3986, 20, 56632, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 6, 1, 'Psalms', 6, 'LXX Psalms 6:8 6:8-64', 'Luke', 'SBLGNT Luke 13:27+32 13:27-14', 3986, 20, 56632, 20, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (6, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (6, 1, 'possible allusion', 'exact, literal', 'Z.K.');

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (71, 7, 1, 'Psalms', 8, 'Psalms 8:2', 'Matthew', 'Matthew 21:16', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (71, 7, 1, 'Psalms', 8, 'LXX Psalms 8:2 8:2-47', 'Matthew', 'SBLGNT Matthew 21:16+76 21:16', 5607, 43, 60218, 43, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (71, 7, 1, 'Psalms', 8, 'LXX Psalms 8:2 8:2-47', 'Matthew', 'SBLGNT Matthew 21:16+76 21:16', 5607, 43, 60218, 43, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (7, 1, null, 'ουδεποτε ανεγνωτε'); -- ουδεποτε ανεγνωτε = did you never read
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (7, 1, 'quotation', 'exact, literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (71, 'Matthew', 'SBLGNT Matthew 21:16+57 21:16-43', 60199, 60217);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (71, 7, 1, 'Psalms', 'LXX Psalms 8:2 8:2-47', 'Matthew', 'SBLGNT Matthew 21:16+76 21:16', 5607, 43, 60218, 43); -- perfect!

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (81, 8, 1, 'Psalms', 8, 'Psalms 8:4-6', 'Hebrews', 'Hebrews 2:6-8', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (81, 8, 1, 'Psalms', 8, 'LXX Psalms 8:4 8:5', 'Hebrews', 'SBLGNT Hebrews 2:6+25 2:7', 5767, 120, 1770, 120, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (81, 8, 1, 'Psalms', 8, 'LXX Psalms 8:6+39 8:6', 'Hebrews', 'SBLGNT Hebrews 2:8 2:8-86', 5926, 33, 1890, 33, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (81, 8, 1, 'Psalms', 8, 'LXX Psalms 8:4 8:6', 'Hebrews', 'SBLGNT Hebrews 2:6+25 2:8-86', 5767, 192, 1770, 120+33, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (8, 1, 'που τις', 'λεγων'); -- που τις = somewhere someone, λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (8, 1, 'quotation', 'superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (81, 'Hebrews', 'SBLGNT Hebrews 2:6 2:6-61', 1745, 1769);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (81, 8, 1, 'Psalms', 'LXX Psalms 8:4 8:5', 'Hebrews', 'SBLGNT Hebrews 2:6+25 2:7', 5767, 120, 1770, 120);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (81, 8, 1, 'Psalms', 'LXX Psalms 8:6+39 8:6', 'Hebrews', 'SBLGNT Hebrews 2:8 2:8-86', 5926, 33, 1890, 33);

-- TODO: Decide how to put this into the system. Since this is a secondary quotation, it does not have an NT quotation ID (51).
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 9, 1, 'Psalms', 10, 'Psalms 10:7', 'Romans', 'Romans 3:14', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 9, 1, 'Psalms', 10, 'LXX Psalms 10:7+2 10:7-39', 'Romans', 'SBLGNT Romans 3:14+2 3:14', 8070, 31, 5977, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (9, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written (in Romans 3:10)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (9, 1, 'secondary quotation', 'literal', 'Z.K.');

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (51, 10, 1, 'Psalms', 14, 'Psalms 14:2-3', 'Romans', 'Romans 3:11-18', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (51, 10, 1, 'Psalms', 14, 'LXX Psalms 14:2+71 14:4-100', 'Romans', 'SBLGNT Romans 3:11+24 3:19-91', 10912, 318, 5816, 318, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (51, 10, 1, 'Psalms', 14, 'LXX Psalms 14:2+59 14:3', 'Romans', 'SBLGNT Romans 3:11+3 3:18', 10900, 329, 5795, 338, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (10, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written (in Romans 3:10)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (10, 1, 'quotation', 'subset, literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (51, 'Romans', 'SBLGNT Romans 3:10 3:10-22', 5753, 5769);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (51, 10, 1, 'Psalms', 'LXX Psalms 14:2+59 14:3', 'Romans', 'SBLGNT Romans 3:11+3 3:18', 10900, 329, 5795, 338);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (111, 11, 1, 'Psalms', 16, 'Psalms 16:8-11', 'Acts', 'Acts 2:25-28', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (111, 11, 1, 'Psalms', 16, 'LXX Psalms 16:8+4 16:11-31', 'Acts', 'SBLGNT Acts 2:25+25 2:28', 12497, 282, 4839, 282, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (111, 11, 1, 'Psalms', 16, 'LXX Psalms 16:8 16:11-31', 'Acts', 'SBLGNT Acts 2:25+21 2:28', 12493, 286, 4835, 286, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (11, 1, 'Δαυιδ', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (11, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (111, 'Acts', 'SBLGNT Acts 2:25 2:25-68', 4814, 4834);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (111, 11, 1, 'Psalms', 'LXX Psalms 16:8 16:11-31', 'Acts', 'SBLGNT Acts 2:25+21 2:28', 12493, 286, 4835, 286);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (112, 11, 2, 'Psalms', 16, 'Psalms 16:10', 'Acts', 'Acts 13:35', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (112, 11, 2, 'Psalms', 16, 'LXX Psalms 16:10+41 16:10', 'Acts', 'SBLGNT Acts 13:35+22 13:35', 12688, 31, 44015, 31, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (112, 11, 2, 'Psalms', 16, 'LXX Psalms 16:10+37 16:10', 'Acts', 'SBLGNT Acts 13:35+20 13:35', 12684, 35, 44013, 33, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (11, 2, 'εν ετερω ... Δαυιδ', 'λεγει'); -- λεγει = says, David is mentioned in 13:34 (and also later in 13:36)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (11, 2, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (112, 'Acts', 'SBLGNT Acts 13:35 13:35-33', 43993, 44012);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (112, 'Acts', 'SBLGNT Acts 13:34+79 13:34', 43967, 43992);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (112, 11, 2, 'Psalms', 'LXX Psalms 16:10+37 16:10', 'Acts', 'SBLGNT Acts 13:35+20 13:35', 12684, 35, 44013, 33);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (121, 12, 1, 'Psalms', 18, 'Psalms 18:49', 'Romans', 'Romans 15:9', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (121, 12, 1, 'Psalms', 18, 'LXX Psalms 18:49 18:49-25', 'Romans', 'SBLGNT Romans 15:9+46 15:9-19', 17410, 33, 30162, 33, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (121, 12, 1, 'Psalms', 18, 'LXX Psalms 18:49+39 18:49', 'Romans', 'SBLGNT Romans 15:9+79 15:9', 17449, 19, 30195, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (121, 12, 1, 'Psalms', 18, 'LXX Psalms 18:49', 'Romans', 'SBLGNT Romans 15:9+46 15:9', 17410, 58, 30162, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (12, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (12, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (121, 'Romans', 'SBLGNT Romans 15:9+32 15:9-52', 30148, 30161);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (121, 12, 1, 'Psalms', 'LXX Psalms 18:49', 'Romans', 'SBLGNT Romans 15:9+46 15:9', 17410, 58, 30162, 52);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (131, 13, 1, 'Psalms', 19, 'Psalms 19:4', 'Romans', 'Romans 10:18', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (131, 13, 1, 'Psalms', 19, 'LXX Psalms 19:4 19:4-27', 'Romans', 'SBLGNT Romans 10:18+28 10:18', 17757, 74, 21813, 74, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (131, 13, 1, 'Psalms', 19, 'LXX Psalms 19:4 19:4-27', 'Romans', 'SBLGNT Romans 10:18+28 10:18', 17757, 74, 21813, 74, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (13, 1, null, 'μενουνγε'); -- μενουνγε = indeed
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (13, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (131, 'Romans', 'SBLGNT Romans 10:18+20 10:18-74', 21805, 21812);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (131, 13, 1, 'Psalms', 'LXX Psalms 19:4 19:4-27', 'Romans', 'SBLGNT Romans 10:18+28 10:18', 17757, 74, 21813, 74);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 14, 1, 'Psalms', 22, 'Psalms 22:18', 'Matthew', 'Matthew 27:35', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 14, 1, 'Psalms', 22, 'LXX Psalms 22:18 22:18-43', 'Matthew', 'SBLGNT Matthew 27:35+19 27:35-20', 21364, 20, 85881, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 14, 1, 'Psalms', 22, 'LXX Psalms 22:18 22:18', 'Matthew', 'SBLGNT Matthew 27:35+19 27:35', 21364, 63, 85881, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (14, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (14, 1, 'strong allusion', 'literal, superset', 'Z.K.');

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (142, 14, 2, 'Psalms', 22, 'Psalms 22:18', 'John', 'John 19:24', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (142, 14, 2, 'Psalms', 22, 'LXX Psalms 22:18 22:18', 'John', 'SBLGNT John 19:24+89 19:24-31', 21364, 63, 63442, 63, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (142, 14, 2, 'Psalms', 22, 'LXX Psalms 22:18', 'John', 'SBLGNT John 19:24+89 19:24-31', 21364, 63, 63442, 63, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (14, 2, null, 'ινα η γραφη πληρωθη η λεγουσα'); -- ινα η γραφη πληρωθη η λεγουσα = that the scripture might be fulfilled, which saith (KJV)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (14, 2, 'quotation', 'exact, literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (142, 'John', 'SBLGNT John 19:24+65 19:24-94', 63418, 63441);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (142, 14, 2, 'Psalms', 'LXX Psalms 22:18', 'John', 'SBLGNT John 19:24+89 19:24-31', 21364, 63, 63442, 63);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (151, 15, 1, 'Psalms', 22, 'Psalms 22:22', 'Hebrews', 'Hebrews 2:12', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (151, 15, 1, 'Psalms', 22, 'LXX Psalms 22:22+10 22:22', 'Hebrews', 'SBLGNT Hebrews 2:12+13 2:12', 21617, 48, 2353, 48, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (151, 15, 1, 'Psalms', 22, 'LXX Psalms 22:22+10 22:22', 'Hebrews', 'SBLGNT Hebrews 2:12+13 2:12', 21617, 48, 2353, 48, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (15, 1, null, 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (15, 1, 'quotation', 'exact, literal, synonym', 'Z.K.'); -- The preceding word διηγησομαι is changed to Απαγγελω (synonym).
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (151, 'Hebrews', 'SBLGNT Hebrews 2:12 2:12-56', 2340, 2344);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (151, 15, 1, 'Psalms', 'LXX Psalms 22:22+10 22:22', 'Hebrews', 'SBLGNT Hebrews 2:12+13 2:12', 21617, 48, 2353, 48);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (161, 16, 1, 'Psalms', 24, 'Psalms 24:1', 'I_Corinthians', 'I_Corinthians 10:26', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (161, 16, 1, 'Psalms', 24, 'LXX Psalms 24:1+37 24:1-39', 'I_Corinthians', 'SBLGNT I_Corinthians 10:26+12 10:26', 23001, 20, 17823, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (161, 16, 1, 'Psalms', 24, 'LXX Psalms 24:1+28 24:1-39', 'I_Corinthians', 'SBLGNT I_Corinthians 10:26', 22992, 29, 17811, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (16, 1, null, 'γαρ'); -- γαρ = for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (16, 1, 'quotation', 'literal, subset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (161, 'I_Corinthians', 'SBLGNT I_Corinthians 10:26+9 10:26-20', 17820, 17822);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (161, 16, 1, 'Psalms', 'LXX Psalms 24:1+37 24:1-39', 'I_Corinthians', 'SBLGNT I_Corinthians 10:26+12 10:26', 23001, 20, 17823, 20);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (161, 16, 1, 'Psalms', 'LXX Psalms 24:1+28 24:1-59', 'I_Corinthians', 'SBLGNT I_Corinthians 10:26 10:26-23', 22992, 9, 17811, 9);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 17, 1, 'Psalms', 31, 'Psalms 31:5', 'Luke', 'Luke 23:46', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 17, 1, 'Psalms', 31, 'LXX Psalms 31:5 31:5-49', 'Luke', 'SBLGNT Luke 23:46+37 23:46-40', 29825, 16, 91009, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 17, 1, 'Psalms', 31, 'LXX Psalms 31:5+20 31:5-31', 'Luke', 'SBLGNT Luke 23:46+57 23:46-22', 29845, 14, 91029, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 17, 1, 'Psalms', 31, 'LXX Psalms 31:5 31:5-31', 'Luke', 'SBLGNT Luke 23:46+37 23:46-22', 29825, 34, 91009, 34, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (17, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (17, 1, 'strong allusion', 'literal', 'Z.K.');

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (181, 18, 1, 'Psalms', 32, 'Psalms 32:1-2', 'Romans', 'Romans 4:7-8', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (181, 18, 1, 'Psalms', 32, 'LXX Psalms 32:1+15 32:2-29', 'Romans', 'SBLGNT Romans 4:7 4:9-101', 31469, 97, 7493, 97, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (181, 18, 1, 'Psalms', 32, 'LXX Psalms 32:1+15 32:2-30', 'Romans', 'SBLGNT Romans 4:7 4:8', 31469, 96, 7493, 96, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (18, 1, 'Δαυιδ', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (18, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (181, 'Romans', 'SBLGNT Romans 4:6 4:6', 7413, 7492);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (181, 18, 1, 'Psalms', 'LXX Psalms 32:1+15 32:2-30', 'Romans', 'SBLGNT Romans 4:7 4:8', 31469, 96, 7493, 96);

-- TODO: Is really this a strong allusion or a quotation?
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 19, 1, 'Psalms', 34, 'Psalms 34:8', 'I_Peter', 'I_Peter 2:3', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 19, 1, 'Psalms', 34, 'LXX Psalms 34:8+15 34:8-28', 'I_Peter', 'SBLGNT I_Peter 2:3+10 2:3', 34265, 18, 2366, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 19, 1, 'Psalms', 34, 'LXX Psalms 34:8 34:8-28', 'I_Peter', 'SBLGNT I_Peter 2:3+3 2:3', 34250, 33, 2359, 25, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (19, 1, null, 'ει'); -- ει = if indeed
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (19, 1, 'strong allusion', 'literal, superset', 'Z.K.');

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 20, 1, 'Psalms', 34, 'Psalms 34:12-16', 'I_Peter', 'I_Peter 3:10-12', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 20, 1, 'Psalms', 34, 'LXX Psalms 34:12+17 34:12-19', 'I_Peter', 'SBLGNT I_Peter 3:10+4 3:10-72', 34529, 13, 5210, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 20, 1, 'Psalms', 34, 'LXX Psalms 34:12+43 34:13-51', 'I_Peter', 'SBLGNT I_Peter 3:10+33 3:10-46', 34555, 10, 5239, 10, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 20, 1, 'Psalms', 34, 'LXX Psalms 34:13+19 34:13-20', 'I_Peter', 'SBLGNT I_Peter 3:10+56 3:10-17', 34580, 16, 5262, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 20, 1, 'Psalms', 34, 'LXX Psalms 34:13+38 34:14-54', 'I_Peter', 'SBLGNT I_Peter 3:10+72 3:11-60', 34599, 23, 5278, 23, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 20, 1, 'Psalms', 34, 'LXX Psalms 34:14+26 34:14-23', 'I_Peter', 'SBLGNT I_Peter 3:11+30 3:11-25', 34642, 11, 5325, 11, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 20, 1, 'Psalms', 34, 'LXX Psalms 34:14+39 34:14-7', 'I_Peter', 'SBLGNT I_Peter 3:11+44 3:11-8', 34655, 14, 5339, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 20, 1, 'Psalms', 34, 'LXX Psalms 34:15 34:16-37', 'I_Peter', 'SBLGNT I_Peter 3:12+3 3:12', 34676, 82, 5364, 82, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (201, 20, 1, 'Psalms', 34, 'LXX Psalms 34:12+17 34:16-37', 'I_Peter', 'SBLGNT I_Peter 3:10+4 3:12', 34529, 229, 5210, 236, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (20, 1, null, 'ο γαρ'); -- ο γαρ = the one for (TODO: maybe "ο" belongs to the quotation, check)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (20, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (201, 'I_Peter', 'SBLGNT I_Peter 3:10 3:10-85', 5206, 5209);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (201, 20, 1, 'Psalms', 'LXX Psalms 34:12+17 34:16-37', 'I_Peter', 'SBLGNT I_Peter 3:10+4 3:12', 34529, 229, 5210, 236);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (211, 21, 1, 'Psalms', 40, 'Psalms 40:6-8', 'Hebrews', 'Hebrews 10:5-7', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (211, 21, 1, 'Psalms', 40, 'LXX Psalms 40:6 40:6-52', 'Hebrews', 'SBLGNT Hebrews 10:5+32 10:5-18', 44126, 29, 15590, 29, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (211, 21, 1, 'Psalms', 40, 'LXX Psalms 40:6+32 40:6-24', 'Hebrews', 'SBLGNT Hebrews 10:5+64 10:6-29', 44158, 25, 15622, 25, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (211, 21, 1, 'Psalms', 40, 'LXX Psalms 40:6+56 40:6-6', 'Hebrews', 'SBLGNT Hebrews 10:6+11 10:6-9', 44182, 19, 15648, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (211, 21, 1, 'Psalms', 40, 'LXX Psalms 40:6+77 40:8-61', 'Hebrews', 'SBLGNT Hebrews 10:6+35 10:7-16', 44203, 64, 15672, 64, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (211, 21, 1, 'Psalms', 40, 'LXX Psalms 40:6 40:8-45', 'Hebrews', 'SBLGNT Hebrews 10:5+32 10:7', 44126, 157, 15590, 162, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (21, 1, null, 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (21, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (211, 'Hebrews', 'SBLGNT Hebrews 10:5 10:5-47', 15558, 15589);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (211, 21, 1, 'Psalms', 'LXX Psalms 40:6 40:8-45', 'Hebrews', 'SBLGNT Hebrews 10:5+32 10:7', 44126, 157, 15590, 162);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (212, 21, 2, 'Psalms', 40, 'Psalms 40:6', 'Hebrews', 'Hebrews 10:8', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (212, 21, 2, 'Psalms', 40, 'LXX Psalms 40:6+6 40:6-64', 'Hebrews', 'SBLGNT Hebrews 10:8+22 10:8-83', 44132, 11, 15774, 11, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (212, 21, 2, 'Psalms', 40, 'LXX Psalms 40:6+56 40:6-5', 'Hebrews', 'SBLGNT Hebrews 10:8+48 10:8-48', 44182, 20, 15800, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (212, 21, 2, 'Psalms', 40, 'LXX Psalms 40:6', 'Hebrews', 'SBLGNT Hebrews 10:8+16 10:8-41', 44126, 81, 15768, 59, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (21, 2, null, 'ανωτερον λεγων οτι'); -- ανωτερον λεγων οτι = above saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (21, 2, 'repeated quotation', 'literal, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (212, 'Hebrews', 'SBLGNT Hebrews 10:8 10:8-100', 15752, 15767);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (212, 21, 2, 'Psalms', 'LXX Psalms 40:6 40:6-64', 'Hebrews', 'SBLGNT Hebrews 10:8+16 10:8-83', 44126, 17, 15768, 17);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (212, 21, 2, 'Psalms', 'LXX Psalms 40:6+47 40:6', 'Hebrews', 'SBLGNT Hebrews 10:8+37 10:8-41', 44173, 34, 15789, 38);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (213, 21, 3, 'Psalms', 40, 'Psalms 40:7-8', 'Hebrews', 'Hebrews 10:9', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (213, 21, 3, 'Psalms', 40, 'LXX Psalms 40:7+8 40:7-34', 'Hebrews', 'SBLGNT Hebrews 10:9+10 10:9-54', 44215, 8, 15878, 8, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (213, 21, 3, 'Psalms', 40, 'LXX Psalms 40:8 40:8-50', 'Hebrews', 'SBLGNT Hebrews 10:9+18 10:9-33', 44257, 21, 15886, 21, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (213, 21, 3, 'Psalms', 40, 'LXX Psalms 40:7+9 40:8-50', 'Hebrews', 'SBLGNT Hebrews 10:9+11 10:9-33', 44216, 62, 15879, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (21, 3, null, 'τοτε ειρηκεν'); -- τοτε ειρηκεν = then he said, TODO: Check if τοτε indeed belongs to the introduction. It is also there in the psalm.
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (21, 3, 'repeated quotation', 'literal, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (213, 'Hebrews', 'SBLGNT Hebrews 10:9 10:9-61', 15868, 15878);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (213, 21, 3, 'Psalms', 'LXX Psalms 40:7+9 40:7-34', 'Hebrews', 'SBLGNT Hebrews 10:9+11 10:9-54', 44216, 7, 15879, 7);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (213, 21, 3, 'Psalms', 'LXX Psalms 40:8 40:8-50', 'Hebrews', 'SBLGNT Hebrews 10:9+18 10:9-33', 44257, 21, 15886, 21);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (221, 22, 1, 'Psalms', 41, 'Psalms 41:9', 'John', 'John 13:18', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (221, 22, 1, 'Psalms', 41, 'LXX Psalms 41:9+45 41:9-5', 'John', 'SBLGNT John 13:18+68 13:18-7', 45860, 29, 46597, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (22, 1, null, 'αλλ ινα η γραφη πληρωθη'); -- αλλ ινα η γραφη πληρωθη = but the Scripture may be fulfilled
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (22, 1, 'quotation', 'far-fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (221, 'John', 'SBLGNT John 13:18+42 13:18-44', 46571, 46589);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (221, 22, 1, 'Psalms', 'LXX Psalms 41:9+45 41:9-25', 'John', 'SBLGNT John 13:18+68 13:18-26', 45860, 9, 46597, 11);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (221, 22, 1, 'Psalms', 'LXX Psalms 41:9+64 41:9-5', 'John', 'SBLGNT John 13:18+85 13:18-7', 45879, 10, 46614, 13);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (231, 23, 1, 'Psalms', 44, 'Psalms 44:22', 'Romans', 'Romans 8:36', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (231, 23, 1, 'Psalms', 44, 'LXX Psalms 44:22+8 44:22', 'Romans', 'SBLGNT Romans 8:36+23 8:36', 49277, 53, 17865, 53, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (231, 23, 1, 'Psalms', 44, 'LXX Psalms 44:22', 'Romans', 'SBLGNT Romans 8:36+14 8:36', 49269, 61, 17856, 62, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (23, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (23, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (231, 'Romans', 'SBLGNT Romans 8:36 8:36-62', 17842, 17855);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (231, 23, 1, 'Psalms', 'LXX Psalms 44:22', 'Romans', 'SBLGNT Romans 8:36+14 8:36', 49269, 61, 17856, 62);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (241, 24, 1, 'Psalms', 45, 'Psalms 45:6', 'Hebrews', 'Hebrews 1:8', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (241, 24, 1, 'Psalms', 45, 'LXX Psalms 45:6 45:6-37', 'Hebrews', 'SBLGNT Hebrews 1:8+13 1:8-43', 50077, 35, 713, 35, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (241, 24, 1, 'Psalms', 45, 'LXX Psalms 45:6+50 45:6-12', 'Hebrews', 'SBLGNT Hebrews 1:8+51 1:8-30', 50127, 10, 751, 10, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (241, 24, 1, 'Psalms', 45, 'LXX Psalms 45:6+40 45:6-22', 'Hebrews', 'SBLGNT Hebrews 1:8+60 1:8-21', 50117, 10, 760, 10, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (241, 24, 1, 'Psalms', 45, 'LXX Psalms 45:6+51 45:7', 'Hebrews', 'SBLGNT Hebrews 1:8+70 1:9', 50128, 124, 770, 124, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (241, 24, 1, 'Psalms', 45, 'LXX Psalms 45:6 45:7', 'Hebrews', 'SBLGNT Hebrews 1:8+13 1:9', 50077, 175, 713, 181, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (24, 1, 'θεος', 'προς δε τον υιον'); -- λεγει ... προς δε τον υιον =  He says ... unto however the Son
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (24, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (241, 'Hebrews', 'SBLGNT Hebrews 1:8 1:8-78', 700, 712);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (241, 'Hebrews', 'SBLGNT Hebrews 1:1+28 1:1-27', 41, 51); -- Theos
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (241, 24, 1, 'Psalms', 'LXX Psalms 45:6 45:7', 'Hebrews', 'SBLGNT Hebrews 1:8+13 1:9', 50077, 175, 713, 181);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (251, 25, 1, 'Psalms', 51, 'Psalms 51:4', 'Romans', 'Romans 3:4', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (251, 25, 1, 'Psalms', 51, 'LXX Psalms 51:4+43 51:4-17', 'Romans', 'SBLGNT Romans 3:4+63 3:4-18', 56557, 38, 5291, 38, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (251, 25, 1, 'Psalms', 51, 'LXX Psalms 51:4+82 51:4', 'Romans', 'SBLGNT Romans 3:4+103 3:4', 56596, 16, 5331, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (251, 25, 1, 'Psalms', 51, 'LXX Psalms 51:4+43 51:4', 'Romans', 'SBLGNT Romans 3:4+63 3:4', 56557, 55, 5291, 56, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (25, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (25, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (251, 'Romans', 'SBLGNT Romans 3:4+49 3:4-56', 5277, 5290);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (251, 25, 1, 'Psalms', 'LXX Psalms 51:4+43 51:4', 'Romans', 'SBLGNT Romans 3:4+63 3:4', 56557, 55, 5291, 56);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (261, 26, 1, 'Psalms', 68, 'Psalms 68:18', 'Ephesians', 'Ephesians 4:8', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (261, 26, 1, 'Psalms', 68, 'LXX Psalms 68:18+5 68:18-86', 'Ephesians', 'SBLGNT Ephesians 4:8+13 4:8-38', 73402, 18, 5810, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (261, 26, 1, 'Psalms', 68, 'LXX Psalms 68:18 68:18-52', 'Ephesians', 'SBLGNT Ephesians 4:8+8 4:8', 73397, 57, 5805, 61, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (26, 1, null, 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (26, 1, 'quotation', 'fuzzy, change', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (261, 'Ephesians', 'SBLGNT Ephesians 4:8 4:8-61', 5797, 5804);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (261, 26, 1, 'Psalms', 'LXX Psalms 68:18 68:18-53', 'Ephesians', 'SBLGNT Ephesians 4:8+8 4:8-3', 73397, 56, 5805, 58);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (271, 27, 1, 'Psalms', 69, 'Psalms 69:9a', 'John', 'John 2:17', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (271, 27, 1, 'Psalms', 69, 'LXX Psalms 69:9+3 69:9-53', 'John', 'SBLGNT John 2:17+43 2:17-10', 75407, 20, 5188, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (271, 27, 1, 'Psalms', 69, 'LXX Psalms 69:9+3 69:9-45', 'John', 'SBLGNT John 2:17+43 2:17', 75407, 28, 5188, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (27, 1, null, 'γεγραμμενον εστιν'); -- γεγραμμενον εστιν = written it is
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (27, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (271, 'John', 'SBLGNT John 2:17+27 2:17-30', 5172, 5187);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (271, 27, 1, 'Psalms', 'LXX Psalms 69:9+3 69:9-45', 'John', 'SBLGNT John 2:17+43 2:17', 75407, 28, 5188, 30);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (281, 28, 1, 'Psalms', 69, 'Psalms 69:9b', 'Romans', 'Romans 15:3', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (281, 28, 1, 'Psalms', 69, 'LXX Psalms 69:9+32 69:9', 'Romans', 'SBLGNT Romans 15:3+44 15:3', 75436, 44, 29644, 44, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (281, 28, 1, 'Psalms', 69, 'LXX Psalms 69:9+34 69:9', 'Romans', 'SBLGNT Romans 15:3+46 15:3', 75438, 42, 29646, 42, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (28, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (28, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (281, 'Romans', 'SBLGNT Romans 15:3+32 15:3-42', 29632, 29645);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (281, 28, 1, 'Psalms', 'LXX Psalms 69:9+34 69:9', 'Romans', 'SBLGNT Romans 15:3+46 15:3', 75438, 42, 29646, 42);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (291, 29, 1, 'Psalms', 69, 'Psalms 69:22-23', 'Romans', 'Romans 11:9-10', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (291, 29, 1, 'Psalms', 69, 'LXX Psalms 69:22 69:22-52', 'Romans', 'SBLGNT Romans 11:9+13 11:9-56', 76386, 22, 22821, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (291, 29, 1, 'Psalms', 69, 'LXX Psalms 69:22+28 69:22-26', 'Romans', 'SBLGNT Romans 11:9+29 11:9-42', 76414, 20, 22837, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (291, 29, 1, 'Psalms', 69, 'LXX Psalms 69:22+58 69:22', 'Romans', 'SBLGNT Romans 11:9+53 11:9-22', 76444, 16, 22861, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (291, 29, 1, 'Psalms', 69, 'LXX Psalms 69:22+42 69:22-18', 'Romans', 'SBLGNT Romans 11:9+69 11:9-8', 76428, 14, 22877, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (291, 29, 1, 'Psalms', 69, 'LXX Psalms 69:23 69:23', 'Romans', 'SBLGNT Romans 11:10 11:10', 76460, 74, 22899, 74, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (291, 29, 1, 'Psalms', 69, 'LXX Psalms 69:22 69:23', 'Romans', 'SBLGNT Romans 11:9+13 11:10', 76386, 148, 22821, 152, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (29, 1, 'Δαυιδ', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (29, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (291, 'Romans', 'SBLGNT Romans 11:9 11:9-78', 22808, 22820);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (291, 29, 1, 'Psalms', 'LXX Psalms 69:22 69:23', 'Romans', 'SBLGNT Romans 11:9+13 11:10', 76386, 148, 22821, 152);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (301, 30, 1, 'Psalms', 69, 'Psalms 69:25', 'Acts', 'Acts 1:20', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (301, 30, 1, 'Psalms', 69, 'LXX Psalms 69:25 69:25-50', 'Acts', 'SBLGNT Acts 1:20+25 1:20-64', 76594, 19, 2052, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (301, 30, 1, 'Psalms', 69, 'LXX Psalms 69:25+54 69:25', 'Acts', 'SBLGNT Acts 1:20+55 1:20-38', 76648, 15, 2082, 15, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (301, 30, 1, 'Psalms', 69, 'LXX Psalms 69:25', 'Acts', 'SBLGNT Acts 1:20+25 1:20-38', 76594, 69, 2052, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (30, 1, 'εν βιβλω ψαλμων', 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (30, 1, 'quotation', 'literal, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (301, 'Acts', 'SBLGNT Acts 1:20 1:20-83', 2027, 2051);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (301, 30, 1, 'Psalms', 'LXX Psalms 69:25 69:25-36', 'Acts', 'SBLGNT Acts 1:20+25 1:20-53', 76594, 33, 2052, 30);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (301, 30, 1, 'Psalms', 'LXX Psalms 69:25+54 69:25', 'Acts', 'SBLGNT Acts 1:20+55 1:20-38', 76648, 15, 2082, 15);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (311, 31, 1, 'Psalms', 78, 'Psalms 78:2', 'Matthew', 'Matthew 13:35', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (311, 31, 1, 'Psalms', 78, 'LXX Psalms 78:2 78:2-26', 'Matthew', 'SBLGNT Matthew 13:35+40 13:35-31', 87284, 28, 37391, 28, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (311, 31, 1, 'Psalms', 78, 'LXX Psalms 78:2 78:2-26', 'Matthew', 'SBLGNT Matthew 13:35+40 13:35-31', 87284, 28, 37391, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (31, 1, 'προφητου', 'ρηθεν ... λεγοντος'); -- ρηθεν ... λεγοντος = having been spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (31, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (311, 'Matthew', 'SBLGNT Matthew 13:35 13:35-59', 37351, 37390);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (311, 31, 1, 'Psalms', 'LXX Psalms 78:2 78:2-26', 'Matthew', 'SBLGNT Matthew 13:35+40 13:35-31', 87284, 28, 37391, 28);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (321, 32, 1, 'Psalms', 82, 'Psalms 82:6', 'John', 'John 10:34', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (321, 32, 1, 'Psalms', 82, 'LXX Psalms 82:6 82:6-20', 'John', 'SBLGNT John 10:34+55 10:34', 96137, 15, 36125, 15, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (321, 32, 1, 'Psalms', 82, 'LXX Psalms 82:6 82:6-20', 'John', 'SBLGNT John 10:34+55 10:34', 96137, 15, 36125, 15, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (32, 1, 'εν τω νομω υμων', 'γεγραμμενον'); -- εν τω νομω υμων = in the law of you, γεγραμμενον = written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (32, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (321, 'John', 'SBLGNT John 10:34+21 10:34-15', 36091, 36124);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (321, 32, 1, 'Psalms', 'LXX Psalms 82:6 82:6-20', 'John', 'SBLGNT John 10:34+55 10:34', 96137, 15, 36125, 15);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (331, 33, 1, 'Psalms', 86, 'Psalms 86:9', 'Revelation_of_John', 'Revelation_of_John 15:4', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (331, 33, 1, 'Psalms', 86, 'LXX Psalms 86:9+56 86:9-15', 'Revelation_of_John', 'SBLGNT Revelation_of_John 15:4+13 15:4-103', 99743, 13, 28951, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (331, 33, 1, 'Psalms', 86, 'LXX Psalms 86:9+22 86:9-28', 'Revelation_of_John', 'SBLGNT Revelation_of_John 15:4+65 15:4-30', 99709, 34, 29003, 34, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (331, 33, 1, 'Psalms', 86, 'LXX Psalms 86:9', 'Revelation_of_John', 'SBLGNT Revelation_of_John 15:4+13 15:4-30', 99687, 84, 28951, 86, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (33, 1, 'την ωδην του αρνιου', 'αδουσιν ... λεγοντες'); -- την ωδην του αρνιου = the Song of the Lamb, αδουσιν ... λεγοντες = they are singing ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (33, 1, 'strong allusion', 'literal, fuzzy', 'Z.K.'); -- Moses and the Lamb are mentioned, not David.

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (341, 34, 1, 'Psalms', 91, 'Psalms 91:11-12', 'Matthew', 'Matthew 4:6', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (341, 34, 1, 'Psalms', 91, 'LXX Psalms 91:11 91:11-35', 'Matthew', 'SBLGNT Matthew 4:6+54 4:6-55', 107356, 37, 6566, 37, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (341, 34, 1, 'Psalms', 91, 'LXX Psalms 91:12 91:13-59', 'Matthew', 'SBLGNT Matthew 4:6+94 4:7-57', 107428, 53, 6606, 53, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (341, 34, 1, 'Psalms', 91, 'LXX Psalms 91:11 91:12', 'Matthew', 'SBLGNT Matthew 4:6+54 4:6', 107356, 124, 6566, 92, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (34, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (34, 1, 'quotation', 'literal, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (341, 'Matthew', 'SBLGNT Matthew 4:6+42 4:6-92', 6554, 6565);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (341, 34, 1, 'Psalms', 'LXX Psalms 91:11 91:11-35', 'Matthew', 'SBLGNT Matthew 4:6+54 4:6-55', 107356, 37, 6566, 37);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (341, 34, 1, 'Psalms', 'LXX Psalms 91:12 91:12', 'Matthew', 'SBLGNT Matthew 4:6+94 4:6', 107428, 52, 6606, 52);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (342, 34, 2, 'Psalms', 91, 'Psalms 91:11-12', 'Luke', 'Luke 4:10-11', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (342, 34, 2, 'Psalms', 91, 'LXX Psalms 91:11 91:11-20', 'Luke', 'SBLGNT Luke 4:10+12 4:10', 107356, 52, 13765, 52, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (342, 34, 2, 'Psalms', 91, 'LXX Psalms 91:12 91:12', 'Luke', 'SBLGNT Luke 4:11+6 4:11', 107428, 52, 13823, 52, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (342, 34, 2, 'Psalms', 91, 'LXX Psalms 91:11 91:12', 'Luke', 'SBLGNT Luke 4:10+12 4:11', 107356, 124, 13765, 110, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (34, 2, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (34, 2, 'quotation', 'literal, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (342, 'Luke', 'SBLGNT Luke 4:10 4:10-52', 13753, 13764);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (342, 34, 2, 'Psalms', 'LXX Psalms 91:11 91:11-20', 'Luke', 'SBLGNT Luke 4:10+12 4:10', 107356, 52, 13765, 52);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (342, 34, 2, 'Psalms', 'LXX Psalms 91:12 91:12', 'Luke', 'SBLGNT Luke 4:11+6 4:11', 107428, 52, 13823, 52);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (351, 35, 1, 'Psalms', 94, 'Psalms 94:11', 'I_Corinthians', 'I_Corinthians 3:20', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (351, 35, 1, 'Psalms', 94, 'LXX Psalms 94:10+45 94:11-23', 'I_Corinthians', 'SBLGNT I_Corinthians 3:20+6 3:20-20', 109643, 35, 5092, 35, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (351, 35, 1, 'Psalms', 94, 'LXX Psalms 94:11+39 94:11', 'I_Corinthians', 'SBLGNT I_Corinthians 3:20+44 3:20', 109684, 17, 5130, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (351, 35, 1, 'Psalms', 94, 'LXX Psalms 94:11', 'I_Corinthians', 'SBLGNT I_Corinthians 3:20+8 3:20', 109645, 56, 5094, 53, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (35, 1, null, 'και παλιν'); -- και παλιν = and again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (35, 1, 'quotation', 'literal, change', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (351, 'I_Corinthians', 'SBLGNT I_Corinthians 3:20 3:20-53', 5086, 5093);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (351, 35, 1, 'Psalms', 'LXX Psalms 94:11 94:11', 'I_Corinthians', 'SBLGNT I_Corinthians 3:20+8 3:20', 109645, 56, 5094, 53);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 1, 'Psalms', 95, 'Psalms 95:7-11', 'Hebrews', 'Hebrews 3:7-11', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 1, 'Psalms', 95, 'LXX Psalms 95:7+65 95:9-28', 'Hebrews', 'SBLGNT Hebrews 3:7+28 3:9-27', 110945, 134, 3418, 134, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 1, 'Psalms', 95, 'LXX Psalms 95:9+43 95:10-90', 'Hebrews', 'SBLGNT Hebrews 3:9+42 3:10-92', 111097, 14, 3569, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 1, 'Psalms', 95, 'LXX Psalms 95:10+15 95:10-62', 'Hebrews', 'SBLGNT Hebrews 3:10+18 3:10-61', 111122, 17, 3597, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 1, 'Psalms', 95, 'LXX Psalms 95:10+45 95:10-29', 'Hebrews', 'SBLGNT Hebrews 3:10+48 3:10-28', 111152, 20, 3627, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 1, 'Psalms', 95, 'LXX Psalms 95:10+73 95:11', 'Hebrews', 'SBLGNT Hebrews 3:10+75 3:11', 111180, 73, 3654, 73, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 1, 'Psalms', 95, 'LXX Psalms 95:7+65 95:11', 'Hebrews', 'SBLGNT Hebrews 3:7+28 3:11', 110945, 308, 3418, 309, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 1, 'το πνευμα το αγιον', 'καθως λεγει'); -- το πνευμα το αγιον = the Holy Spirit, καθως λεγει = just as says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (361, 'Hebrews', 'SBLGNT Hebrews 3:7 3:7-31', 3390, 3417);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (361, 36, 1, 'Psalms', 'LXX Psalms 95:7+65 95:11', 'Hebrews', 'SBLGNT Hebrews 3:7+28 3:11', 110945, 308, 3418, 309);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 2, 'Psalms', 95, 'Psalms 95:7-8', 'Hebrews', 'Hebrews 3:15', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 2, 'Psalms', 95, 'LXX Psalms 95:7+65 95:8-34', 'Hebrews', 'SBLGNT Hebrews 3:15+12 3:15', 110945, 75, 4005, 75, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 2, 'Psalms', 95, 'LXX Psalms 95:7+65 95:8-34', 'Hebrews', 'SBLGNT Hebrews 3:15+12 3:15', 110945, 75, 4005, 75, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 2, null, 'εν τω λεγεσθαι'); -- εν τω λεγεσθαι = as it is said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 2, 'repeated quotation', 'literal, exact', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (361, 36, 2, 'Psalms', 'LXX Psalms 95:7+65 95:8-34', 'Hebrews', 'SBLGNT Hebrews 3:15+12 3:15', 110945, 75, 4005, 75);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 3, 'Psalms', 95, 'Psalms 95:11', 'Hebrews', 'Hebrews 3:18', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 3, 'Psalms', 95, 'LXX Psalms 95:11+31 95:11-3', 'Hebrews', 'SBLGNT Hebrews 3:18+26 3:18-24', 111232, 18, 4254, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 3, 'Psalms', 95, 'LXX Psalms 95:11+2 95:11-3', 'Hebrews', 'SBLGNT Hebrews 3:18+7 3:18-24', 111203, 47, 4235, 37, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 3, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 3, 'repetition', 'literal, superset', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (361, 36, 3, 'Psalms', 'LXX Psalms 95:11+20 95:11-3', 'Hebrews', 'SBLGNT Hebrews 3:18+15 3:18-24', 111221, 29, 4243, 29);
-- This clasp would be too short and far from being unique, even if there is connection between the texts:
-- insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
--  (361, 'Psalms', 'LXX Psalms 95:11+2 95:11-46', 'Hebrews', 'SBLGNT Hebrews 3:18+7 3:18-57', 111202, 4, 4235, 4);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 4, 'Psalms', 95, 'Psalms 95:11', 'Hebrews', 'Hebrews 4:3', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 4, 'Psalms', 95, 'LXX Psalms 95:11 95:11', 'Hebrews', 'SBLGNT Hebrews 4:3+53 4:3-42', 111201, 52, 4606, 52, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 4, 'Psalms', 95, 'LXX Psalms 95:11', 'Hebrews', 'SBLGNT Hebrews 4:3+53 4:3-42', 111201, 52, 4606, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 4, null, 'καθως ειρηκεν'); -- καθως ειρηκεν = as He has said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 4, 'repeated quotation', 'literal, exact', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (361, 36, 4, 'Psalms', 'LXX Psalms 95:11', 'Hebrews', 'SBLGNT Hebrews 4:3+53 4:3-42', 111201, 52, 4606, 52);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 5, 'Psalms', 95, 'Psalms 95:11', 'Hebrews', 'Hebrews 4:5', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 5, 'Psalms', 95, 'LXX Psalms 95:11+18 95:11', 'Hebrews', 'SBLGNT Hebrews 4:5+15 4:5', 111219, 34, 4804, 34, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 5, 'Psalms', 95, 'LXX Psalms 95:11+18 95:11', 'Hebrews', 'SBLGNT Hebrews 4:5+15 4:5', 111219, 34, 4804, 34, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 5, null, 'και εν τουτω παλιν'); -- και εν τουτω παλιν = and in this again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 5, 'repeated quotation', 'literal, exact', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (361, 36, 5, 'Psalms', 'LXX Psalms 95:11+18 95:11', 'Hebrews', 'SBLGNT Hebrews 4:5+15 4:5', 111219, 34, 4804, 34);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 6, 'Psalms', 95, 'Psalms 95:7-8', 'Hebrews', 'Hebrews 4:7', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 6, 'Psalms', 95, 'LXX Psalms 95:7+65 95:8-52', 'Hebrews', 'SBLGNT Hebrews 4:7+73 4:7', 110945, 57, 5001, 57, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (361, 36, 6, 'Psalms', 95, 'LXX Psalms 95:7+65 95:8-52', 'Hebrews', 'SBLGNT Hebrews 4:7+73 4:7', 110945, 57, 5001, 57, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (36, 6, 'Δαυιδ', 'καθως προειρηται'); -- καθως προειρηται = just as it has been said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (36, 6, 'repeated quotation', 'literal, exact', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (361, 36, 6, 'Psalms', 'LXX Psalms 95:7+65 95:8-52', 'Hebrews', 'SBLGNT Hebrews 4:7+73 4:7', 110945, 57, 5001, 57);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (371, 37, 1, 'Psalms', 102, 'Psalms 102:25-27', 'Hebrews', 'Hebrews 1:10-12', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (371, 37, 1, 'Psalms', 102, 'LXX Psalms 102:25+10 102:26-29', 'Hebrews', 'SBLGNT Hebrews 1:10+13 1:12-74', 117061, 133, 907, 133, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (371, 37, 1, 'Psalms', 102, 'LXX Psalms 102:26+92 102:27', 'Hebrews', 'SBLGNT Hebrews 1:12+40 1:12', 117208, 52, 1062, 52, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (371, 37, 1, 'Psalms', 102, 'LXX Psalms 102:25 102:27', 'Hebrews', 'SBLGNT Hebrews 1:10+3 1:12', 117051, 209, 897, 217, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (37, 1, 'θεος', 'και'); -- προς δε τον υιον ... και = unto however the Son ... and
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (37, 1, 'quotation', 'literal, subset', 'Z.K.'); -- the words "ως ιματιον" is doubled in Hebrews
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (371, 'Hebrews', 'SBLGNT Hebrews 1:10 1:10-65', 894, 896); -- kai
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (371, 'Hebrews', 'SBLGNT Hebrews 1:1+28 1:1-27', 41, 51); -- Theos
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (371, 37, 1, 'Psalms', 'LXX Psalms 102:25 102:27', 'Hebrews', 'SBLGNT Hebrews 1:10+3 1:12', 117051, 209, 897, 217);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (381, 38, 1, 'Psalms', 104, 'Psalms 104:4', 'Hebrews', 'Hebrews 1:7', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (381, 38, 1, 'Psalms', 104, 'LXX Psalms 104:4 104:4-6', 'Hebrews', 'SBLGNT Hebrews 1:7+27 1:7-7', 119059, 57, 636, 57, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (381, 38, 1, 'Psalms', 104, 'LXX Psalms 104:4', 'Hebrews', 'SBLGNT Hebrews 1:7+27 1:7', 119059, 63, 636, 64, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (38, 1, 'θεος', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (38, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (381, 'Hebrews', 'SBLGNT Hebrews 1:7 1:7-64', 609, 635);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (381, 'Hebrews', 'SBLGNT Hebrews 1:1+28 1:1-27', 41, 51); -- Theos
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (381, 38, 1, 'Psalms', 'LXX Psalms 104:4', 'Hebrews', 'SBLGNT Hebrews 1:7+27 1:7', 119059, 63, 636, 64);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (391, 39, 1, 'Psalms', 109, 'Psalms 109:3', 'John', 'John 15:25', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (391, 39, 1, 'Psalms', 109, 'LXX Psalms 109:3+35 109:3', 'John', 'SBLGNT John 15:25+51 15:25', 130561, 12, 52597, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (391, 39, 1, 'Psalms', 109, 'LXX Psalms 109:3+29 109:3', 'John', 'SBLGNT John 15:25+47 15:25', 130555, 18, 52593, 16, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (39, 1, 'εν τω νομω αυτων', 'γεγραμμενος'); -- εν τω νομω αυτων γεγραμμενος = in the law of them having been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (39, 1, 'quotation', 'literal, change', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (391, 'John', 'SBLGNT John 15:25 15:25-16', 52546, 52592);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (391, 39, 1, 'Psalms', 'LXX Psalms 109:3+9 109:3-35', 'John', 'SBLGNT John 15:25+48 15:25-12', 130535, 3, 52594, 3);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (391, 39, 1, 'Psalms', 'LXX Psalms 109:3+35 109:3', 'John', 'SBLGNT John 15:25+51 15:25', 130561, 12, 52597, 12);
-- "Mis" is copied from the beginning from Psalm 109:3. So this is similar to a "..."-like quotation.

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (401, 40, 1, 'Psalms', 110, 'Psalms 110:1', 'Luke', 'Luke 20:42-43', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (401, 40, 1, 'Psalms', 110, 'LXX Psalms 110:1+19 110:1', 'Luke', 'SBLGNT Luke 20:42+36 20:43', 132491, 73, 79157, 73, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (401, 40, 1, 'Psalms', 110, 'LXX Psalms 110:1+13 110:1', 'Luke', 'SBLGNT Luke 20:42+31 20:43', 132485, 79, 79152, 78, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 1, 'Δαυιδ ... εν βιβλω ψαλμων', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (401, 'Luke', 'SBLGNT Luke 20:42 20:42-37', 79121, 79151);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (401, 40, 1, 'Psalms', 'LXX Psalms 110:1+13 110:1', 'Luke', 'SBLGNT Luke 20:42+31 20:43', 132485, 79, 79152, 78);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (402, 40, 2, 'Psalms', 110, 'Psalms 110:1', 'Acts', 'Acts 2:34-35', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (402, 40, 2, 'Psalms', 110, 'LXX Psalms 110:1+11 110:1', 'Acts', 'SBLGNT Acts 2:34+40 2:35', 132483, 81, 5654, 81, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (402, 40, 2, 'Psalms', 110, 'LXX Psalms 110:1+13 110:1', 'Acts', 'SBLGNT Acts 2:34+42 2:35', 132485, 79, 5656, 79, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 2, 'Δαυιδ', 'λεγει, exact'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 2, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (402, 'Acts', 'SBLGNT Acts 2:34 2:34-38', 5614, 5655);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (402, 40, 2, 'Psalms', 'LXX Psalms 110:1+13 110:1', 'Acts', 'SBLGNT Acts 2:34+42 2:35', 132485, 79, 5656, 79);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (403, 40, 3, 'Psalms', 110, 'Psalms 110:1', 'Hebrews', 'Hebrews 1:13', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (403, 40, 3, 'Psalms', 110, 'LXX Psalms 110:1+35 110:1', 'Hebrews', 'SBLGNT Hebrews 1:13+31 1:13', 132507, 57, 1145, 57, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (403, 40, 3, 'Psalms', 110, 'LXX Psalms 110:1+35 110:1', 'Hebrews', 'SBLGNT Hebrews 1:13+31 1:13', 132507, 57, 1145, 57, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 3, 'θεος', 'ειρηκεν'); -- ειρηκεν = did He say
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (403, 'Hebrews', 'SBLGNT Hebrews 1:13 1:13-57', 1114, 1144);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (403, 'Hebrews', 'SBLGNT Hebrews 1:1+28 1:1-27', 41, 51); -- Theos
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (403, 40, 3, 'Psalms', 'LXX Psalms 110:1+35 110:1', 'Hebrews', 'SBLGNT Hebrews 1:13+31 1:13', 132507, 57, 1145, 57);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (404, 40, 4, 'Psalms', 110, 'Psalms 110:1', 'Matthew', 'Matthew 22:44', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (404, 40, 4, 'Psalms', 110, 'LXX Psalms 110:1+19 110:1-17', 'Matthew', 'SBLGNT Matthew 22:44+5 22:44-15', 132491, 56, 66113, 56, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (404, 40, 4, 'Psalms', 110, 'LXX Psalms 110:1+13 110:1', 'Matthew', 'SBLGNT Matthew 22:44', 132485, 79, 66108, 76, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 4, 'Δαυιδ', 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 4, 'quotation', 'literal, synonym', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (404, 'Matthew', 'SBLGNT Matthew 22:43+11 22:43', 66066, 66107);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (404, 40, 4, 'Psalms', 'LXX Psalms 110:1+13 110:1', 'Matthew', 'SBLGNT Matthew 22:44', 132485, 79, 66108, 76);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (405, 40, 5, 'Psalms', 110, 'Psalms 110:1', 'Mark', 'Mark 12:36', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (405, 40, 5, 'Psalms', 110, 'LXX Psalms 110:1+19 110:1-17', 'Mark', 'SBLGNT Mark 12:36+38 12:36-15', 132491, 56, 41475, 56, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (405, 40, 5, 'Psalms', 110, 'LXX Psalms 110:1+13 110:1', 'Mark', 'SBLGNT Mark 12:36+33 12:36', 132485, 79, 41470, 76, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 5, 'Δαυιδ', 'ειπεν'); -- ειπεν = said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 5, 'quotation', 'literal, synonym', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (405, 'Mark', 'SBLGNT Mark 12:36 12:36-76', 41437, 41469);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (405, 40, 5, 'Psalms', 'LXX Psalms 110:1+13 110:1', 'Mark', 'SBLGNT Mark 12:36+33 12:36', 132485, 79, 41470, 76);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (403, 40, 6, 'Psalms', 110, 'Psalms 110:1', 'Hebrews', 'Hebrews 10:13', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (403, 40, 6, 'Psalms', 110, 'LXX Psalms 110:1+70 110:1-3', 'Hebrews', 'SBLGNT Hebrews 10:13+40 10:13-5', 132542, 19, 16239, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (403, 40, 6, 'Psalms', 110, 'LXX Psalms 110:1+62 110:1-3', 'Hebrews', 'SBLGNT Hebrews 10:13+31 10:13-5', 132534, 27, 16230, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (40, 6, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (40, 6, 'strong allusion', 'literal', 'Z.K.'); -- weaker than a repetition

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (411, 41, 1, 'Psalms', 110, 'Psalms 110:4', 'Hebrews', 'Hebrews 5:6', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (411, 41, 1, 'Psalms', 110, 'LXX Psalms 110:4+36 110:4', 'Hebrews', 'SBLGNT Hebrews 5:6+22 5:6', 132762, 39, 6337, 39, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (411, 41, 1, 'Psalms', 110, 'LXX Psalms 110:4+32 110:4', 'Hebrews', 'SBLGNT Hebrews 5:6+20 5:6', 132758, 43, 6335, 41, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (41, 1, 'ο λαλησας', 'λεγει'); -- ο λαλησας = the [One] having said, λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (41, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (411, 'Hebrews', 'SBLGNT Hebrews 5:6 5:6-41', 6315, 6334);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (411, 'Hebrews', 'SBLGNT Hebrews 5:5+53 5:5-32', 6266, 6282); -- o lelhsas
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (411, 41, 1, 'Psalms', 'LXX Psalms 110:4+32 110:4', 'Hebrews', 'SBLGNT Hebrews 5:6+20 5:6', 132758, 43, 6335, 41);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (412, 41, 2, 'Psalms', 110, 'Psalms 110:4', 'Hebrews', 'Hebrews 5:10', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (412, 41, 2, 'Psalms', 110, 'LXX Psalms 110:4+53 110:4', 'Hebrews', 'SBLGNT Hebrews 5:10+33 5:10', 132779, 22, 6667, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (412, 41, 2, 'Psalms', 110, 'LXX Psalms 110:4+53 110:4', 'Hebrews', 'SBLGNT Hebrews 5:10+33 5:10', 132779, 22, 6667, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (41, 2, 'θεου', 'προσαγορευθεις'); -- προσαγορευθεις = having been designated
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (41, 2, 'repeated quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (412, 'Hebrews', 'SBLGNT Hebrews 5:10 5:10-22', 6634, 6666);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (412, 41, 2, 'Psalms', 'LXX Psalms 110:4+53 110:4', 'Hebrews', 'SBLGNT Hebrews 5:10+33 5:10', 132779, 22, 6667, 22);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (413, 41, 3, 'Psalms', 110, 'Psalms 110:4', 'Hebrews', 'Hebrews 7:17', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (413, 41, 3, 'Psalms', 110, 'LXX Psalms 110:4+36 110:4', 'Hebrews', 'SBLGNT Hebrews 7:17+19 7:17', 132762, 39, 10191, 39, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (413, 41, 3, 'Psalms', 110, 'LXX Psalms 110:4+32 110:4', 'Hebrews', 'SBLGNT Hebrews 7:17+17 7:17', 132758, 43, 10189, 41, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (41, 3, null, 'μαρτυρειται γαρ'); -- μαρτυρειται γαρ = it is testified for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (41, 3, 'repeated quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (413, 'Hebrews', 'SBLGNT Hebrews 7:17 7:17-41', 10172, 10188);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (413, 41, 3, 'Psalms', 'LXX Psalms 110:4+32 110:4', 'Hebrews', 'SBLGNT Hebrews 7:17+17 7:17', 132758, 43, 10189, 41);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (414, 41, 4, 'Psalms', 110, 'Psalms 110:4', 'Hebrews', 'Hebrews 7:21', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (414, 41, 4, 'Psalms', 110, 'LXX Psalms 110:4 110:4-41', 'Hebrews', 'SBLGNT Hebrews 7:21+40 7:21-17', 132726, 34, 10477, 34, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (414, 41, 4, 'Psalms', 110, 'LXX Psalms 110:4+36 110:4-17', 'Hebrews', 'SBLGNT Hebrews 7:21+74 7:22-43', 132762, 22, 10511, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (414, 41, 4, 'Psalms', 110, 'LXX Psalms 110:4 110:4-22', 'Hebrews', 'SBLGNT Hebrews 7:21+40 7:21', 132726, 53, 10477, 51, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (41, 4, 'του', 'λεγοντος'); -- του = the [One], λεγοντος = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (41, 4, 'repeated quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (414, 'Hebrews', 'SBLGNT Hebrews 7:21+20 7:21-51', 10457, 10476);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (414, 41, 4, 'Psalms', 'LXX Psalms 110:4 110:4-22', 'Hebrews', 'SBLGNT Hebrews 7:21+40 7:21', 132726, 53, 10477, 51);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (421, 42, 1, 'Psalms', 112, 'Psalms 112:9', 'II_Corinthians', 'II_Corinthians 9:9', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (421, 42, 1, 'Psalms', 112, 'LXX Psalms 112:9 112:9-37', 'II_Corinthians', 'SBLGNT II_Corinthians 9:9+14 9:9', 134164, 59, 14361, 59, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (421, 42, 1, 'Psalms', 112, 'LXX Psalms 112:9 112:9-37', 'II_Corinthians', 'SBLGNT II_Corinthians 9:9+14 9:9', 134164, 59, 14361, 59, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (42, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (42, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (421, 'II_Corinthians', 'SBLGNT II_Corinthians 9:9 9:9-59', 14347, 14360);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (421, 42, 1, 'Psalms', 'LXX Psalms 112:9 112:9-37', 'II_Corinthians', 'SBLGNT II_Corinthians 9:9+14 9:9', 134164, 59, 14361, 59);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (431, 43, 1, 'Psalms', 116, 'Psalms 116:10', 'II_Corinthians', 'II_Corinthians 4:13', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (431, 43, 1, 'Psalms', 116, 'LXX Psalms 116:10+9 116:10-22', 'II_Corinthians', 'SBLGNT II_Corinthians 4:13+48 4:13-32', 136804, 19, 6211, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (431, 43, 1, 'Psalms', 116, 'LXX Psalms 116:10+9 116:10-22', 'II_Corinthians', 'SBLGNT II_Corinthians 4:13+48 4:13-32', 136804, 19, 6211, 19, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (43, 1, null, 'γεγραμμενον'); -- γεγραμμενον = having been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (43, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (431, 'II_Corinthians', 'SBLGNT II_Corinthians 4:13+31 4:13-51', 6194, 6210);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (431, 43, 1, 'Psalms', 'LXX Psalms 116:10+9 116:10-22', 'II_Corinthians', 'SBLGNT II_Corinthians 4:13+48 4:13-32', 136804, 19, 6211, 19);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (441, 44, 1, 'Psalms', 117, 'Psalms 117:1', 'Romans', 'Romans 15:11', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (441, 44, 1, 'Psalms', 117, 'LXX Psalms 117:1+36 117:1-18', 'Romans', 'SBLGNT Romans 15:11+38 15:11-21', 137244, 9, 30295, 9, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (441, 44, 1, 'Psalms', 117, 'LXX Psalms 117:1+46 117:1', 'Romans', 'SBLGNT Romans 15:11+51 15:11', 137254, 17, 30308, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (441, 44, 1, 'Psalms', 117, 'LXX Psalms 117:1+9 117:1', 'Romans', 'SBLGNT Romans 15:11+8 15:11', 137217, 54, 30265, 60, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (44, 1, null, 'και παλιν'); -- και παλιν = and again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (44, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (441, 'Romans', 'SBLGNT Romans 15:11 15:11-60', 30257, 30264);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (441, 44, 1, 'Psalms', 'LXX Psalms 117:1+9 117:1', 'Romans', 'SBLGNT Romans 15:11+8 15:11', 137217, 54, 30265, 60);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (451, 45, 1, 'Psalms', 118, 'Psalms 118:6', 'Hebrews', 'Hebrews 13:6', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (451, 45, 1, 'Psalms', 118, 'LXX Psalms 118:5+55 118:6', 'Hebrews', 'SBLGNT Hebrews 13:6+23 13:6', 137637, 50, 24683, 50, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (451, 45, 1, 'Psalms', 118, 'LXX Psalms 118:6', 'Hebrews', 'SBLGNT Hebrews 13:6+24 13:6', 137638, 49, 24684, 49, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (45, 1, null, 'ωστε θαρρουντας ημας λεγειν'); -- ωστε θαρρουντας ημας λεγειν = so are confident we to say
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (45, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (451, 'Hebrews', 'SBLGNT Hebrews 13:6 13:6-49', 24660, 24683);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (451, 45, 1, 'Psalms', 'LXX Psalms 118:6', 'Hebrews', 'SBLGNT Hebrews 13:6+24 13:6', 137638, 49, 24684, 49);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (461, 46, 1, 'Psalms', 118, 'Psalms 118:22-23', 'Matthew', 'Matthew 21:42', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (461, 46, 1, 'Psalms', 118, 'LXX Psalms 118:22 118:23', 'Matthew', 'SBLGNT Matthew 21:42+47 21:42', 138495, 114, 62687, 114, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (461, 46, 1, 'Psalms', 118, 'LXX Psalms 118:22 118:23', 'Matthew', 'SBLGNT Matthew 21:42+47 21:42', 138495, 114, 62687, 114, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (46, 1, 'εν ταις γραφαις', 'ανεγνωτε'); -- εν ταις γραφαις = in the Scriptures, ανεγνωτε = did you read
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (46, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (461, 'Matthew', 'SBLGNT Matthew 21:42 21:42-114', 62640, 62686);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (461, 46, 1, 'Psalms', 'LXX Psalms 118:22 118:23', 'Matthew', 'SBLGNT Matthew 21:42+47 21:42', 138495, 114, 62687, 114);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (462, 46, 2, 'Psalms', 118, 'Psalms 118:22-23', 'Mark', 'Mark 12:10-11', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (462, 46, 2, 'Psalms', 118, 'LXX Psalms 118:22 118:23', 'Mark', 'SBLGNT Mark 12:10+27 12:11', 138495, 114, 39109, 114, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (462, 46, 2, 'Psalms', 118, 'LXX Psalms 118:22 118:23', 'Mark', 'SBLGNT Mark 12:10+27 12:11', 138495, 114, 39109, 114, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (46, 2, 'γραφην', 'ανεγνωτε'); -- γραφην = Scripture, ανεγνωτε = have you read
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (46, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (462, 'Mark', 'SBLGNT Mark 12:10 12:10-62', 39082, 39108);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (462, 46, 2, 'Psalms', 'LXX Psalms 118:22 118:23', 'Mark', 'SBLGNT Mark 12:10+27 12:11', 138495, 114, 39109, 114);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (463, 46, 3, 'Psalms', 118, 'Psalms 118:22', 'Luke', 'Luke 20:17', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (463, 46, 3, 'Psalms', 118, 'LXX Psalms 118:22 118:23-50', 'Luke', 'SBLGNT Luke 20:17+50 20:18-62', 138495, 64, 77307, 64, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (463, 46, 3, 'Psalms', 118, 'LXX Psalms 118:22', 'Luke', 'SBLGNT Luke 20:17+50 20:17', 138495, 62, 77307, 62, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (46, 3, null, 'γεγραμμενον'); -- γεγραμμενον = has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (46, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (463, 'Luke', 'SBLGNT Luke 20:17+22 20:17-62', 77279, 77306);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (463, 46, 3, 'Psalms', 'LXX Psalms 118:22', 'Luke', 'SBLGNT Luke 20:17+50 20:17', 138495, 62, 77307, 62);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (464, 46, 4, 'Psalms', 118, 'Psalms 118:22', 'I_Peter', 'I_Peter 2:7', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (464, 46, 4, 'Psalms', 118, 'LXX Psalms 118:22+5 118:22', 'I_Peter', 'SBLGNT I_Peter 2:7+44 2:7', 138500, 57, 2736, 57, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (464, 46, 4, 'Psalms', 118, 'LXX Psalms 118:22', 'I_Peter', 'SBLGNT I_Peter 2:7+39 2:7', 138495, 62, 2731, 62, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (46, 4, 'εν γραφη', 'περιεχει ... δε'); -- εν γραφη = in Scripture, περιεχει ... δε = it is contained ... however
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (46, 4, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (464, 'I_Peter', 'SBLGNT I_Peter 2:7+27 2:7-62', 2719, 2730);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (464, 'I_Peter', 'SBLGNT I_Peter 2:6 2:6-81', 2591, 2610);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (464, 46, 4, 'Psalms', 'LXX Psalms 118:22', 'I_Peter', 'SBLGNT I_Peter 2:7+39 2:7', 138495, 62, 2731, 62);

-- TODO: Renumber psalm IDs eventually:
-- TODO: This may be a combination of more quotations, consider adding this as a part to 22061.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 47, 1, 'Psalms', 50, 'LXX Psalms 50:14', 'Matthew', 'SBLGNT Matthew 5:33b', 0, 0, 0, 0, 'traditional');
-- TODO: Find this quotation, it seems Matthew 5:33 is not a literal quotation.

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (481, 48, 1, 'Psalms', 78, 'LXX Psalms 78:24+35 78:24', 'John', 'SBLGNT John 6:31+66 6:31-6', 88940, 19, 19255, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (481, 48, 1, 'Psalms', 78, 'LXX Psalms 78:24+21 78:24', 'John', 'SBLGNT John 6:31+56 6:31', 88926, 33, 19245, 35, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (48, 1, null, 'καθως εστιν γεγραμμενον'); -- καθως εστιν γεγραμμενον = as it is written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (48, 1, 'quotation', 'literal, fuzzy, subset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (481, 'John', 'SBLGNT John 6:31+35 6:31-35', 19224, 19244);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (481, 48, 1, 'Psalms', 'LXX Psalms 78:24+21 78:24', 'John', 'SBLGNT John 6:31+56 6:31', 88926, 33, 19245, 35);

-- Discuss if this indeed belongs to 301, or, because of "kai", this can be considered as a second quotation.
-- "kai" is actually there in LXX, so it can be considered as a part of the quoted text. Now we assume that this belongs to 301.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (301, 49, 1, 'Psalms', 109, 'LXX Psalms 109:8+30 109:8-8', 'Acts', 'SBLGNT Acts 1:20+76 1:20-9', 130835, 23, 2103, 23, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (301, 49, 1, 'Psalms', 109, 'LXX Psalms 109:8+30 109:8', 'Acts', 'SBLGNT Acts 1:20+76 1:20', 130835, 31, 2103, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (49, 1, 'εν βιβλω ψαλμων', 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (49, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (301, 49, 1, 'Psalms', 'LXX Psalms 109:8+30 109:8', 'Acts', 'SBLGNT Acts 1:20+76 1:20', 130835, 31, 2103, 32);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (501, 50, 1, 'Psalms', 132, 'LXX Psalms 132:11+47 132:11-32', 'Acts', 'SBLGNT Acts 2:30+48 2:30-35', 154632, 11, 5305, 11, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (501, 50, 1, 'Psalms', 132, 'LXX Psalms 132:11 132:11-3', 'Acts', 'SBLGNT Acts 2:30 2:30-5', 154585, 87, 5257, 89, 'manual'); -- This is maybe too long. FIXME
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (50, 1, 'Δαυιδ', 'ειδως'); -- ειδως = knowing
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (50, 1, 'quotation', 'far-fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (501, 'Acts', 'SBLGNT Acts 2:29+13 2:29-70', 5134, 5186); -- David is mentioned here
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (501, 'Acts', 'SBLGNT Acts 2:30 2:30-61', 5257, 5289); -- This overlaps the quotation. FIXME
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (501, 50, 1, 'Psalms', 'LXX Psalms 132:11+47 132:11-32', 'Acts', 'SBLGNT Acts 2:30+48 2:30-35', 154632, 11, 5305, 11);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (501, 50, 1, 'Psalms', 'LXX Psalms 132:11+75 132:11-3', 'Acts', 'SBLGNT Acts 2:30+77 2:30-5', 154660, 12, 5334, 12);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (501, 50, 1, 'Psalms', 'LXX Psalms 132:11 132:11-84', 'Acts', 'SBLGNT Acts 2:30+33 2:30-55', 154585, 6, 5290, 6);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (511, 51, 1, 'Psalms', 89, 'LXX Psalms 89:20 89:20-34', 'Acts', 'SBLGNT Acts 13:22+68 13:22-58', 103496, 13, 42868, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (511, 51, 1, 'Psalms', 89, 'LXX Psalms 89:20 89:20-34', 'Acts', 'SBLGNT Acts 13:22+68 13:22-58', 103496, 13, 42868, 13, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (51, 1, null, 'ω ... ειπεν'); -- ω ... ειπεν = to whom ... He said
-- In fact, David as source is not given here. Psalm 89 is authored by Ethan the Ezrahite.
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (51, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (511, 'Acts', 'SBLGNT Acts 13:22+49 13:22-71', 42849, 42867);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (511, 51, 1, 'Psalms', 'LXX Psalms 89:20 89:20-34', 'Acts', 'SBLGNT Acts 13:22+68 13:22-58', 103496, 13, 42868, 13);

-- TODO: Complete these entries if quotations with just contextual evidence will be accepted for the database. (See also II_Corinthians 13:1.)
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (521, 52, 1, 'Psalms', 118, 'LXX Psalms 118:26 118:26-28', 'Matthew', 'SBLGNT Matthew 21:9+75 21:9-20', 138698, 36, 59524, 36, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (531, 53, 1, 'Psalms', 148, 'LXX Psalms 148:1+67 148:1', 'Matthew', 'SBLGNT Matthew 21:9+117 21:9', 169576, 14, 59566, 14, 'getrefs');
-- Also, there are references in the other Gospels (Mark 11:9, John 12:13, Luke 13:35, Matthew 23:39). TODO.

-- Non-psalms:

-- TODO: Add traditional data (eventually).
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1011, 101, 1, 'Isaiah', null, 'LXX Isaiah 29:14+69 29:14-5', 'I_Corinthians', 'SBLGNT I_Corinthians 1:19+12 1:19-7', 55662, 45, 1391, 45, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1011, 101, 1, 'Isaiah', null, 'LXX Isaiah 29:14+69 29:14-5', 'I_Corinthians', 'SBLGNT I_Corinthians 1:19+12 1:19-7', 55662, 45, 1391, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (101, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (101, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1011, 'I_Corinthians', 'SBLGNT I_Corinthians 1:19 1:19-52', 1379, 1390);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1011, 101, 1, 'Isaiah', 'LXX Isaiah 29:14+69 29:14-5', 'I_Corinthians', 'SBLGNT I_Corinthians 1:19+12 1:19-7', 55662, 45, 1391, 45);
-- TODO: Complete this entry:
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1021, 102, 1, 'Isaiah', null, 'Isaiah 64:4', 'I_Corinthians', 'I_Corinthians 2:9', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1031, 103, 1, 'Isaiah', null, 'LXX Isaiah 40:13+3 40:13-41', 'Romans', 'SBLGNT Romans 11:34+6 11:34-25', 79031, 14, 24741, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1031, 103, 1, 'Isaiah', null, 'LXX Isaiah 40:13 40:13-14', 'Romans', 'SBLGNT Romans 11:34', 79028, 44, 24735, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (103, 1, null, 'γαρ'); -- γαρ = for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (103, 1, 'quotation', 'fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1031, 'Romans', 'SBLGNT Romans 11:34+3 11:34-39', 24738, 24740);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1031, 103, 1, 'Isaiah', 'LXX Isaiah 40:13 40:13-55', 'Romans', 'SBLGNT Romans 11:34 11:34-42', 79028, 3, 24735, 3);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1031, 103, 1, 'Isaiah', 'LXX Isaiah 40:13+3 40:13-14', 'Romans', 'SBLGNT Romans 11:34+6 11:34', 79031, 41, 24741, 39);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1032, 103, 2, 'Isaiah', null, 'LXX Isaiah 40:13+3 40:13-41', 'I_Corinthians', 'SBLGNT I_Corinthians 2:16+6 2:16-41', 79031, 14, 3646, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1032, 103, 2, 'Isaiah', null, 'LXX Isaiah 40:13', 'I_Corinthians', 'SBLGNT I_Corinthians 2:16 2:16-24', 79028, 58, 3640, 37, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (103, 2, null, 'γαρ'); -- γαρ = for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (103, 2, 'quotation', 'far-fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1032, 'I_Corinthians', 'SBLGNT I_Corinthians 2:16+3 2:16-55', 3643, 3645);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1032, 103, 2, 'Isaiah', 'LXX Isaiah 40:13 40:13-55', 'I_Corinthians', 'SBLGNT I_Corinthians 2:16 2:16-58', 79028, 3, 3640, 3);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1032, 103, 2, 'Isaiah', 'LXX Isaiah 40:13+3 40:13-41', 'I_Corinthians', 'SBLGNT I_Corinthians 2:16+6 2:16-41', 79031, 14, 3646, 14);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1033, 103, 3, 'Isaiah', null, 'LXX Isaiah 52:5+115 52:5', 'Romans', 'SBLGNT Romans 2:24+23 2:24-14', 106382, 25, 4605, 25, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1033, 103, 3, 'Isaiah', null, 'LXX Isaiah 52:5+90 52:5', 'Romans', 'SBLGNT Romans 2:24 2:24-14', 106357, 50, 4582, 48, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (103, 3, null, 'γαρ, καθως γεγραπται'); -- γαρ = for, καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (103, 3, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1033, 'Romans', 'SBLGNT Romans 2:24+2 2:24-57', 4584, 4586); -- gar
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1033, 'Romans', 'SBLGNT Romans 2:24+48 2:24', 4630, 4643); -- καθως γεγραπται
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1033, 103, 3, 'Isaiah', 'LXX Isaiah 52:5+105 52:5-33', 'Romans', 'SBLGNT Romans 2:24 2:24-60', 106372, 2, 4582, 2); -- to
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1033, 103, 3, 'Isaiah', 'LXX Isaiah 52:5+107 52:5-28', 'Romans', 'SBLGNT Romans 2:24+5 2:24-52', 106374, 5, 4587, 5); -- onoma
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1033, 103, 3, 'Isaiah', 'LXX Isaiah 52:5+90 52:5-44', 'Romans', 'SBLGNT Romans 2:24+17 2:24-39', 106357, 6, 4599, 6); -- di ymas
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1033, 103, 3, 'Isaiah', 'LXX Isaiah 52:5+115 52:5', 'Romans', 'SBLGNT Romans 2:24+23 2:24-14', 106382, 25, 4605, 25);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1041, 104, 1, 'Isaiah', null, 'LXX Isaiah 10:22+18 10:22-64', 'Romans', 'SBLGNT Romans 9:27+46 9:27-18', 22157, 27, 20033, 27, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1041, 104, 1, 'Isaiah', null, 'LXX Isaiah 10:22+60 10:22-12', 'Romans', 'SBLGNT Romans 9:27+82 9:28-22', 22199, 37, 20069, 37, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1041, 104, 1, 'Isaiah', null, 'LXX Isaiah 10:22+18 10:23-21', 'Romans', 'SBLGNT Romans 9:27+46 9:28-15', 22157, 119, 20033, 80, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (104, 1, 'Ησαιας', 'κραζει'); -- κραζει = cries out
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (104, 1, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1041, 'Romans', 'SBLGNT Romans 9:27 9:27-64', 19987, 20013);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1041, 104, 1, 'Isaiah', 'LXX Isaiah 10:22+3 10:22-103', 'Romans', 'SBLGNT Romans 9:27+27 9:27-61', 22142, 3, 20014, 3); -- ean
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1041, 104, 1, 'Isaiah', 'LXX Isaiah 10:22+18 10:22-64', 'Romans', 'SBLGNT Romans 9:27+46 9:27-18', 22157, 27, 20033, 27); -- ισραηλ ως η αμμος της θαλασσης το
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1041, 104, 1, 'Isaiah', 'LXX Isaiah 10:22+49 10:22-54', 'Romans', 'SBLGNT Romans 9:27+76 9:27-9', 22188, 6, 20063, 6); -- leimma
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1041, 104, 1, 'Isaiah', 'LXX Isaiah 10:22+60 10:22-12', 'Romans', 'SBLGNT Romans 9:27+82 9:28-22', 22199, 37, 20069, 37);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1041, 104, 1, 'Isaiah', 'LXX Isaiah 10:23+21 10:23-21', 'Romans', 'SBLGNT Romans 9:28+28 9:28-15', 22269, 7, 20106, 7); -- ποιησει
-- Alternatively:
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos, alternative) values
 (91041, 'Romans', 'SBLGNT Romans 9:27 9:27-64', 19987, 20013, 1);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (91041, 104, 1, 'Isaiah', 'LXX Isaiah 10:22+3 10:22-103', 'Romans', 'SBLGNT Romans 9:27+27 9:27-61', 22142, 3, 20014, 3); -- ean
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (91041, 104, 1, 'Isaiah', 'LXX Isaiah 10:22+18 10:22-64', 'Romans', 'SBLGNT Romans 9:27+46 9:27-18', 22157, 27, 20033, 27); -- ισραηλ ως η αμμος της θαλασσης το
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (91041, 104, 1, 'Isaiah', 'LXX Isaiah 10:22+45 10:22-54', 'Romans', 'SBLGNT Romans 9:27+73 9:27-9', 22184, 10, 20060, 9); -- kataleimma -> upoleimma
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (91041, 104, 1, 'Isaiah', 'LXX Isaiah 10:22+60 10:22-12', 'Romans', 'SBLGNT Romans 9:27+82 9:28-22', 22199, 37, 20069, 37);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (91041, 104, 1, 'Isaiah', 'LXX Isaiah 10:23+21 10:23-21', 'Romans', 'SBLGNT Romans 9:28+28 9:28-15', 22269, 7, 20106, 7); -- ποιησει
-- End of alternation.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1051, 105, 1, 'Isaiah', null, 'LXX Isaiah 1:9+3 1:9', 'Romans', 'SBLGNT Romans 9:29+24 9:29', 809, 81, 20152, 81, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1051, 105, 1, 'Isaiah', null, 'LXX Isaiah 1:9+3 1:9', 'Romans', 'SBLGNT Romans 9:29+24 9:29', 809, 81, 20152, 81, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (105, 1, 'Ησαιας', 'καθως προειρηκεν'); -- καθως προειρηκεν = as foretold
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (105, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1051, 'Romans', 'SBLGNT Romans 9:29 9:29-81', 20128, 20151);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1051, 105, 1, 'Isaiah', 'LXX Isaiah 1:9+3 1:9', 'Romans', 'SBLGNT Romans 9:29+24 9:29', 809, 81, 20152, 81);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1061, 106, 1, 'Isaiah', null, 'LXX Isaiah 8:14+53 8:14-95', 'Romans', 'SBLGNT Romans 9:33+35 9:33-56', 16776, 10, 20466, 10, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1061, 106, 1, 'Isaiah', null, 'LXX Isaiah 8:14+48 8:14-94', 'Romans', 'SBLGNT Romans 9:33+30 9:33-54', 16771, 16, 20461, 17, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (106, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (106, 1, 'quotation', 'literal, in-quotation', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1061, 'Romans', 'SBLGNT Romans 9:33 9:33-87', 20431, 20444);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1061, 106, 1, 'Isaiah', 'LXX Isaiah 8:14+48 8:14-94', 'Romans', 'SBLGNT Romans 9:33+30 9:33-54', 16771, 16, 20461, 17);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1061, 106, 1, 'Isaiah', 'LXX Isaiah 8:14+86 8:14-66', 'Romans', 'SBLGNT Romans 9:33+50 9:33-45', 16809, 6, 20481, 6); -- petras -> petran
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1061, 107, 1, 'Isaiah', null, 'LXX Isaiah 28:16+49 28:16-84', 'Romans', 'SBLGNT Romans 9:33+26 9:33-65', 52741, 10, 20457, 10, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1061, 107, 1, 'Isaiah', null, 'LXX Isaiah 28:16+110 28:16-13', 'Romans', 'SBLGNT Romans 9:33+65 9:33-16', 52802, 20, 20496, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1061, 107, 1, 'Isaiah', null, 'LXX Isaiah 28:16+24 28:16', 'Romans', 'SBLGNT Romans 9:33+14 9:33-5', 52716, 119, 20445, 82, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (107, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (107, 1, 'quotation', 'literal, change, far-fuzzy, superset, subset', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1061, 107, 1, 'Isaiah', 'LXX Isaiah 28:16+110 28:16', 'Romans', 'SBLGNT Romans 9:33+65 9:33', 52802, 33, 20496, 36);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1061, 107, 1, 'Isaiah', 'LXX Isaiah 28:16+24 28:16-115', 'Romans', 'SBLGNT Romans 9:33+14 9:33-83', 52716, 4, 20445, 4); -- idoy
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1061, 107, 1, 'Isaiah', 'LXX Isaiah 28:16+49 28:16-85', 'Romans', 'SBLGNT Romans 9:33+26 9:33-66', 52741, 9, 20457, 9); -- Σιων λιθον
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1061, 107, 2, 'Isaiah', null, 'LXX Isaiah 28:16+113 28:16-13', 'Romans', 'SBLGNT Romans 10:11+17 10:11-16', 52805, 17, 21317, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1061, 107, 2, 'Isaiah', null, 'LXX Isaiah 28:16+113 28:16', 'Romans', 'SBLGNT Romans 10:11+17 10:11-5', 52805, 30, 21317, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (107, 2, 'η γραφη', 'λεγει γαρ'); -- η γραφη = the Scripture, λεγει γαρ = says for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (107, 2, 'repeated quotation', 'literal, exact', 'Z.K.');
-- We need to disable this until it cannot be indicated that this introduction belongs to the repeated quotation part.
-- insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
--  (1061, 'Romans', 'SBLGNT Romans 10:11 10:11-36', 21300, 21313); -- TODO: Consider adding the info that this belongs to 107, 2.
-- Otherwise this will show up at the end of the hierarchical diagram -- we don't want that.
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1061, 107, 2, 'Isaiah', 'LXX Isaiah 28:16+113 28:16', 'Romans', 'SBLGNT Romans 10:11+17 10:11-5', 52805, 30, 21317, 28);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1073, 107, 3, 'Isaiah', null, 'LXX Isaiah 28:16+72 28:16-56', 'I_Peter', 'SBLGNT I_Peter 2:6+39 2:6-47', 52764, 15, 2630, 15, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1073, 107, 3, 'Isaiah', null, 'LXX Isaiah 28:16+110 28:16', 'I_Peter', 'SBLGNT I_Peter 2:6+68 2:6', 52802, 33, 2659, 33, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1073, 107, 3, 'Isaiah', null, 'LXX Isaiah 28:16+24 28:16', 'I_Peter', 'SBLGNT I_Peter 2:6+20 2:6', 52716, 119, 2611, 81, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (107, 3, 'εν γραφη', 'περιεχει'); -- εν γραφη = in Scripture,  περιεχει = it is contained
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (107, 3, 'quotation', 'literal, fuzzy, change, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1073, 'I_Peter', 'SBLGNT I_Peter 2:6 2:6-81', 2591, 2610);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1073, 107, 3, 'Isaiah', 'LXX Isaiah 28:16+24 28:16-115', 'I_Peter', 'SBLGNT I_Peter 2:6+20 2:6-77', 52716, 4, 2611, 4); -- idoy
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1073, 107, 3, 'Isaiah', 'LXX Isaiah 28:16+49 28:16-85', 'I_Peter', 'SBLGNT I_Peter 2:6+32 2:6-60', 52741, 9, 2623, 9); -- Σιων λιθον
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1073, 107, 3, 'Isaiah', 'LXX Isaiah 28:16+66 28:16-50', 'I_Peter', 'SBLGNT I_Peter 2:6+41 2:6-33', 52758, 27, 2632, 27); -- ακρογωνιαιον εκλεκτον εντιμον
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1073, 107, 3, 'Isaiah', 'LXX Isaiah 28:16+110 28:16', 'I_Peter', 'SBLGNT I_Peter 2:6+68 2:6', 52802, 33, 2659, 33);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1081, 108, 1, 'Isaiah', null, 'LXX Isaiah 52:7 52:7-58', 'Romans', 'SBLGNT Romans 10:15+44 10:15', 106484, 72, 21631, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (108, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (108, 1, 'quotation', 'far-fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1081, 'Romans', 'SBLGNT Romans 10:15+30 10:15-40', 21617, 21630);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1081, 108, 1, 'Isaiah', 'LXX Isaiah 52:7 52:7-125', 'Romans', 'SBLGNT Romans 10:15+44 10:15-35', 106484, 5, 21631, 5); -- ως ωρα
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1081, 108, 1, 'Isaiah', 'LXX Isaiah 52:7+18 52:7-107', 'Romans', 'SBLGNT Romans 10:15+54 10:15-25', 106502, 5, 21641, 5); -- podes
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1081, 108, 1, 'Isaiah', 'LXX Isaiah 52:7+23 52:7-92', 'Romans', 'SBLGNT Romans 10:15+62 10:15-7', 106507, 15, 21649, 15); -- ευαγγελιζομενου -> ευαγγελιζομενων
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1081, 108, 1, 'Isaiah', 'LXX Isaiah 52:7+67 52:7-58', 'Romans', 'SBLGNT Romans 10:15+79 10:15', 106551, 5, 21666, 5); -- αγαθα
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1091, 109, 1, 'Isaiah', null, 'LXX Isaiah 53:1 53:1-31', 'Romans', 'SBLGNT Romans 10:16+45 10:16', 107401, 28, 21716, 28, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1091, 109, 1, 'Isaiah', null, 'LXX Isaiah 53:1 53:1-31', 'Romans', 'SBLGNT Romans 10:16+45 10:16', 107401, 28, 21716, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (109, 1, 'Ησαιας', 'γαρ λεγει'); -- γαρ λεγει = for says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (109, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1091, 'Romans', 'SBLGNT Romans 10:16+31 10:16-28', 21702, 21715);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1091, 109, 1, 'Isaiah', 'LXX Isaiah 53:1 53:1-31', 'Romans', 'SBLGNT Romans 10:16+45 10:16', 107401, 28, 21716, 28);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1092, 109, 2, 'Isaiah', null, 'LXX Isaiah 52:15+123 53:1', 'John', 'SBLGNT John 12:38+39 12:38', 107400, 60, 44175, 60, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1092, 109, 2, 'Isaiah', null, 'LXX Isaiah 53:1 53:1', 'John', 'SBLGNT John 12:38+40 12:38', 107401, 59, 44176, 59, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (109, 2, 'Ησαΐου του προφητου', 'ον ειπεν'); -- Ησαΐου του προφητου = Isaiah the prophet, ον ειπεν = that said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (109, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1092, 'John', 'SBLGNT John 12:38 12:38-59', 44136, 44175);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1092, 109, 2, 'Isaiah', 'LXX Isaiah 53:1', 'John', 'SBLGNT John 12:38+40 12:38', 107401, 59, 44176, 59);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1101, 110, 1, 'Isaiah', null, 'LXX Isaiah 65:1+32 65:1-61', 'Romans', 'SBLGNT Romans 10:20+24 10:20-53', 127360, 7, 22004, 7, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1101, 110, 1, 'Isaiah', null, 'LXX Isaiah 65:1+14 65:1-67', 'Romans', 'SBLGNT Romans 10:20+32 10:20-33', 127342, 19, 22012, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1101, 110, 1, 'Isaiah', null, 'LXX Isaiah 65:1+37 65:1-42', 'Romans', 'SBLGNT Romans 10:20+63 10:20', 127365, 21, 22043, 21, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1101, 110, 1, 'Isaiah', null, 'LXX Isaiah 65:1 65:1-76', 'Romans', 'SBLGNT Romans 10:20+50 10:20-10', 127328, 24, 22030, 24, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1101, 110, 1, 'Isaiah', null, 'LXX Isaiah 65:1 65:1-42', 'Romans', 'SBLGNT Romans 10:20+24 10:20', 127328, 58, 22004, 60, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (110, 1, 'Ησαιας', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (110, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1101, 'Romans', 'SBLGNT Romans 10:20 10:20-60', 21980, 22003);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1111, 'Romans', 'SBLGNT Romans 10:20 10:20-60', 21980, 22003); -- it introduces also Romans 10:21
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1101, 110, 1, 'Isaiah', 'LXX Isaiah 65:1 65:1-42', 'Romans', 'SBLGNT Romans 10:20+24 10:20', 127328, 58, 22004, 60);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1111, 111, 1, 'Isaiah', null, 'LXX Isaiah 65:2+34 65:2-50', 'Romans', 'SBLGNT Romans 10:21+54 10:21', 127462, 32, 22118, 32, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1111, 111, 1, 'Isaiah', null, 'LXX Isaiah 65:2 65:2-95', 'Romans', 'SBLGNT Romans 10:21+33 10:21-32', 127428, 21, 22097, 21, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1111, 111, 1, 'Isaiah', null, 'LXX Isaiah 65:2 65:2-50', 'Romans', 'SBLGNT Romans 10:21+20 10:21', 127428, 66, 22084, 66, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (111, 1, 'Ησαιας ... προς ... Ισραηλ', 'λεγει'); -- προς ... Ισραηλ = as for ... Israel, λεγει = says (Isaiah is mentioned in 10:20)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (111, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1111, 'Romans', 'SBLGNT Romans 10:21 10:21-66', 22064, 22083);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1111, 111, 1, 'Isaiah', 'LXX Isaiah 65:2 65:2-50', 'Romans', 'SBLGNT Romans 10:21+20 10:21', 127428, 66, 22084, 66);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1121, 112, 1, 'Isaiah', null, 'LXX Isaiah 29:10+22 29:10-60', 'Romans', 'SBLGNT Romans 11:8+31 11:8-46', 55055, 42, 22734, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (112, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (112, 1, 'quotation', 'literal, in-quotation, grammatical-change, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1121, 'Romans', 'SBLGNT Romans 11:8 11:8-91', 22703, 22716);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1121, 112, 1, 'Isaiah', 'LXX Isaiah 29:10+22 29:10-84', 'Romans', 'SBLGNT Romans 11:8+31 11:8-58', 55055, 18, 22734, 16); -- πνευματι κατανυξεως -> πνευμα κατανυξεως
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1121, 112, 1, 'Isaiah', 'LXX Isaiah 29:10+55 29:10-60', 'Romans', 'SBLGNT Romans 11:8+47 11:8-49', 55088, 9, 22750, 9); -- οφθαλμους
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1131, 113, 1, 'Isaiah', null, 'LXX Isaiah 59:20+13 59:20-29', 'Romans', 'SBLGNT Romans 11:26+46 11:26-26', 119274, 13, 24255, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1131, 113, 1, 'Isaiah', null, 'LXX Isaiah 59:20+29 59:21-161', 'Romans', 'SBLGNT Romans 11:26+59 11:27-28', 119290, 54, 24268, 54, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1131, 113, 1, 'Isaiah', null, 'LXX Isaiah 59:20+3 59:21-161', 'Romans', 'SBLGNT Romans 11:26+40 11:27-28', 119264, 80, 24249, 73, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (113, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (113, 1, 'quotation', 'literal, subset, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1131, 'Romans', 'SBLGNT Romans 11:26+26 11:26-45', 24235, 24248);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1131, 113, 1, 'Isaiah', 'LXX Isaiah 59:20+3 59:21-161', 'Romans', 'SBLGNT Romans 11:26+40 11:27-28', 119264, 80, 24249, 73);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1131, 114, 1, 'Isaiah', null, 'LXX Isaiah 27:9+59 27:9-147', 'Romans', 'SBLGNT Romans 11:27+28 11:27-16', 50477, 12, 24322, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1131, 114, 1, 'Isaiah', null, 'LXX Isaiah 27:9+59 27:9-132', 'Romans', 'SBLGNT Romans 11:27+28 11:27', 50477, 27, 24322, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (114, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written (in Romans 11:26)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (114, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1131, 114, 1, 'Isaiah', 'LXX Isaiah 27:9+59 27:9-131', 'Romans', 'SBLGNT Romans 11:27+28 11:27', 50477, 28, 24322, 28);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1151, 115, 1, 'Isaiah', null, 'LXX Isaiah 45:23+119 45:23-5', 'Romans', 'SBLGNT Romans 14:11+49 14:11-19', 93657, 12, 28554, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1151, 115, 1, 'Isaiah', null, 'LXX Isaiah 45:23+84 45:23-29', 'Romans', 'SBLGNT Romans 14:11+28 14:11-29', 93622, 23, 28533, 23, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1151, 115, 1, 'Isaiah', null, 'LXX Isaiah 45:23+84 45:23', 'Romans', 'SBLGNT Romans 14:11+28 14:11', 93622, 52, 28533, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (115, 1, null, 'γεγραπται γαρ');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (115, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1151, 'Romans', 'SBLGNT Romans 14:11 14:11-68', 28505, 28516);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1151, 115, 1, 'Isaiah', 'LXX Isaiah 45:23+84 45:23', 'Romans', 'SBLGNT Romans 14:11+28 14:11', 93622, 52, 28533, 52);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1161, 116, 1, 'Isaiah', null, 'LXX Isaiah 11:10+23 11:10-27', 'Romans', 'SBLGNT Romans 15:12+24 15:12', 24107, 59, 30349, 59, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1161, 116, 1, 'Isaiah', null, 'LXX Isaiah 11:10+3 11:10-27', 'Romans', 'SBLGNT Romans 15:12+19 15:12', 24087, 79, 30344, 64, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (116, 1, 'Ησαιας', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (116, 1, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1161, 'Romans', 'SBLGNT Romans 15:12 15:12-64', 30325, 30343);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1161, 116, 1, 'Isaiah', 'LXX Isaiah 11:10+3 11:10-101', 'Romans', 'SBLGNT Romans 15:12+19 15:12-59', 24087, 5, 30344, 5);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1161, 116, 1, 'Isaiah', 'LXX Isaiah 11:10+23 11:10-27', 'Romans', 'SBLGNT Romans 15:12+24 15:12', 24107, 59, 30349, 59);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1171, 117, 1, 'Isaiah', null, 'LXX Isaiah 52:15+66 52:15', 'Romans', 'SBLGNT Romans 15:21+17 15:21', 107343, 58, 31217, 58, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1171, 117, 1, 'Isaiah', null, 'LXX Isaiah 52:15+67 52:15', 'Romans', 'SBLGNT Romans 15:21+18 15:21', 107344, 57, 31218, 57, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (117, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (117, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1171, 'Romans', 'SBLGNT Romans 15:21 15:21-57', 31200, 31217);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1171, 117, 1, 'Isaiah', 'LXX Isaiah 52:15+67 52:15', 'Romans', 'SBLGNT Romans 15:21+18 15:21', 107344, 57, 31218, 57);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1181, 118, 1, 'Isaiah', null, 'LXX Isaiah 7:14+85 7:14', 'Matthew', 'SBLGNT Matthew 1:23+52 1:23-34', 14284, 21, 1974, 21, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1181, 118, 1, 'Isaiah', null, 'LXX Isaiah 7:14+35 7:14-24', 'Matthew', 'SBLGNT Matthew 1:23 1:23-60', 14234, 47, 1922, 47, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1181, 118, 1, 'Isaiah', null, 'LXX Isaiah 7:14+35 7:14', 'Matthew', 'SBLGNT Matthew 1:23 1:23-34', 14234, 71, 1922, 73, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (118, 1, 'δια του προφητου', 'το ρηθεν υπο κυριου ... λεγοντος'); -- δια του προφητου = through the prophet, το ρηθεν υπο κυριου ... λεγοντος = having been spoken by the Lord ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (118, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1181, 'Matthew', 'SBLGNT Matthew 1:22 1:22', 1856, 1921);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1181, 118, 1, 'Isaiah', 'LXX Isaiah 7:14+35 7:14', 'Matthew', 'SBLGNT Matthew 1:23 1:23-34', 14234, 71, 1922, 73);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1191, 119, 1, 'Isaiah', null, 'Aleppo Isaiah 11:1+16 11:1-10', 'Matthew', 'SBLGNT Matthew 2:23+76 2:23-14', null, 3, 4488, 5, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (119, 1, 'δια του προφητων', 'το ρηθεν ... οτι'); -- δια του προφητων = through the prophets, το ρηθεν ... οτι = that having been spoken ... that
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (119, 1, 'quotation', 'puzzle', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1191, 'Matthew', 'SBLGNT Matthew 2:23+41 2:23-19', 4453, 4487);
-- insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
--  (1191, 119, 1, 'Isaiah', 'Aleppo Isaiah 11:1+16 11:1-10', 'Matthew', 'SBLGNT Matthew 2:23+76 2:23-14', null, 3, 4488, 5);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1201, 120, 1, 'Isaiah', null, 'LXX Isaiah 28:11+12 28:11', 'I_Corinthians', 'SBLGNT I_Corinthians 14:21+40 14:21-38', 52171, 46, 25551, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (120, 1, 'εν τω νομω', 'γεγραπται οτι'); -- εν τω νομω  = in the law, γεγραπται οτι = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (120, 1, 'quotation', 'far-fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1201, 'I_Corinthians', 'SBLGNT I_Corinthians 14:21 14:21-88', 25511, 25530);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1201, 120, 1, 'Isaiah', 'LXX Isaiah 28:11+12 28:11-39', 'I_Corinthians', 'SBLGNT I_Corinthians 14:21+40 14:21-60', 52171, 7, 25551, 8); -- χειλεων -> χειλεσιν
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1201, 120, 1, 'Isaiah', 'LXX Isaiah 28:11+22 28:11-23', 'I_Corinthians', 'SBLGNT I_Corinthians 14:21+22 14:21-73', 52181, 13, 25533, 13) ; -- γλωσσης ετερας -> ετερογλωσσοις
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1201, 120, 1, 'Isaiah', 'LXX Isaiah 28:11+38 28:11', 'I_Corinthians', 'SBLGNT I_Corinthians 14:21+54 14:21-38', 52197, 20, 25565, 16); -- λαλησουσιν τω λαω τουτω -> λαλησω τω λαω τουτω
-- TODO: The end of Isaiah 28:12 is a bit similar to the end of I_Corinthians 14:22, consider adding it as another clasp.
-- TODO: Consider this as a quotation in case. No word seems to indicate that this indeed a quotation:
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 121, 1, 'Isaiah', null, 'LXX Isaiah 22:13+107 22:13', 'I_Corinthians', 'SBLGNT I_Corinthians 15:32+67 15:32', 41992, 37, 29181, 37, 'getrefs');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (121, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (121, 1, 'strong allusion', 'literal', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1221, 122, 1, 'Isaiah', null, 'LXX Isaiah 9:2+71 9:2-6', 'II_Corinthians', 'SBLGNT II_Corinthians 4:6+23 4:6-80', 17973, 9, 5634, 9, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1221, 122, 1, 'Isaiah', null, 'LXX Isaiah 9:2+71 9:2-6', 'II_Corinthians', 'SBLGNT II_Corinthians 4:6+23 4:6-80', 17973, 9, 5634, 9, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (122, 1, 'θεος', 'ειπων'); -- ειπων = having said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (122, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1221, 'II_Corinthians', 'SBLGNT II_Corinthians 4:6 4:6-98', 5611, 5624);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1221, 122, 1, 'Isaiah', 'LXX Isaiah 9:2+71 9:2-6', 'II_Corinthians', 'SBLGNT II_Corinthians 4:6+23 4:6-80', 17973, 9, 5634, 9); -- φως λαμψει
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1221, 122, 1, 'Isaiah', 'LXX Isaiah 9:2+17 9:2-61', 'II_Corinthians', 'SBLGNT II_Corinthians 4:6+14 4:6-89', 17919, 8, 5625, 9); -- εν σκοτει -> Εκ σκοτους
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1222, 122, 2, 'Isaiah', null, 'LXX Isaiah 9:1+80 9:1-88', 'Matthew', 'SBLGNT Matthew 4:15+13 4:15-32', 17792, 22, 7230, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1222, 122, 2, 'Isaiah', null, 'LXX Isaiah 9:1+141 9:1-17', 'Matthew', 'SBLGNT Matthew 4:15+35 4:15', 17853, 32, 7252, 32, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1222, 122, 2, 'Isaiah', null, 'LXX Isaiah 9:2+12 9:2-63', 'Matthew', 'SBLGNT Matthew 4:16+10 4:16-69', 17914, 11, 7294, 11, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1222, 122, 2, 'Isaiah', null, 'LXX Isaiah 9:2+50 9:2-12', 'Matthew', 'SBLGNT Matthew 4:16+51 4:16-15', 17952, 24, 7335, 24, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1222, 122, 2, 'Isaiah', null, 'LXX Isaiah 9:1+71 9:2-12', 'Matthew', 'SBLGNT Matthew 4:15+2 4:16-15', 17783, 193, 7219, 140, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (122, 2, 'Ησαΐου του προφητου', 'λεγοντος'); -- λεγοντος = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (122, 2, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1222, 'Matthew', 'SBLGNT Matthew 4:14 4:14', 7172, 7216);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1222, 122, 2, 'Isaiah', 'LXX Isaiah 9:1+71 9:1-88', 'Matthew', 'SBLGNT Matthew 4:15 4:15-32', 17783, 31, 7217, 35); -- ζαβουλων η γη νεφθαλιμ οδον θαλασσης -> Γη Ζαβουλων και γη Νεφθαλιμ, οδον θαλασσης
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1222, 122, 2, 'Isaiah', 'LXX Isaiah 9:1+141 9:1-17', 'Matthew', 'SBLGNT Matthew 4:15+35 4:15', 17853, 32, 7252, 32); -- περαν του ιορδανου γαλιλαια των εθνων
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1222, 122, 2, 'Isaiah', 'LXX Isaiah 9:2 9:2-12', 'Matthew', 'SBLGNT Matthew 4:16 4:16-15', 17902, 74, 7284, 75);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1231, 123, 1, 'Isaiah', null, 'LXX Isaiah 49:8+16 49:8-77', 'II_Corinthians', 'SBLGNT II_Corinthians 6:2+8 6:2-45', 99749, 50, 8510, 50, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1231, 123, 1, 'Isaiah', null, 'LXX Isaiah 49:8+16 49:8-77', 'II_Corinthians', 'SBLGNT II_Corinthians 6:2+8 6:2-45', 99749, 50, 8510, 50, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (123, 1, 'θεου', 'λεγει γαρ'); -- λεγει γαρ = He says for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (123, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1231, 'II_Corinthians', 'SBLGNT II_Corinthians 6:1+29 6:2-95', 8465, 8509);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1231, 123, 1, 'Isaiah', 'LXX Isaiah 49:8+16 49:8-77', 'II_Corinthians', 'SBLGNT II_Corinthians 6:2+8 6:2-45', 99749, 50, 8510, 50);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1241, 124, 1, 'Isaiah', null, 'LXX Isaiah 40:3+27 40:3-35', 'John', 'SBLGNT John 1:23+31 1:23-25', 78225, 16, 1469, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1241, 124, 1, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-57', 'John', 'SBLGNT John 1:23+6 1:23-45', 78198, 21, 1444, 21, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1241, 124, 1, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-35', 'John', 'SBLGNT John 1:23+6 1:23-25', 78198, 43, 1444, 41, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (124, 1, 'Ησαΐας ο προφητης', 'καθως ειπεν'); -- Ησαΐας ο προφητης = Isaiah the prophet, καθως ειπεν = as said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (124, 1, 'quotation', 'literal, fuzzy, change', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1241, 'John', 'SBLGNT John 1:23+47 1:23', 1485, 1509);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1241, 124, 1, 'Isaiah', 'LXX Isaiah 40:3 40:3-35', 'John', 'SBLGNT John 1:23+6 1:23-25', 78198, 43, 1444, 41);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1242, 124, 2, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-11', 'Luke', 'SBLGNT Luke 3:4+40 3:4-5', 78198, 67, 10561, 67, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1242, 124, 2, 'Isaiah', null, 'LXX Isaiah 40:4 40:4-42', 'Luke', 'SBLGNT Luke 3:5 3:5-44', 78276, 63, 10633, 63, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1242, 124, 2, 'Isaiah', null, 'LXX Isaiah 40:5+23 40:5-17', 'Luke', 'SBLGNT Luke 3:6 3:6', 78404, 34, 10740, 34, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1242, 124, 2, 'Isaiah', null, 'LXX Isaiah 40:4+68 40:4-16', 'Luke', 'SBLGNT Luke 3:5+63 3:5-23', 78344, 21, 10696, 21, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1242, 124, 2, 'Isaiah', null, 'LXX Isaiah 40:3 40:5-17', 'Luke', 'SBLGNT Luke 3:4+40 3:6', 78198, 240, 10561, 213, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (124, 2, 'εν βιβλω λογων Ησαΐου του προφητου', 'ως γεγραπται'); -- εν βιβλω λογων Ησαΐου του προφητου = in the book of the words of Isaiah the prophet, ως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (124, 2, 'quotation', 'literal, exact, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1242, 'Luke', 'SBLGNT Luke 3:4 3:4-72', 10521, 10560);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1242, 124, 2, 'Isaiah', 'LXX Isaiah 40:3 40:3-8', 'Luke', 'SBLGNT Luke 3:4+40 3:4', 78198, 70, 10561, 72);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1242, 124, 2, 'Isaiah', 'LXX Isaiah 40:4 40:4-42', 'Luke', 'SBLGNT Luke 3:5 3:5-44', 78276, 63, 10633, 63);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1242, 124, 2, 'Isaiah', 'LXX Isaiah 40:4+68 40:4-16', 'Luke', 'SBLGNT Luke 3:5+63 3:5-23', 78344, 21, 10696, 21);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1242, 124, 2, 'Isaiah', 'LXX Isaiah 40:5+23 40:5-17', 'Luke', 'SBLGNT Luke 3:6 3:6', 78404, 34, 10740, 34);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1243, 124, 3, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-11', 'Mark', 'SBLGNT Mark 1:3 1:3-5', 78198, 67, 136, 67, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1243, 124, 3, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-11', 'Mark', 'SBLGNT Mark 1:3 1:3-5', 78198, 67, 136, 67, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (124, 3, 'εν τω Ησαΐα τω προφητη', 'Καθως γεγραπται'); -- εν τω Ησαΐα τω προφητη = in Isaiah the prophet, Καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (124, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1243, 'Mark', 'SBLGNT Mark 1:2 1:2-64', 40, 71);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1243, 124, 3, 'Isaiah', 'LXX Isaiah 40:3 40:3-8', 'Mark', 'SBLGNT Mark 1:3 1:3', 78198, 70, 136, 72);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1244, 124, 4, 'Isaiah', null, 'LXX Isaiah 40:2+145 40:3-11', 'Matthew', 'SBLGNT Matthew 3:3+47 3:3-5', 78197, 68, 4680, 68, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1244, 124, 4, 'Isaiah', null, 'LXX Isaiah 40:3 40:3-11', 'Matthew', 'SBLGNT Matthew 3:3+48 3:3-5', 78198, 67, 4681, 67, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (124, 4, 'δια Ησαΐου του προφητου', 'ρηθεις ... λεγοντος'); -- ρηθεις ... λεγοντος = having been spoken of ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (124, 4, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1244, 'Matthew', 'SBLGNT Matthew 3:3 3:3-72', 4633, 4680);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1244, 124, 4, 'Isaiah', 'LXX Isaiah 40:3 40:3-8', 'Matthew', 'SBLGNT Matthew 3:3+48 3:3', 78198, 70, 4681, 72);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1251, 125, 1, 'Isaiah', null, 'LXX Isaiah 52:11+72 52:11-23', 'II_Corinthians', 'SBLGNT II_Corinthians 6:17+26 6:17-50', 106991, 10, 9683, 10, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1251, 125, 1, 'Isaiah', null, 'LXX Isaiah 52:11+52 52:11-35', 'II_Corinthians', 'SBLGNT II_Corinthians 6:17+3 6:17-65', 106971, 18, 9660, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1251, 125, 1, 'Isaiah', null, 'LXX Isaiah 52:11+31 52:11-53', 'II_Corinthians', 'SBLGNT II_Corinthians 6:17+47 6:17-18', 106950, 21, 9704, 21, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1251, 125, 1, 'Isaiah', null, 'LXX Isaiah 52:11+31 52:11-23', 'II_Corinthians', 'SBLGNT II_Corinthians 6:17+3 6:17-18', 106950, 51, 9660, 65, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (125, 1, 'κυριος', 'διο ... λεγει'); -- διο ... λεγει = therefore ... says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (125, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1251, 'II_Corinthians', 'SBLGNT II_Corinthians 6:17 6:17-83', 9657, 9659);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1251, 'II_Corinthians', 'SBLGNT II_Corinthians 6:17+36 6:17-39', 9693, 9703);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1251, 125, 1, 'Isaiah', 'LXX Isaiah 52:11+52 52:11-23', 'II_Corinthians', 'SBLGNT II_Corinthians 6:17+3 6:17-50', 106971, 30, 9660, 33);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1251, 125, 1, 'Isaiah', 'LXX Isaiah 52:11+31 52:11-53', 'II_Corinthians', 'SBLGNT II_Corinthians 6:17+47 6:17-18', 106950, 21, 9704, 21);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1261, 126, 1, 'Isaiah', null, 'LXX Isaiah 54:1 54:1-14', 'Galatians', 'SBLGNT Galatians 4:27+12 4:27', 108811, 102, 7727, 102, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1261, 126, 1, 'Isaiah', null, 'LXX Isaiah 54:1 54:1-14', 'Galatians', 'SBLGNT Galatians 4:27+12 4:27', 108811, 102, 7727, 102, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (126, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (126, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1261, 'Galatians', 'SBLGNT Galatians 4:27 4:27-102', 7715, 7726);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1261, 126, 1, 'Isaiah', 'LXX Isaiah 54:1 54:1-14', 'Galatians', 'SBLGNT Galatians 4:27+12 4:27', 108811, 102, 7727, 102);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1271, 127, 1, 'Isaiah', null, 'LXX Isaiah 57:19+29 57:19-31', 'Ephesians', 'SBLGNT Ephesians 2:17+51 2:18-65', 115041, 10, 3440, 10, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1271, 127, 1, 'Isaiah', null, 'LXX Isaiah 57:19+9 57:19-50', 'Ephesians', 'SBLGNT Ephesians 2:17+44 2:17-5', 115021, 11, 3433, 11, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1271, 127, 1, 'Isaiah', null, 'LXX Isaiah 57:19 57:19-32', 'Ephesians', 'SBLGNT Ephesians 2:17+20 2:17', 115012, 38, 3409, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (127, 1, null, 'ευηγγελισατο'); -- ευηγγελισατο = He proclaimed the gospel
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (127, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1271, 'Ephesians', 'SBLGNT Ephesians 2:17+8 2:17-40', 3397, 3408);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1271, 127, 1, 'Isaiah', 'LXX Isaiah 57:19 57:19-32', 'Ephesians', 'SBLGNT Ephesians 2:17+20 2:17', 115012, 38, 3409, 40);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1281, 128, 1, 'Isaiah', null, 'LXX Isaiah 8:18 8:18-78', 'Hebrews', 'SBLGNT Hebrews 2:13+39 2:13', 17131, 33, 2440, 33, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1281, 128, 1, 'Isaiah', null, 'LXX Isaiah 8:17+67 8:18-78', 'Hebrews', 'SBLGNT Hebrews 2:13+11 2:13', 17111, 53, 2412, 61, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (128, 1, null, 'και παλιν ... και παλιν'); -- και παλιν = and again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (128, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1281, 'Hebrews', 'SBLGNT Hebrews 2:13 2:13-64', 2401, 2408);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1281, 'Hebrews', 'SBLGNT Hebrews 2:13+31 2:13-33', 2432, 2439);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1281, 128, 1, 'Isaiah', 'LXX Isaiah 8:17+67 8:17', 'Hebrews', 'SBLGNT Hebrews 2:13+11 2:13-41', 17111, 20, 2412, 20);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1281, 128, 1, 'Isaiah', 'LXX Isaiah 8:18 8:18-78', 'Hebrews', 'SBLGNT Hebrews 2:13+39 2:13', 17131, 33, 2440, 33);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1291, 129, 1, 'Isaiah', null, 'LXX Isaiah 26:20+66 26:20-23', 'Hebrews', 'SBLGNT Hebrews 10:37+6 10:37-27', 49503, 14, 18052, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1291, 129, 1, 'Isaiah', null, 'LXX Isaiah 26:20+66 26:20-23', 'Hebrews', 'SBLGNT Hebrews 10:37+6 10:37-27', 49503, 14, 18052, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (129, 1, null, 'ετι γαρ'); -- ετι γαρ = yet for (see also Hebrews 10:36)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (129, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1291, 'Hebrews', 'SBLGNT Hebrews 10:37 10:37-41', 18046, 18051);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1291, 129, 1, 'Isaiah', 'LXX Isaiah 26:20+66 26:20-23', 'Hebrews', 'SBLGNT Hebrews 10:37+6 10:37-27', 49503, 14, 18052, 14);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1301, 130, 1, 'Isaiah', null, 'LXX Isaiah 40:6+40 40:6-20', 'I_Peter', 'SBLGNT I_Peter 1:24+15 1:24-50', 78495, 18, 2065, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1301, 130, 1, 'Isaiah', null, 'LXX Isaiah 40:6+65 40:8-27', 'I_Peter', 'SBLGNT I_Peter 1:24+37 1:25-61', 78520, 54, 2087, 54, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1301, 130, 1, 'Isaiah', null, 'LXX Isaiah 40:6+32 40:8', 'I_Peter', 'SBLGNT I_Peter 1:24+5 1:25-39', 78487, 114, 2055, 108, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (130, 1, null, 'διοτι'); -- διοτι = because (see also the end: "τουτο δε εστιν το ρημα το ευαγγελισθεν εις υμας" in I_Peter 1:25)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (130, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1301, 'I_Peter', 'SBLGNT I_Peter 1:24 1:24-78', 2050, 2054);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1301, 130, 1, 'Isaiah', 'LXX Isaiah 40:6+32 40:8', 'I_Peter', 'SBLGNT I_Peter 1:24+5 1:25-39', 78487, 114, 2055, 108);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1311, 131, 1, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7', 'Mark', 'SBLGNT Mark 11:17+42 11:17-36', 112775, 48, 36991, 48, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1311, 131, 1, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7', 'Mark', 'SBLGNT Mark 11:17+42 11:17-36', 112775, 48, 36991, 48, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (131, 1, null, 'Ου γεγραπται οτι'); -- Ου γεγραπται οτι = not has it been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (131, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1311, 'Mark', 'SBLGNT Mark 11:17+27 11:17-85', 36976, 36989);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1311, 131, 1, 'Isaiah', 'LXX Isaiah 56:7+139 56:7', 'Mark', 'SBLGNT Mark 11:17+41 11:17-36', 112771, 52, 36990, 49);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1312, 131, 2, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7-16', 'Matthew', 'SBLGNT Matthew 21:13+24 21:13-33', 112775, 32, 59893, 32, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1312, 131, 2, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7-16', 'Matthew', 'SBLGNT Matthew 21:13+24 21:13-33', 112775, 32, 59893, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (131, 2, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (131, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1312, 'Matthew', 'SBLGNT Matthew 21:13+14 21:13-66', 59883, 59891);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1312, 131, 2, 'Isaiah', 'LXX Isaiah 56:7+139 56:7-16', 'Matthew', 'SBLGNT Matthew 21:13+23 21:13-33', 112771, 36, 59892, 33);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1313, 131, 3, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7-26', 'Luke', 'SBLGNT Luke 19:46+29 19:46-35', 112775, 22, 75718, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1313, 131, 3, 'Isaiah', null, 'LXX Isaiah 56:7+143 56:7-26', 'Luke', 'SBLGNT Luke 19:46+29 19:46-35', 112775, 22, 75718, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (131, 3, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (131, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1313, 'Luke', 'SBLGNT Luke 19:46+11 19:46-66', 75700, 75708);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1313, 131, 3, 'Isaiah', 'LXX Isaiah 56:7+139 56:7-26', 'Luke', 'SBLGNT Luke 19:46+28 19:46-35', 112771, 26, 75717, 23);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1313, 131, 3, 'Isaiah', 'LXX Isaiah 56:7+89 56:7-99', 'Luke', 'SBLGNT Luke 19:46+20 19:46-63', 112721, 3, 75709, 3); -- kai
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1313, 131, 3, 'Isaiah', 'LXX Isaiah 56:7+105 56:7-79', 'Luke', 'SBLGNT Luke 19:46+23 19:46-58', 112737, 7, 75712, 5); -- esontai -> estai
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1321, 132, 1, 'Isaiah', null, 'LXX Isaiah 53:9+78 53:9', 'I_Peter', 'SBLGNT I_Peter 2:22+7 2:22', 108358, 45, 4031, 45, 'getrefs');
-- TODO: The non-literal quotation is longer: I_Peter 2:22-25 cites and summarizes Isaiah 53:5-9. Extend...
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1321, 132, 1, 'Isaiah', null, 'LXX Isaiah 53:9+78 53:9', 'I_Peter', 'SBLGNT I_Peter 2:22+7 2:22', 108358, 45, 4031, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (132, 1, null, 'υπολιμπανων υπογραμμον ινα επακολουθησητε'); -- υπολιμπανων υπογραμμον ινα επακολουθησητε = leaving an example that you should follow after
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (132, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1321, 'I_Peter', 'SBLGNT I_Peter 2:21+50 2:21', 3970, 4023);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1321, 132, 1, 'Isaiah', 'LXX Isaiah 53:9+71 53:9', 'I_Peter', 'SBLGNT I_Peter 2:22 2:22', 108351, 52, 4024, 52);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 133, 1, 'Isaiah', null, 'LXX Isaiah 66:24+68 66:24-58', 'Mark', 'SBLGNT Mark 9:48+5 9:48-20', 133191, 19, 31055, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 133, 1, 'Isaiah', null, 'LXX Isaiah 66:24+68 66:24-28', 'Mark', 'SBLGNT Mark 9:48+5 9:48', 133191, 49, 31055, 39, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (133, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (133, 1, 'strong allusion', 'literal, fuzzy', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1341, 134, 1, 'Isaiah', null, 'LXX Isaiah 53:4', 'Matthew', 'Matthew 8:17', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1341, 134, 1, 'Isaiah', null, 'LXX Isaiah 53:4+1 53:4-92', 'Matthew', 'SBLGNT Matthew 8:17+47 8:17-39', 107716, 8, 19103, 8, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1341, 134, 1, 'Isaiah', null, 'LXX Isaiah 53:4 53:4-81', 'Matthew', 'SBLGNT Matthew 8:17+46 8:17-27', 107715, 20, 19102, 21, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (134, 1, 'Ησαΐου του προφητου', 'λεγοντος'); -- ρηθεν ... λεγοντος = having spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (134, 1, 'quotation', 'fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1341, 'Matthew', 'SBLGNT Matthew 8:17 8:17-48', 19056, 19101);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1341, 134, 1, 'Isaiah', 'LXX Isaiah 53:4 53:4-81', 'Matthew', 'SBLGNT Matthew 8:17+46 8:17-27', 107715, 20, 19102, 21); -- ουτος τας αμαρτιας ημων -> Αυτος τας ασθενειας ημων
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1351, 135, 1, 'Isaiah', null, 'LXX Isaiah 42:1+77 42:1-23', 'Matthew', 'SBLGNT Matthew 12:18+59 12:18-28', 83409, 19, 31171, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1351, 135, 1, 'Isaiah', null, 'LXX Isaiah 42:1+95 42:1-7', 'Matthew', 'SBLGNT Matthew 12:18+80 12:18-9', 83427, 17, 31192, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1351, 135, 1, 'Isaiah', null, 'LXX Isaiah 42:2+19 42:2-20', 'Matthew', 'SBLGNT Matthew 12:19+19 12:19-33', 83470, 12, 31237, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1351, 135, 1, 'Isaiah', null, 'LXX Isaiah 42:2+46 42:3-78', 'Matthew', 'SBLGNT Matthew 12:19+59 12:20-77', 83497, 12, 31277, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1351, 135, 1, 'Isaiah', null, 'LXX Isaiah 42:3+27 42:3-48', 'Matthew', 'SBLGNT Matthew 12:20+29 12:20-45', 83529, 10, 31311, 10, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1351, 135, 1, 'Isaiah', null, 'LXX Isaiah 42:3+43 42:3-28', 'Matthew', 'SBLGNT Matthew 12:20+42 12:20-28', 83545, 14, 31324, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1351, 135, 1, 'Isaiah', null, 'LXX Isaiah 42:4+53 42:4', 'Matthew', 'SBLGNT Matthew 12:21+2 12:21', 83640, 28, 31368, 28, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1351, 135, 1, 'Isaiah', null, 'LXX Isaiah 42:4+53 42:4', 'Matthew', 'SBLGNT Matthew 12:21+2 12:21', 83640, 28, 31368, 28, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1351, 135, 1, 'Isaiah', null, 'LXX Isaiah 42:1+5 42:4', 'Matthew', 'SBLGNT Matthew 12:18+4 12:21', 83337, 331, 31116, 280, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (135, 1, 'Ησαΐου του προφητου', 'ρηθεν ... λεγοντος'); -- το ρηθεν ... λεγοντος = having been spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (135, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1351, 'Matthew', 'SBLGNT Matthew 12:17 12:17', 31067, 31111);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1351, 135, 1, 'Isaiah', 'LXX Isaiah 42:1+5 42:1-106', 'Matthew', 'SBLGNT Matthew 12:18+4 12:18-94', 83337, 8, 31116, 8); -- ο παις μου
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1351, 135, 1, 'Isaiah', 'LXX Isaiah 42:1+64 42:1-7', 'Matthew', 'SBLGNT Matthew 12:18+47 12:18-9', 83396, 48, 31159, 50); -- η ψυχη μου εδωκα το πνευμα μου επ αυτον κρισιν τοις εθνεσιν -> η ψυχη μου θησω το πνευμα μου επ αυτον, και κρισιν τοις εθνεσιν
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1351, 135, 1, 'Isaiah', 'LXX Isaiah 42:2+22 42:2-13', 'Matthew', 'SBLGNT Matthew 12:19+22 12:19-31', 83473, 16, 31240, 11); -- ουδε ακουσθησεται -> ουδε ακουσει
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1351, 135, 1, 'Isaiah', 'LXX Isaiah 42:2+42 42:3-78', 'Matthew', 'SBLGNT Matthew 12:19+54 12:20-77', 83493, 16, 31272, 17); -- φωνη αυτου καλαμον -> φωνην αυτου καλαμον
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1351, 135, 1, 'Isaiah', 'LXX Isaiah 42:3+29 42:3-28', 'Matthew', 'SBLGNT Matthew 12:20+31 12:20-28', 83531, 28, 31313, 25); -- και λινον καπνιζομενον ου σβεσει -> και λινον τυφομενον ου σβεσει
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1351, 135, 1, 'Isaiah', 'LXX Isaiah 42:4+42 42:4', 'Matthew', 'SBLGNT Matthew 12:20+78 12:21', 83629, 39, 31360, 36); -- κρισιν και επι τω ονοματι αυτου εθνη ελπιουσιν -> κρισιν και τω ονοματι αυτου εθνη ελπιουσιν
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1361, 136, 1, 'Isaiah', null, 'LXX Isaiah 6:10+96 6:10-66', 'John', 'SBLGNT John 12:40+59 12:40-44', 12595, 22, 44341, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1361, 136, 1, 'Isaiah', null, 'LXX Isaiah 6:10+164 6:10', 'John', 'SBLGNT John 12:40+105 12:40', 12663, 20, 44387, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1361, 136, 1, 'Isaiah', null, 'LXX Isaiah 6:10+63 6:10', 'John', 'SBLGNT John 12:40+10 12:40', 12562, 121, 44292, 115, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (136, 1, 'Ησαΐας', 'ειπεν'); -- ειπεν = said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (136, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1361, 'John', 'SBLGNT John 12:39 12:39', 44235, 44281);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1361, 136, 1, 'Isaiah', 'LXX Isaiah 6:10+63 6:10-103', 'John', 'SBLGNT John 12:40+10 12:40-97', 12562, 18, 44292, 18); -- τους οφθαλμους αυτων -> αυτων τους οφθαλμους
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1361, 136, 1, 'Isaiah', 'LXX Isaiah 6:10+96 6:10-66', 'John', 'SBLGNT John 12:40+59 12:40-44', 12595, 22, 44341, 22); -- ιδωσιν τοις οφθαλμοις και
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1361, 136, 1, 'Isaiah', 'LXX Isaiah 6:10+138 6:10-38', 'John', 'SBLGNT John 12:40+89 12:40-28', 12637, 8, 44371, 8); -- τη καρδια
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1361, 136, 1, 'Isaiah', 'LXX Isaiah 6:10+153 6:10', 'John', 'SBLGNT John 12:40+97 12:40', 12652, 31, 44379, 28); -- και επιστρεψωσιν και ιασομαι αυτους -> και στραφωσιν, και ιασομαι αυτους
-- An alternative way, by adding "kardia" as an extra clasp:
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos, alternative) values
 (91361, 'John', 'SBLGNT John 12:39 12:39', 44235, 44281, 1);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (91361, 136, 1, 'Isaiah', 'LXX Isaiah 6:10+63 6:10-103', 'John', 'SBLGNT John 12:40+10 12:40-97', 12562, 18, 44292, 18); -- τους οφθαλμους αυτων -> αυτων τους οφθαλμους
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (91361, 136, 1, 'Isaiah', 'LXX Isaiah 6:10+96 6:10-66', 'John', 'SBLGNT John 12:40+59 12:40-44', 12595, 22, 44341, 22); -- ιδωσιν τοις οφθαλμοις και
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (91361, 136, 1, 'Isaiah', 'LXX Isaiah 6:10+138 6:10-38', 'John', 'SBLGNT John 12:40+89 12:40-28', 12637, 8, 44371, 8); -- τη καρδια
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (91361, 136, 1, 'Isaiah', 'LXX Isaiah 6:10+153 6:10', 'John', 'SBLGNT John 12:40+97 12:40', 12652, 31, 44379, 28); -- και επιστρεψωσιν και ιασομαι αυτους -> και στραφωσιν, και ιασομαι αυτους
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (91361, 136, 1, 'Isaiah', 'LXX Isaiah 6:10+12 6:10-166', 'John', 'SBLGNT John 12:40+47 12:40-72', 12511, 6, 44329, 6); -- kardia
-- End of alternation.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1362, 136, 2, 'Isaiah', null, 'LXX Isaiah 6:9+35 6:10-142', 'Acts', 'SBLGNT Acts 28:26+39 28:27-137', 12443, 98, 95175, 98, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1362, 136, 2, 'Isaiah', null, 'LXX Isaiah 6:10+46 6:10', 'Acts', 'SBLGNT Acts 28:27+41 28:27', 12545, 138, 95272, 138, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1362, 136, 2, 'Isaiah', null, 'LXX Isaiah 6:9+8 6:10', 'Acts', 'SBLGNT Acts 28:26+5 28:27', 12416, 267, 95141, 269, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (136, 2, 'Ησαΐου του προφητου', 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (136, 2, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1362, 'Acts', 'SBLGNT Acts 28:25+63 28:26-90', 95069, 95140);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1362, 136, 2, 'Isaiah', 'LXX Isaiah 6:9+8 6:10', 'Acts', 'SBLGNT Acts 28:26+5 28:27', 12416, 267, 95141, 269);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1363, 136, 3, 'Isaiah', null, 'LXX Isaiah 6:9+35 6:10-142', 'Matthew', 'SBLGNT Matthew 13:14+45 13:15-137', 12443, 98, 35214, 98, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1363, 136, 3, 'Isaiah', null, 'LXX Isaiah 6:10+46 6:10', 'Matthew', 'SBLGNT Matthew 13:15+41 13:15', 12545, 138, 35311, 138, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1363, 136, 3, 'Isaiah', null, 'LXX Isaiah 6:9+35 6:10', 'Matthew', 'SBLGNT Matthew 13:14+45 13:15', 12443, 240, 35214, 235, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (136, 3, 'η προφητεια Ησαΐου', 'η λεγουσα'); -- η λεγουσα = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (136, 3, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1363, 'Matthew', 'SBLGNT Matthew 13:14 13:14-56', 35169, 35213);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1363, 136, 3, 'Isaiah', 'LXX Isaiah 6:9+35 6:10', 'Matthew', 'SBLGNT Matthew 13:14+45 13:15', 12443, 240, 35214, 235);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1364, 136, 4, 'Isaiah', null, 'LXX Isaiah 6:9+63 6:9-16', 'Mark', 'SBLGNT Mark 4:12+3 4:12-79', 12471, 12, 9850, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1364, 136, 4, 'Isaiah', null, 'LXX Isaiah 6:9+39 6:10', 'Mark', 'SBLGNT Mark 4:12+3 4:12', 12447, 236, 9850, 91, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (136, 4, null, 'ινα'); -- ινα = so that
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (136, 4, 'quotation', 'far-fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1364, 'Mark', 'SBLGNT Mark 4:12 4:12-91', 9847, 9849);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1364, 136, 4, 'Isaiah', 'LXX Isaiah 6:9+63 6:9', 'Mark', 'SBLGNT Mark 4:12+3 4:12-64', 12471, 28, 9850, 27); -- βλεποντες βλεψετε και ου μη ιδητε -> βλεποντες βλεπωσι και μη ιδωσιν
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1364, 136, 4, 'Isaiah', 'LXX Isaiah 6:10+126 6:10-46', 'Mark', 'SBLGNT Mark 4:12+42 4:12-42', 12625, 12, 9889, 10); -- ακουσωσιν και -> ακουωσι και
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1364, 136, 4, 'Isaiah', 'LXX Isaiah 6:10+146 6:10-31', 'Mark', 'SBLGNT Mark 4:12+54 4:12-32', 12645, 7, 9901, 8); -- ακουσωσιν και τη καρδια συνωσιν -> ακουωσι και μη συνιωσιν
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1364, 136, 4, 'Isaiah', 'LXX Isaiah 6:10+90 6:10-88', 'Mark', 'SBLGNT Mark 4:12+62 4:12-26', 12589, 6, 9909, 6); -- μηποτε
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1364, 136, 4, 'Isaiah', 'LXX Isaiah 6:10+156 6:10-13', 'Mark', 'SBLGNT Mark 4:12+68 4:12-11', 12655, 15, 9915, 15); -- επιστρεψωσιν και
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1365, 136, 5, 'Isaiah', null, 'LXX Isaiah 6:9+39 6:9-12', 'Luke', 'SBLGNT Luke 8:10+82 8:10', 12447, 40, 30550, 41, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (136, 5, null, 'ινα'); -- ινα = so that
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (136, 5, 'quotation', 'far-fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1365, 'Luke', 'SBLGNT Luke 8:10+79 8:10-41', 30547, 30549);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1365, 136, 5, 'Isaiah', 'LXX Isaiah 6:9+39 6:9-12', 'Luke', 'SBLGNT Luke 8:10+82 8:10', 12447, 40, 30550, 41);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1371, 137, 1, 'Isaiah', null, 'LXX Isaiah 29:13+24 29:13-104', 'Matthew', 'SBLGNT Matthew 15:8 15:8-37', 55467, 22, 42765, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1371, 137, 1, 'Isaiah', null, 'LXX Isaiah 29:13+60 29:13-31', 'Matthew', 'SBLGNT Matthew 15:8+28 15:9-28', 55503, 59, 42793, 59, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1371, 137, 1, 'Isaiah', null, 'LXX Isaiah 29:13+118 29:13-11', 'Matthew', 'SBLGNT Matthew 15:9+38 15:10-51', 55561, 21, 42862, 21, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1371, 137, 1, 'Isaiah', null, 'LXX Isaiah 29:13+139 29:13', 'Matthew', 'SBLGNT Matthew 15:9+28 15:9-17', 55582, 11, 42852, 11, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1371, 137, 1, 'Isaiah', null, 'LXX Isaiah 29:13+24 29:13', 'Matthew', 'SBLGNT Matthew 15:8 15:9', 55467, 126, 42765, 115, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (137, 1, 'Ησαΐας', 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (137, 1, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1371, 'Matthew', 'SBLGNT Matthew 15:7 15:7', 42720, 42764);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1371, 137, 1, 'Isaiah', 'LXX Isaiah 29:13+24 29:13', 'Matthew', 'SBLGNT Matthew 15:8 15:9', 55467, 126, 42765, 115);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1372, 137, 2, 'Isaiah', null, 'LXX Isaiah 29:13+32 29:13-104', 'Mark', 'SBLGNT Mark 7:6+79 7:6-37', 55475, 14, 21325, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1372, 137, 2, 'Isaiah', null, 'LXX Isaiah 29:13+60 29:13-31', 'Mark', 'SBLGNT Mark 7:6+99 7:7-28', 55503, 59, 21345, 59, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1372, 137, 2, 'Isaiah', null, 'LXX Isaiah 29:13+118 29:13-14', 'Mark', 'SBLGNT Mark 7:7+38 7:7', 55561, 18, 21414, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1372, 137, 2, 'Isaiah', null, 'LXX Isaiah 29:13+139 29:13', 'Mark', 'SBLGNT Mark 7:7+28 7:7-17', 55582, 11, 21404, 11, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1372, 137, 2, 'Isaiah', null, 'LXX Isaiah 29:13+24 29:13', 'Mark', 'SBLGNT Mark 7:6+71 7:7', 55467, 126, 21317, 115, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (137, 2, 'Ησαΐας', 'γεγραπται οτι'); -- γεγραπται οτι = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (137, 2, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1372, 'Mark', 'SBLGNT Mark 7:6 7:6-59', 21246, 21316);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1372, 137, 2, 'Isaiah', 'LXX Isaiah 29:13+24 29:13', 'Mark', 'SBLGNT Mark 7:6+71 7:7', 55467, 126, 21317, 115);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1381, 138, 1, 'Isaiah', null, 'LXX Isaiah 62:11+44 62:11-65', 'Matthew', 'SBLGNT Matthew 21:4+52 21:5-71', 124178, 24, 59120, 24, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1381, 138, 1, 'Isaiah', null, 'LXX Isaiah 62:11+45 62:11-65', 'Matthew', 'SBLGNT Matthew 21:5 21:5-71', 124179, 23, 59121, 23, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (138, 1, 'του προφητου', 'ρηθεν ... λεγοντος'); -- having been spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (138, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1381, 'Matthew', 'SBLGNT Matthew 21:4 21:4', 59068, 59120);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1381, 138, 1, 'Isaiah', 'LXX Isaiah 62:11+45 62:11-65', 'Matthew', 'SBLGNT Matthew 21:5 21:5-71', 124179, 23, 59121, 23);
-- TODO: Complete this entry (if possible)
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1391, 139, 1, 'Isaiah', null, 'LXX Isaiah 53:12+98 53:12-61', 'Mark', 'ABPGRK Mark 15:28+32 15:28', 108735, 15, null, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (139, 1, 'γραφή', 'λέγουσα'); -- γραφή = Scripture, λέγουσα = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (139, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1392, 139, 2, 'Isaiah', null, 'LXX Isaiah 53:12+105 53:12-58', 'Luke', 'SBLGNT Luke 22:37+66 22:37-22', 108742, 11, 85151, 11, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1392, 139, 2, 'Isaiah', null, 'LXX Isaiah 53:12+98 53:12-61', 'Luke', 'SBLGNT Luke 22:37+60 22:37-25', 108735, 15, 85145, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (139, 2, null, 'το γεγραμμενον'); -- το γεγραμμενον = which has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (139, 2, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1392, 'Luke', 'SBLGNT Luke 22:37 22:37-48', 85085, 85135);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1392, 139, 2, 'Isaiah', 'LXX Isaiah 53:12+89 53:12-82', 'Luke', 'SBLGNT Luke 22:37+53 22:37-43', 108726, 3, 85138, 3); -- και
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1392, 139, 2, 'Isaiah', 'LXX Isaiah 53:12+98 53:12-61', 'Luke', 'SBLGNT Luke 22:37+60 22:37-25', 108735, 15, 85145, 14); -- ανομοις ελογισθη -> ανομων ελογισθη
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 140, 1, 'Isaiah', null, 'LXX Isaiah 61:1 61:1-78', 'Luke', 'SBLGNT Luke 4:18 4:18-74', 121799, 68, 14360, 68, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 140, 1, 'Isaiah', null, 'LXX Isaiah 61:1+103 61:1', 'Luke', 'SBLGNT Luke 4:18+68 4:18-31', 121902, 43, 14428, 43, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 140, 1, 'Isaiah', null, 'LXX Isaiah 61:2+5 61:2-49', 'Luke', 'SBLGNT Luke 4:19+5 4:20-89', 121950, 25, 14507, 25, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1401, 140, 1, 'Isaiah', null, 'LXX Isaiah 61:1 61:2-52', 'Luke', 'SBLGNT Luke 4:18 4:19', 121799, 173, 14360, 169, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (140, 1, 'του προφητου Ησαΐου', 'ην γεγραμμενον'); -- ην γεγραμμενον = it was written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (140, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1401, 'Luke', 'SBLGNT Luke 4:17 4:17', 14273, 14359);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1401, 140, 1, 'Isaiah', 'LXX Isaiah 61:1 61:1-78', 'Luke', 'SBLGNT Luke 4:18 4:18-74', 121799, 68, 14360, 68);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1401, 140, 1, 'Isaiah', 'LXX Isaiah 61:1+103 61:1', 'Luke', 'SBLGNT Luke 4:18+68 4:18-31', 121902, 43, 14428, 43);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1401, 140, 1, 'Isaiah', 'LXX Isaiah 61:2+7 61:2-52', 'Luke', 'SBLGNT Luke 4:19+7 4:19', 121952, 20, 14509, 20);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1411, 141, 1, 'Isaiah', null, 'LXX Isaiah 54:13+21 54:13-32', 'John', 'SBLGNT John 6:45+47 6:45-51', 110015, 7, 20387, 7, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1411, 141, 1, 'Isaiah', null, 'LXX Isaiah 54:13 54:13-26', 'John', 'SBLGNT John 6:45+31 6:45-46', 109994, 34, 20371, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (141, 1, 'εν τοις προφηταις', 'εστιν γεγραμμενον'); -- εστιν γεγραμμενον = it is written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (141, 1, 'quotation', 'far-fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1411, 'John', 'SBLGNT John 6:45 6:45-74', 20340, 20370);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1411, 141, 1, 'Isaiah', 'LXX Isaiah 54:13 54:13-57', 'John', 'SBLGNT John 6:45+31 6:45-71', 109994, 3, 20371, 3); -- και
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1411, 141, 1, 'Isaiah', 'LXX Isaiah 54:13+3 54:13-51', 'John', 'SBLGNT John 6:45+41 6:45-58', 109997, 6, 20381, 6); -- παντας -> παντες
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1411, 141, 1, 'Isaiah', 'LXX Isaiah 54:13+21 54:13-26', 'John', 'SBLGNT John 6:45+47 6:45-46', 110015, 13, 20387, 12); -- διδακτους θεου -> διδακτοι θεου
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1421, 142, 1, 'Isaiah', null, 'LXX Isaiah 66:1+16 66:1-28', 'Acts', 'SBLGNT Acts 7:49 7:49-37', 130334, 67, 22671, 67, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1421, 142, 1, 'Isaiah', null, 'LXX Isaiah 66:1+88 66:1', 'Acts', 'SBLGNT Acts 7:49+81 7:49', 130406, 23, 22752, 23, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1421, 142, 1, 'Isaiah', null, 'LXX Isaiah 66:1+5 66:2-105', 'Acts', 'SBLGNT Acts 7:49 7:50', 130323, 132, 22671, 134, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (142, 1, 'ο προφητης', 'καθως ... λεγει'); -- καθως ... λεγει = as ... says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (142, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1421, 'Acts', 'SBLGNT Acts 7:48+37 7:48', 22652, 22670);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1421, 142, 1, 'Isaiah', 'LXX Isaiah 66:1+5 66:2-105', 'Acts', 'SBLGNT Acts 7:49 7:50', 130323, 132, 22671, 134);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1431, 143, 1, 'Isaiah', null, 'LXX Isaiah 53:7+40 53:7-43', 'Acts', 'SBLGNT Acts 8:32+38 8:32-43', 108067, 48, 26456, 48, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1431, 143, 1, 'Isaiah', null, 'LXX Isaiah 53:7+89 53:8-34', 'Acts', 'SBLGNT Acts 8:32+87 8:34-95', 108116, 130, 26505, 130, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1431, 143, 1, 'Isaiah', null, 'LXX Isaiah 53:7+40 53:8-37', 'Acts', 'SBLGNT Acts 8:32+38 8:33', 108067, 176, 26456, 176, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (143, 1, 'Ησαΐαν τον προφητην ... περιοχη της γραφης', 'ανεγινωσκεν'); -- περιοχη της γραφης = the passage of the Scripture, = he was reading
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (143, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1431, 'Acts', 'SBLGNT Acts 8:32 8:32-91', 26418, 26455);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1431, 'Acts', 'SBLGNT Acts 8:28+47 8:28', 26146, 26173);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1431, 'Acts', 'SBLGNT Acts 8:30+33 8:30-35', 26264, 26294);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1431, 143, 1, 'Isaiah', 'LXX Isaiah 53:7+40 53:8-37', 'Acts', 'SBLGNT Acts 8:32+38 8:33', 108067, 176, 26456, 176);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1441, 144, 1, 'Isaiah', null, 'LXX Isaiah 55:3+124 55:3', 'Acts', 'SBLGNT Acts 13:34+86 13:34', 110809, 19, 43974, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1441, 144, 1, 'Isaiah', null, 'LXX Isaiah 55:3+106 55:3', 'Acts', 'SBLGNT Acts 13:34+83 13:34', 110791, 37, 43971, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (144, 1, null, 'ειρηκεν οτι'); -- ειρηκεν οτι = He spoke
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (144, 1, 'quotation', 'literal, fuzzy, change', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1441, 'Acts', 'SBLGNT Acts 13:34 13:34-26', 43888, 43966);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1441, 144, 1, 'Isaiah', 'LXX Isaiah 55:3+106 55:3-33', 'Acts', 'SBLGNT Acts 13:34+83 13:34-18', 110791, 4, 43971, 4);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1441, 144, 1, 'Isaiah', 'LXX Isaiah 55:3+125 55:3', 'Acts', 'SBLGNT Acts 13:34+87 13:34', 110810, 18, 43975, 18);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1451, 145, 1, 'Isaiah', null, 'LXX Isaiah 49:6+104 49:6-62', 'Acts', 'SBLGNT Acts 13:47+29 13:47-45', 99422, 12, 45085, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1451, 145, 1, 'Isaiah', null, 'LXX Isaiah 49:6+130 49:6', 'Acts', 'SBLGNT Acts 13:47+38 13:47', 99448, 48, 45094, 48, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1451, 145, 1, 'Isaiah', null, 'LXX Isaiah 49:6+104 49:6', 'Acts', 'SBLGNT Acts 13:47+29 13:47', 99422, 74, 45085, 57, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (145, 1, 'ο κυριος', 'ουτως γαρ εντεταλται ημιν'); -- ουτως γαρ εντεταλται ημιν = thus for has commanded us
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (145, 1, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1451, 'Acts', 'SBLGNT Acts 13:47 13:47-57', 45056, 45084);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1451, 145, 1, 'Isaiah', 'LXX Isaiah 49:6+104 49:6-62', 'Acts', 'SBLGNT Acts 13:47+29 13:47-45', 99422, 12, 45085, 12); -- Τεθεικα σε εις
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1451, 145, 1, 'Isaiah', 'LXX Isaiah 49:6+130 49:6', 'Acts', 'SBLGNT Acts 13:47+38 13:47', 99448, 48, 45094, 48); -- εις φως εθνων του ειναι σε εις σωτηριαν εως εσχατου της γης, the leading "εις" overlaps the end of the first clasp
-- This is covered with 1401 (so no mentioned in the clasps, therefore obsolete):
-- insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
--  (1461, 146, 1, 'Isaiah', null, 'LXX Isaiah 58:6+108 58:6-29', 'Luke', 'SBLGNT Luke 4:18+111 4:18', 116010, 30, 14471, 31, 'manual');
-- insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
--  (1461, 146, 1, 'Isaiah', null, 'LXX Isaiah 58:6+117 58:6-28', 'Luke', 'SBLGNT Luke 4:18+121 4:19-26', 116019, 22, 14481, 22, 'getrefs');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (146, 1, 'του προφητου Ησαΐου', 'ην γεγραμμενον'); -- ην γεγραμμενον = it was written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (146, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1401, 146, 1, 'Isaiah', 'LXX Isaiah 58:6+108 58:6-29', 'Luke', 'SBLGNT Luke 4:18+111 4:18', 116010, 30, 14471, 31); -- αποστελλε τεθραυσμενους εν αφεσει -> αποστειλαι τεθραυσμενους εν αφεσει
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1471, 147, 1, 'Isaiah', null, 'LXX Isaiah 55:10+102 55:10', 'II_Corinthians', 'SBLGNT II_Corinthians 9:10+19 9:10-71', 111473, 28, 14439, 28, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1471, 147, 1, 'Isaiah', null, 'LXX Isaiah 55:10+96 55:10', 'II_Corinthians', 'SBLGNT II_Corinthians 9:10+13 9:10-71', 111467, 34, 14433, 34, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (147, 1, null, 'ο δε επιχορηγων'); -- ο δε επιχορηγων = the [One] now supplying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (147, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1471, 'II_Corinthians', 'SBLGNT II_Corinthians 9:10 9:10-105', 14420, 14432);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1471, 147, 1, 'Isaiah', 'LXX Isaiah 55:10+96 55:10', 'II_Corinthians', 'SBLGNT II_Corinthians 9:10+13 9:10-71', 111467, 34, 14433, 34);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1481, 148, 1, 'Isaiah', null, 'LXX Isaiah 2:2+2 2:2-106', 'Acts', 'SBLGNT Acts 2:17+2 2:17-168', 3073, 27, 3971, 27, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1481, 148, 1, 'Isaiah', null, 'LXX Isaiah 2:2+3 2:2-106', 'Acts', 'SBLGNT Acts 2:17+3 2:17-168', 3074, 26, 3972, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (148, 1, 'προφητου Ιωηλ', 'ειρημενον'); -- προφητου Ιωηλ = prophet Joel, ειρημενον = having been spoken
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (148, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (14012, 148, 1, 'Isaiah', 'LXX Isaiah 2:2+3 2:2-106', 'Acts', 'SBLGNT Acts 2:17+3 2:17-168', 3074, 26, 3972, 26);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1421, 149, 1, 'Isaiah', null, 'LXX Isaiah 41:20+58 41:20-28', 'Acts', 'SBLGNT Acts 7:50+10 7:50', 82448, 20, 22785, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1421, 149, 1, 'Isaiah', null, 'LXX Isaiah 41:20+50 41:20-28', 'Acts', 'SBLGNT Acts 7:50+5 7:50', 82440, 28, 22780, 25, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (149, 1, 'ο προφητης', 'καθως ... λεγει'); -- καθως ... λεγει = as ... says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (149, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1421, 149, 1, 'Isaiah', 'LXX Isaiah 41:20+50 41:20-28', 'Acts', 'SBLGNT Acts 7:50+5 7:50', 82440, 28, 22780, 25);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2011, 201, 1, 'Jeremiah', null, 'LXX Jeremiah 31:15+50 31:15-64', 'Matthew', 'SBLGNT Matthew 2:18+25 2:18-66', 80265, 9, 3951, 9, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2011, 201, 1, 'Jeremiah', null, 'LXX Jeremiah 31:15+14 31:15-90', 'Matthew', 'SBLGNT Matthew 2:17+47 2:18-83', 80229, 19, 3924, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2011, 201, 1, 'Jeremiah', null, 'LXX Jeremiah 31:15+16 31:15', 'Matthew', 'SBLGNT Matthew 2:18', 80231, 107, 3926, 100, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (201, 1, 'δια Ιερεμιου του προφητου', 'το ρηθεν ... λεγοντος'); -- δια Ιερεμιου του προφητου = by Jeremiah the prophet, το ρηθεν ... λεγοντος = having been spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (201, 1, 'quotation', 'far-fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (2011, 'Matthew', 'SBLGNT Matthew 2:17 2:17',  3877, 3925);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (2011, 201, 1, 'Jeremiah', 'LXX Jeremiah 31:15+16 31:15-46', 'Matthew', 'SBLGNT Matthew 2:18 2:18-47', 80231, 61, 3926, 53);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (2011, 201, 1, 'Jeremiah', 'LXX Jeremiah 31:15+77 31:15-37', 'Matthew', 'SBLGNT Matthew 2:18+68 2:18-23', 80292, 9, 3994, 9); -- ουκ ηθελεν
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (2011, 201, 1, 'Jeremiah', 'LXX Jeremiah 31:15+112 31:15', 'Matthew', 'SBLGNT Matthew 2:18+89 2:18', 80327, 11, 4015, 11); -- οτι ουκ εισιν
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2021, 202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:31+63 31:32-152', 'Hebrews', 'SBLGNT Hebrews 8:8+96 8:9-149', 81873, 38, 11910, 38, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2021, 202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:32+27 31:32-27', 'Hebrews', 'SBLGNT Hebrews 8:9+26 8:9-25', 81919, 117, 11955, 117, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2021, 202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:32+146 31:32-11', 'Hebrews', 'SBLGNT Hebrews 8:9+143 8:9-11', 82038, 14, 12072, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2021, 202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:32+165 31:33-125', 'Hebrews', 'SBLGNT Hebrews 8:9+162 8:10-124', 82057, 65, 12091, 65, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2021, 202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:33+64 31:33-108', 'Hebrews', 'SBLGNT Hebrews 8:10+64 8:10-107', 82127, 12, 12161, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2021, 202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:33+80 31:33-58', 'Hebrews', 'SBLGNT Hebrews 8:10+76 8:10-61', 82143, 46, 12173, 46, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2021, 202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:33+126 31:34-86', 'Hebrews', 'SBLGNT Hebrews 8:10+125 8:11-15', 82189, 170, 12222, 170, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2021, 202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:34+120 31:35-134', 'Hebrews', 'SBLGNT Hebrews 8:11+112 8:13-76', 82367, 79, 12392, 79, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (2021, 202, 1, 'Jeremiah', null, 'LXX Jeremiah 31:31 31:34', 'Hebrews', 'SBLGNT Hebrews 8:8+24 8:12', 81810, 635, 11838, 632, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (202, 1, null, 'λεγει'); -- λεγει = He says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (202, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (2021, 'Hebrews', 'SBLGNT Hebrews 8:8 8:8-91', 11814, 11837);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (2021, 202, 1, 'Jeremiah', 'LXX Jeremiah 31:31 31:34', 'Hebrews', 'SBLGNT Hebrews 8:8+24 8:12', 81810, 635, 11838, 632);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1313, 203, 1, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Luke', 'SBLGNT Luke 19:46+72 19:46', 19391, 14, 75761, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1313, 203, 1, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Luke', 'SBLGNT Luke 19:46+72 19:46', 19391, 14, 75761, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (203, 1, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (203, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1313, 203, 1, 'Jeremiah', 'LXX Jeremiah 7:11+2 7:11-80', 'Luke', 'SBLGNT Luke 19:46+72 19:46', 19391, 14, 75761, 14);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1311, 203, 2, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Mark', 'SBLGNT Mark 11:17+112 11:17', 19391, 14, 37061, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1311, 203, 2, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Mark', 'SBLGNT Mark 11:17+112 11:17', 19391, 14, 37061, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (203, 2, null, 'Ου γεγραπται οτι'); -- Ου γεγραπται οτι = not has it been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (203, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1311, 203, 2, 'Jeremiah', 'LXX Jeremiah 7:11+2 7:11-80', 'Mark', 'SBLGNT Mark 11:17+112 11:17', 19391, 14, 37061, 14);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1312, 203, 3, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Matthew', 'SBLGNT Matthew 21:13+75 21:13', 19391, 14, 59944, 14, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1312, 203, 3, 'Jeremiah', null, 'LXX Jeremiah 7:11+2 7:11-80', 'Matthew', 'SBLGNT Matthew 21:13+75 21:13', 19391, 14, 59944, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (203, 3, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (203, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1312, 203, 3, 'Jeremiah', 'LXX Jeremiah 7:11+2 7:11-80', 'Matthew', 'SBLGNT Matthew 21:13+75 21:13', 19391, 14, 59944, 14);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3011, 301, 1, 'Ezekiel', null, 'LXX Ezekiel 37:27+47 37:27-14', 'II_Corinthians', 'SBLGNT II_Corinthians 6:16+125 6:16-14', 104701, 12, 9631, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3011, 301, 1, 'Ezekiel', null, 'LXX Ezekiel 37:27+32 37:27', 'II_Corinthians', 'SBLGNT II_Corinthians 6:16+111 6:16', 104686, 41, 9617, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (301, 1, 'θεος', 'καθως ειπεν'); -- καθως ειπεν = as has said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (301, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (3011, 'II_Corinthians', 'SBLGNT II_Corinthians 6:16 6:16-71', 9506, 9585);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (3011, 301, 1, 'Ezekiel', 'LXX Ezekiel 37:27+32 37:27', 'II_Corinthians', 'SBLGNT II_Corinthians 6:16+111 6:16', 104686, 41, 9617, 40);
-- TODO: Consider adding Ezekiel 20:34 or 22:20 as a second part of a combined quotation in II_Corinthians 6:17

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10011, 1001, 1, 'Habakkuk', null, 'LXX Habakkuk 2:4+39 2:4-10', 'Romans', 'SBLGNT Romans 1:17+68 1:17-7', 2127, 19, 1330, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10011, 1001, 1, 'Habakkuk', null, 'LXX Habakkuk 2:4+39 2:4', 'Romans','SBLGNT Romans 1:17+68 1:17', 2127, 29, 1330, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1001, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1001, 1, 'quotation', 'literal, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (10011, 'Romans', 'SBLGNT Romans 1:17 1:17-26', 1262, 1329);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (10011, 1001, 1, 'Habakkuk', 'LXX Habakkuk 2:4+39 2:4', 'Romans','SBLGNT Romans 1:17+68 1:17', 2127, 29, 1330, 26);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10012, 1001, 2, 'Habakkuk', null, 'LXX Habakkuk 2:4+42 2:4-10', 'Galatians', 'SBLGNT Galatians 3:11+45 3:11-7', 2130, 16, 4515, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10012, 1001, 2, 'Habakkuk', null, 'LXX Habakkuk 2:4+39 2:4', 'Galatians', 'SBLGNT Galatians 3:11+44 3:11', 2127, 29, 4514, 24, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1001, 2, null, 'οτι'); -- οτι = because
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1001, 2, 'quotation', 'literal, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (10012, 'Galatians', 'SBLGNT Galatians 3:11 3:11-24', 4470, 4513);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (10012, 1001, 2, 'Habakkuk', 'LXX Habakkuk 2:4+39 2:4', 'Galatians', 'SBLGNT Galatians 3:11+44 3:11', 2127, 29, 4514, 24);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1291, 1001, 3, 'Habakkuk', null, 'LXX Habakkuk 2:3+84 2:3-9', 'Hebrews', 'SBLGNT Hebrews 10:37+21 10:37-8', 2061, 18, 18067, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1291, 1001, 3, 'Habakkuk', null, 'LXX Habakkuk 2:4 2:4-29', 'Hebrews', 'SBLGNT Hebrews 10:38+32 10:38', 2088, 39, 18125, 39, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1291, 1001, 3, 'Habakkuk', null, 'LXX Habakkuk 2:4+49 2:4-10', 'Hebrews', 'SBLGNT Hebrews 10:38+13 10:38-49', 2137, 9, 18106, 9, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1291, 1001, 3, 'Habakkuk', null, 'LXX Habakkuk 2:3+84 2:4', 'Hebrews', 'SBLGNT Hebrews 10:37+21 10:38', 2061, 95, 18067, 97, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1001, 3, null, 'κομισησθε την επαγγελιαν / ετι γαρ'); -- κομισησθε την επαγγελιαν / ετι γαρ = you may receive the promise / yet for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1001, 3, 'quotation', 'fuzzy, subset', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1291, 1001, 3, 'Habakkuk', 'LXX Habakkuk 2:3+84 2:4', 'Hebrews', 'SBLGNT Hebrews 10:37+21 10:38', 2061, 95, 18067, 97);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10021, 1002, 1, 'Habakkuk', null, 'LXX Habakkuk 1:5 1:5-113', 'Acts', 'SBLGNT Acts 13:41 13:41-99', 343, 22, 44377, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10021, 1002, 1, 'Habakkuk', null, 'LXX Habakkuk 1:5+32 1:5-91', 'Acts', 'SBLGNT Acts 13:41+19 13:41-90', 375, 12, 44396, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10021, 1002, 1, 'Habakkuk', null, 'LXX Habakkuk 1:5+52 1:5-70', 'Acts', 'SBLGNT Acts 13:41+31 13:41-77', 395, 13, 44408, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10021, 1002, 1, 'Habakkuk', null, 'LXX Habakkuk 1:5+67 1:5-59', 'Acts', 'SBLGNT Acts 13:41+44 13:41-68', 410, 9, 44421, 9, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10021, 1002, 1, 'Habakkuk', null, 'LXX Habakkuk 1:5+78 1:5-47', 'Acts', 'SBLGNT Acts 13:41+52 13:41-59', 421, 10, 44429, 10, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10021, 1002, 1, 'Habakkuk', null, 'LXX Habakkuk 1:5+103 1:5', 'Acts', 'SBLGNT Acts 13:41+85 13:41-4', 446, 32, 44462, 32, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (10021, 1002, 1, 'Habakkuk', null, 'LXX Habakkuk 1:5', 'Acts', 'SBLGNT Acts 13:41 13:41-4', 343, 135, 44377, 117, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1002, 1, 'εν τοις προφηταις', 'ειρημενον'); -- ειρημενον εν τοις προφηταις = having been said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1002, 1, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (10021, 'Acts', 'SBLGNT Acts 13:40 13:40', 44333, 44376);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (10021, 1002, 1, 'Habakkuk', 'LXX Habakkuk 1:5', 'Acts', 'SBLGNT Acts 13:41 13:41-4', 343, 135, 44377, 117);
-- The clasp has difference 0.179, however, by adding the last four letters from Acts, 0.171 could be reached.
-- Also, the clasp could be split into two shorter ones, because the word 'και επιβλεψατε' could be omitted.

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11011, 1101, 1, 'Malachi', null, 'LXX Malachi 1:3 1:3-68', 'Romans', 'SBLGNT Romans 9:13+29 9:13', 174, 16, 19062, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (11011, 1101, 1, 'Malachi', null, 'LXX Malachi 1:2+87 1:3-68', 'Romans', 'SBLGNT Romans 9:13+14 9:13', 159, 31, 19047, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1101, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1101, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (11011, 'Romans', 'SBLGNT Romans 9:13 9:13-31', 19033, 19046);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (11011, 1101, 1, 'Malachi', 'LXX Malachi 1:2+87 1:3-68', 'Romans', 'SBLGNT Romans 9:13+14 9:13', 159, 31, 19047, 31);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (12011, 1201, 1, 'Haggai', null, 'LXX Haggai 2:6+31 2:6-44', 'Hebrews', 'SBLGNT Hebrews 12:26+46 12:26-30', 2323, 15, 24105, 15, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (12011, 1201, 1, 'Haggai', null, 'LXX Haggai 2:6+31 2:6-25', 'Hebrews', 'SBLGNT Hebrews 12:26+46 12:26', 2323, 34, 24105, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1201, 1, null, 'επηγγελται λεγων'); -- επηγγελται λεγων = He has promised saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1201, 1, 'quotation', 'literal, fuzzy, subset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (12011, 'Hebrews', 'SBLGNT Hebrews 12:26 12:26-45',  24059, 24104);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (12011, 1201, 1, 'Haggai', 'LXX Haggai 2:6+31 2:6-44', 'Hebrews', 'SBLGNT Hebrews 12:26+46 12:26-30', 2323, 15, 24105, 15); -- ετι απαξ εγω σεισω
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (12011, 1201, 1, 'Haggai', 'LXX Haggai 2:6+46 2:6-34', 'Hebrews', 'SBLGNT Hebrews 12:26+81 12:26', 2338, 10, 24140, 10); -- τον ουρανον
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (12011, 1201, 1, 'Haggai', 'LXX Haggai 2:6+59 2:6-25', 'Hebrews', 'SBLGNT Hebrews 12:26+68 12:26-17', 2351, 6, 24127, 6); -- την γην

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13011, 1301, 1, 'Hosea', null, 'ABPGRK Hosea 2:23+38 2:23-34', 'Romans', 'SBLGNT Romans 9:25+24 9:25-10', null, 39, 19866, 38, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1301, 1, 'Ωσηε', 'λεγει'); -- Ωσηε = Hosea, λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1301, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
-- TODO: add missing clasp
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13011, 1302, 1, 'Hosea', null, 'LXX Hosea 1:10+82 1:10', 'Romans', 'SBLGNT Romans 9:26 9:26', 1055, 73, 19914, 73, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13011, 1302, 1, 'Hosea', null, 'LXX Hosea 1:10+82 1:10', 'Romans', 'SBLGNT Romans 9:26', 1055, 73, 19914, 73, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1302, 1, 'Ωσηε', 'λεγει'); -- Ωσηε = Hosea, λεγει = says (in Romans 9:25)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1302, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (13011, 'Romans', 'SBLGNT Romans 9:25 9:25-54', 19842, 19859);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (1041, 'Romans', 'SBLGNT Romans 9:25 9:25-54', 19842, 19859); -- This also introduces Romans 9:27 (Hosea, says).
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (13011, 1302, 1, 'Hosea', 'LXX Hosea 1:10+82 1:10', 'Romans', 'SBLGNT Romans 9:26', 1055, 73, 19914, 73);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1041, 1303, 1, 'Hosea', null, 'LXX Hosea 1:10+5 1:10-110', 'Romans', 'SBLGNT Romans 9:27+31 9:27-20', 978, 40, 20018, 40, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1041, 1303, 1, 'Hosea', null, 'LXX Hosea 1:10+3 1:10-110', 'Romans', 'SBLGNT Romans 9:27+30 9:27-20', 976, 42, 20017, 41, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1303, 1, 'Ωσηε', 'λεγει'); -- Ωσηε = Hosea, λεγει = says (in Romans 9:25)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1303, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1041, 1303, 1, 'Hosea', 'LXX Hosea 1:10+3 1:10-110', 'Romans', 'SBLGNT Romans 9:27+30 9:27-20', 976, 17+25, 20017, 16+25);
-- Alternatively:
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (91041, 1303, 1, 'Hosea', 'LXX Hosea 1:10+3 1:10-110', 'Romans', 'SBLGNT Romans 9:27+30 9:27-20', 976, 17+25, 20017, 16+25);
-- End of alternation.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13041, 1304, 1, 'Hosea', null, 'LXX Hosea 11:1+38 11:1-11', 'Matthew', 'SBLGNT Matthew 2:15+77 2:15-9', 15030, 21, 3672, 18, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1304, 1, 'δια του προφητου', 'το ρηθεν υπο κυριου ... λεγοντος'); -- δια του προφητου = through the prophet, το ρηθεν υπο κυριου ... λεγοντος = having been spoken by the Lord ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1304, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (13041, 'Matthew', 'SBLGNT Matthew 2:15 2:15-27', 3595, 3671);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (13041, 1304, 1, 'Hosea', 'LXX Hosea 11:1+38 11:1-11', 'Matthew', 'SBLGNT Matthew 2:15+77 2:15-9', 15030, 21, 3672, 18);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13051, 1305, 1, 'Hosea', null, 'LXX Hosea 13:14+61 13:14-51', 'I_Corinthians', 'SBLGNT I_Corinthians 15:55+22 15:55-9', 18605, 9, 30852, 9, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13051, 1305, 1, 'Hosea', null, 'LXX Hosea 13:14+73 13:14-39', 'I_Corinthians', 'SBLGNT I_Corinthians 15:55+31 15:55', 18617, 9, 30861, 9, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13051, 1305, 1, 'Hosea', null, 'LXX Hosea 13:14+61 13:14-39', 'I_Corinthians', 'SBLGNT I_Corinthians 15:55+19 15:55', 18605, 21, 30849, 21, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1305, 1, null, 'γεγραμμενος'); -- γεγραμμενος = having been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1305, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (13051, 'I_Corinthians', 'SBLGNT I_Corinthians 15:54 15:54-24', 30703, 30805);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (13051, 1305, 1, 'Hosea', 'LXX Hosea 13:14+61 13:14-39', 'I_Corinthians', 'SBLGNT I_Corinthians 15:55+19 15:55', 18605, 21, 30849, 21);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13061, 1306, 1, 'Hosea', null, 'LXX Hosea 6:6+5 6:6-29', 'Matthew', 'SBLGNT Matthew 9:13+26 9:13-39', 8273, 20, 21658, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13061, 1306, 1, 'Hosea', null, 'LXX Hosea 6:6+5 6:6-29', 'Matthew', 'SBLGNT Matthew 9:13+26 9:13-39', 8273, 20, 21658, 20, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1306, 1, null, 'πορευθεντες δε μαθετε τι εστιν'); -- πορευθεντες δε μαθετε τι εστιν = having gone however learn what is
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1306, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (13061, 'Matthew', 'SBLGNT Matthew 9:13 9:13-59' , 21632, 21657);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (13061, 1306, 1, 'Hosea', 'LXX Hosea 6:6+5 6:6-29', 'Matthew', 'SBLGNT Matthew 9:13+26 9:13-39', 8273, 20, 21658, 20);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13062, 1306, 2, 'Hosea', null, 'LXX Hosea 6:6+5 6:6-29', 'Matthew', 'SBLGNT Matthew 12:7+20 12:7-30', 8273, 20, 30379, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (13062, 1306, 2, 'Hosea', null, 'LXX Hosea 6:6+5 6:6-29', 'Matthew', 'SBLGNT Matthew 12:7+20 12:7-30', 8273, 20, 30379, 20, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1306, 2, null, 'ει δε εγνωκειτε τι εστιν'); -- ει δε εγνωκειτε τι εστιν = if however you had known what is
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1306, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (13062, 'Matthew', 'SBLGNT Matthew 12:7 12:7-50', 30359, 30378);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (13062, 1306, 2, 'Hosea', 'LXX Hosea 6:6+5 6:6-29', 'Matthew', 'SBLGNT Matthew 12:7+20 12:7-30', 8273, 20, 30379, 20);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14011, 1401, 1, 'Joel', null, 'LXX Joel 2:32+11 2:32-103', 'Romans', 'SBLGNT Romans 10:13+6 10:13', 5577, 38, 21454, 38, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14011, 1401, 1, 'Joel', null, 'LXX Joel 2:32+8 2:32-103', 'Romans', 'SBLGNT Romans 10:13', 5574, 41, 21448, 44, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1401, 1, null, 'γαρ'); -- γαρ = for
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (14011, 'Romans', 'SBLGNT Romans 10:13+3 10:13-38', 21451, 21453); -- γαρ
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (14011, 1401, 1, 'Joel', 'LXX Joel 2:32+8 2:32-141', 'Romans', 'SBLGNT Romans 10:13 10:13-41', 5574, 3, 21448, 3);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (14011, 1401, 1, 'Joel', 'LXX Joel 2:32+11 2:32-103', 'Romans', 'SBLGNT Romans 10:13+6 10:13', 5577, 38, 21454, 38);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1401, 1, 'quotation', 'literal, exact, subset', 'Z.K.'); -- subset because of insertion of "γαρ"
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:29+52 2:29', 'Acts', 'SBLGNT Acts 2:17+38 2:17-135', 5393, 24, 4007, 24, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:28+20 2:28-70', 'Acts', 'SBLGNT Acts 2:17+39 2:17-72', 5185, 86, 4008, 86, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:28+144 2:29-73', 'Acts', 'SBLGNT Acts 2:17+120 2:17-42', 5309, 35, 4089, 35, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:28+101 2:28-49', 'Acts', 'SBLGNT Acts 2:17+152 2:17-19', 5266, 26, 4121, 26, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:28+128 2:28-29', 'Acts', 'SBLGNT Acts 2:17+181 2:18-98', 5293, 19, 4150, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:29+17 2:29-44', 'Acts', 'SBLGNT Acts 2:18+22 2:18-64', 5358, 15, 4188, 15, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:29+32 2:30-57', 'Acts', 'SBLGNT Acts 2:18+40 2:18-14', 5373, 47, 4206, 47, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:28+56 2:28-103', 'Acts', 'SBLGNT Acts 2:18+84 2:18', 5221, 17, 4250, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:30 2:30-37', 'Acts', 'SBLGNT Acts 2:19 2:19-50', 5417, 23, 4267, 23, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:30+35 2:31-38', 'Acts', 'SBLGNT Acts 2:19+48 2:20-39', 5452, 76, 4315, 76, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:31+51 2:32-139', 'Acts', 'SBLGNT Acts 2:20+52 2:21-37', 5528, 51, 4392, 51, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:32+13 2:32-103', 'Acts', 'SBLGNT Acts 2:21+14 2:21', 5579, 36, 4444, 36, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14012, 1401, 2, 'Joel', null, 'LXX Joel 2:28 2:32-103', 'Acts', 'SBLGNT Acts 2:17 2:21', 5165, 450, 3969, 511, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1401, 2, 'προφητου Ιωηλ', 'ειρημενον'); -- προφητου Ιωηλ = prophet Joel, ειρημενον = having been spoken
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1401, 2, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (14012, 'Acts', 'SBLGNT Acts 2:16+4 2:16', 3930, 3968);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (14012, 'Acts', 'SBLGNT Acts 2:17+29 2:17-158', 3998, 4007);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (14012, 1401, 2, 'Joel', 'LXX Joel 2:28 2:28-168', 'Acts', 'SBLGNT Acts 2:17 2:17-189', 5165, 8, 3969, 8); -- και εσται
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (14012, 1401, 2, 'Joel', 'LXX Joel 2:28+20 2:32-103', 'Acts', 'SBLGNT Acts 2:17+39 2:21', 5185, 430, 4008, 472); -- this can be split into some other ones, consider doing it, TODO

-- https://projekte.isbtf.de/lxx-nt/index.php, 5473
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14511, 1451, 1, 'Jonah', null, 'LXX Jonah 1:17+50 1:17', 'Matthew', 'SBLGNT Matthew 12:40+8 12:40-67', 1910, 51, 33085, 51, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (14511, 1451, 1, 'Jonah', null, 'LXX Jonah 1:17+50 1:17', 'Matthew', 'SBLGNT Matthew 12:40+8 12:40-67', 1910, 51, 33085, 51, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1451, 1, 'Ιωνα του προφητου', 'ωσπερ γαρ'); -- Ιωνα του προφητου = Jonah the prophet, ωσπερ γαρ = just as for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1451, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (14511, 'Matthew', 'SBLGNT Matthew 12:39+99 12:40-118', 33062, 33084);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (14511, 1451, 1, 'Jonah', 'LXX Jonah 1:17+50 1:17', 'Matthew', 'SBLGNT Matthew 12:40+8 12:40-67', 1910, 51, 33085, 51);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (15011, 1501, 1, 'Micah', null, 'LXX Micah 5:2 5:2-132', 'Matthew', 'SBLGNT Matthew 2:6 2:6-103', 6563, 12, 2608, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (15011, 1501, 1, 'Micah', null, 'LXX Micah 5:2+52 5:2-79', 'Matthew', 'SBLGNT Matthew 2:6+47 2:6-55', 6615, 13, 2655, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (15011, 1501, 1, 'Micah', null, 'LXX Micah 5:2 5:2-79', 'Matthew', 'SBLGNT Matthew 2:6 2:6-55', 6563, 65, 2608, 60, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1501, 1, 'δια του προφητου', 'γαρ γεγραπται'); -- γαρ γεγραπται, δια του προφητου = for has it been written, through the prophet
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1501, 1, 'quotation', 'far-fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (15011, 'Matthew', 'SBLGNT Matthew 2:5 2:5', 2544, 2607);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (15011, 1501, 1, 'Micah', 'LXX Micah 5:2 5:2-132', 'Matthew', 'SBLGNT Matthew 2:6 2:6-103', 6563, 12, 2608, 12);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (15011, 1501, 1, 'Micah', 'LXX Micah 5:2+45 5:2-65', 'Matthew', 'SBLGNT Matthew 2:6+36 2:6-41', 6608, 34, 2644, 38);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (15011, 1501, 1, 'Micah', 'LXX Micah 5:2+99 5:2-37', 'Matthew', 'SBLGNT Matthew 2:6+106 2:6', 6662, 8, 2714, 9);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16011, 1601, 1, 'Amos', null, 'LXX Amos 5:25 5:25-34', 'Acts', 'SBLGNT Acts 7:42+93 7:42-34', 9155, 33, 22107, 33, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16011, 1601, 1, 'Amos', null, 'LXX Amos 5:25+56 5:26-44', 'Acts', 'SBLGNT Acts 7:42+149 7:43-76', 9211, 58, 22163, 58, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16011, 1601, 1, 'Amos', null, 'LXX Amos 5:26+51 5:26-24', 'Acts', 'SBLGNT Acts 7:43+47 7:43-60', 9273, 16, 22221, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16011, 1601, 1, 'Amos', null, 'LXX Amos 5:26+85 5:27-45', 'Acts', 'SBLGNT Acts 7:43+85 7:43-9', 9307, 29, 22259, 29, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16011, 1601, 1, 'Amos', null, 'LXX Amos 5:25 5:27-45', 'Acts', 'SBLGNT Acts 7:42+93 7:43-9', 9155, 181, 22107, 181, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1601, 1, 'εν βιβλω των προφητων', 'καθως γεγραπται'); -- εν βιβλω των προφητων = in the book of the prophets, καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1601, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (16011, 'Acts', 'SBLGNT Acts 7:42+61 7:42-67', 22075, 22106);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (16011, 1601, 1, 'Amos', 'LXX Amos 5:25 5:27-45', 'Acts', 'SBLGNT Acts 7:42+93 7:43-9', 9155, 181, 22107, 181);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16021, 1602, 1, 'Amos', null, 'LXX Amos 9:11+110 9:11-27', 'Acts', 'SBLGNT Acts 15:16+17 15:16-77', 15526, 16, 49615, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16021, 1602, 1, 'Amos', null, 'LXX Amos 9:11+20 9:11-100', 'Acts', 'SBLGNT Acts 15:16+30 15:16-47', 15436, 33, 49628, 33, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16021, 1602, 1, 'Amos', null, 'LXX Amos 9:11+81 9:11-48', 'Acts', 'SBLGNT Acts 15:16+60 15:16-26', 15497, 24, 49658, 24, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16021, 1602, 1, 'Amos', null, 'LXX Amos 9:11+108 9:11-36', 'Acts', 'SBLGNT Acts 15:16+91 15:16-10', 15524, 9, 49689, 9, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16021, 1602, 1, 'Amos', null, 'LXX Amos 9:12+4 9:12-75', 'Acts', 'SBLGNT Acts 15:17+6 15:17-78', 15573, 34, 49714, 34, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16021, 1602, 1, 'Amos', null, 'LXX Amos 9:12+37 9:12-16', 'Acts', 'SBLGNT Acts 15:17+48 15:17-10', 15606, 60, 49756, 60, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (16021, 1602, 1, 'Amos', null, 'LXX Amos 9:11+15 9:12', 'Acts', 'SBLGNT Acts 15:16+9 15:17', 15431, 251, 49607, 219, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1602, 1, 'οι λογοι των προφητων', 'καθως γεγραπται'); -- οι λογοι των προφητων = the words of the prophets, καθως γεγραπται = as it is written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1602, 1, 'quotation', 'literal, fuzzy, change, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (16021, 'Acts', 'SBLGNT Acts 15:15 15:15', 49547, 49597);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (16021, 1602, 1, 'Amos', 'LXX Amos 9:11+15 9:11-27', 'Acts', 'SBLGNT Acts 15:16+9 15:16-16', 15431, 111, 49607, 85);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (16021, 1602, 1, 'Amos', 'LXX Amos 9:12 9:12', 'Acts', 'SBLGNT Acts 15:17 15:17', 15569, 113, 49708, 118);
-- TODO: consider adding the clasp "αιωνος" (this is, however, quite oftenly used in LXX, but not in SBLGNT)

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1381, 1701, 1, 'Zechariah', null, 'LXX Zechariah 9:9+46 9:9-62', 'Matthew', 'SBLGNT Matthew 21:5+19 21:5-49', 14394, 26, 59140, 26, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1381, 1701, 1, 'Zechariah', null, 'LXX Zechariah 9:9+92 9:9-21', 'Matthew', 'SBLGNT Matthew 21:5+45 21:5-28', 14440, 21, 59166, 21, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1381, 1701, 1, 'Zechariah', null, 'LXX Zechariah 9:9+46 9:9', 'Matthew', 'SBLGNT Matthew 21:5+19 21:5', 14394, 88, 59140, 75, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1701, 1, 'του προφητου', 'ρηθεν ... λεγοντος'); -- having been spoken ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1701, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1381, 1701, 1, 'Zechariah', 'LXX Zechariah 9:9+46 9:9-62', 'Matthew', 'SBLGNT Matthew 21:5+19 21:5-49', 14394, 26, 59140, 26);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1381, 1701, 1, 'Zechariah', 'LXX Zechariah 9:9+92 9:9', 'Matthew', 'SBLGNT Matthew 21:5+45 21:5', 14440, 42, 59166, 49);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17012, 1701, 2, 'Zechariah', null, 'LXX Zechariah 9:9+46 9:9-65', 'John', 'SBLGNT John 12:15+18 12:15-21', 14394, 23, 42240, 23, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17012, 1701, 2, 'Zechariah', null, 'LXX Zechariah 9:9+11 9:9', 'John', 'SBLGNT John 12:15+7 12:15', 14359, 123, 42229, 55, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1701, 2, null, 'καθως εστιν γεγραμμενον'); -- καθως εστιν γεγραμμενον = as it is written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1701, 2, 'quotation', 'literal, far-fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (17012, 'John', 'SBLGNT John 12:14 12:14', 42166, 42221);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (17012, 1701, 2, 'Zechariah', 'LXX Zechariah 9:9+11 9:9-112', 'John', 'SBLGNT John 12:15+7 12:15-44', 14359, 11, 42229, 11); -- θυγατερ σιων -> θυγατηρ Σιων
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (17012, 1701, 2, 'Zechariah', 'LXX Zechariah 9:9+46 9:9-65', 'John', 'SBLGNT John 12:15+18 12:15-21', 14394, 23, 42240, 23); -- ιδου ο βασιλευς σου ερχεται
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (17012, 1701, 2, 'Zechariah', 'LXX Zechariah 9:9+110 9:9-21', 'John', 'SBLGNT John 12:15+50 12:15-9', 14458, 3, 42272, 3); -- επι
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (17012, 1701, 2, 'Zechariah', 'LXX Zechariah 9:9+125 9:9-4', 'John', 'SBLGNT John 12:15+53 12:15-4', 14473, 5, 42275, 5); -- πωλον
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17021, 1702, 1, 'Zechariah', null, 'LXX Zechariah 13:7+77 13:7', 'Matthew', 'SBLGNT Matthew 26:31+81 26:31', 21571, 75, 79398, 56, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1702, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1702, 1, 'quotation', 'far-fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (17021, 'Matthew', 'SBLGNT Matthew 26:31 26:31-56', 79317, 79397);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (17021, 1702, 1, 'Zechariah', 'LXX Zechariah 13:7+77 13:7-52', 'Matthew', 'SBLGNT Matthew 26:31+81 26:31-37', 21571, 23, 79398, 19); -- παταξατε τους ποιμενας και -> Παταξω τον ποιμενα, και
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (17021, 1702, 1, 'Zechariah', 'LXX Zechariah 13:7+109 13:7-34', 'Matthew', 'SBLGNT Matthew 26:31+118 26:31-10', 21603, 9, 79435, 9); -- τα προβατα
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (17021, 1702, 1, 'Zechariah', 'LXX Zechariah 13:7+140 13:7', 'Matthew', 'SBLGNT Matthew 26:31+127 26:31', 21634, 12, 79444, 10); -- τους ποιμενας -> της ποιμνης
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17022, 1702, 2, 'Zechariah', null, 'LXX Zechariah 13:7+77 13:7-34', 'Mark', 'SBLGNT Mark 14:27+58 14:27-18', 21571, 41, 47406, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1702, 2, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1702, 2, 'quotation', 'far-fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (17022, 'Mark', 'SBLGNT Mark 14:27 14:27-46', 47348, 47405);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (17022, 1702, 2, 'Zechariah', 'LXX Zechariah 13:7+77 13:7-52', 'Mark', 'SBLGNT Mark 14:27+58 14:27-27', 21571, 23, 47406, 19); -- παταξατε τους ποιμενας και -> Παταξω τον ποιμενα, και
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (17022, 1702, 2, 'Zechariah', 'LXX Zechariah 13:7+109 13:7-34', 'Mark', 'SBLGNT Mark 14:27+77 14:27-18', 21603, 9, 47425, 9); -- τα προβατα
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17031, 1703, 1, 'Zechariah', null, 'LXX Zechariah 11:13+98 11:13-50', 'Matthew', 'SBLGNT Matthew 27:9+49 27:9-47', 18294, 30, 83819, 27, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1703, 1, 'Ιερεμιου του προφητου', 'ρηθεν ... λεγοντος'); -- ρηθεν ... λεγοντος = having been spoken ... saying (see https://www.gotquestions.org/Matthew-27-9-Jeremiah-Zechariah.html for a possible explanation why Jeremiah is mentioned and not Zechariah)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1703, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (17031, 'Matthew', 'SBLGNT Matthew 27:9 27:9-74', 83770, 83818);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (17031, 1703, 1, 'Zechariah', 'LXX Zechariah 11:13+98 11:13-50', 'Matthew', 'SBLGNT Matthew 27:9+49 27:9-47', 18294, 30, 83819, 27);
-- TODO: Finalize this entry:
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (17041, 1704, 1, 'Zechariah', null, 'Zechariah 12:10', 'John', 'John 19:37', null, null, null, null, 'traditional');

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18011, 1801, 1, 'Daniel', null, 'LXX Daniel 9:27+101 9:27-54', 'Matthew', 'SBLGNT Matthew 24:15+14 24:15-60', 36179, 20, 70680, 20, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1801, 1, 'Δανιηλ του προφητου', 'ρηθεν'); -- ρηθεν = having been spoken
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1801, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (18011, 'Matthew', 'SBLGNT Matthew 24:15+34 24:15-33', 70700, 70726);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (18011, 'Matthew', 'SBLGNT Matthew 24:15+76 24:15', 70742, 70759);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (18011, 1801, 1, 'Daniel', 'LXX Daniel 9:27+101 9:27-54', 'Matthew', 'SBLGNT Matthew 24:15+14 24:15-60', 36179, 20, 70680, 20);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18012, 1801, 2, 'Daniel', null, 'LXX Daniel 9:27+101 9:27-54', 'Mark', 'SBLGNT Mark 13:14+13 13:14-70', 36179, 20, 43429, 20, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
-- (1801, 2, 'Δανιηλ του προφητου', 'ρηθεν'); -- ρηθεν = having been spoken (these are mentioned only in ABPGRK, in LXX and 01 it is only mentioned: "ο αναγινώσκων νοείτω", the one reading let him understand)
 (1801, 2, null, 'ο αναγινώσκων νοείτω');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1801, 2, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (18012, 'Mark', 'SBLGNT Mark 13:14+50 13:14-35', 43466, 43483);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (18012, 1801, 2, 'Daniel', 'LXX Daniel 9:27+101 9:27-54', 'Mark', 'SBLGNT Mark 13:14+13 13:14-70', 36179, 20, 43429, 20);
-- TODO: Consider merging this with 18011:
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18021, 1802, 1, 'Daniel', null, 'LXX Daniel 12:1+104 12:1-112', 'Matthew', 'SBLGNT Matthew 24:21+24 24:21-35', 44472, 13, 71031, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18021, 1802, 1, 'Daniel', null, 'LXX Daniel 12:1+80 12:1-111', 'Matthew', 'SBLGNT Matthew 24:21+24 24:21-34', 44448, 38, 71031, 14, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1802, 1, 'Δανιηλ του προφητου', 'γαρ'); -- γαρ = for (Daniel is mentioned formerly in Matthew 24:15, see below, this cannot be handled with the .brst export)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1802, 1, 'quotation', 'literal, fuzzy, subset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (18021, 'Matthew', 'SBLGNT Matthew 24:21+5 24:21-60', 71012, 71018);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (18021, 'Matthew', 'SBLGNT Matthew 24:15+34 24:15-33', 70700, 70726);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (18021, 1802, 1, 'Daniel', 'LXX Daniel 12:1+80 12:1-144', 'Matthew', 'SBLGNT Matthew 24:21 24:21-67', 44448, 5, 71007, 5); -- εσται
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (18021, 1802, 1, 'Daniel', 'LXX Daniel 12:1+98 12:1-111', 'Matthew', 'SBLGNT Matthew 24:21+12 24:21-34', 44466, 20, 71019, 26); -- θλιψις οια ου γεγονεν αφ -> θλιψις μεγαλη οια ου γεγονεν απ
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (18021, 1802, 1, 'Daniel', 'LXX Daniel 12:1+118 12:1-100', 'Matthew', 'SBLGNT Matthew 24:21+61 24:21', 44486, 11, 71068, 11); -- ου γεγενηται -> ου μη γενηται
-- TODO: Consider merging this with 18021:
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18022, 1802, 2, 'Daniel', null, 'LXX Daniel 12:1+98 12:1-113', 'Mark', 'SBLGNT Mark 13:19+25 13:19-58', 44466, 18, 43757, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (18022, 1802, 2, 'Daniel', null, 'LXX Daniel 12:1+80 12:1-111', 'Mark', 'SBLGNT Mark 13:19+25 13:19-49', 44448, 38, 43757, 27, 'manual');
-- insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
--  (1802, 2, 'Δανιηλ του προφητου', 'γαρ'); -- γαρ = for (Daniel is mentioned formerly in Mark 13:14, ABPGRK)
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (1802, 2, null, 'γαρ'); -- γαρ = for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (1802, 2, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (18022, 'Mark', 'SBLGNT Mark 13:19+7 13:19-91', 43739, 43741);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (18022, 1802, 2, 'Daniel', 'LXX Daniel 12:1+80 12:1-144', 'Mark', 'SBLGNT Mark 13:19 13:19-94', 44448, 5, 43732, 7); -- εσονται -> εσονται
-- Note: The SBLGNT word εκειναι (those) appears in slightly different forms three times in Daniel 12:1 (and more than 500 times at other places in LXX).
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (18022, 1802, 2, 'Daniel', 'LXX Daniel 12:1+118 12:1-100', 'Mark', 'SBLGNT Mark 13:19+90 13:19', 44486, 11, 43822, 11); -- ου γεγενηται -> ου μη γενηται

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20011, 2001, 1, 'Genesis', null, 'LXX Genesis 15:6+16 15:6', 'Romans', 'SBLGNT Romans 4:3+32 4:3', 34472, 36, 7233, 36, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20011, 2001, 1, 'Genesis', null, 'LXX Genesis 15:6+3 15:6', 'Romans', 'SBLGNT Romans 4:3+16 4:3', 34459, 49, 7217, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 1, 'η γραφη', 'λεγει'); -- η γραφη = the Scripture, λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20011, 'Romans', 'SBLGNT Romans 4:3 4:3-52', 7201, 7216);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20011, 2001, 1, 'Genesis', 'LXX Genesis 15:6+3 15:6', 'Romans', 'SBLGNT Romans 4:3+16 4:3', 34459, 49, 7217, 52);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20012, 2001, 2, 'Genesis', null, 'LXX Genesis 15:6+18 15:6', 'Galatians', 'SBLGNT Galatians 3:6+21 3:6', 34474, 34, 4109, 34, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20012, 2001, 2, 'Genesis', null, 'LXX Genesis 15:6+3 15:6', 'Galatians', 'SBLGNT Galatians 3:6+5 3:6', 34459, 49, 4093, 50, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 2, null, 'καθως'); -- καθως = so also
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 2, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20012, 'Galatians', 'SBLGNT Galatians 3:6 3:6-50' , 4088, 4092);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20012, 2001, 2, 'Genesis', 'LXX Genesis 15:6+3 15:6', 'Galatians', 'SBLGNT Galatians 3:6+5 3:6', 34459, 49, 4093, 50);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20013, 2001, 3, 'Genesis', null, 'LXX Genesis 15:6+16 15:6', 'James', 'SBLGNT James 2:23+41 2:23-18', 34472, 36, 3924, 36, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20013, 2001, 3, 'Genesis', null, 'LXX Genesis 15:6+3 15:6', 'James', 'SBLGNT James 2:23+25 2:23-18', 34459, 49, 3908, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 3, 'η γραφη', 'λεγουσα'); -- η γραφη = the Scripture, λεγουσα = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 3, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20013, 'James', 'SBLGNT James 2:23 2:23-70', 3883, 3907);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20013, 2001, 3, 'Genesis', 'LXX Genesis 15:6+3 15:6', 'James', 'SBLGNT James 2:23+25 2:23-18', 34459, 49, 3908, 52);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20011, 2001, 4, 'Genesis', null, 'LXX Genesis 15:6+3 15:6', 'Romans', 'SBLGNT Romans 4:9+65 4:9', 34458, 49, 7654, 37, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 4, null, 'λεγομεν γαρ'); -- λεγομεν γαρ = we are saying for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 4, 'repeated quotation', 'far-fuzzy, superset', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20011, 2001, 5, 'Genesis', null, 'LXX Genesis 15:6+26 15:6', 'Romans', 'SBLGNT Romans 4:22+3 4:22', 34458, 26, 8858, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 5, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 5, 'repetition', 'literal, exact', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20011, 2001, 6, 'Genesis', null, 'LXX Genesis 15:6+26 15:6', 'Romans', 'SBLGNT Romans 4:23+26 4:23', 34482, 12, 8910, 12, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2001, 6, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2001, 6, 'repetition', 'literal, exact', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20021, 2002, 1, 'Genesis', null, 'LXX Genesis 17:5+57 17:6-65', 'Romans', 'SBLGNT Romans 4:17+14 4:17-75', 37723, 31, 8409, 31, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20021, 2002, 1, 'Genesis', null, 'LXX Genesis 17:5+57 17:5', 'Romans', 'SBLGNT Romans 4:17+14 4:17-77', 37723, 29, 8409, 29, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2002, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2002, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20021, 'Romans', 'SBLGNT Romans 4:17 4:17-106', 8395, 8408);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20021, 2002, 1, 'Genesis', 'LXX Genesis 17:5+57 17:5', 'Romans', 'SBLGNT Romans 4:17+14 4:17-77', 37723, 29, 8409, 29);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20021, 2002, 2, 'Genesis', null, 'LXX Genesis 17:5+60 17:5-9', 'Romans', 'SBLGNT Romans 4:18+47 4:18-36', 37726, 17, 8562, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20021, 2002, 2, 'Genesis', null, 'LXX Genesis 17:5+60 17:5-9', 'Romans', 'SBLGNT Romans 4:18+47 4:18-36', 37726, 17, 8562, 17, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2002, 2, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2002, 2, 'repetition', 'literal, exact', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20031, 2003, 1, 'Genesis', null, 'LXX Genesis 15:5+109 15:6-49', 'Romans', 'SBLGNT Romans 4:18+78 4:19-104', 34434, 25, 8593, 25, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20031, 2003, 1, 'Genesis', null, 'LXX Genesis 15:5+110 15:5', 'Romans', 'SBLGNT Romans 4:18+79 4:18', 34435, 21, 8594, 21, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2003, 1, null, 'κατα το ειρημενον'); -- κατα το ειρημενον = according to that having spoken
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2003, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20031, 'Romans', 'SBLGNT Romans 4:18+64 4:18-21', 8579, 8593);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20031, 2003, 1, 'Genesis', 'LXX Genesis 15:5+110 15:5', 'Romans', 'SBLGNT Romans 4:18+79 4:18', 34435, 21, 8594, 21);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20041, 2004, 1, 'Genesis', null, 'LXX Genesis 21:12+127 21:12', 'Romans', 'SBLGNT Romans 9:7+37 9:7', 50389, 26, 18646, 26, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20041, 2004, 1, 'Genesis', null, 'LXX Genesis 21:12+127 21:12', 'Romans', 'SBLGNT Romans 9:7+37 9:7', 50389, 26, 18646, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2004, 1, 'ο λογος του θεου', 'ου γαρ ... ουδ οτι ... αλλ'); -- ο λογος του θεου = the word of God, ου γαρ ... ουδ οτι ... αλλ = not for ... nor because ... rather
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2004, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20041, 'Romans', 'SBLGNT Romans 9:6 9:7-26', 18542, 18645);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20041, 2004, 1, 'Genesis', 'LXX Genesis 21:12+127 21:12', 'Romans', 'SBLGNT Romans 9:7+37 9:7', 50389, 26, 18646, 26);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20042, 2004, 2, 'Genesis', null, 'LXX Genesis 21:12+124 21:12', 'Hebrews', 'SBLGNT Hebrews 11:18+13 11:18', 50386, 29, 19955, 29, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20042, 2004, 2, 'Genesis', null, 'LXX Genesis 21:12+124 21:12', 'Hebrews', 'SBLGNT Hebrews 11:18+13 11:18', 50386, 29, 19955, 29, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2004, 2, null, 'ελαληθη'); -- ελαληθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2004, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20042, 'Hebrews', 'SBLGNT Hebrews 11:18 11:18-29', 19942, 19954);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20042, 2004, 2, 'Genesis', 'LXX Genesis 21:12+124 21:12', 'Hebrews', 'SBLGNT Hebrews 11:18+13 11:18', 50386, 29, 19955, 29);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20051, 2005, 1, 'Genesis', null, 'LXX Genesis 18:10+28 18:10-79', 'Romans', 'SBLGNT Romans 9:9+24 9:9-27', 40962, 20, 18782, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20051, 2005, 1, 'Genesis', null, 'LXX Genesis 18:14+63 18:14', 'Romans', 'SBLGNT Romans 9:9+52 9:9', 41368, 19, 18810, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20051, 2005, 1, 'Genesis', null, 'LXX Genesis 18:10+28 18:14', 'Romans', 'SBLGNT Romans 9:9+24 9:9', 40962, 425, 18782, 47, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2005, 1, null, 'επαγγελιας γαρ ο λογος ουτος'); -- επαγγελιας γαρ ο λογος ουτος = of the promise for the word is this
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2005, 1, 'quotation', 'literal, superset, synonym', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20051, 'Romans', 'SBLGNT Romans 9:9 9:9-47', 18758, 18781);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20051, 2005, 1, 'Genesis', 'LXX Genesis 18:10+28 18:10-79', 'Romans', 'SBLGNT Romans 9:9+24 9:9-27', 40962, 20, 18782, 20);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20051, 2005, 1, 'Genesis', 'LXX Genesis 18:14+63 18:14', 'Romans', 'SBLGNT Romans 9:9+52 9:9', 41368, 19, 18810, 19);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20061, 2006, 1, 'Genesis', null, 'LXX Genesis 25:23+103 25:24-64', 'Romans', 'SBLGNT Romans 9:12+39 9:13-43', 65835, 29, 19006, 29, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20061, 2006, 1, 'Genesis', null, 'LXX Genesis 25:23+104 25:23', 'Romans', 'SBLGNT Romans 9:12+40 9:12', 65836, 26, 19007, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2006, 1, 'Ρεβεκκα ... αυτη', 'ερρεθη'); -- Ρεβεκκα ... αυτη = Rebecca ... to her, ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2006, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20061, 'Romans', 'SBLGNT Romans 9:12 9:12-26', 18967, 19006);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20061, 'Romans', 'SBLGNT Romans 9:10+16 9:10-36', 18845, 18851); -- Rebecca is mentioned only here in NT
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20061, 2006, 1, 'Genesis', 'LXX Genesis 25:23+104 25:23', 'Romans', 'SBLGNT Romans 9:12+40 9:12', 65836, 26, 19007, 26);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20071, 2007, 1, 'Genesis', null, 'LXX Genesis 2:24+109 2:24', 'I_Corinthians', 'SBLGNT I_Corinthians 6:16+57 6:16', 5595, 17, 9366, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20071, 2007, 1, 'Genesis', null, 'LXX Genesis 2:24+102 2:24', 'I_Corinthians', 'SBLGNT I_Corinthians 6:16+42 6:16', 5588, 24, 9351, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2007, 1, null, 'γαρ φησιν'); -- γαρ φησιν = for it says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2007, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20071, 'I_Corinthians', 'SBLGNT I_Corinthians 6:16+49 6:16-17', 9358, 9365);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20071, 2007, 1, 'Genesis', 'LXX Genesis 2:24+109 2:24', 'I_Corinthians', 'SBLGNT I_Corinthians 6:16+57 6:16', 5595, 17, 9366, 17);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20071, 2007, 1, 'Genesis', 'LXX Genesis 2:24+102 2:24-17', 'I_Corinthians', 'SBLGNT I_Corinthians 6:16+42 6:16-25', 5588, 7, 9351, 7); -- esontai
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20072, 2007, 2, 'Genesis', null, 'LXX Genesis 2:24+6 2:24-87', 'Ephesians', 'SBLGNT Ephesians 5:31+4 5:31-72', 5492, 33, 9802, 33, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20072, 2007, 2, 'Genesis', null, 'LXX Genesis 2:24+61 2:24-46', 'Ephesians', 'SBLGNT Ephesians 5:31+49 5:31-41', 5547, 19, 9847, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20072, 2007, 2, 'Genesis', null, 'LXX Genesis 2:24+94 2:24', 'Ephesians', 'SBLGNT Ephesians 5:31+77 5:31', 5580, 32, 9875, 32, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20072, 2007, 2, 'Genesis', null, 'LXX Genesis 2:24', 'Ephesians', 'SBLGNT Ephesians 5:31', 5486, 126, 9798, 109, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2007, 2, null, 'το μυστηριον τουτο μεγα εστιν, εγω δε λεγω εις Χριστον και εις την εκκλησιαν'); -- το μυστηριον τουτο μεγα εστιν, εγω δε λεγω εις Χριστον και εις την εκκλησιαν = This is a great mystery: but I speak concerning Christ and the church.
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2007, 2, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20072, 'Ephesians', 'SBLGNT Ephesians 5:32 5:32', 9907, 9968);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20072, 2007, 2, 'Genesis', 'LXX Genesis 2:24+6 2:24', 'Ephesians', 'SBLGNT Ephesians 5:31+4 5:31', 5492, 120, 9802, 105);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20073, 2007, 3, 'Genesis', null, 'LXX Genesis 2:24+94 2:24', 'Matthew', 'SBLGNT Matthew 19:5+82 19:5', 5580, 32, 53857, 32, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20073, 2007, 3, 'Genesis', null, 'LXX Genesis 2:24+6 2:24-87', 'Matthew', 'SBLGNT Matthew 19:5+13 19:5-68', 5492, 33, 53788, 33, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20073, 2007, 3, 'Genesis', null, 'LXX Genesis 2:24 2:24', 'Matthew', 'SBLGNT Matthew 19:5+8 19:5', 5486, 126, 53783, 106, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2007, 3, 'ο', 'και ειπεν'); -- και ειπεν = and said (the source is the same as in Matthew 19:4, that is, God: ο = the One)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2007, 3, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20073, 'Matthew', 'SBLGNT Matthew 19:4+32 19:5-106', 53735, 53782);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20073, 2007, 3, 'Genesis', 'LXX Genesis 2:24 2:24', 'Matthew', 'SBLGNT Matthew 19:5+8 19:5', 5486, 126, 53783, 106);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20074, 2007, 4, 'Genesis', null, 'LXX Genesis 2:24 2:24-70', 'Mark', 'SBLGNT Mark 10:7 10:7-38', 5486, 56, 31616, 56, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20074, 2007, 4, 'Genesis', null, 'LXX Genesis 2:24+61 2:24', 'Mark', 'SBLGNT Mark 10:7+56 10:8-29', 5547, 65, 31672, 65, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20074, 2007, 4, 'Genesis', null, 'LXX Genesis 2:24 2:24', 'Mark', 'SBLGNT Mark 10:7 10:8-29', 5486, 126, 31616, 121, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2007, 4, 'απο ... αρχης κτισεως', 'δε'); -- απο δε αρχης κτισεως = from ... the beginning of creation, δε = however (in Mark 10:6)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2007, 4, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20074, 'Mark', 'SBLGNT Mark 10:6 10:6-26', 31573, 31589);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20074, 2007, 4, 'Genesis', 'LXX Genesis 2:24 2:24', 'Mark', 'SBLGNT Mark 10:7 10:8-29', 5486, 126, 31616, 121);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20074, 2008, 1, 'Genesis', null, 'LXX Genesis 1:27+53 1:27', 'Mark', 'SBLGNT Mark 10:6+17 10:6', 2703, 26, 31590, 26, 'manual');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20074, 2008, 1, 'Genesis', 'LXX Genesis 1:27+53 1:27', 'Mark', 'SBLGNT Mark 10:6+17 10:6', 2703, 26, 31590, 26);
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2008, 1, 'απο ... αρχης κτισεως', 'δε'); -- απο δε αρχης κτισεως = from ... the beginning of creation, δε = however
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2008, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20082, 2008, 2, 'Genesis', null, 'LXX Genesis 1:27+53 1:27', 'Matthew', 'SBLGNT Matthew 19:4+46 19:4', 2703, 26, 53749, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2008, 2, null, 'Ουκ ανεγνωτε οτι'); -- Ουκ ανεγνωτε οτι = Not have you read that
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2008, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20082, 'Matthew', 'SBLGNT Matthew 19:4 19:4-40', 53703, 53734);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20082, 2008, 2, 'Genesis', 'LXX Genesis 1:27+53 1:27', 'Matthew', 'SBLGNT Matthew 19:4+46 19:4', 2703, 26, 53749, 26);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20091, 2009, 1, 'Genesis', null, 'LXX Genesis 2:7+98 2:7', 'I_Corinthians', 'SBLGNT I_Corinthians 15:45+43 15:45-30', 3957, 13, 30076, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20091, 2009, 1, 'Genesis', null, 'LXX Genesis 2:7+82 2:7', 'I_Corinthians', 'SBLGNT I_Corinthians 15:45+17 15:45-30', 3941, 29, 30050, 39, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2009, 1, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2009, 1, 'quotation', 'literal, subset, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20091, 'I_Corinthians', 'SBLGNT I_Corinthians 15:45 15:45-69', 30033, 30049);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20091, 2009, 1, 'Genesis', 'LXX Genesis 2:7+82 2:7', 'I_Corinthians', 'SBLGNT I_Corinthians 15:45+17 15:45-30', 3941, 29, 30050, 39);
-- Alternative way:
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos, alternative) values
 (920091, 'I_Corinthians', 'SBLGNT I_Corinthians 15:45 15:45-69', 30033, 30049, 1);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (920091, 2009, 1, 'Genesis', 'LXX Genesis 2:7+98 2:7', 'I_Corinthians', 'SBLGNT I_Corinthians 15:45+43 15:45-30', 3957, 13, 30076, 13);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (920091, 2009, 1, 'Genesis', 'LXX Genesis 2:7+82 2:7-21', 'I_Corinthians', 'SBLGNT I_Corinthians 15:45+17 15:45-61', 3941, 8, 30050, 8); -- Εγενετο ο
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (920091, 2009, 1, 'Genesis', 'LXX Genesis 2:7+90 2:7-13', 'I_Corinthians', 'SBLGNT I_Corinthians 15:45+31 15:45-47', 3949, 8, 30064, 8); -- ανθρωπος
-- End of alternation.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20101, 2010, 1, 'Genesis', null, 'LXX Genesis 12:7+32 12:7-68', 'Galatians', 'SBLGNT Galatians 3:16+97 3:16-14', 28321, 13, 4978, 13, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2010, 1, null, 'ου λεγει ... αλλ'); -- ου λεγει ... αλλ = not it does say ... but
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2010, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20101, 'Galatians', 'SBLGNT Galatians 3:16 3:16-30', 4881, 4974);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20101, 2010, 1, 'Genesis', 'LXX Genesis 12:7+20 12:7-90', 'Galatians', 'SBLGNT Galatians 3:16+94 3:16-27', 28309, 3, 4975, 3); -- kai
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20101, 2010, 1, 'Genesis', 'LXX Genesis 12:7+32 12:7-68', 'Galatians', 'SBLGNT Galatians 3:16+97 3:16-14', 28321, 13, 4978, 13);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20111, 2011, 1, 'Genesis', null, 'LXX Genesis 21:10+93 21:10-8', 'Galatians', 'SBLGNT Galatians 4:30+84 4:30-12', 50185, 13, 8016, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20111, 2011, 1, 'Genesis', null, 'LXX Genesis 21:10+16 21:10-80', 'Galatians', 'SBLGNT Galatians 4:30+17 4:30-74', 50108, 18, 7949, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20111, 2011, 1, 'Genesis', null, 'LXX Genesis 21:10+38 21:10-54', 'Galatians', 'SBLGNT Galatians 4:30+33 4:30-54', 50130, 22, 7965, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20111, 2011, 1, 'Genesis', null, 'LXX Genesis 21:10+60 21:10-25', 'Galatians', 'SBLGNT Galatians 4:30+57 4:30-23', 50152, 29, 7989, 29, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20111, 2011, 1, 'Genesis', null, 'LXX Genesis 21:10+16 21:10-8', 'Galatians', 'SBLGNT Galatians 4:30+17 4:30-12', 50108, 90, 7949, 80, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2011, 1, null, 'αλλα τι λεγει η γραφη'); -- αλλα τι λεγει η γραφη = but what says the Scripture
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2011, 1, 'quotation', 'literal, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20111, 'Galatians', 'SBLGNT Galatians 4:30 4:30-92', 7932, 7948);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20111, 2011, 1, 'Genesis', 'LXX Genesis 21:10+16 21:10-8', 'Galatians', 'SBLGNT Galatians 4:30+17 4:30-12', 50108, 90, 7949, 80);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20121, 2012, 1, 'Genesis', null, 'LXX Genesis 2:2+11 2:2-83', 'Hebrews', 'SBLGNT Hebrews 4:4+42 4:4-27', 3379, 20, 4742, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20121, 2012, 1, 'Genesis', null, 'LXX Genesis 2:2+64 2:2-10', 'Hebrews', 'SBLGNT Hebrews 4:4+49 4:4', 3432, 40, 4749, 40, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20121, 2012, 1, 'Genesis', null, 'LXX Genesis 2:2+54 2:2-10', 'Hebrews', 'SBLGNT Hebrews 4:4+32 4:4', 3422, 50, 4732, 57, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2012, 1, 'που περι της εβδομης', 'ειρηκεν γαρ'); -- που περι της εβδομης = somewhere concerning the seventh day, ειρηκεν γαρ = He has spoken for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2012, 1, 'quotation', 'literal, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20121, 'Hebrews', 'SBLGNT Hebrews 4:4 4:4-57', 4700, 4731);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20121, 2012, 1, 'Genesis', 'LXX Genesis 2:2+54 2:2-10', 'Hebrews', 'SBLGNT Hebrews 4:4+32 4:4', 3422, 50, 4732, 57);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20131, 2013, 1, 'Genesis', null, 'LXX Genesis 22:17+1 22:17-121', 'Hebrews', 'SBLGNT Hebrews 6:14+7 6:14-2', 54247, 38, 8206, 38, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20131, 2013, 1, 'Genesis', null, 'LXX Genesis 22:17+1 22:17-121', 'Hebrews', 'SBLGNT Hebrews 6:14+7 6:14-2', 54247, 38, 8206, 38, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2013, 1, null, 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2013, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20131, 'Hebrews', 'SBLGNT Hebrews 6:13 6:14-42', 8121, 8203);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20131, 2013, 1, 'Genesis', 'LXX Genesis 22:17+1 22:17-121', 'Hebrews', 'SBLGNT Hebrews 6:14+7 6:14-2', 54247, 38, 8206, 38);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20141, 2014, 1, 'Genesis', null, 'LXX Genesis 14:17+62 14:17-82', 'Hebrews', 'SBLGNT Hebrews 7:1+84 7:1-27', 33237, 12, 8855, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20141, 2014, 1, 'Genesis', null, 'LXX Genesis 14:18+3 14:18-50', 'Hebrews', 'SBLGNT Hebrews 7:1+9 7:1-91', 33334, 23, 8780, 23, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20141, 2014, 1, 'Genesis', null, 'LXX Genesis 14:18+53 14:18', 'Hebrews', 'SBLGNT Hebrews 7:1+32 7:1-68', 33384, 23, 8803, 23, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20141, 2014, 1, 'Genesis', null, 'LXX Genesis 14:20+77 14:21-66', 'Hebrews', 'SBLGNT Hebrews 7:2+4 7:2-99', 33569, 17, 8898, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20141, 2014, 1, 'Genesis', null, 'LXX Genesis 14:17+62 14:20', 'Hebrews', 'SBLGNT Hebrews 7:1+9 7:2-100', 33237, 348, 8780, 134, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2014, 1, null, 'Ουτος γαρ'); -- Ουτος γαρ = this for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2014, 1, 'quotation', 'superset, far-fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20141, 'Hebrews', 'SBLGNT Hebrews 7:1 7:1-115', 8771, 8778);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20141, 2014, 1, 'Genesis', 'LXX Genesis 14:18+3 14:18-50', 'Hebrews', 'SBLGNT Hebrews 7:1+9 7:1-91', 33334, 23, 8780, 23); -- μελχισεδεκ βασιλευς σαλημ
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20141, 2014, 1, 'Genesis', 'LXX Genesis 14:18+53 14:18', 'Hebrews', 'SBLGNT Hebrews 7:1+32 7:1-68', 33384, 23, 8803, 23); -- ιερευς του θεου του υψιστου
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20141, 2014, 1, 'Genesis', 'LXX Genesis 14:20+77 14:20', 'Hebrews', 'SBLGNT Hebrews 7:2+4 7:2-100', 33569, 16, 8898, 16); -- δεκατην απο παντων
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20141, 2014, 1, 'Genesis', 'LXX Genesis 14:17+62 14:17-82', 'Hebrews', 'SBLGNT Hebrews 7:1+84 7:1-27', 33237, 12, 8855, 12); -- απο της κοπης
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20151, 2015, 1, 'Genesis', null, 'LXX Genesis 18:18+44 18:18-6', 'Galatians', 'SBLGNT Galatians 3:8+73 3:8', 41664, 33, 4262, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2015, 1, 'η γραφη ... τω Αβρααμ', 'θεος προευηγγελισατο ... οτι'); -- θεος προευηγγελισατο = God foretold the gospel
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2015, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20151, 'Galatians', 'SBLGNT Galatians 3:8 3:8-32', 4189, 4261);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20151, 2015, 1, 'Genesis', 'LXX Genesis 18:18+44 18:18-6', 'Galatians', 'SBLGNT Galatians 3:8+73 3:8', 41664, 33, 4262, 32);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20161, 2016, 1, 'Genesis', null, 'LXX Genesis 28:14+98 28:14', 'Acts', 'SBLGNT Acts 3:25+88 3:25', 76468, 57, 9167, 54, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2016, 1, 'προς Αβρααμ', 'θεος ... λεγων'); -- θεος ... λεγων = God ... saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2016, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20161, 'Acts', 'SBLGNT Acts 3:25 3:25-54', 9079, 9166);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20161, 2016, 1, 'Genesis', 'LXX Genesis 28:14+98 28:14', 'Acts', 'SBLGNT Acts 3:25+88 3:25', 76468, 57, 9167, 54);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20171, 2017, 1, 'Genesis', null, 'LXX Genesis 12:1+21 12:1-43', 'Acts', 'SBLGNT Acts 7:3+17 7:3-26', 27636, 41, 18379, 41, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20171, 2017, 1, 'Genesis', null, 'LXX Genesis 12:1+84 12:1', 'Acts', 'SBLGNT Acts 7:3+63 7:3', 27699, 21, 18425, 21, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20171, 2017, 1, 'Genesis', null, 'LXX Genesis 12:1+21 12:1', 'Acts', 'SBLGNT Acts 7:3+17 7:3', 27636, 84, 18379, 67, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2017, 1, 'Ο θεος της δοξης ... προς αυτον', 'ειπεν'); -- Ο θεος της δοξης ... προς αυτον = the God of glory ... to him (Abraham), ειπεν = said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2017, 1, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20171, 'Acts', 'SBLGNT Acts 7:2 7:3-67', 18244, 18378);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20171, 2017, 1, 'Genesis', 'LXX Genesis 12:1+21 12:1-43', 'Acts', 'SBLGNT Acts 7:3+17 7:3-26', 27636, 41, 18379, 41);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20171, 2017, 1, 'Genesis', 'LXX Genesis 12:1+84 12:1', 'Acts', 'SBLGNT Acts 7:3+63 7:3', 27699, 21, 18425, 21);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20181, 2018, 1, 'Genesis', null, 'LXX Genesis 15:13+34 15:13-100', 'Acts', 'SBLGNT Acts 7:6+41 7:6-55', 35016, 9, 18749, 9, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20181, 2018, 1, 'Genesis', null, 'LXX Genesis 15:13+67 15:13-56', 'Acts', 'SBLGNT Acts 7:6+59 7:6-26', 35049, 20, 18767, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20181, 2018, 1, 'Genesis', null, 'LXX Genesis 15:14+4 15:14-57', 'Acts', 'SBLGNT Acts 7:7+5 7:7-78', 35129, 16, 18818, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20181, 2018, 1, 'Genesis', null, 'LXX Genesis 15:14+21 15:14-45', 'Acts', 'SBLGNT Acts 7:7+23 7:7-65', 35146, 11, 18836, 11, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20181, 2018, 1, 'Genesis', null, 'LXX Genesis 15:14+38 15:14-22', 'Acts', 'SBLGNT Acts 7:7+51 7:7-31', 35163, 17, 18864, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20181, 2018, 1, 'Genesis', null, 'LXX Genesis 15:13+34 15:14-22', 'Acts', 'SBLGNT Acts 7:6+41 7:7-31', 35016, 164, 18749, 132, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2018, 1, 'θεος', 'ελαλησεν δε'); -- ελαλησεν δε = spoke however
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2018, 1, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20181, 'Acts', 'SBLGNT Acts 7:6 7:6-85', 18708, 18727);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20181, 'Acts', 'SBLGNT Acts 7:7+34 7:7-55', 18847, 18856);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20181, 2018, 1, 'Genesis', 'LXX Genesis 15:13+31 15:14-45', 'Acts', 'SBLGNT Acts 7:6+20 7:7-65', 35013, 144, 18728, 119);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20181, 2018, 1, 'Genesis', 'LXX Genesis 15:14+32 15:14-22', 'Acts', 'SBLGNT Acts 7:7+47 7:7-31', 35157, 23, 18860, 21);
-- Alternative way:
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos, alternative) values
 (920181, 'Acts', 'SBLGNT Acts 7:6 7:6-85', 18708, 18727, 1);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (920181, 'Acts', 'SBLGNT Acts 7:7+34 7:7-55', 18847, 18856);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (920181, 2018, 1, 'Genesis', 'LXX Genesis 15:13+31 15:13-81', 'Acts', 'SBLGNT Acts 7:6+20 7:6-52', 35013, 31, 18728, 33); -- οτι παροικον εσται το σπερμα σου εν γη -> οτι εσται το σπερμα αυτου παροικον εν γη
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (920181, 2018, 1, 'Genesis', 'LXX Genesis 15:13+69 15:13-41', 'Acts', 'SBLGNT Acts 7:6+61 7:6-13', 35051, 33, 18769, 31); -- και δουλωσουσιν αυτους και κακωσουσιν -> και δουλωσουσιν αυτο και κακωσουσιν
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (920181, 2018, 1, 'Genesis', 'LXX Genesis 15:13+130 15:14-45', 'Acts', 'SBLGNT Acts 7:6+92 7:7-65', 35112, 45, 18800, 47); -- τετρακοσια ετη το δε εθνος ω εαν δουλευσωσιν κρινω εγω -> ετη τετρακοσια και το εθνος ω εαν δουλευσουσιν κρινω εγω
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (920181, 2018, 1, 'Genesis', 'LXX Genesis 15:14+32 15:14-22', 'Acts', 'SBLGNT Acts 7:7+47 7:7-31', 35157, 23, 18860, 21); -- μετα δε ταυτα εξελευσονται
-- End of alternative way.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20191, 2019, 1, 'Genesis', null, 'LXX Genesis 17:19+130 17:19', 'Acts', 'SBLGNT Acts 7:5+87 7:5-18', 39279, 27, 18663, 27, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20191, 2019, 1, 'Genesis', null, 'LXX Genesis 17:19+130 17:19', 'Acts', 'SBLGNT Acts 7:5+87 7:5-18', 39279, 27, 18663, 27, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2019, 1, null, 'επηγγειλατο'); -- επηγγειλατο = [God] promised
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2019, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20191, 'Acts', 'SBLGNT Acts 7:5+49 7:5-72', 18625, 18635);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20191, 2019, 1, 'Genesis', 'LXX Genesis 17:19+130 17:19', 'Acts', 'SBLGNT Acts 7:5+87 7:5-18', 39279, 27, 18663, 27);
-- This is just a reference but not a quotation:
-- insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
--  (20201, 2020, 1, 'Genesis', null, 'LXX Genesis 46:27+4 46:27', 'Acts', 'SBLGNT Acts 7:14+10 7:14', 138115, 103, 19514, 83, 'manual');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (20211, 2021, 1, 'Genesis', null, 'LXX Genesis 47:27+68 47:27-6', 'Acts', 'SBLGNT Acts 7:17+59 7:17-9', 142227, 24, 19810, 24, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2021, 1, null, 'επαγγελιας ης ωμολογησεν ο θεος τω Αβρααμ'); -- επαγγελιας ης ωμολογησεν ο θεος τω Αβρααμ = promise that had made God to Abraham
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2021, 1, 'quotation', 'fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (20211, 'Acts', 'SBLGNT Acts 7:17 7:17-33', 19751, 19809);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (20211, 2021, 1, 'Genesis', 'LXX Genesis 47:27+68 47:27-6', 'Acts', 'SBLGNT Acts 7:17+59 7:17-9', 142227, 24, 19810, 24);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21011, 2101, 1, 'Exodus', null, 'LXX Exodus 33:19+86 33:19', 'Romans', 'SBLGNT Romans 9:15+15 9:15', 99825, 38, 19131, 38, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21011, 2101, 1, 'Exodus', null, 'LXX Exodus 33:19+87 33:19', 'Romans', 'SBLGNT Romans 9:15+16 9:15', 99826, 37, 19132, 37, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2101, 1, 'τω Μωυσει', 'γαρ λεγει'); -- τω Μωυσει = to Moses, γαρ λεγει = for He says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2101, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21011, 'Romans', 'SBLGNT Romans 9:15 9:15-37', 19116, 19131);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21011, 2101, 1, 'Exodus', 'LXX Exodus 33:19+87 33:19', 'Romans', 'SBLGNT Romans 9:15+16 9:15', 99826, 37, 19132, 37);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21021, 2102, 1, 'Exodus', null, 'LXX Exodus 9:16+28 9:16-43', 'Romans', 'SBLGNT Romans 9:17+50 9:17-45', 24278, 18, 19273, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21021, 2102, 1, 'Exodus', null, 'LXX Exodus 9:16+50 9:16', 'Romans', 'SBLGNT Romans 9:17+74 9:17', 24300, 39, 19297, 39, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21021, 2102, 1, 'Exodus', null, 'LXX Exodus 9:16+28 9:16', 'Romans', 'SBLGNT Romans 9:17+50 9:17', 24278, 61, 19273, 63, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2102, 1, 'τω Φαραω', 'λεγει γαρ η γραφη'); -- τω Φαραω = to Pharaoh, λεγει γαρ η γραφη = says for the Scripture
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2102, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21021, 'Romans', 'SBLGNT Romans 9:17 9:17-89', 19223, 19246);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21021, 2102, 1, 'Exodus', 'LXX Exodus 9:16+28 9:16', 'Romans', 'SBLGNT Romans 9:17+50 9:17', 24278, 61, 19273, 63);
-- The Ten Commandments:
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21031, 2103, 1, 'Exodus', null, 'LXX Exodus 20:13 20:15', 'Romans', 'SBLGNT Romans 13:9+5 13:9-96', 57313, 32, 27196, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 1, 'νομον', 'το γαρ'); -- νομον = the Law (in Romans 13:8), το γαρ = for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 1, 'quotation', 'literal', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21031, 'Romans', 'SBLGNT Romans 13:9 13:9-128', 27191, 27195);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21031, 'Romans', 'SBLGNT Romans 13:8+39 13:8', 27157, 27190); -- nomon
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21031, 2103, 1, 'Exodus', 'LXX Exodus 20:13 20:15', 'Romans', 'SBLGNT Romans 13:9+5 13:9-96', 57313, 32, 27196, 32);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21031, 2103, 1, 'Exodus', 'LXX Exodus 20:17 20:17-197', 'Romans', 'SBLGNT Romans 13:9+37 13:9-82', 57394, 14, 27228, 14);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21032, 2103, 2, 'Exodus', null, 'LXX Exodus 20:12+27 20:12-63', 'Ephesians', 'SBLGNT Ephesians 6:2+58 6:3-24', 57231, 19, 10174, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21032, 2103, 2, 'Exodus', null, 'LXX Exodus 20:12 20:12-35', 'Ephesians', 'SBLGNT Ephesians 6:2 6:3', 57204, 74, 10116, 101, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 2, 'εντολη', null); -- εντολη = commandment
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 2, 'quotation', 'literal, exact, subset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21032, 'Ephesians', 'SBLGNT Ephesians 6:2+28 6:2', 10144, 10174);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21032, 2103, 2, 'Exodus', 'LXX Exodus 20:12 20:12-81', 'Ephesians', 'SBLGNT Ephesians 6:2 6:2-31', 57204, 28, 10116, 28);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21032, 2103, 2, 'Exodus', 'LXX Exodus 20:12+28 20:12-35', 'Ephesians', 'SBLGNT Ephesians 6:3 6:3', 57232, 46, 10175, 42);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21033, 2103, 3, 'Exodus', null, 'LXX Exodus 20:12 20:12-81', 'Mark', 'SBLGNT Mark 7:10+14 7:10-44', 57204, 28, 21573, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 3, 'Μωυσης', 'γαρ ειπεν'); -- γαρ ειπεν = for said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21033, 'Mark', 'SBLGNT Mark 7:10 7:10-72', 21559, 21572);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21033, 2103, 3, 'Exodus', 'LXX Exodus 20:12 20:12-81', 'Mark', 'SBLGNT Mark 7:10+14 7:10-44', 57204, 28, 21573, 28);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21034, 2103, 4, 'Exodus', null, 'LXX Exodus 20:12 20:16-31', 'Mark', 'SBLGNT Mark 10:19+15 10:19', 57204, 159, 32469, 87, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 4, 'τας εντολας', 'οιδας'); -- τας εντολας οιδας = the commandments you know
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 4, 'quotation', 'literal, far-fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21034, 'Mark', 'SBLGNT Mark 10:19 10:19-87', 32454, 32468);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21034, 2103, 4, 'Exodus', 'LXX Exodus 20:13 20:16-31', 'Mark', 'SBLGNT Mark 10:19+15 10:19-41', 57313, 50, 32469, 46);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21034, 2103, 4, 'Exodus', 'LXX Exodus 20:12 20:12-81', 'Mark', 'SBLGNT Mark 10:19+74 10:19', 57204, 28, 32528, 28);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21035, 2103, 5, 'Exodus', null, 'LXX Exodus 20:12 20:16-31', 'Luke', 'SBLGNT Luke 18:20+15 18:20', 57204, 159, 70605, 74, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 5, 'τας εντολας', 'οιδας'); -- τας εντολας οιδας = the commandments you know
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 5, 'quotation', 'literal, far-fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21035, 'Luke', 'SBLGNT Luke 18:20 18:20-74', 70590, 70604);
-- Strangely these are very far:
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21035, 2103, 5, 'Exodus', 'LXX Exodus 20:13 20:16-31', 'Luke', 'SBLGNT Luke 18:20+15 18:20-28', 57313, 50, 70605, 46);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21035, 2103, 5, 'Exodus', 'LXX Exodus 20:12 20:12-81', 'Luke', 'SBLGNT Luke 18:20+61 18:20', 57204, 28, 70651, 28);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21036, 2103, 6, 'Exodus', null, 'LXX Exodus 20:13 20:14', 'James', 'SBLGNT James 2:11+9 2:11-46', 57313, 23, 3015, 29, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 6, null, 'ο γαρ ειπων ... ειπεν και'); -- ο γαρ ειπων = the One for having said, ειπεν και = said also
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 6, 'quotation', 'literal, far-fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21036, 'James', 'SBLGNT James 2:11 2:11-75', 3006, 3014);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21036, 'James', 'SBLGNT James 2:11+20 2:11-56', 3026, 3033);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21036, 2103, 6, 'Exodus', 'LXX Exodus 20:13 20:13', 'James', 'SBLGNT James 2:11+28 2:11-46', 57313, 11, 3034, 10);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21036, 2103, 6, 'Exodus', 'LXX Exodus 20:14 20:14', 'James', 'SBLGNT James 2:11+9 2:11-64', 57324, 12, 3015, 11);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21037, 2103, 7, 'Exodus', null, 'LXX Exodus 20:13 20:13', 'Matthew', 'SBLGNT Matthew 5:21+29 5:21-31', 57313, 11, 9907, 11, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 7, null, 'ερρεθη'); -- ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 7, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21037, 'Matthew', 'SBLGNT Matthew 5:21 5:21-42', 9878, 9906);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21037, 2103, 7, 'Exodus', 'LXX Exodus 20:13 20:13', 'Matthew', 'SBLGNT Matthew 5:21+29 5:21-31', 57313, 11, 9907, 11);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21038, 2103, 8, 'Exodus', null, 'LXX Exodus 20:12 20:16-31', 'Matthew', 'SBLGNT Matthew 19:18+30 19:19-34', 57204, 159, 54982, 75, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 8, 'τας εντολας', null); -- τας εντολας = the commandments
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 8, 'quotation', 'literal, exact, far-fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21038, 'Matthew', 'SBLGNT Matthew 19:17+50 19:18-50', 54906, 54981);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21038, 2103, 8, 'Exodus', 'LXX Exodus 20:13 20:16-31', 'Matthew', 'SBLGNT Matthew 19:18+30 19:18', 57313, 50, 54982, 50); -- Ου φονευσεις, Ου μοιχευσεις, Ου κλεψεις. Ου ψευδομαρτυρησεις
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21038, 2103, 8, 'Exodus', 'LXX Exodus 20:12 20:12-81', 'Matthew', 'SBLGNT Matthew 19:19 19:19-34', 57204, 28, 55032, 25); -- Τιμα τον πατερα και την μητερα
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21039, 2103, 9, 'Exodus', null, 'LXX Exodus 20:14 20:14', 'Matthew', 'SBLGNT Matthew 5:27+17 5:27', 57324, 12, 10489, 12, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 9, null, 'ερρεθη'); -- ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 9, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21039, 'Matthew', 'SBLGNT Matthew 5:27 5:27-12', 10472, 10488);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21039, 2103, 9, 'Exodus', 'LXX Exodus 20:14 20:14', 'Matthew', 'SBLGNT Matthew 5:27+17 5:27', 57324, 12, 10489, 12);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21040, 2103, 10, 'Exodus', null, 'LXX Exodus 20:12 20:12-81', 'Matthew', 'SBLGNT Matthew 15:4+13 15:4-41', 57204, 28, 42524, 25, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2103, 10, 'θεος', 'ειπεν'); -- ειπεν = commanded
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2103, 10, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21040, 'Matthew', 'SBLGNT Matthew 15:4 15:4-66', 42511, 42523);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21040, 2103, 10, 'Exodus', 'LXX Exodus 20:12 20:12-81', 'Matthew', 'SBLGNT Matthew 15:4+13 15:4-41', 57204, 28, 42524, 25);
-- End of the Ten Commandments.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21041, 2104, 1, 'Exodus', null, 'LXX Exodus 13:12+10 13:12-91', 'Luke', 'SBLGNT Luke 2:23+29 2:23-10', 37462, 35, 7753, 35, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2104, 1, 'εν νομω κυριου', 'καθως γεγραπται'); -- εν νομω κυριου = in the law of the Lord, καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2104, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21041, 'Luke', 'SBLGNT Luke 2:23 2:23-45', 7724, 7752);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21041, 2104, 1, 'Exodus', 'LXX Exodus 13:12+10 13:12-98', 'Luke', 'SBLGNT Luke 2:23+29 2:23-22', 37462, 28, 7753, 23); -- παν διανοιγον μητραν τα αρσενικα -> Παν αρσεν διανοιγον μητραν
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21041, 2104, 1, 'Exodus', 'LXX Exodus 13:12+121 13:12', 'Luke', 'SBLGNT Luke 2:23+52 2:23-10', 37573, 15, 7776, 12); -- αγιασεις τω κυριω -> αγιον τω κυριω
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21051, 2105, 1, 'Exodus', null, 'LXX Exodus 32:6+72 32:6-23', 'I_Corinthians', 'SBLGNT I_Corinthians 10:7+50 10:7-22', 94487, 25, 16516, 25, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21051, 2105, 1, 'Exodus', null, 'LXX Exodus 32:6+98 32:6', 'I_Corinthians', 'SBLGNT I_Corinthians 10:7+75 10:7', 94513, 22, 16541, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21051, 2105, 1, 'Exodus', null, 'LXX Exodus 32:6+74 32:6', 'I_Corinthians', 'SBLGNT I_Corinthians 10:7+52 10:7', 94489, 46, 16518, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2105, 1, null, 'ωσπερ γεγραπται'); -- ωσπερ γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2105, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21051, 'I_Corinthians', 'SBLGNT I_Corinthians 10:7 10:7-45', 16466, 16517);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21051, 2105, 1, 'Exodus', 'LXX Exodus 32:6+74 32:6', 'I_Corinthians', 'SBLGNT I_Corinthians 10:7+52 10:7', 94489, 46, 16518, 45);
-- TODO: These have longer variants in Deuteronomy (see 24101 and 24102), so these should be removed from database:
-- insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
--  (21061, 2106, 1, 'Exodus', null, 'LXX Exodus 20:5+2 20:5-115', 'Matthew', 'SBLGNT Matthew 4:10+59 4:10-3', 56471, 31, 6932, 30, 'manual');
-- insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
--  (2106, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
-- insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
--  (2106, 1, 'quotation', 'literal, changed, fuzzy', 'Z.K.');
-- insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
--  (21062, 2106, 2, 'Exodus', null, 'LXX Exodus 20:5+2 20:5-115', 'Luke', 'SBLGNT Luke 4:8+54 4:8-3', 56471, 31, 13608, 30, 'manual');
-- insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
--  (2106, 2, null, 'γεγραπται'); -- γεγραπται = it has been written
-- insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
--  (2106, 2, 'quotation', 'literal, changed, fuzzy', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21071, 2107, 1, 'Exodus', null, 'LXX Exodus 16:18+21 16:18-75', 'II_Corinthians', 'SBLGNT II_Corinthians 8:15+21 8:15-26', 47144, 13, 12704, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21071, 2107, 1, 'Exodus', null, 'LXX Exodus 16:18+52 16:18-41', 'II_Corinthians', 'SBLGNT II_Corinthians 8:15+44 8:15', 47175, 16, 12727, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21071, 2107, 1, 'Exodus', null, 'LXX Exodus 16:18+21 16:18-41', 'II_Corinthians', 'SBLGNT II_Corinthians 8:15+14 8:15', 47144, 47, 12697, 46, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2107, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2107, 1, 'quotation', 'literal, synonym, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21071, 'II_Corinthians', 'SBLGNT II_Corinthians 8:15 8:15-46', 12683, 12696);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21071, 2107, 1, 'Exodus', 'LXX Exodus 16:18+21 16:18-41', 'II_Corinthians', 'SBLGNT II_Corinthians 8:15+14 8:15', 47144, 47, 12697, 46);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21081, 2108, 1, 'Exodus', null, 'LXX Exodus 25:40+11 25:40-20', 'Hebrews', 'SBLGNT Hebrews 8:5+121 8:5-18', 73209, 17, 11613, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21081, 2108, 1, 'Exodus', null, 'LXX Exodus 25:40+3 25:40', 'Hebrews', 'SBLGNT Hebrews 8:5+108 8:5', 73201, 45, 11600, 48, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2108, 1, 'Μωυσης', 'καθως κεχρηματισται ... φησιν'); -- καθως κεχρηματισται ... φησιν = as was divinely instructed ... He says (this has to be split in the .brst)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2108, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21081, 'Hebrews', 'SBLGNT Hebrews 8:5 8:5-59', 11492, 11588);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21081, 'Hebrews', 'SBLGNT Hebrews 8:5+100 8:5-48', 11592, 11599);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21081, 2108, 1, 'Exodus', 'LXX Exodus 25:40 25:40-45', 'Hebrews', 'SBLGNT Hebrews 8:5+97 8:5-56', 73198, 3, 11589, 3); -- Ορα
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21081, 2108, 1, 'Exodus', 'LXX Exodus 25:40+3 25:40', 'Hebrews', 'SBLGNT Hebrews 8:5+108 8:5', 73201, 45, 11600, 48);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21091, 2109, 1, 'Exodus', null, 'LXX Exodus 24:8+50 24:8-45', 'Hebrews', 'SBLGNT Hebrews 9:20+10 9:20-23', 68770, 19, 14396, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21091, 2109, 1, 'Exodus', null, 'LXX Exodus 24:8+50 24:8-24', 'Hebrews', 'SBLGNT Hebrews 9:20+10 9:20-5', 68770, 40, 14396, 37, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2109, 1, null, 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2109, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21091, 'Hebrews', 'SBLGNT Hebrews 9:19 9:20-47', 14234, 14390);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21091, 2109, 1, 'Exodus', 'LXX Exodus 24:8+50 24:8-45', 'Hebrews', 'SBLGNT Hebrews 9:20+10 9:20-23', 68770, 19, 14396, 19);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21091, 2109, 1, 'Exodus', 'LXX Exodus 24:8+82 24:8-24', 'Hebrews', 'SBLGNT Hebrews 9:20+39 9:20-5', 68802, 8, 14425, 8); -- προς υμας
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21091, 2109, 1, 'Exodus', 'LXX Exodus 24:8+108 24:8', 'Hebrews', 'SBLGNT Hebrews 9:20+5 9:20-42', 68828, 6, 14391, 5); -- τουτων -> Τουτο
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21101, 2110, 1, 'Exodus', null, 'LXX Exodus 21:24 21:24-28', 'Matthew', 'SBLGNT Matthew 5:38+17 5:38', 60430, 37, 11387, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2110, 1, null, 'ερρεθη'); -- ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2110, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21101, 'Matthew', 'SBLGNT Matthew 5:38 5:38-40', 11370, 11386);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21101, 2110, 1, 'Exodus', 'LXX Exodus 21:24 21:24-28', 'Matthew', 'SBLGNT Matthew 5:38+17 5:38', 60430, 37, 11387, 40);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21111, 2111, 1, 'Exodus', null, 'LXX Exodus 23:20+1 23:20-54', 'Matthew', 'SBLGNT Matthew 11:10+23 11:10-36', 66260, 45, 28147, 45, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21111, 2111, 1, 'Exodus', null, 'LXX Exodus 23:20+1 23:20-54', 'Matthew', 'SBLGNT Matthew 11:10+23 11:10-36', 66260, 45, 28147, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2111, 1, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2111, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21111, 'Matthew', 'SBLGNT Matthew 11:10 11:10-79', 28124, 28148);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21111, 2111, 1, 'Exodus', 'LXX Exodus 23:20+3 23:20-54', 'Matthew', 'SBLGNT Matthew 11:10+25 11:10-36', 66262, 43, 28149, 43);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21112, 2111, 2, 'Exodus', null, 'LXX Exodus 23:20+10 23:20-54', 'Luke', 'SBLGNT Luke 7:27+29 7:27-36', 66269, 36, 27601, 36, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21112, 2111, 2, 'Exodus', null, 'LXX Exodus 23:20+3 23:20-54', 'Luke', 'SBLGNT Luke 7:27+25 7:27-36', 66262, 43, 27597, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2111, 2, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2111, 2, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21112, 'Luke', 'SBLGNT Luke 7:27 7:27-76', 27572, 27596);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21112, 2111, 2, 'Exodus', 'LXX Exodus 23:20+3 23:20-54', 'Luke', 'SBLGNT Luke 7:27+25 7:27-36', 66262, 43, 27597, 40);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1243, 2111, 3, 'Exodus', null, 'LXX Exodus 23:20+10 23:20-54', 'Mark', 'SBLGNT Mark 1:2+36 1:2-24', 66269, 36, 76, 36, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1243, 2111, 3, 'Exodus', null, 'LXX Exodus 23:20+3 23:20-54', 'Mark', 'SBLGNT Mark 1:2+32 1:2-24', 66262, 43, 72, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2111, 3, null, 'Καθως γεγραπται'); -- Καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2111, 3, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1243, 2111, 3, 'Exodus', 'LXX Exodus 23:20+3 23:20-54', 'Mark', 'SBLGNT Mark 1:2+32 1:2-24', 66262, 43, 72, 40);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21121, 2112, 1, 'Exodus', null, 'LXX Exodus 21:17 21:17-33', 'Matthew', 'SBLGNT Matthew 15:4+41 15:4-22', 59825, 16, 42552, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21121, 2112, 1, 'Exodus', null, 'LXX Exodus 21:17', 'Matthew', 'SBLGNT Matthew 15:4+41 15:4', 59825, 49, 42552, 38, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2112, 1, 'θεος', 'ειπεν'); -- ειπεν = commanded (this belongs to the first introduction, it cannot be handled with .brst export)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2112, 1, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21121, 'Matthew', 'SBLGNT Matthew 15:4+38 15:4-38', 42549, 42551);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21121, 'Matthew', 'SBLGNT Matthew 15:4 15:4-66', 42511, 42523);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21121, 2112, 1, 'Exodus', 'LXX Exodus 21:17 21:17', 'Matthew', 'SBLGNT Matthew 15:4+41 15:4', 59825, 49, 42552, 38);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21122, 2112, 2, 'Exodus', null, 'LXX Exodus 21:17 21:17-33', 'Mark', 'SBLGNT Mark 7:10+48 7:10-22', 59825, 16, 21607, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21122, 2112, 2, 'Exodus', null, 'LXX Exodus 21:17', 'Mark', 'SBLGNT Mark 7:10+48 7:10', 59825, 49, 21607, 38, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2112, 2, 'Μωυσης', 'γαρ ειπεν'); -- γαρ ειπεν = for said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2112, 2, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21122, 'Mark', 'SBLGNT Mark 7:10+45 7:10-38', 21604, 21606);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21122, 'Mark', 'SBLGNT Mark 7:10 7:10-72', 21559, 21572);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21122, 2112, 2, 'Exodus', 'LXX Exodus 21:17 21:17', 'Mark', 'SBLGNT Mark 7:10+48 7:10', 59825, 49, 21607, 38);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21131, 2113, 1, 'Exodus', null, 'LXX Exodus 3:6+12 3:6-70', 'Matthew', 'SBLGNT Matthew 22:32 22:32-29', 4990, 58, 65454, 44, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2113, 1, 'θεου', 'λεγοντος'); -- λεγοντος = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2113, 1, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21131, 'Matthew', 'SBLGNT Matthew 22:31 22:31', 65386, 65453);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21131, 2113, 1, 'Exodus', 'LXX Exodus 3:6+12 3:6-116', 'Matthew', 'SBLGNT Matthew 22:32 22:32-61', 4990, 12, 65454, 12); -- εγω ειμι ο θεος
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21131, 2113, 1, 'Exodus', 'LXX Exodus 3:6+40 3:6-70', 'Matthew', 'SBLGNT Matthew 22:32+12 22:32-29', 5018, 30, 65466, 32); -- αβρααμ και θεος ισαακ και θεος ιακωβ -> Αβρααμ και ο θεος Ισαακ και ο θεος Ιακωβ
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21132, 2113, 2, 'Exodus', null, 'LXX Exodus 3:6+12 3:6-70', 'Mark', 'SBLGNT Mark 12:26+88 12:26', 4990, 58, 40548, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2113, 2, 'εν τη βιβλω Μωυσεως', 'λεγων'); -- λεγων = saying
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2113, 2, 'quotation', 'literal, superset, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21132, 'Mark', 'SBLGNT Mark 12:26 12:26-40', 40460, 40547);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21132, 2113, 2, 'Exodus', 'LXX Exodus 3:6+12 3:6-125', 'Mark', 'SBLGNT Mark 12:26+88 12:26-37', 4990, 3, 40548, 3); -- εγω
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21132, 2113, 2, 'Exodus', 'LXX Exodus 3:6+19 3:6-116', 'Mark', 'SBLGNT Mark 12:26+91 12:26-32', 4997, 5, 40551, 5); -- ο θεος
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21132, 2113, 2, 'Exodus', 'LXX Exodus 3:6+40 3:6-70', 'Mark', 'SBLGNT Mark 12:26+96 12:26', 5018, 30, 40556, 32); -- αβρααμ και θεος ισαακ και θεος ιακωβ -> Αβρααμ και ο θεος Ισαακ και ο θεος Ιακωβ
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21133, 2113, 3, 'Exodus', null, 'LXX Exodus 3:6+33 3:6-70', 'Luke', 'SBLGNT Luke 20:37+64 20:37', 5011, 37, 78894, 37, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2113, 3, 'Μωυσης', 'λεγει'); -- λεγει = calls
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2113, 3, 'quotation', 'literal, grammatical-change, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21133, 'Luke', 'SBLGNT Luke 20:37 20:37-37', 78830, 78893);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21133, 2113, 3, 'Exodus', 'LXX Exodus 3:6+33 3:6-70', 'Luke', 'SBLGNT Luke 20:37+64 20:37', 5011, 37, 78894, 37);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21134, 2113, 4, 'Exodus', null, 'LXX Exodus 3:5+61 3:5', 'Acts', 'SBLGNT Acts 7:33+55 7:33', 4960, 18, 21100, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21134, 2113, 4, 'Exodus', null, 'LXX Exodus 3:7+22 3:7-58', 'Acts', 'SBLGNT Acts 7:33+72 7:34-80', 5140, 46, 21117, 46, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21134, 2113, 4, 'Exodus', null, 'LXX Exodus 3:8 3:8-207', 'Acts', 'SBLGNT Acts 7:34+67 7:34-33', 5244, 25, 21185, 25, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21134, 2113, 4, 'Exodus', null, 'LXX Exodus 3:9+81 3:10-72', 'Acts', 'SBLGNT Acts 7:34+86 7:34-11', 5557, 28, 21204, 28, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21134, 2113, 4, 'Exodus', null, 'LXX Exodus 3:5+20 3:10-48', 'Acts', 'SBLGNT Acts 7:32 7:34', 4919, 690, 20953, 290, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2113, 4, 'Μωυσης', 'εγενετο φωνη κυριου'); -- εγενετο φωνη κυριου = there was voice of the Lord
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2113, 4, 'quotation', 'literal, far-fuzzy, grammatical-change, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21134, 'Acts', 'SBLGNT Acts 7:31 7:31', 20877, 20952);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21134, 'Acts', 'SBLGNT Acts 7:32+48 7:33-55', 21001, 21062);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21134, 2113, 4, 'Exodus', 'LXX Exodus 3:5+20 3:5', 'Acts', 'SBLGNT Acts 7:33+18 7:33', 4919, 59, 21063, 55); -- λυσαι το υποδημα εκ των ποδων σου ο γαρ τοπος εν ω συ εστηκας γη αγια εστιν -> Λυσον το υποδημα των ποδων σου, ο γαρ τοπος εφ ω εστηκας γη αγια εστιν
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21134, 2113, 4, 'Exodus', 'LXX Exodus 3:6+12 3:6-70', 'Acts', 'SBLGNT Acts 7:32 7:32-44', 4990, 58, 20953, 48); -- εγω ειμι ο θεος του πατρος σου θεος αβρααμ και θεος ισαακ και θεος ιακωβ -> Εγω ο θεος των πατερων σου, ο θεος Αβρααμ και Ισαακ και Ιακωβ
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21134, 2113, 4, 'Exodus', 'LXX Exodus 3:7+23 3:7-59', 'Acts', 'SBLGNT Acts 7:34 7:34-81', 5141, 44, 21118, 44); -- ιδων ειδον την κακωσιν του λαου μου του εν αιγυπτω
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21134, 2113, 4, 'Exodus', 'LXX Exodus 3:8 3:8-207', 'Acts', 'SBLGNT Acts 7:34+67 7:34-33', 5244, 25, 21185, 25); -- και κατεβην εξελεσθαι αυτους
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21134, 2113, 4, 'Exodus', 'LXX Exodus 3:10 3:10-72', 'Acts', 'SBLGNT Acts 7:34+92 7:34-11', 5563, 22, 21210, 22); -- και νυν δευρο αποστειλω σε
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21134, 2113, 4, 'Exodus', 'LXX Exodus 3:10+38 3:10-48', 'Acts', 'SBLGNT Acts 7:34+117 7:34', 5601, 8, 21235, 8); -- αιγυπτου -> Αιγυπτον
-- This is repeated in Exodus 12:46 (but 12:10 is not present in many translations):
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21141, 2114, 1, 'Exodus', null, 'LXX Exodus 12:10+30 12:10-48', 'John', 'SBLGNT John 19:36+31 19:36', 31881, 25, 64533, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2114, 1, 'η γραφη', 'πληρωθη'); -- η γραφη = the Scripture, πληρωθη = might be fulfilled
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2114, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21141, 'John', 'SBLGNT John 19:36 19:36-26', 64502, 64532);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21141, 2114, 1, 'Exodus', 'LXX Exodus 12:10+30 12:10-48', 'John', 'SBLGNT John 19:36+31 19:36', 31881, 25, 64533, 26);
-- This does not seem to be a formal quotation. Stephan recalls many parts of a long story. Even if there are
-- longer parts that are literally the same, this is a kind of mixture of story telling and non-strict quoting.
-- On the other hand, a quoted text of 93 characters with full match cannot be just something random!
-- TODO: Maybe handle the whole story as one text and find the clasps---there are many shorter and longer ones too.
-- insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
--  (21151, 2115, 1, 'Exodus', null, 'LXX Exodus 2:14+7 2:14-53', 'Acts', 'SBLGNT Acts 7:27+35 7:29-72', 3240, 93, 20629, 93, 'getrefs');
-- insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
--  (21151, 2115, 1, 'Exodus', null, 'LXX Exodus 2:14+8 2:14-55', 'Acts', 'SBLGNT Acts 7:27+36 7:28', 3241, 90, 20630, 90, 'manual');
-- insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
--  (2115, 1, 'Μωυσης', 'ειπων'); -- ειπων = having said
-- insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
--  (2115, 1, 'quotation', 'literal, exact', 'Z.K.');
-- Again, this is more a story-telling than a formal quotation.
-- TODO: Do something similar like with Acts 7:27-28.
-- insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
--  (21161, 2116, 1, 'Exodus', null, 'LXX Exodus 32:1+96 32:1', 'Acts', 'SBLGNT Acts 7:40+15 7:40', 93906, 107, 21811, 101, 'manual');
-- insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
--  (2116, 1, 'τω Ααρων', 'ειποντες'); -- ειποντες = having said
-- insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
--  (2116, 1, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21171, 2117, 1, 'Exodus', null, 'LXX Exodus 22:28+22 22:28', 'Acts', 'SBLGNT Acts 23:5+59 23:5', 64257, 30, 76956, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2117, 1, null, 'γεγραπται γαρ οτι'); -- γεγραπται γαρ οτι = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2117, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21171, 'Acts', 'SBLGNT Acts 23:5+44 23:5-30', 76941, 76955);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21171, 2117, 1, 'Exodus', 'LXX Exodus 22:28+22 22:28', 'Acts', 'SBLGNT Acts 23:5+59 23:5', 64257, 30, 76956, 30);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21181, 2118, 1, 'Exodus', null, 'LXX Exodus 1:8+8 1:8', 'Acts', 'SBLGNT Acts 7:18+12 7:18', 406, 41, 19855, 41, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21181, 2118, 1, 'Exodus', null, 'LXX Exodus 1:8 1:8', 'Acts', 'SBLGNT Acts 7:18+6 7:18', 398, 49, 19849, 47, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2118, 1, null, 'αχρι ου'); -- αχρι ου = until that
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2118, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21181, 'Acts', 'SBLGNT Acts 7:18 7:18-47', 19843, 19848);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21181, 2118, 1, 'Exodus', 'LXX Exodus 1:8 1:8', 'Acts', 'SBLGNT Acts 7:18+6 7:18', 398, 49, 19849, 47);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21191, 2119, 1, 'Exodus', null, 'LXX Exodus 2:11+72 2:11-91', 'Acts', 'SBLGNT Acts 7:23+74 7:24-81', 2924, 34, 20284, 34, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21191, 2119, 1, 'Exodus', null, 'LXX Exodus 2:11+72 2:11-93', 'Acts', 'SBLGNT Acts 7:23+74 7:23', 2924, 32, 20284, 32, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2119, 1, null, 'ανεβη επι την καρδιαν αυτου'); -- ανεβη επι την καρδιαν αυτου = it came into the mind of him
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2119, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21191, 'Acts', 'SBLGNT Acts 7:23+39 7:23-44', 20249, 20271);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21191, 2119, 1, 'Exodus', 'LXX Exodus 2:11+72 2:11-93', 'Acts', 'SBLGNT Acts 7:23+74 7:23', 2924, 32, 20284, 32);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21201, 2120, 1, 'Exodus', null, 'LXX Exodus 2:12+40 2:12-19', 'Acts', 'SBLGNT Acts 7:24+64 7:25-85', 3089, 20, 20380, 20, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (21201, 2120, 1, 'Exodus', null, 'LXX Exodus 2:12+40 2:12-20', 'Acts', 'SBLGNT Acts 7:24+64 7:24', 3089, 19, 20380, 19, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2120, 1, null, 'και ιδων τινα αδικουμενον'); -- και ιδων τινα αδικουμενον = and having seen a certain one being wronged
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2120, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (21201, 'Acts', 'SBLGNT Acts 7:24 7:24-61', 20316, 20337);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (21201, 2120, 1, 'Exodus', 'LXX Exodus 2:12+40 2:12-20', 'Acts', 'SBLGNT Acts 7:24+64 7:24', 3089, 19, 20380, 19);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22011, 2201, 1, 'Leviticus', null, 'LXX Leviticus 18:5+69 18:5-21', 'Romans', 'SBLGNT Romans 10:5+46 10:5-1', 57053, 27, 20846, 27, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22011, 2201, 1, 'Leviticus', null, 'LXX Leviticus 18:5+69 18:5-21', 'Romans', 'SBLGNT Romans 10:5+46 10:5-1', 57053, 27, 20846, 27, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2201, 1, 'Μωυσης', 'γαρ γραφει'); -- γαρ γραφει = for writes
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2201, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22011, 'Romans', 'SBLGNT Romans 10:5 10:5-56', 20800, 20817);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24011, 'Romans', 'SBLGNT Romans 10:5 10:5-56', 20800, 20817); -- this introduces also Romans 10:6
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22011, 2201, 1, 'Leviticus', 'LXX Leviticus 18:5+69 18:5-18', 'Romans', 'SBLGNT Romans 10:5+46 10:5', 57053, 30, 20846, 28);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22012, 2201, 2, 'Leviticus', null, 'LXX Leviticus 18:5+64 18:5-18', 'Galatians', 'SBLGNT Galatians 3:12+29 3:12', 57048, 35, 4567, 26, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2201, 2, null, 'αλλ'); -- αλλ = rather
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2201, 2, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22012, 'Galatians', 'SBLGNT Galatians 3:12 3:12-27', 4538, 4565);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22012, 2201, 2, 'Leviticus', 'LXX Leviticus 18:5+64 18:5-41', 'Galatians', 'SBLGNT Galatians 3:12+28 3:12-15', 57048, 12, 4566, 12); -- αυτα α ποιησας -> Ο ποιησας αυτα
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22012, 2201, 2, 'Leviticus', 'LXX Leviticus 18:5+84 18:5-18', 'Galatians', 'SBLGNT Galatians 3:12+40 3:12', 57068, 15, 4578, 15); -- ζησεται εν αυτοις
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22021, 2202, 1, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-22', 'Matthew', 'SBLGNT Matthew 5:43+17 5:43-23', 60912, 22, 11699, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22021, 2202, 1, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-22', 'Matthew', 'SBLGNT Matthew 5:43+17 5:43-23', 60912, 22, 11699, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 1, null, 'ερρεθη'); -- ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22021, 'Matthew', 'SBLGNT Matthew 5:43 5:43-45', 11682, 11698);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22021, 2202, 1, 'Leviticus', 'LXX Leviticus 19:18+57 19:18-22', 'Matthew', 'SBLGNT Matthew 5:43+17 5:43-23', 60912, 22, 11699, 22);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22022, 2202, 2, 'Leviticus', null, 'LXX Leviticus 19:18+66 19:18-12', 'Luke', 'SBLGNT Luke 10:27+120 10:28-41', 60921, 23, 43145, 23, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22022, 2202, 2, 'Leviticus', null, 'LXX Leviticus 19:18+66 19:18-13', 'Luke', 'SBLGNT Luke 10:27+120 10:27', 60921, 22, 43145, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 2, 'Εν τω νομω', 'τι γεγραπται; πως αναγινωσκεις ... και'); -- Εν τω νομω = in the law, τι γεγραπται; πως αναγινωσκεις = what has been written; how read you (written in 10:26), και = and
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22022, 'Luke', 'SBLGNT Luke 10:27+117 10:27-22', 43142, 43144); -- και
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22022, 'Luke', 'SBLGNT Luke 10:26 10:27-124', 42974, 43042);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22022, 2202, 2, 'Leviticus', 'LXX Leviticus 19:18+66 19:18-13', 'Luke', 'SBLGNT Luke 10:27+120 10:27', 60921, 22, 43145, 22);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22023, 2202, 3, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'James', 'SBLGNT James 2:8+42 2:8-12', 60912, 31, 2835, 31, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22023, 2202, 3, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'James', 'SBLGNT James 2:8+42 2:8-12', 60912, 31, 2835, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 3, 'νομον', 'κατα την γραφην'); -- νομον = law, κατα την γραφην = according to the Scripture
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 3, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22023, 'James', 'SBLGNT James 2:8 2:8-43', 2793, 2834);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22023, 2202, 3, 'Leviticus', 'LXX Leviticus 19:18+57 19:18-13', 'James', 'SBLGNT James 2:8+42 2:8-12', 60912, 31, 2835, 31);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22024, 2202, 4, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Mark', 'SBLGNT Mark 12:31+11 12:31-30', 60912, 31, 40936, 31, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22024, 2202, 4, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Mark', 'SBLGNT Mark 12:31+11 12:31-30', 60912, 31, 40936, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 4, 'εντολη', 'αυτη'); -- εντολη = commandment, αυτη = this
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 4, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22024, 'Mark', 'SBLGNT Mark 12:31 12:31-61', 40925, 40935);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22024, 'Mark', 'SBLGNT Mark 12:28 12:29-40', 40628, 40773);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22024, 2202, 4, 'Leviticus', 'LXX Leviticus 19:18+57 19:18-13', 'Mark', 'SBLGNT Mark 12:31+11 12:31-30', 60912, 31, 40936, 31);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22025, 2202, 5, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Romans', 'SBLGNT Romans 13:9+102 13:9', 60912, 31, 27293, 31, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22025, 2202, 5, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Romans', 'SBLGNT Romans 13:9+102 13:9', 60912, 31, 27293, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 5, 'εντολη', 'ανακεφαλαιουται εν τω'); -- εντολη = commandment, ανακεφαλαιουται εν τω = it is summed up in the
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 5, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22025, 'Romans', 'SBLGNT Romans 13:9+64 13:9-31', 27255, 27292);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22025, 2202, 5, 'Leviticus', 'LXX Leviticus 19:18+57 19:18-13', 'Romans', 'SBLGNT Romans 13:9+102 13:9', 60912, 31, 27293, 31);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22026, 2202, 6, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-12', 'Galatians', 'SBLGNT Galatians 5:14+35 5:15-58', 60912, 32, 8944, 32, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22026, 2202, 6, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Galatians', 'SBLGNT Galatians 5:14+35 5:14', 60912, 31, 8944, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 6, 'νομος', 'πεπληρωται εν τω'); -- νομος = Law, πεπληρωται εν τω = is fulfilled in this
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 6, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22026, 'Galatians', 'SBLGNT Galatians 5:14 5:14-31', 8909, 8943);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22026, 2202, 6, 'Leviticus', 'LXX Leviticus 19:18+57 19:18-13', 'Galatians', 'SBLGNT Galatians 5:14+35 5:14', 60912, 31, 8944, 31);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22027, 2202, 7, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-12', 'Matthew', 'SBLGNT Matthew 22:39+18 22:40-56', 60912, 32, 65856, 32, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22027, 2202, 7, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Matthew', 'SBLGNT Matthew 22:39+18 22:39', 60912, 31, 65856, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 7, 'εντολη ... εν τω νομω', 'αυτη εστιν ... δε ομοια αυτη'); -- εντολη ... εν τω νομω = commandment ... in the law, αυτη εστιν ... δε ομοια αυτη = this is ... also is like it
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 7, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22027, 'Matthew', 'SBLGNT Matthew 22:38 22:39-31', 65808, 65855);
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22027, 'Matthew', 'SBLGNT Matthew 22:36 22:37-78', 65687, 65729);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22027, 2202, 7, 'Leviticus', 'LXX Leviticus 19:18+57 19:18-13', 'Matthew', 'SBLGNT Matthew 22:39+18 22:39', 60912, 31, 65856, 31);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22028, 2202, 8, 'Leviticus', null, 'LXX Leviticus 19:18+54 19:18-13', 'Matthew', 'SBLGNT Matthew 19:19+25 19:19', 60909, 34, 55057, 34, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22028, 2202, 8, 'Leviticus', null, 'LXX Leviticus 19:18+57 19:18-13', 'Matthew', 'SBLGNT Matthew 19:19+28 19:19', 60912, 31, 55060, 31, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2202, 8, 'τας εντολας', 'και'); -- και = and
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2202, 8, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22028, 'Matthew', 'SBLGNT Matthew 19:19+25 19:19-31', 55057, 55059); -- kai
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22028, 'Matthew', 'SBLGNT Matthew 19:17+50 19:18-50', 54906, 54981); -- tas entolas
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22028, 2202, 8, 'Leviticus', 'LXX Leviticus 19:18+57 19:18-13', 'Matthew', 'SBLGNT Matthew 19:19+28 19:19', 60912, 31, 55060, 31);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22031, 2203, 1, 'Leviticus', null, 'LXX Leviticus 12:8+51 12:8-82', 'Luke', 'SBLGNT Luke 2:24+47 2:24', 33446, 33, 7845, 35, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2203, 1, 'εν τω νομω κυριου', 'το ειρημενον'); -- εν τω νομω κυριου = in the law of the Lord, το ειρημενον = that having been said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2203, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22031, 'Luke', 'SBLGNT Luke 2:24 2:24-35', 7798, 7844);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22031, 2203, 1, 'Leviticus', 'LXX Leviticus 12:8+51 12:8-82', 'Luke', 'SBLGNT Luke 2:24+47 2:24', 33446, 33, 7845, 35);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3011, 2204, 1, 'Leviticus', null, 'LXX Leviticus 26:11+53 26:12-44', 'II_Corinthians', 'SBLGNT II_Corinthians 6:16+95 6:16-40', 84290, 16, 9601, 16, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (3011, 2204, 1, 'Leviticus', null, 'LXX Leviticus 26:12 26:12-44', 'II_Corinthians', 'SBLGNT II_Corinthians 6:16+96 6:16-40', 84291, 15, 9602, 15, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2204, 1, 'θεος', 'καθως ειπεν'); -- καθως ειπεν = as has said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2204, 1, 'quotation', 'literal, far-fuzzy', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (3011, 2204, 1, 'Leviticus', 'LXX Leviticus 26:12 26:12-44', 'II_Corinthians', 'SBLGNT II_Corinthians 6:16+96 6:16-40', 84291, 15, 9602, 15);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22051, 2205, 1, 'Leviticus', null, 'LXX Leviticus 19:2+48 19:2-14', 'I_Peter', 'SBLGNT I_Peter 1:16+17 1:17-107', 59515, 23, 1440, 23, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22051, 2205, 1, 'Leviticus', null, 'LXX Leviticus 19:2+48 19:2-15', 'I_Peter', 'SBLGNT I_Peter 1:16+17 1:16', 59515, 22, 1440, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2205, 1, null, 'διοτι γεγραπται οτι'); -- διοτι γεγραπται οτι = because it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2205, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (22051, 'I_Peter', 'SBLGNT I_Peter 1:16 1:16-22', 1423, 1439);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (22051, 2205, 1, 'Leviticus', 'LXX Leviticus 19:2+48 19:2-15', 'I_Peter', 'SBLGNT I_Peter 1:16+17 1:16', 59515, 22, 1440, 22);
-- TODO: This may be a quotation, consider adding it fully (Matthew 5:33 can be eventually two quotations):
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (22061, 2206, 1, 'Leviticus', null, 'LXX Leviticus 19:12', 'Matthew', 'Matthew 5:33a', 0, 0, 0, 0, 'traditional');
-- TODO: Find this quotation, it seems Matthew 5:33 is not a literal quotation.

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (23011, 2301, 1, 'Numbers', null, 'LXX Numbers 16:5+73 16:5-75', 'II_Timothy', 'SBLGNT II_Timothy 2:19+65 2:19-43', 57258, 19, 2818, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (23011, 2301, 1, 'Numbers', null, 'LXX Numbers 16:5+66 16:5-78', 'II_Timothy', 'SBLGNT II_Timothy 2:19+57 2:19-46', 57251, 23, 2810, 24, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2301, 1, null, 'εχων την σφραγιδα ταυτην'); -- εχων την σφραγιδα ταυτην = having the seal this
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2301, 1, 'quotation', 'literal, synonym', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (23011, 'II_Timothy', 'SBLGNT II_Timothy 2:19 2:19-70', 2753, 2809);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (23011, 2301, 1, 'Numbers', 'LXX Numbers 16:5+66 16:5-78', 'II_Timothy', 'SBLGNT II_Timothy 2:19+57 2:19-46', 57251, 23, 2810, 24);
-- TODO: The last part of II_Timothy 2:19 seems a bit similar to Psalms 119:29. Check...

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24011, 2401, 1, 'Deuteronomy', null, 'LXX Deuteronomy 30:14+25 30:14-28', 'Romans', 'SBLGNT Romans 10:8+30 10:8-36', 94465, 30, 21069, 30, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24011, 2401, 1, 'Deuteronomy', null, 'LXX Deuteronomy 30:12+26 30:14-28', 'Romans', 'SBLGNT Romans 10:6+52 10:8-21', 94236, 259, 20926, 188, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2401, 1, 'Μωυσης', 'λεγει'); -- λεγει = says (Moses was already mentioned in Romans 10:5)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2401, 1, 'quotation', 'literal, subset, superset, far-fuzzy, change', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24011, 'Romans', 'SBLGNT Romans 10:6 10:6-72', 20874, 20905);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24011, 2401, 1, 'Deuteronomy', 'LXX Deuteronomy 30:12+26 30:12-47', 'Romans', 'SBLGNT Romans 10:6+52 10:6-26', 94236, 30, 20926, 26); -- τις αναβησεται ημιν εις τον ουρανον -> Τις αναβησεται εις τον ουρανον
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24011, 2401, 1, 'Deuteronomy', 'LXX Deuteronomy 30:13+30 30:13-94', 'Romans', 'SBLGNT Romans 10:7+1 10:7-57', 94343, 3, 20979, 3); -- τις
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24011, 2401, 1, 'Deuteronomy', 'LXX Deuteronomy 30:14 30:14-28', 'Romans', 'SBLGNT Romans 10:8+11 10:8-36', 94440, 55, 21050, 49); -- εστιν σου εγγυς το ρημα σφοδρα εν τω στοματι σου και εν τη καρδια σου -> Εγγυς σου το ρημα εστιν, εν τω στοματι σου και εν τη καρδια σου
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24021, 2402, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:21+58 32:21-44', 'Romans', 'SBLGNT Romans 10:19+41 10:19-40', 101516, 12, 21928, 12, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24021, 2402, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:21+75 32:21-6', 'Romans', 'SBLGNT Romans 10:19+56 10:19-4', 101533, 33, 21943, 33, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24021, 2402, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:21+56 32:21-6', 'Romans', 'SBLGNT Romans 10:19+41 10:19-4', 101514, 52, 21928, 48, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2402, 1, 'Μωυσης', 'λεγει'); -- λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2402, 1, 'quotation', 'literal, fuzzy, grammatical-change', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24021, 'Romans', 'SBLGNT Romans 10:19+23 10:19-53', 21910, 21926);
-- TODO: Consider adding the starting word εδωκεν. This is however quite frequent in LXX.
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24021, 2402, 1, 'Deuteronomy', 'LXX Deuteronomy 32:21+58 32:21-44', 'Romans', 'SBLGNT Romans 10:19+41 10:19-40', 101516, 12, 21928, 12);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24021, 2402, 1, 'Deuteronomy', 'LXX Deuteronomy 32:21+75 32:21-6', 'Romans', 'SBLGNT Romans 10:19+56 10:19-4', 101533, 33, 21943, 33);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1121, 2403, 1, 'Deuteronomy', null, 'LXX Deuteronomy 29:4+53 29:4-25', 'Romans', 'SBLGNT Romans 11:8+61 11:8-31', 89881, 13, 22764, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1121, 2403, 1, 'Deuteronomy', null, 'LXX Deuteronomy 29:4+66 29:4-12', 'Romans', 'SBLGNT Romans 11:8+79 11:8-13', 89894, 13, 22782, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (1121, 2403, 1, 'Deuteronomy', null, 'LXX Deuteronomy 29:4+6 29:4-6', 'Romans', 'SBLGNT Romans 11:8+14 11:8', 89834, 79, 22717, 91, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2403, 1, null, 'καθως γεγραπται'); -- καθως γεγραπται = as it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2403, 1, 'quotation', 'literal, fuzzy, subset, superset', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1121, 2403, 1, 'Deuteronomy', 'LXX Deuteronomy 29:4+6 29:4-79', 'Romans', 'SBLGNT Romans 11:8+14 11:8-85', 89834, 6, 22717, 6); -- εδωκεν
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1121, 2403, 1, 'Deuteronomy', 'LXX Deuteronomy 29:4+18 29:4-68', 'Romans', 'SBLGNT Romans 11:8+26 11:8-74', 89846, 5, 22729, 5); -- ο θεος
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1121, 2403, 1, 'Deuteronomy', 'LXX Deuteronomy 29:4+53 29:4-25', 'Romans', 'SBLGNT Romans 11:8+61 11:8-31', 89881, 13, 22764, 13); -- βλεπειν και ωτα
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1121, 2403, 1, 'Deuteronomy', 'LXX Deuteronomy 29:4+66 29:4-12', 'Romans', 'SBLGNT Romans 11:8+79 11:8-13', 89894, 13, 22782, 13); -- ακουειν εως της
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1121, 2403, 1, 'Deuteronomy', 'LXX Deuteronomy 29:4+79 29:4-6', 'Romans', 'SBLGNT Romans 11:8+99 11:8', 89907, 6, 22802, 6); -- ημερας
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (1121, 2403, 1, 'Deuteronomy', 'LXX Deuteronomy 29:4+44 29:4-38', 'Romans', 'SBLGNT Romans 11:8+47 11:8-49', 89872, 9, 22750, 9); -- οφθαλμους
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24041, 2404, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:35', 'Romans', 'Romans 12:19', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24041, 2404, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:35+7 32:35-73', 'Romans', 'SBLGNT Romans 12:19+63 12:19-11', 102578, 20, 26274, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2404, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2404, 1, 'quotation', 'fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24041, 'Romans', 'SBLGNT Romans 12:19 12:19-37', 26211, 26269);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24041, 2404, 1, 'Deuteronomy', 'LXX Deuteronomy 32:35+7 32:35-83', 'Romans', 'SBLGNT Romans 12:19+63 12:19-24', 102578, 10, 26274, 9); -- εκδικησεως -> εκδικησις
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24041, 2404, 1, 'Deuteronomy', 'LXX Deuteronomy 32:35+17 32:35-73', 'Romans', 'SBLGNT Romans 12:19+75 12:19-11', 102588, 10, 26286, 10); -- ανταποδωσω
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24042, 2404, 2, 'Deuteronomy', null, 'LXX Deuteronomy 32:35-36', 'Hebrews', 'Hebrews 10:30', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24042, 2404, 2, 'Deuteronomy', null, 'LXX Deuteronomy 32:35+7 32:36-102', 'Hebrews', 'SBLGNT Hebrews 10:30+24 10:30', 102578, 120, 17522, 54, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2404, 2, 'τον', 'ειποντα ... και παλιν'); -- τον = the One, ειποντα = having said, και παλιν = and again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2404, 2, 'quotation', 'fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24042, 'Hebrews', 'SBLGNT Hebrews 10:30 10:30-58', 17498, 17517);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24042, 2404, 2, 'Deuteronomy', 'LXX Deuteronomy 32:35+7 32:35-83', 'Hebrews', 'SBLGNT Hebrews 10:30+24 10:30-45', 102578, 10, 17522, 9); -- εκδικησεως -> εκδικησις
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24042, 2404, 2, 'Deuteronomy', 'LXX Deuteronomy 32:35+17 32:35-73', 'Hebrews', 'SBLGNT Hebrews 10:30+36 10:30-32', 102588, 10, 17534, 10); -- ανταποδωσω
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24042, 'Hebrews', 'SBLGNT Hebrews 10:30+46 10:30-24', 17544, 17551); -- και παλιν
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24042, 2404, 2, 'Deuteronomy', 'LXX Deuteronomy 32:36+3 32:36-102', 'Hebrews', 'SBLGNT Hebrews 10:30+54 10:30', 102674, 24, 17552, 24);
-- There is a literal match for the last clasp in Psalms 135:14 too.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24051, 2405, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:43+60 32:43-169', 'Romans', 'SBLGNT Romans 15:10+13 15:11-65', 103458, 33, 30227, 33, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24051, 2405, 1, 'Deuteronomy', null, 'LXX Deuteronomy 32:43+60 32:43-172', 'Romans', 'SBLGNT Romans 15:10+13 15:10', 103458, 30, 30227, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2405, 1, null, 'λεγει'); -- λεγει = it says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2405, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24051, 'Romans', 'SBLGNT Romans 15:10 15:10-30', 30214, 30226);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24051, 2405, 1, 'Deuteronomy', 'LXX Deuteronomy 32:43+60 32:43-172', 'Romans', 'SBLGNT Romans 15:10+13 15:10', 103458, 30, 30227, 30);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24052, 2405, 2, 'Deuteronomy', null, 'LXX Deuteronomy 32:43+24 32:43-210', 'Hebrews', 'SBLGNT Hebrews 1:6+53 1:6-11', 103422, 28, 570, 28, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24052, 2405, 2, 'Deuteronomy', null, 'LXX Deuteronomy 32:43+99 32:43-135', 'Hebrews', 'SBLGNT Hebrews 1:6+64 1:6', 103497, 28, 581, 28, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24052, 2405, 2, 'Deuteronomy', null, 'LXX Deuteronomy 32:43+24 32:43-135', 'Hebrews', 'SBLGNT Hebrews 1:6+53 1:6', 103422, 103, 570, 39, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2405, 2, null, 'λεγει'); -- λεγει = it says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2405, 2, 'quotation', 'literal, far-fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24052, 'Hebrews', 'SBLGNT Hebrews 1:6 1:6-39', 517, 569);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24052, 2405, 2, 'Deuteronomy', 'LXX Deuteronomy 32:43+24 32:43-210', 'Hebrews', 'SBLGNT Hebrews 1:6+53 1:6-11', 103422, 28, 570, 28); -- και προσκυνησατωσαν αυτω παντες
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24052, 2405, 2, 'Deuteronomy', 'LXX Deuteronomy 32:43+106 32:43-135', 'Hebrews', 'SBLGNT Hebrews 1:6+71 1:6', 103504, 21, 588, 21); -- ...αυτω παντες αγγελοι θεου
-- The importance and the way of citing seems here not so mandatory. TODO: Check, at the moment this is NOT considered a valid quotation.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24061, 2406, 1, 'Deuteronomy', null, 'LXX Deuteronomy 24:1+100 24:1-60', 'Mark', 'SBLGNT Mark 10:4+24 10:4-11', 72306, 27, 31468, 23, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2406, 1, 'Μωυσης', 'εγραψεν'); -- εγραψεν = he wrote
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2406, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
-- This one is similar. The exact match is present also in Mark 10:4 (βιβλιον αποστασιου). TODO: Check, at the moment this is NOT considered a valid quotation.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24062, 2406, 2, 'Deuteronomy', null, 'LXX Deuteronomy 24:1+110 24:1-60', 'Matthew', 'SBLGNT Matthew 19:7+39 19:7-16', 72316, 17, 53994, 17, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2406, 2, 'Μωυσης', 'ενετειλατο'); -- ενετειλατο = did command
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2406, 2, 'quotation', 'literal, exact', 'Z.K.');
-- This one is not literally cited, but logically it should be a quotation. TODO: Check.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24063, 2406, 3, 'Deuteronomy', null, 'LXX Deuteronomy 24:1+117 24:1-52', 'Matthew', 'SBLGNT Matthew 5:31+34 5:31', 72323, 18, 10880, 18, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2406, 3, null, 'Ερρεθη'); -- Ερρεθη = it was said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2406, 3, 'quotation', 'far-fuzzy', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24071, 2407, 1, 'Deuteronomy', null, 'LXX Deuteronomy 25:4+4 25:4', 'I_Corinthians', 'SBLGNT I_Corinthians 9:9+31 9:9-19', 75102, 17, 14457, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24071, 2407, 1, 'Deuteronomy', null, 'LXX Deuteronomy 25:4', 'I_Corinthians', 'SBLGNT I_Corinthians 9:9+27 9:9-19', 75098, 21, 14453, 21, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2407, 1, 'εν ... τω Μωυσεως νομω ', 'γαρ ... γεγραπται'); -- εν γαρ τω Μωυσεως νομω γεγραπται = in for the of Moses law it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2407, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24071, 'I_Corinthians', 'SBLGNT I_Corinthians 9:9 9:9-40', 14426, 14452);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24071, 2407, 1, 'Deuteronomy', 'LXX Deuteronomy 25:4', 'I_Corinthians', 'SBLGNT I_Corinthians 9:9+27 9:9-19', 75098, 21, 14453, 21);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24072, 2407, 2, 'Deuteronomy', null, 'LXX Deuteronomy 25:4 25:4-11', 'I_Timothy', 'SBLGNT I_Timothy 5:18+25 5:18-30', 75098, 10, 6303, 10, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24072, 2407, 2, 'Deuteronomy', null, 'LXX Deuteronomy 25:4+10 25:4', 'I_Timothy', 'SBLGNT I_Timothy 5:18+14 5:18-40', 75108, 11, 6292, 11, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24072, 2407, 2, 'Deuteronomy', null, 'LXX Deuteronomy 25:4', 'I_Timothy', 'SBLGNT I_Timothy 5:18+14 5:18-30', 75098, 21, 6292, 21, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2407, 2, 'η γραφη', 'λεγει γαρ'); -- η γραφη = the Scripture, λεγει γαρ = says for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2407, 2, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24072, 'I_Timothy', 'SBLGNT I_Timothy 5:18 5:18-51', 6278, 6291);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24072, 2407, 2, 'Deuteronomy', 'LXX Deuteronomy 25:4', 'I_Timothy', 'SBLGNT I_Timothy 5:18+14 5:18-30', 75098, 21, 6292, 21);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24081, 2408, 1, 'Deuteronomy', null, 'LXX Deuteronomy 6:16 6:16-33', 'Luke', 'SBLGNT Luke 4:12+39 4:12', 23212, 30, 13914, 30, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24081, 2408, 1, 'Deuteronomy', null, 'LXX Deuteronomy 6:16 6:16-33', 'Luke', 'SBLGNT Luke 4:12+39 4:12', 23212, 30, 13914, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2408, 1, null, 'Ειρηται'); -- Ειρηται = it has been said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2408, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24081, 'Luke', 'SBLGNT Luke 4:12 4:12-30', 13875, 13913);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24081, 2408, 1, 'Deuteronomy', 'LXX Deuteronomy 6:16 6:16-33', 'Luke', 'SBLGNT Luke 4:12+39 4:12', 23212, 30, 13914, 30);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24082, 2408, 2, 'Deuteronomy', null, 'LXX Deuteronomy 6:16 6:16-33', 'Matthew', 'SBLGNT Matthew 4:7+28 4:7', 23212, 30, 6686, 30, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24082, 2408, 2, 'Deuteronomy', null, 'LXX Deuteronomy 6:16 6:16-33', 'Matthew', 'SBLGNT Matthew 4:7+28 4:7', 23212, 30, 6686, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2408, 2, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2408, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24082, 'Matthew', 'SBLGNT Matthew 4:7 4:7-30', 6658, 6685);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24082, 2408, 2, 'Deuteronomy', 'LXX Deuteronomy 6:16 6:16-33', 'Matthew', 'SBLGNT Matthew 4:7+28 4:7', 23212, 30, 6686, 30);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24091, 2409, 1, 'Deuteronomy', null, 'LXX Deuteronomy 8:3+140 8:3-16', 'Matthew', 'SBLGNT Matthew 4:4+73 4:4', 27931, 27, 6402, 27, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24091, 2409, 1, 'Deuteronomy', null, 'LXX Deuteronomy 8:3+91 8:3-45', 'Matthew', 'SBLGNT Matthew 4:4+26 4:4-27', 27882, 47, 6355, 47, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24091, 2409, 1, 'Deuteronomy', null, 'LXX Deuteronomy 8:3+92 8:3-16', 'Matthew', 'SBLGNT Matthew 4:4+27 4:4', 27883, 75, 6356, 73, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2409, 1, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2409, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24091, 'Matthew', 'SBLGNT Matthew 4:4 4:4-73', 6329, 6355);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24091, 2409, 1, 'Deuteronomy', 'LXX Deuteronomy 8:3+92 8:3-16', 'Matthew', 'SBLGNT Matthew 4:4+27 4:4', 27883, 75, 6356, 73);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24092, 2409, 2, 'Deuteronomy', null, 'LXX Deuteronomy 8:3+88 8:3-62', 'Luke', 'SBLGNT Luke 4:4+35 4:4', 27879, 33, 13306, 33, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24092, 2409, 2, 'Deuteronomy', null, 'LXX Deuteronomy 8:3+92 8:3-62', 'Luke', 'SBLGNT Luke 4:4+39 4:4', 27883, 29, 13310, 29, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2409, 2, null, 'γεγραπται οτι'); -- γεγραπται οτι = it has been written (the word "οτι" also appears in LXX)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2409, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24092, 'Luke', 'SBLGNT Luke 4:4 4:4-29', 13271, 13309);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24092, 2409, 2, 'Deuteronomy', 'LXX Deuteronomy 8:3+92 8:3-62', 'Luke', 'SBLGNT Luke 4:4+39 4:4', 27883, 29, 13310, 29);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24101, 2410, 1, 'Deuteronomy', null, 'LXX Deuteronomy 6:13 6:13-41', 'Matthew', 'SBLGNT Matthew 4:10+43 4:10', 22967, 41, 6916, 49, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2410, 1, null, 'γεγραπται γαρ'); -- γεγραπται γαρ = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2410, 1, 'quotation', 'literal, changed, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24101, 'Matthew', 'SBLGNT Matthew 4:10 4:10-49', 6873, 6915);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24101, 2410, 1, 'Deuteronomy', 'LXX Deuteronomy 6:13 6:13-66', 'Matthew', 'SBLGNT Matthew 4:10+43 4:10-33', 22967, 16, 6916, 16); -- Κυριον τον θεον σου
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24101, 2410, 1, 'Deuteronomy', 'LXX Deuteronomy 6:13+24 6:13-51', 'Matthew', 'SBLGNT Matthew 4:10+71 4:10-14', 22991, 7, 6944, 7); -- και αυτω
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24101, 2410, 1, 'Deuteronomy', 'LXX Deuteronomy 6:13+31 6:13-41', 'Matthew', 'SBLGNT Matthew 4:10+82 4:10', 22998, 10, 6955, 10); -- λατρευσεις
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24102, 2410, 2, 'Deuteronomy', null, 'LXX Deuteronomy 6:13 6:13-41', 'Luke', 'SBLGNT Luke 4:8+38 4:8', 22967, 41, 13596, 49, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2410, 2, null, 'γεγραπται'); -- γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2410, 2, 'quotation', 'literal, changed, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24102, 'Luke', 'SBLGNT Luke 4:8 4:8-49', 13558, 13595);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24102, 2410, 2, 'Deuteronomy', 'LXX Deuteronomy 6:13 6:13-66', 'Luke', 'SBLGNT Luke 4:8+38 4:8-33', 22967, 16, 13596, 16); -- Κυριον τον θεον σου
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24102, 2410, 2, 'Deuteronomy', 'LXX Deuteronomy 6:13+24 6:13-51', 'Luke', 'SBLGNT Luke 4:8+66 4:8-14', 22991, 7, 13624, 7); -- και αυτω
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24102, 2410, 2, 'Deuteronomy', 'LXX Deuteronomy 6:13+31 6:13-41', 'Luke', 'SBLGNT Luke 4:8+77 4:8', 22998, 10, 13635, 10); -- λατρευσεις
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24111, 2411, 1, 'Deuteronomy', null, 'LXX Deuteronomy 27:26+22 27:26-72', 'Galatians', 'SBLGNT Galatians 3:10+68 3:10-53', 81686, 13, 4404, 13, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24111, 2411, 1, 'Deuteronomy', null, 'LXX Deuteronomy 27:26 27:26-92', 'Galatians', 'SBLGNT Galatians 3:10+54 3:10-65', 81664, 15, 4390, 15, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24111, 2411, 1, 'Deuteronomy', null, 'LXX Deuteronomy 27:26 27:26-28', 'Galatians', 'SBLGNT Galatians 3:10+54 3:10-1', 81664, 79, 4390, 79, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2411, 1, null, 'γεγραπται γαρ οτι'); -- γεγραπται γαρ οτι = it has been written for
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2411, 1, 'quotation', 'literal, grammatical-change, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24111, 'Galatians', 'SBLGNT Galatians 3:10 3:10-80', 4336, 4389);
-- FIXME: This could be done better in more clasps:
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24111, 2411, 1, 'Deuteronomy', 'LXX Deuteronomy 27:26 27:26-92', 'Galatians', 'SBLGNT Galatians 3:10+54 3:10-65', 81664, 15, 4390, 15); -- Επικαταρατος πας
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24111, 2411, 1, 'Deuteronomy', 'LXX Deuteronomy 27:26+23 27:26-61', 'Galatians', 'SBLGNT Galatians 3:10+69 3:10-44', 81687, 23, 4405, 21); -- ος ουκ εμμενει εν πασιν τοις -> ος ουκ εμμενει εν πασιν τοις
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24111, 2411, 1, 'Deuteronomy', 'LXX Deuteronomy 27:26+52 27:26-25', 'Galatians', 'SBLGNT Galatians 3:10+112 3:10', 81716, 30, 4448, 22); -- του νομου τουτου του ποιησαι αυτους -> του νομου του ποιησαι αυτα
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24121, 2412, 1, 'Deuteronomy', null, 'LXX Deuteronomy 21:23+100 21:23-52', 'Galatians', 'SBLGNT Galatians 3:13+92 3:13', 66388, 18, 4685, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24121, 2412, 1, 'Deuteronomy', null, 'LXX Deuteronomy 21:23+97 21:23-52', 'Galatians', 'SBLGNT Galatians 3:13+88 3:13', 66385, 21, 4681, 22, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2412, 1, null, 'οτι γεγραπται'); -- οτι γεγραπται = it has been written
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2412, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24121, 'Galatians', 'SBLGNT Galatians 3:13 3:13-34', 4593, 4668);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24121, 2412, 1, 'Deuteronomy', 'LXX Deuteronomy 21:23+97 21:23-52', 'Galatians', 'SBLGNT Galatians 3:13+88 3:13', 66385, 21, 4681, 22);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24131, 2413, 1, 'Deuteronomy', null, 'LXX Deuteronomy 9:19+3 9:19-102', 'Hebrews', 'SBLGNT Hebrews 12:21+41 12:21-11', 32201, 11, 23651, 11, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24131, 2413, 1, 'Deuteronomy', null, 'LXX Deuteronomy 9:19+3 9:19-102', 'Hebrews', 'SBLGNT Hebrews 12:21+41 12:21-11', 32201, 11, 23651, 11, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2413, 1, 'Μωυσης', 'ειπεν'); -- ειπεν = said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2413, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24131, 'Hebrews', 'SBLGNT Hebrews 12:21 12:21-22', 23610, 23650);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24131, 2413, 1, 'Deuteronomy', 'LXX Deuteronomy 9:19+3 9:19-102', 'Hebrews', 'SBLGNT Hebrews 12:21+41 12:21-11', 32201, 11, 23651, 11);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24141, 2414, 1, 'Deuteronomy', null, 'LXX Deuteronomy 31:6+104 31:6-19', 'Hebrews', 'SBLGNT Hebrews 13:5+54 13:5-20', 96097, 9, 24631, 9, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24141, 2414, 1, 'Deuteronomy', null, 'LXX Deuteronomy 31:6+105 31:6', 'Hebrews', 'SBLGNT Hebrews 13:5+55 13:5', 96098, 27, 24632, 28, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2414, 1, null, 'αυτος γαρ ειρηκεν'); -- αυτος γαρ ειρηκεν = He Himself for has said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2414, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24141, 'Hebrews', 'SBLGNT Hebrews 13:5 13:5-28', 24577, 24631);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24141, 2414, 1, 'Deuteronomy', 'LXX Deuteronomy 31:6+105 31:6', 'Hebrews', 'SBLGNT Hebrews 13:5+55 13:5', 96098, 27, 24632, 28);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 2415, 1, 'Deuteronomy', null, 'LXX Deuteronomy 19:15+105 19:15-41', 'II_Corinthians', 'SBLGNT II_Corinthians 13:1+26 13:1-22', 60565, 25, 21162, 25, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 2415, 1, 'Deuteronomy', null, 'LXX Deuteronomy 19:15+152 19:15', 'II_Corinthians', 'SBLGNT II_Corinthians 13:1+54 13:1', 60612, 19, 21190, 19, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (null, 2415, 1, 'Deuteronomy', null, 'LXX Deuteronomy 19:15+105 19:15', 'II_Corinthians', 'SBLGNT II_Corinthians 13:1+26 13:1', 60565, 66, 21162, 47, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2415, 1, null, null);
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2415, 1, 'strong allusion', 'literal, fuzzy, superset', 'Z.K.');
-- Also, I_Timothy 5:19 is very similar.
-- TODO: Add full entry. This seems to be a quotation (far-fuzzy):
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24161, 2416, 1, 'Deuteronomy', null, 'LXX Deuteronomy 25:5', 'Matthew', 'SBLGNT Matthew 22:24', null, null, null, null, 'traditional');
-- TODO: Add full entry. This seems to be a quotation (far-fuzzy):
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24162, 2416, 2, 'Deuteronomy', null, 'LXX Deuteronomy 25:5', 'Mark', 'SBLGNT Mark 12:19', null, null, null, null, 'traditional');
-- TODO: Add full entry. This seems to be a quotation (far-fuzzy):
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24163, 2416, 3, 'Deuteronomy', null, 'LXX Deuteronomy 25:5', 'Luke', 'SBLGNT Luke 20:28', null, null, null, null, 'traditional');
-- In fact, these are closer to a kind of storytelling/summarizing than quoting. TODO: Decide how to classify such types.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24171, 2417, 1, 'Deuteronomy', null, 'LXX Deuteronomy 6:5+3 6:5-61', 'Matthew', 'SBLGNT Matthew 22:37+10 22:37-52', 22214, 26, 65730, 26, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24171, 2417, 1, 'Deuteronomy', null, 'LXX Deuteronomy 6:5+3 6:5', 'Matthew', 'SBLGNT Matthew 22:37+10 22:37', 22214, 87, 65730, 78, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2417, 1, 'ποια εντολη μεγαλη εν τω νομω', null); -- ποια εντολη μεγαλη εν τω νομω = which is the greatest commandment in the law
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2417, 1, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24171, 'Matthew', 'SBLGNT Matthew 22:36 22:37-78', 65687, 65729);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24171, 2417, 1, 'Deuteronomy', 'LXX Deuteronomy 6:5+3 6:5-11', 'Matthew', 'SBLGNT Matthew 22:37+10 22:37-10', 22214, 76, 65730, 68);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24171, 2417, 1, 'Deuteronomy', 'LXX Deuteronomy 6:5+87 6:5', 'Matthew', 'SBLGNT Matthew 22:37+85 22:37', 22298, 3, 65805, 3); -- σου
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24172, 2417, 2, 'Deuteronomy', null, 'LXX Deuteronomy 6:5+3 6:5-39', 'Luke', 'SBLGNT Luke 10:27+18 10:27-76', 22214, 48, 43043, 48, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24172, 2417, 2, 'Deuteronomy', null, 'LXX Deuteronomy 6:5+3 6:5-23', 'Luke', 'SBLGNT Luke 10:27+18 10:27-63', 22214, 64, 43043, 61, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2417, 2, 'Εν τω νομω', 'τι γεγραπται; πως αναγινωσκεις'); -- Εν τω νομω = in the law, τι γεγραπται; πως αναγινωσκεις = what has been written; how read you
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2417, 2, 'quotation', 'literal, fuzzy, subset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24172, 'Luke', 'SBLGNT Luke 10:26 10:27-124', 42974, 43042);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24172, 2417, 2, 'Deuteronomy', 'LXX Deuteronomy 6:5+3 6:5-23', 'Luke', 'SBLGNT Luke 10:27+18 10:27-63', 22214, 64, 43043, 61);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24173, 2417, 3, 'Deuteronomy', null, 'LXX Deuteronomy 6:4+103 6:5-10', 'Mark', 'SBLGNT Mark 12:29+28 12:30-31', 22171, 120, 40774, 120, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24173, 2417, 3, 'Deuteronomy', null, 'LXX Deuteronomy 6:4+103 6:5', 'Mark', 'SBLGNT Mark 12:29+28 12:30-21', 22171, 130, 40774, 130, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2417, 3, 'Ποια εστιν εντολη πρωτη παντων', null); -- Ποια εστιν εντολη πρωτη παντων = which is commandment the first of all
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2417, 3, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24173, 'Mark', 'SBLGNT Mark 12:28 12:29-40', 40628, 40773);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24173, 2417, 3, 'Deuteronomy', 'LXX Deuteronomy 6:4+103 6:5-11', 'Mark', 'SBLGNT Mark 12:29+28 12:30-32', 22171, 119, 40774, 119);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24173, 2417, 3, 'Deuteronomy', 'LXX Deuteronomy 6:5+87 6:5', 'Mark', 'SBLGNT Mark 12:30+87 12:30-21', 22298, 3, 40901, 3); -- σου
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24181, 2418, 1, 'Deuteronomy', null, 'LXX Deuteronomy 4:35+38 4:35-12', 'Mark', 'SBLGNT Mark 12:32+57 12:32-14', 16688, 17, 41054, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24181, 2418, 1, 'Deuteronomy', null, 'LXX Deuteronomy 4:35+39 4:35', 'Mark', 'SBLGNT Mark 12:32+58 12:32', 16689, 28, 41055, 30, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2418, 1, 'επʼ αληθειας', 'ειπες οτι'); -- επʼ αληθειας = according to truth, ειπες οτι = you have spoken that
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2418, 1, 'quotation', 'literal, fuzzy, synonym', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24181, 'Mark', 'SBLGNT Mark 12:32 12:32-33', 40997, 41051);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24181, 2418, 1, 'Deuteronomy', 'LXX Deuteronomy 4:35+39 4:35-12', 'Mark', 'SBLGNT Mark 12:32+58 12:32-14', 16689, 16, 41055, 16); -- εστιν και ουκ εστιν
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24181, 2418, 1, 'Deuteronomy', 'LXX Deuteronomy 4:35+58 4:35', 'Mark', 'SBLGNT Mark 12:32+79 12:32', 16708, 9, 41076, 9); -- πλην αυτου
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24191, 2419, 1, 'Deuteronomy', null, 'LXX Deuteronomy 18:18 18:18-28', 'Acts', 'SBLGNT Acts 3:22+17 3:22-8', 58142, 88, 8827, 87, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2419, 1, 'Μωυσης', 'ειπεν οτι'); -- ειπεν οτι = said that
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2419, 1, 'quotation', 'far-fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24191, 'Acts', 'SBLGNT Acts 3:22 3:22-95', 8810, 8826);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24191, 2419, 1, 'Deuteronomy', 'LXX Deuteronomy 18:18 18:18-108', 'Acts', 'SBLGNT Acts 3:22+17 3:22-87', 58142, 8, 8827, 8); -- Προφητην
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24191, 2419, 1, 'Deuteronomy', 'LXX Deuteronomy 18:18+8 18:18-100', 'Acts', 'SBLGNT Acts 3:22+29 3:22-74', 58150, 8, 8839, 9); -- αναστησω -> αναστησει
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24191, 2419, 1, 'Deuteronomy', 'LXX Deuteronomy 18:18+22 18:18-82', 'Acts', 'SBLGNT Acts 3:22+49 3:22-51', 58164, 12, 8859, 12); -- εκ των αδελφων
-- TODO: The word λαλησ... occurs also, but it is very frequent. Consider adding it.
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24201, 2420, 1, 'Deuteronomy', null, 'LXX Deuteronomy 18:15 18:15-31', 'Acts', 'SBLGNT Acts 7:37+38 7:37', 57869, 37, 21525, 47, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2420, 1, 'Μωυσης', 'ειπας'); -- ειπας = having said
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2420, 1, 'quotation', 'literal, fuzzy, subset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24201, 'Acts', 'SBLGNT Acts 7:37 7:37-47', 21487, 21524);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24201, 2420, 1, 'Deuteronomy', 'LXX Deuteronomy 18:15 18:15-60', 'Acts', 'SBLGNT Acts 7:37+38 7:37-39', 57869, 8, 21525, 8); -- προφητην
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24201, 2420, 1, 'Deuteronomy', 'LXX Deuteronomy 18:15+28 18:15-31', 'Acts', 'SBLGNT Acts 7:37+50 7:37-26', 57897, 9, 21537, 9); -- αναστησει
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24201, 2420, 1, 'Deuteronomy', 'LXX Deuteronomy 18:15+8 18:15-48', 'Acts', 'SBLGNT Acts 7:37+64 7:37-9', 57877, 12, 21551, 12); -- εκ των αδελφων
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24201, 2420, 1, 'Deuteronomy', 'LXX Deuteronomy 18:15+23 18:15-40', 'Acts', 'SBLGNT Acts 7:37+80 7:37', 57892, 5, 21567, 5); -- ως εμε
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24211, 2421, 1, 'Deuteronomy', null, 'LXX Deuteronomy 19:15+105 19:15-44', 'Matthew', 'SBLGNT Matthew 18:16+41 18:16-18', 60565, 22, 51782, 22, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24211, 2421, 1, 'Deuteronomy', null, 'LXX Deuteronomy 19:15+105 19:15', 'Matthew', 'SBLGNT Matthew 18:16+41 18:16', 60565, 66, 51782, 40, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2421, 1, '', 'ινα'); -- ινα = that
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2421, 1, 'quotation', 'literal, fuzzy, superset', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (24211, 'Matthew', 'SBLGNT Matthew 18:16+38 18:16-40', 51779, 51781);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24211, 2421, 1, 'Deuteronomy', 'LXX Deuteronomy 19:15+105 19:15', 'Matthew', 'SBLGNT Matthew 18:16+41 18:16', 60565, 66, 51782, 40);
-- TODO: The same passage is quoted in II_Corinthians 13:1, but without any introduction. This is something exceptional... Add it (or not).

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24173, 2501, 1, 'Joshua', null, 'LXX Joshua 22:5+197 22:5-25', 'Mark', 'SBLGNT Mark 12:30+70 12:30-24', 60942, 17, 40884, 17, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24173, 2501, 1, 'Joshua', null, 'LXX Joshua 22:5+197 22:5-25', 'Mark', 'SBLGNT Mark 12:30+70 12:30-24', 60942, 17, 40884, 17, 'manual');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24173, 2501, 1, 'Joshua', 'LXX Joshua 22:5+197 22:5-25', 'Mark', 'SBLGNT Mark 12:30+70 12:30-24', 60942, 17, 40884, 17);
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2501, 1, 'ποια εντολη μεγαλη εν τω νομω', null); -- ποια εντολη μεγαλη εν τω νομω = which is the greatest commandment in the law (see 2417,3)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2501, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24171, 2501, 2, 'Joshua', null, 'LXX Joshua 22:5+197 22:5-25', 'Matthew', 'SBLGNT Matthew 22:37+71 22:37-3', 60942, 17, 65791, 14, 'manual');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24171, 2501, 2, 'Joshua', 'LXX Joshua 22:5+197 22:5-25', 'Matthew', 'SBLGNT Matthew 22:37+71 22:37-3', 60942, 17, 65791, 14);
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2501, 2, 'ποια εντολη μεγαλη εν τω νομω', null); -- ποια εντολη μεγαλη εν τω νομω = which is the greatest commandment in the law (see 2417,1)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2501, 2, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (24172, 2501, 3, 'Joshua', null, 'LXX Joshua 22:5+197 22:5-25', 'Luke', 'SBLGNT Luke 10:27+100 10:27-28', 60942, 17, 43125, 14, 'manual');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (24172, 2501, 3, 'Joshua', 'LXX Joshua 22:5+197 22:5-25', 'Luke', 'SBLGNT Luke 10:27+100 10:27-28', 60942, 17, 43125, 14);
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (2501, 3, 'Εν τω νομω', 'τι γεγραπται; πως αναγινωσκεις'); -- Εν τω νομω = in the law, τι γεγραπται; πως αναγινωσκεις = what has been written; how read you (see 2417,2)
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (2501, 3, 'quotation', 'literal, fuzzy', 'Z.K.');

-- TODO: Add this as a quotation (if it is indeed from Job, the matching text is "σοφους εν τη", "wise in the"):
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (30011, 3001, 1, 'Job', null, 'Job 5:12-13', 'I_Corinthians', 'I_Corinthians 3:19', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (30011, 3001, 1, 'Job', null, 'LXX Job 5:13+13 5:13-35', 'I_Corinthians', 'SBLGNT I_Corinthians 3:19+71 3:19-14', 8399, 10, 5062, 10, 'getrefs');

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31011, 3101, 1, 'Proverbs', null, 'LXX Proverbs 25:21 25:21-28', 'Romans', 'SBLGNT Romans 12:20+4 12:20-82', 47241, 18, 26311, 18, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31011, 3101, 1, 'Proverbs', null, 'LXX Proverbs 25:21+22 25:22-28', 'Romans', 'SBLGNT Romans 12:20+27 12:20', 47263, 77, 26334, 77, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31011, 3101, 1, 'Proverbs', null, 'LXX Proverbs 25:21 25:22-28', 'Romans', 'SBLGNT Romans 12:20+4 12:20', 47241, 99, 26311, 100, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3101, 1, null, 'αλλα'); -- αλλα = on the contrary
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3101, 1, 'quotation', 'literal, fuzzy, synonym', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (31011, 'Romans', 'SBLGNT Romans 12:20 12:20-100', 26307, 26310);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (31011, 3101, 1, 'Proverbs', 'LXX Proverbs 25:21 25:22-28', 'Romans', 'SBLGNT Romans 12:20+4 12:20', 47241, 99, 26311, 100);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31021, 3102, 1, 'Proverbs', null, 'LXX Proverbs 3:11+3 3:12', 'Hebrews', 'SBLGNT Hebrews 12:5+57 12:6', 4276, 108, 22341, 108, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31021, 3102, 1, 'Proverbs', null, 'LXX Proverbs 3:11 3:12', 'Hebrews', 'SBLGNT Hebrews 12:5+51 12:6', 4273, 111, 22335, 114, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3102, 1, null, 'παρακλησεως'); -- παρακλησεως = exhortation
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3102, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (31021, 'Hebrews', 'SBLGNT Hebrews 12:5 12:5-58', 22284, 22334);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (31021, 3102, 1, 'Proverbs', 'LXX Proverbs 3:11 3:12', 'Hebrews', 'SBLGNT Hebrews 12:5+51 12:6', 4273, 111, 22335, 114);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31031, 3103, 1, 'Proverbs', null, 'LXX Proverbs 3:34+4 3:34', 'James', 'SBLGNT James 4:6+32 4:6', 5754, 48, 6153, 48, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31031, 3103, 1, 'Proverbs', null, 'LXX Proverbs 3:34', 'James', 'SBLGNT James 4:6+30 4:6', 5750, 52, 6151, 50, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3103, 1, null, 'διο λεγει'); -- διο λεγει = therefore it says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3103, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (31031, 'James', 'SBLGNT James 4:6 4:6-50', 6121, 6150);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (31031, 3103, 1, 'Proverbs', 'LXX Proverbs 3:34', 'James', 'SBLGNT James 4:6+30 4:6', 5750, 52, 6151, 50);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31032, 3103, 2, 'Proverbs', null, 'LXX Proverbs 3:34+4 3:34', 'I_Peter', 'SBLGNT I_Peter 5:5+87 5:5', 5754, 48, 8331, 48, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31032, 3103, 2, 'Proverbs', null, 'LXX Proverbs 3:34', 'I_Peter', 'SBLGNT I_Peter 5:5+85 5:5', 5750, 52, 8329, 50, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3103, 2, null, 'οτι'); -- οτι = because
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3103, 2, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (31032, 'I_Peter', 'SBLGNT I_Peter 5:5+35 5:5-50', 8279, 8328);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (31032, 3103, 2, 'Proverbs', 'LXX Proverbs 3:34', 'I_Peter', 'SBLGNT I_Peter 5:5+85 5:5', 5750, 52, 8329, 50);
-- TODO: Double check this:
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31041, 3104, 1, 'Proverbs', null, 'LXX Proverbs 26:11', 'II_Peter', 'II_Peter 2:22', null, null, null, null, 'traditional');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31051, 3105, 1, 'Proverbs', null, 'LXX Proverbs 11:31+6 11:31', 'I_Peter', 'SBLGNT I_Peter 4:18+6 4:18', 20518, 49, 7758, 49, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (31051, 3105, 1, 'Proverbs', null, 'LXX Proverbs 11:31 11:31', 'I_Peter', 'SBLGNT I_Peter 4:18+3 4:18', 20512, 55, 7755, 52, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (3105, 1, null, 'και'); -- και = and
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3105, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (31051, 'I_Peter', 'SBLGNT I_Peter 4:18 4:18-52', 7752, 7754);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (31051, 3105, 1, 'Proverbs', 'LXX Proverbs 11:31 11:31-52', 'I_Peter', 'SBLGNT I_Peter 4:18+3 4:18-49', 20512, 3, 7755, 3);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (31051, 3105, 1, 'Proverbs', 'LXX Proverbs 11:31+6 11:31', 'I_Peter', 'SBLGNT I_Peter 4:18+6 4:18', 20518, 49, 7758, 49);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (51, 3201, 1, 'Ecclesiastes', null, 'LXX Ecclesiastes 7:20+11 7:20-38', 'Romans', 'SBLGNT Romans 3:10+17 3:10-7', 12724, 15, 5770, 15, 'manual');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (3201, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (51, 3201, 1, 'Ecclesiastes', 'LXX Ecclesiastes 7:20+11 7:20-38', 'Romans', 'SBLGNT Romans 3:10+17 3:10-7', 12724, 15, 5770, 15);

insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (41011, 4101, 1, 'II_Samuel', null, 'LXX II_Samuel 7:14 7:14-71', 'Hebrews', 'SBLGNT Hebrews 1:5+66 1:5', 20344, 45, 472, 45, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (4101, 1, null, 'και παλιν'); -- και παλιν = and again
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (4101, 1, 'quotation', 'literal, exact', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (41011, 'Hebrews', 'SBLGNT Hebrews 1:5+58 1:5-45', 464, 471);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (41011, 4101, 1, 'II_Samuel', 'LXX II_Samuel 7:14 7:14-71', 'Hebrews', 'SBLGNT Hebrews 1:5+66 1:5', 20344, 45, 472, 45);
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (15011, 4102, 1, 'II_Samuel', null, 'LXX II_Samuel 5:2+95 5:2-33', 'Matthew', 'SBLGNT Matthew 2:6+88 2:6', 13368, 28, 2696, 27, 'manual');
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (4102, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (15011, 4102, 1, 'II_Samuel', 'LXX II_Samuel 5:2+95 5:2-33', 'Matthew', 'SBLGNT Matthew 2:6+88 2:6', 13368, 28, 2696, 27); -- ποιμανεις τον λαον μου τον ισραηλ -> ποιμανει τον λαον μου τον Ισραηλ
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (42011, 4201, 1, 'I_Kings', null, 'LXX I_Kings 19:10+72 19:10-94', 'Romans', 'SBLGNT Romans 11:3+30 11:3-39', 75874, 28, 22370, 28, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (42011, 4201, 1, 'I_Kings', null, 'LXX I_Kings 19:10+72 19:10-11', 'Romans', 'SBLGNT Romans 11:3+5 11:3', 75874, 111, 22345, 92, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (4201, 1, 'εν Ηλια ... η γραφη', 'λεγει'); -- εν Ηλια ... η γραφη = in Elijah ... the Scripture, λεγει = says
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (4201, 1, 'quotation', 'literal, fuzzy', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (42011, 'Romans', 'SBLGNT Romans 11:2+36 11:2', 22281, 22339);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (42011, 4201, 1, 'I_Kings', 'LXX I_Kings 19:10+72 19:10-68', 'Romans', 'SBLGNT Romans 11:3+5 11:3-41', 75874, 54, 22345, 51); -- τα θυσιαστηρια σου κατεσκαψαν και τους προφητας σου απεκτειναν -> τους προφητας σου απεκτειναν, τα θυσιαστηρια σου κατεσκαψαν
-- TODO: Consider splitting this into two clasps:
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (42011, 4201, 1, 'I_Kings', 'LXX I_Kings 19:10+135 19:10-11', 'Romans', 'SBLGNT Romans 11:3+56 11:3', 75937, 21+27, 22396, 22+19); -- και υπολελειμμαι εγω μονωτατος + και ζητουσι την ψυχην μου -> καγω υπελειφθην μονος + και ζητουσιν την ψυχην μου
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (42021, 4202, 1, 'I_Kings', null, 'LXX I_Kings 19:18+60 19:18-35', 'Romans', 'SBLGNT Romans 11:4+77 11:4-5', 77001, 7, 22514, 7, 'getrefs');
insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values
 (42021, 4202, 1, 'I_Kings', null, 'LXX I_Kings 19:18+3 19:18-30', 'Romans', 'SBLGNT Romans 11:4+27 11:4', 76944, 69, 22464, 62, 'manual');
insert into quotations_properties (quotation_ot_id, quotation_nt_id, source_given, as_it_is_written) values
 (4202, 1, 'αυτω ... ο χρηματισμος', 'λεγει'); -- λεγει = spoken, αυτω ... ο χρηματισμος = to him [Elijah] ... the divine answer
insert into quotations_classifications (quotation_ot_id, quotation_nt_id, classification, classification_subtype, classified_by) values
 (4202, 1, 'quotation', 'far-fuzzy, synonym', 'Z.K.');
insert into nt_quotation_introductions (nt_quotation_id, nt_book, nt_passage, nt_startpos, nt_endpos) values
 (42021, 'Romans', 'SBLGNT Romans 11:4 11:4-62', 22437, 22463);
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (42021, 4202, 1, 'I_Kings', 'LXX I_Kings 19:18+3 19:18-88', 'Romans', 'SBLGNT Romans 11:4+27 11:4-53', 76944, 11, 22464, 9); -- καταλειψεις -> Κατελιπον
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (42021, 4202, 1, 'I_Kings', 'LXX I_Kings 19:18+22 19:18-62', 'Romans', 'SBLGNT Romans 11:4+42 11:4-27', 76963, 18, 22479, 20); -- επτα χιλιαδας ανδρων -> επτακισχιλιους ανδρας
insert into clasps (nt_quotation_id, ot_id, nt_id, ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length) values
 (42021, 4202, 1, 'I_Kings', 'LXX I_Kings 19:18+52 19:18-30', 'Romans', 'SBLGNT Romans 11:4+69 11:4', 76993, 20, 22506, 20); -- ουκ ωκλασαν γονυ τω βααλ -> ουκ εκαμψαν γονυ τη Βααλ
