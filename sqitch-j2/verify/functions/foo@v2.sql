-- Verify MyProj:functions/foo on pg

BEGIN;

SELECT foo(2);

ROLLBACK;
