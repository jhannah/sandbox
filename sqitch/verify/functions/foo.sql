-- Verify MyProj:functions/foo on pg

BEGIN;

SELECT foo(3);

ROLLBACK;
