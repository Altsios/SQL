DEFINE STR='211221'
WITH CNAR_NUM
AS(SELECT NUM,CH,ROWNUM RN FROM--Шаг 2)
       (SELECT SUBSTR('&&STR',LEVEL,1)NUM--Шаг 1)получение цифр--1 цифра
        FROM DUAL
        CONNECT BY LEVEL<=LENGTH('&STR')
        UNION ALL
        SELECT SUBSTR('&STR',LEVEL,2)--2 цифры
        FROM DUAL
        CONNECT BY LEVEL<=LENGTH('&STR')-1)NUMS--пар на 1 меньше
        JOIN ALPH ON NUMS.NUM=ALPH.N)
SELECT '&STR' "Строка",LISTAGG(RES,',') WITHIN GROUP (ORDER BY RES) "Набор слов"--Шаг 4)Окончательный вывод
FROM(SELECT DISTINCT REPLACE(SYS_CONNECT_BY_PATH(CH,'.'),'.') RES,REPLACE(SYS_CONNECT_BY_PATH(NUM,'.'),'.') RESNUM--Шаг 3)Соединение слов
FROM CNAR_NUM
CONNECT BY NOCYCLE PRIOR RN<>RN AND LEVEL<=LENGTH('&STR'))
