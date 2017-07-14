-- Deploy MyProj:functions/foo to pg

BEGIN;

CREATE OR REPLACE FUNCTION foo(input INT) RETURNS VOID AS $EOT$
  BEGIN
    IF input <> 1 THEN
      RAISE EXCEPTION 'nope';
    END IF;
  END;
$EOT$ LANGUAGE PLPGSQL;

COMMIT;
