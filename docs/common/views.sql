-- These views are very important to simplify queries and better understand
-- the structure of quotations.

-- Only those entries from the table "quotations" should be considered as quotations which
-- are introduced with some special words. The introductory words do not need to be
-- at the beginning: they can be in the middle or after the quotation as well.
create view quotations_with_introduction as
 select q.nt_quotation_id, q.ot_id, q.nt_id, q.ot_book, q.psalm,
  q.ot_passage, q.nt_book, q.nt_passage, q.ot_startpos, q.ot_length,
  q.nt_startpos, q.nt_length, q.found_method
 from quotations q, quotations_classifications qc
 where qc.classification = 'quotation'
 and qc.quotation_ot_id = q.ot_id
 and qc.quotation_nt_id = q.nt_id;

-- Only those entries should be accepted as verified ones that were already checked manually.
create view quotations_with_introduction_manual as
 select * from quotations_with_introduction where
 found_method = 'manual';

-- A list of NT quotations contain not just the "single" ones (where there is only one
-- OT passage) but also the "combinations" (where there are at least two OT passages).
create view nt_quotations as
 select nt_quotation_id, nt_book, min(nt_startpos) as nt_startpos, max(nt_endpos) as nt_endpos, count(*) as count
 from (select qwim.nt_quotation_id as nt_quotation_id, qwim.nt_book as nt_book,
 qwim.nt_startpos as nt_startpos,qwim.nt_startpos+qwim.nt_length-1 as nt_endpos
 from quotations_with_introduction_manual qwim) group by nt_quotation_id;

