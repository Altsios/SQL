SELECT LISTAGG(НАЗВАНИЕ,', ') WITHIN GROUP (ORDER BY НАЗВАНИЕ) "Список дисциплин"
FROM (SELECT НАЗВАНИЕ
FROM ДИСЦИПЛИНЫ JOIN УСПЕВАЕМОСТЬ
USING (НОМЕР_ДИСЦИПЛИНЫ)
WHERE ОЦЕНКА=5
GROUP BY НОМЕР_ДИСЦИПЛИНЫ,НАЗВАНИЕ
HAVING COUNT(*)=(SELECT MAX(COUNT(*))
                 FROM УСПЕВАЕМОСТЬ
                 WHERE ОЦЕНКА=5
                 GROUP BY НОМЕР_ДИСЦИПЛИНЫ));
