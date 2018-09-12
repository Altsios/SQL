DEFINE START=1
WITH COL AS--вспомогательный столбец для формирования доски 
(SELECT LEVEL L--Шаг 1й)
FROM DUAL 
CONNECT BY LEVEL<=8 
), 
CHB AS 
(SELECT С1.L X, С2.L Y, (С1.L - 1) * 8 + С2.L ID --X-номер строки, Y-номер столбца, ID-номер поля на доске, нумерация от верхнего левого угла
FROM COL С1 CROSS JOIN COL С2--Шаг 2) 
),
STH--всевозможные ходы коня. Шаг 3)
AS (SELECT 1 X, 2 Y FROM DUAL UNION ALL 
SELECT 1 , -2  FROM DUAL UNION ALL 
SELECT 2 , -1  FROM DUAL UNION ALL 
SELECT 2 , 1  FROM DUAL UNION ALL 
SELECT -1 , 2  FROM DUAL UNION ALL 
SELECT -1 , -2  FROM DUAL UNION ALL 
SELECT -2 , -1  FROM DUAL UNION ALL 
SELECT -2 , 1  FROM DUAL 
),
STEP AS--ШАГ 4)
(SELECT CHB_FROM.ID ID_FROM, CHB_FROM.X X_FROM, CHB_FROM.Y Y_FROM, CHB_TO.ID ID_TO, CHB_TO.X X_TO, CHB_TO.Y Y_TO,s.x,s.y--ходы коня по всей доске. из точки from в to
FROM CHB CHB_FROM CROSS JOIN STH S CROSS JOIN CHB CHB_TO 
WHERE CHB_FROM.X + S.X = CHB_TO.X AND CHB_FROM.Y + S.Y = CHB_TO.Y--клетки, куда из заданной точки мог попасть конь согласно шагам
),
STEPS --ШАГ 5)
AS (SELECT S1.ID_FROM, S1.ID_TO ID_TO1, S2.ID_TO ID_TO2--"Маршрут коня из 3х посещенных клеток". куда можно попасть конем за 2 хода
FROM STEP S1 CROSS JOIN STEP S2 
WHERE S2.ID_FROM = S1.ID_TO 
),
STR --шаг 6)
AS (SELECT CAST('-' AS VARCHAR2(4000)) ID 
    FROM DUAL),--строка, куда записываются номер клеток, куда пошел конь
T (ID, ID_NEXT, L)--текущая клетка, следующая клетка, кол-о ходов(уровень)
AS ( 
SELECT ID, &&START ID_NEXT, 1 L 
FROM STR
UNION ALL 
SELECT ID || ID_NEXT || '-' ID, 
( 
SELECT MAX(STEPS.ID_TO1) KEEP (DENSE_RANK FIRST ORDER BY COUNT(*))
FROM STEPS
WHERE STEPS.ID_FROM = T.ID_NEXT 
AND T.ID || ID_NEXT || '-' NOT LIKE '%-' || STEPS.ID_TO1 || '-%'--отсев варианта наступления на поле дважды 
AND (T.ID || ID_NEXT || '-' NOT LIKE '%-' || STEPS.ID_TO2 || '-%' OR L = 63)--отсев варианта наступления на поле дважды. Без этого условия часто возникал тупик. Допускается только на 63 шаге
GROUP BY STEPS.ID_TO1 
) ID_NEXT, 
L+1  
FROM T 
WHERE L < 64--условие ограничения поиска ходов
)--ШАГ 7)
SELECT LTRIM(ID || ID_NEXT,'-') "Маршрут коня"
FROM T 
WHERE L = 64;--выбираем самую последнюю запись
