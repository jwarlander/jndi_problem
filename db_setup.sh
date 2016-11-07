echo "** Creating user; please enter 'password' as password"
sudo -u postgres createuser --createdb --pwprompt johwar
echo "** Creating databases; please enter 'password' when asked for password"
psql -h localhost -U johwar -d postgres <<\EOF
CREATE DATABASE test1;
CREATE DATABASE test2;
\connect test1
CREATE TABLE foo (n INT);
INSERT INTO foo VALUES (1);
INSERT INTO foo VALUES (2);
INSERT INTO foo VALUES (3);
\connect test2
CREATE TABLE bar (c TEXT);
INSERT INTO bar VALUES ('a');
INSERT INTO bar VALUES ('b');
INSERT INTO bar VALUES ('c');
EOF
