SELECT TRIM(EXTRACT(DAY FROM TRUNC(SYSDATE,'MONTH')+LEVEL-1)||' '||--номер дня, начиная с первого в месяце
TO_CHAR(SYSDATE,'MONTH','NLS_DATE_LANGUAGE=ENGLISH')||' '||--определяем месяц
EXTRACT(YEAR FROM SYSDATE)||' '||--определяем год
TO_CHAR(TRUNC(SYSDATE,'MONTH')+LEVEL-1,'day','NLS_DATE_LANGUAGE=ENGLISH')) "Календарь"--день недели
FROM DUAL
CONNECT BY LEVEL<=LAST_DAY(SYSDATE)-TRUNC(SYSDATE,'MONTH')+1;--определяем кол-о дней в месяце
