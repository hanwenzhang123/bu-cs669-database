Setup as a new user:
Oracle
CREATE USER username IDENTIFIED BY password DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp;
GRANT connect, resource TO username;

MSSQL
CREATE DATABASE database_name;
GO;
USE database_name;

PostgreSQL 
CREATE DATABASE database_name;

Saving Your Data:
COMMIT;

   
An instance is a collection of SQL Server databases run by a single SQL Server service

MSSQL - sqlcmd for command-line window
execute - press F5 or select lines of code to be executed then press F5. 
column - control + space - show existing column
