CREATE TABLE foo (
  id SERIAL PRIMARY KEY,
  pear_id INTEGER
);

CREATE TABLE bar (
  id SERIAL PRIMARY KEY,
  foo_id INTEGER,
  peach_id INTEGER
);
ALTER TABLE bar 
  ADD CONSTRAINT bar_foo_id_fk FOREIGN KEY (foo_id)
    REFERENCES foo (id);

INSERT INTO foo (id) values (1);
INSERT INTO foo (id, pear_id) values (2, 10);

INSERT INTO bar (id) values (1);
INSERT INTO bar (id, foo_id) values (2, 1);
INSERT INTO bar (id, foo_id, peach_id) values (3, 1, 20);



