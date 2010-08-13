
create table foo ( 
   id int not null primary key
);
create table bar ( 
   id int not null primary key, 
   foo_id int not null,
   desc text,
   foreign key(foo_id) references foo(id)
);
insert into foo values ( 1 );
insert into foo values ( 2 );
insert into foo values ( 3 );
insert into bar values ( 1, 2, 'aaa' );
insert into bar values ( 2, 2, 'bbb' );
insert into bar values ( 3, 2, 'ccc' );

