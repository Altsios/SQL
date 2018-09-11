# SQL
Решения некоторых задачек на SQL
##### ЗАДАНИЕ 1 (шахматная доска)
На шахматную доску положена на первую клеточку А1 одна монетка. На каждую последующую клеточку кладется  столько, сколько уже положено на все предыдущие  клетки, плюс одна. Т.е на клетку А2 положено 2 монетки, А3  - 4 монетки и т.д.  Составить SQL запрос, который нарисует шахматную доску с заголовками столбцов и строк (таблицу 9 на 9),  заполненную согласно приведенного алгоритма. 
![Screenshot](img1.jpg)

##### ЗАДАНИЕ 2 (число 100)
Задается шестизначное число. Нужно расставить между цифрами знаки арифметических операций + , - , * , / и скобки так, чтобы в результате получить число 100. "Склеивать" цифры нельзя, т.е. между любыми двумя цифрами должен стоять знак арифметической операции. Запрещено использование других символов (возведение в степень, квадратный корень, факториал и т. д.). Все расчёты ведутся в десятичной системе счисления. 
Например, число 555555.
Решение: (5+5+5-5)*(5+5), или (5*5-5)*5*5/5,
или
5*(5+5)+5*(5+5) и т. д.
Требуется найти все решения для билета 683443.

##### ЗАДАНИЕ 3(иерархия)
В иерархической структуре сетевого маркетинга члены вышестоящих уровней, получают бонусы от своих нижестоящих партнеров. Вышестоящий партнер получает от каждого своего нижестоящего партнера такую же сумму бонусов, которую получает сам нижестоящий партнер.
Нужно посчитать суммы бонусов, которые получат корневые партнеры, стоящие у начала сетевой пирамиды.
Корпорация строго следит, чтобы: 
У каждого партнера был только один вышестоящий партнер, чтобы не допускать выплаты двойных бонусов.
Для каждого партнера имеется единственный корневой партнер, над которым нет вышестоящего партнера.

Формат входных данных
Иерархическая структура Корпорации описывается таблицей   MLM_NET с полями: 
MEMBER_CHILD - нижестоящий партнер.
MEMBER_PARENT - его вышестоящий партнер.
Данные по собственным бонусам участников сети находятся в таблице MLM_FEE: 
MEMBER - член сети, к которому относятся бонусы.
FEE - сумма его собственных бонусов.
Формат результата
Вывести полные суммы бонусов корневых партнеров, отсортированных по сумме бонусов в порядке убывания. 
Имена столбцов вывода: 
ROOT_MEMBER - корневой член сети.
TOTAL_FEE - полная сумма его бонусов, с учетом бонусов подчиненных партнёров.

##### ЗАДАНИЕ 4(ход конем)
Есть пустая шахматная доска (обыкновенная, размера 8x8). Требуется  за 64 хода обойти конем все её клетки (не наступая  ни на какое поле дважды).

##### ЗАДАНИЕ 5(макс. кол-во "5-к")
Создать запрос для вывода списка дисциплин, по которым на сессии было получено максимальное количество пятерок. Список дисциплин вывести в виде символьной строки с запятой в качестве разделителя.

##### ЗАДАНИЕ 6(транзитивное множество)
Есть таблица с парами значений, связанными отношением. Одно значение может быть связано с несколькими, те в свою очередь могут быть связаны друг с другом. В результате, значения транзитивно образуют связанные множества. На входе имеем некое значение, нужно получить все элементы множества, к которому оно относится. Результат вывести в виде строки с запятой в качестве разделителя.

##### ЗАДАНИЕ 7(коэффициент размножения)
Имеется таблица с тремя столбцами: именем, фамилией и коэффициентом размножения. Требуется написать запрос, выводящий таблицу, содержащую строки с именами и фамилиями двух сотрудников. Число строк для каждого сотрудника должно определяться коэффициентом размножения. То есть, если Иван Петров имел коэффициент размножения 3, а Сергей Сидоров –  коэффициент размножения 5, то в результатах запроса должны быть 3 строки для сотрудника Петрова  и 5 строк для  Сидорова. 
 Строки должны быть объединены в группы и отсортированы по фамилии и имени.
 Кроме того, должны быть пронумерованы элементы внутри группы и должна присутствовать сквозная нумерация. Этот запрос должен работать для произвольного количества строк в исходной таблице

##### ЗАДАНИЕ 8(0 экзаменов)
Создать запрос для вывода списка фамилий студентов, которые не сдали ни одного экзамена в сессию, т.е. они могли делать попытки, но эти попытки были неудачными.

##### ЗАДАНИЕ 9(календарь)
Используя обращение только к таблице DUAL, построить SQL-запрос, возвращающий один столбец, содержащий календарь на текущий месяц текущего года:
номер дня в месяце (две цифры),
полное название месяца по-английски заглавными буквами (в верхнем регистре),
год (четыре цифры),
полное название дня недели по-английски строчными буквами (в нижнем регистре).
Каждое "подполе" должно быть отделено от следующего одним пробелом. В результате не должно быть начальных и хвостовых пробелов. Количество возвращаемых строк должно точно соответствовать количеству дней в текущем месяце. Строки должны быть упорядочены по номерам дней в месяце по возрастанию.
