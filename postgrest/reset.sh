psql -c "drop database foo"
psql -c "create database foo"
psql foo < schema.sql
postgrest postgres://jhannah:@localhost/foo -a jhannah -s public

# Then:
# curl -s "http://localhost:3000/foo?select=pear_id,bar\{peach_id\}&bar.peach_id=gt.1" | python -m json.tool

