-- Revert MyProj:functions/foo from pg

BEGIN;

DROP FUNCTION foo(int);

COMMIT;
