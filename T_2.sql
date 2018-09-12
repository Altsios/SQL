DEFINE N='683443'; 

WITH REC(RES,SUM,LEN) 
AS(SELECT CAST (REGEXP_REPLACE('&&N','(\d|$)',' \1') AS VARCHAR(23))--выбрали все цифры и заполнили пробелами между ними
         ,CAST (REGEXP_REPLACE('&N','(\d|$)',' \1') AS VARCHAR(250)),LENGTH('&N')
   FROM DUAL             
  UNION ALL--Шаг 2)в)                            
  SELECT REGEXP_REPLACE(REGEXP_REPLACE(RES,'\s','#' ,1 ,L+1),'(\S+)#(\S+)'--Шаг 2)г) расставляем всевозможные знаки между 2я числами(выражениями)
                        ,CASE WHEN DECODE(SIGN ,1,'+',2,'-',3,'*',4,'/') IN('+','-') THEN '(\1'||DECODE(SIGN ,1,'+',2,'-',3,'*',4,'/')||'\2)'--расстановка скобок только с + и -
                         ELSE '\1'||DECODE(SIGN ,1,'+',2,'-',3,'*',4,'/')||'\2' END)
                         --считаем значение выражения--Шаг 2) д)
                        ,SUBSTR(SUM,1,INSTR(SUM,' ',1,L))
                        ||DECODE(SIGN,1 ,SUBSTR(SUM,INSTR(SUM,' ',1,L)+1 ,INSTR(SUM,' ',1,L+1)-INSTR(SUM,' ',1,L)-1)
                                + SUBSTR(SUM ,INSTR(SUM,' ',1,L+1)+1 ,INSTR(SUM,' ',1,L+2)-INSTR(SUM,' ',1,L+1)-1)
                              ,2 ,SUBSTR(SUM ,INSTR(SUM,' ',1,L)+1 ,INSTR(SUM,' ',1,L+1)-INSTR(SUM,' ',1,L)-1)
                                - SUBSTR(SUM ,INSTR(SUM,' ',1,L+1)+1 ,INSTR(SUM,' ',1,L+2)-INSTR(SUM,' ',1,L+1)-1)
                              ,3 ,SUBSTR(SUM ,INSTR(SUM,' ',1,L)+1 ,INSTR(SUM,' ',1,L+1)-INSTR(SUM,' ',1,L)-1)
                                * SUBSTR(SUM ,INSTR(SUM,' ',1,L+1)+1 ,INSTR(SUM,' ',1,L+2)-INSTR(SUM,' ',1,L+1)-1)
                          ,4 ,NVL((SUBSTR(SUM ,INSTR(SUM,' ',1,L)+1 ,INSTR(SUM,' ',1,L+1)-INSTR(SUM,' ',1,L)-1)
                         / NULLIF(TO_NUMBER(SUBSTR(SUM ,INSTR(SUM,' ',1,L+1)+1 ,INSTR(SUM,' ',1,L+2)-INSTR(SUM,' ',1,L+1)-1)),0)),-531442))
                   ||SUBSTR(SUM,INSTR(SUM,' ',1,L+2))
                    ,LEN-1--Шаг 2)е)
                     FROM REC 
                    ,(SELECT LEVEL SIGN 
                      FROM DUAL 
                      CONNECT BY LEVEL <= 4)--Шаг 2)a)--возможны всего 4 знака по условию
                    ,(SELECT LEVEL AS L 
                      FROM DUAL 
                      CONNECT BY LEVEL<6)--Шаг 2)б)цифры от 1 до 5-обозначают номер позиции вставки знака в числе 
                 WHERE L < LEN--позиций для вставки знака должно быть на 1 меньше, чем чисел/выражений в строке, между которыми можно вставить знак (разделены пробелом)
   )
   SELECT DISTINCT '&N' "Число",RES "Решение"--Шаг 3)
       FROM REC
       WHERE LEN=1 AND ROUND(SUM,10)= 100;--последний уровень рекурсии len=1
