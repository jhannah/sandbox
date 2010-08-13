
create table foo ( id int not null primary key, bar_id int not null );
create table bar ( id int not null primary key, foreign key(id) references foo(bar_id) );
insert into foo ( id, bar_id ) values ( 1, 1 );
insert into foo ( id, bar_id ) values ( 2, 1 );
insert into foo ( id, bar_id ) values ( 3, 1 );
insert into bar ( id ) values ( 1 );



