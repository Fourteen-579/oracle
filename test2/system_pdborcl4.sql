create role fourteen_579;
grant connect,resource,create view to fourteen_579;
CREATE USER fourteen IDENTIFIED BY "123" DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp;
ALTER USER fourteen QUOTA 50M ON users;
GRANT fourteen_579 TO fourteen;


SELECT tablespace_name,FILE_NAME,BYTES/1024/1024 MB,MAXBYTES/1024/1024 MAX_MB,autoextensible 
    FROM dba_data_files  WHERE  tablespace_name='USERS';

SELECT a.tablespace_name "表空间名",Total/1024/1024 "大小MB",
 free/1024/1024 "剩余MB",( total - free )/1024/1024 "使用MB",
 Round(( total - free )/ total,4)* 100 "使用率%"
 from (SELECT tablespace_name,Sum(bytes)free
        FROM   dba_free_space group  BY tablespace_name)a,
       (SELECT tablespace_name,Sum(bytes)total FROM dba_data_files
        group  BY tablespace_name)b
 where  a.tablespace_name = b.tablespace_name;