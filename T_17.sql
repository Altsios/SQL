WITH T(VAL1,VAL2) AS (
SELECT 1, 1 FROM DUAL UNION ALL 
SELECT 1, 2 FROM DUAL UNION ALL 
SELECT 1, 3 FROM DUAL UNION ALL 
SELECT 2, 1 FROM DUAL UNION ALL 
SELECT 2, 2 FROM DUAL UNION ALL 
SELECT 2, 3 FROM DUAL UNION ALL 
SELECT 2, 4 FROM DUAL UNION ALL 
SELECT 3, 1 FROM DUAL  
),
FST--Получение разных первых чисел в столбике--ШАГ 1)
AS(SELECT LTRIM(SYS_CONNECT_BY_PATH(VAL1||' '||VAL2,';'),';') STR--соединение записей ";"
FROM T
CONNECT BY PRIOR VAL1<VAL1 --Соединяем так, чтобы не образовывалось одинаковых чисел и не было дублей строк типа 1 2; 2 3 и 2 3;1 2
),
SCND(STR,NUM,i)-- подсчет чисел во втором столбце--ШАГ 2)
AS(SELECT STR,REGEXP_SUBSTR(STR,'\s\d+',1,1), 2
FROM FST 
UNION ALL
SELECT
STR,REGEXP_SUBSTR(STR,'\s\d+',1,i),i+1--выбор числа второго столбика
FROM
SCND
WHERE i<=(SELECT COUNT(DISTINCT VAL2) 
          FROM T)),-- идем до тех пор, пока есть вероятность найти неповторяющиеся числа)
CAND --ШАГ 3)
AS(SELECT DN.STR S,DN.DIF_NUM CNT
FROM(SELECT STR,COUNT(DISTINCT NUM) DIF_NUM
     FROM SCND 
     GROUP BY STR)DN JOIN 
     (SELECT STR,COUNT(I)NNULL_NUM
     FROM SCND
     WHERE NUM IS NOT NULL
     GROUP BY STR)NN 
     ON DN.STR=NN.STR AND DN.DIF_NUM=NN.NNULL_NUM)
SELECT VAL1||' '||VAL2 "Исходная таблица"--ШАГ 4)
FROM T
UNION ALL
SELECT '"Результат"' FROM DUAL
UNION ALL
SELECT '('||S||')' 
FROM CAND 
WHERE CNT=(SELECT MAX(CNT)
           FROM CAND);
