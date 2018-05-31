CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY,
                  name TEXT,
                  lang TEXT,
                  location TEXT);

INSERT INTO user(id, name, lang, location)
SELECT DISTINCT user_id, name, lang, location
FROM tweet;

CREATE TABLE IF NOT EXISTS media(id INTEGER PRIMARY KEY,
                  display_url TEXT);

INSERT INTO media(display_url)
SELECT DISTINCT display_url
FROM tweet
WHERE display_url like 'p%'
ORDER BY tweet_id;

ALTER TABLE tweet RENAME TO tweet_old;

ALTER TABLE tweet_old ADD COLUMN media_id INTEGER DEFAULT NULL;

CREATE TABLE IF NOT EXISTS tweet(id INTEGER PRIMARY KEY,
                        user_id INTEGER,
                        tweet_text TEXT,
                        media_id INTEGER DEFAULT NULL,
                        country_code TEXT,
                        created_at TIMESTAMP,
                        tweet_sentiment INTEGER,
                        FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE ON UPDATE NO ACTION
                        FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE ON UPDATE NO ACTION);

UPDATE tweet_old
SET media_id=(SELECT id FROM media WHERE tweet_old.display_url=media.display_url);

pragma writable_schema=1;
update SQLITE_MASTER set sql = replace(sql, 'FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE ON UPDATE NO ACTION)',
    'FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE ON UPDATE NO ACTION FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE ON UPDATE NO ACTION)'
) where name = 'tweet_old' and type = 'table';

INSERT INTO tweet(id, user_id, tweet_text, country_code, media_id, created_at, tweet_sentiment)
       SELECT DISTINCT tweet_id,
              user_id,
              tweet_text,
              country_code,
              media_id,
              created_at,
              tweet_sentiment
       FROM tweet_old;

DROP TABLE tweet_old;