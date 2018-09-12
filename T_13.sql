SELECT s "Запрос", LENGTH(TRANSLATE(RTRIM(regexp_replace(REGEXP_REPLACE(s,'("(\w*\s*)*as(\s*\w*)*"|''(\w*\s*)*as(\s*\w*)*''|\w+\s+as\s*\()','#\1#',1,0,'i'),'as','',1,0,'i'),
';'),'+'||CHR(10)||CHR(09)||CHR(32),'+')) "Длина запроса"
FROM (SELECT q'#WITH 
EMP AS 
(SELECT FIRST_NAME AS "imechko'", employee_id "I D", ' AS '' ' AS "AS" 
FROM EMPLOYEES),
KURSACH AS(SELECT 'bd as vsya zizn' AS " as why tak " FROM DUAL)
SELECT "AS" as "Not as", " as why tak "
FROM EMP,KURSACH;#' s
      FROM DUAL);
