-- Verify MyProj:functions/foo on pg

BEGIN;

SELECT foo(1);

ROLLBACK;
