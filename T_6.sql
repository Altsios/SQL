UNDEFINE VAL
WITH REL AS
(SELECT  *
FROM (SELECT 3 VAL1, 1 VAL2 FROM DUAL
      UNION ALL
      SELECT 3 ,2 VAL2 FROM DUAL
      UNION ALL
      SELECT 4,3 FROM DUAL
      UNION ALL
      SELECT 6,9 FROM DUAL
      UNION ALL
      SELECT 7,8 FROM DUAL
      UNION ALL
      SELECT 9,10 FROM DUAL
)
START WITH VAL1=&&VAL OR VAL2=&VAL --построение иерархии от введенного числа
CONNECT BY NOCYCLE PRIOR VAL1=VAL2 OR VAL1=PRIOR VAL2)
SELECT &VAL "Значение",LISTAGG(VAL1,',') WITHIN GROUP (ORDER BY VAL1) "Эл-ы множества"
FROM(SELECT VAL1 --окончательное формирование множества
FROM REL
UNION 
SELECT VAL2 
FROM REL);
