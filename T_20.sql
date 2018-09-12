--Решение с использованием регулярных выражений;
DEFINE STR='0|0|1.45|2|1|2|10|22|34|15|0|-105|66|73'
SELECT '&STR'"Исходная строка",R "Обратный порядок"
FROM(SELECT LISTAGG(NUM,'|') WITHIN GROUP (ORDER BY RN DESC) R
FROM(SELECT ROWNUM RN, REGEXP_SUBSTR('&STR','[^|]+',1,LEVEL) NUM
     FROM DUAL
     CONNECT BY REGEXP_SUBSTR('&STR','[^|]+',1,LEVEL) IS NOT NULL));

--Решение с использованием раздела Model.
DEFINE STR='0|0|1.45|2|1|2|10|22|34|15|0|-105|66|73'
SELECT '&STR'"Исходная строка",RTRIM(RS,'|') "Обратный порядок"
FROM DUAL
MODEL
DIMENSION BY (0 i)
MEASURES (CAST('' AS VARCHAR2(4000))RS)
RULES ITERATE (4000) UNTIL (ITERATION_NUMBER=REGEXP_COUNT('&str','[^|]+')-1)
(RS[0]=REGEXP_SUBSTR('&str', '[^|]+',1,ITERATION_NUMBER+1)||'|'||RS[0]);
