Файлы:
sql_for_table.sql по первой табличке

tweets_calculations.py решает - 1, 2, 4 пункта

normalize.sql - 3 пункт

fortunate_country.sql - 5 пункт

ETL.txt - 6 пункт



SQL:

Табличка имеет такие данные:

ID

Value

Date

1

5

2017-01-01

1

6

2017-01-01

2

2

2017-01-02

3

5

2017-05-06

3

6

2017-06-06



Задание: необходимо написать SQL , который должен вывести уникальные строки для поля ID с максимальной датой или если даты одинаковые с максимальной value.

 

2.        Аналитика над данными:

 

Высылаем вам выгрузку сообщений твиттер за три минуты в формате json

 

Необходимо:

1. Написать скрипт на Python который загружает в БД (sqlite3) данные по каждому твитту из файла “three_minutes_tweets.json.txt”:

Таблица Tweet

  name, tweet_text, country_code, display_url, lang, created_at, location

Все необходимые файлы находятся во вложенном файле Documrnts.zip

2. Добавить новую колонку tweet_sentiment

3. Подумать как можно провести нормализацию данной таблицы, создать и применить SQL скрипт

для нормализации

4.  Написать скрипт на Python для подсчета среднего sentiment (Эмоциональной окраски сообщения) на основе AFINN-111.txt и обновить tweet_sentiment колонку, если слова нет в файле предполагать что sentiment =0

AFINN ReadMe:

AFINN is a list of English words rated for valence with an integer

between minus five (negative) and plus five (positive). The words have

been manually labeled by Finn Årup Nielsen in 2009-2011. The file

is tab-separated. There are two versions:

AFINN-111: Newest version with 2477 words and phrases.

5. Написать 1 SQL скрипт, который выводит наиболее и наименее счастливую страну, локацию и пользователя

6. Подумать как можно организовать процесс ежедневной оценки параметров в п. 5 (Production решение)

и описать из каких шагов ETL будет состоять процесс трансформации до получения и хранения конечной информации

Первый этап: данные приходят на FTP (tweet.json+AFINN.txt), последний этап: данные отгружаются на другой FTP
