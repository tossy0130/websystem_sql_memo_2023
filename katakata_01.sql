-- ■ テーブル　カラム　日付変更

update 予約枠マスタ set 適用開始日 = TO_DATE('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
  WHERE 適用開始日 = TO_DATE('2323-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS');


-- update 予約枠マスタ set 適用開始日 = TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
  WHERE 適用開始日 = TO_TIMESTAMP('2323-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
    AND EXTRACT(SECOND FROM 適用開始日) = 0;


-- # OK　例　, 適用開始日が 0000-01-01 00:00:00 になる。
Insert into 予約枠マスタ (予約枠番号,適用開始日,適用終了日,予約時間番号,予約枠数,市外予約上限数,作成日時,更新日時,更新SEQ) values (1,to_timestamp('2000-01-01 00:00:00','YYYY-MM-DD HH24:MI:SSXFF'),null,201,2,2,to_timestamp('1414-07-11 00:00:00','YYYY-MM-DD HH24:MI:SSXFF'),to_timestamp('1414-07-11 00:00:00','YYYY-MM-DD HH24:MI:SSXFF'),0);


--------------- シーケンス 作成
-- シーケンス "予約SEQ" を作成
CREATE SEQUENCE 予約SEQ
MINVALUE 1
MAXVALUE 999999999
INCREMENT BY 1
START WITH 1
CACHE 20;



--------------- シーケンス 作成 02

CREATE SEQUENCE "送信制御SEQ"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 94814 CACHE 20 ORDER  CYCLE  NOPARTITION ;

------------------------


------------- 201は式場利用
---------- 予約枠数　変更
------------------------

update 予約枠マスタ set 予約枠数 = 10 where 予約時間番号 = 201;
update 予約枠マスタ set 予約枠数 = 2 where 予約時間番号 = 201;

update 予約枠マスタ set 予約枠数 = 10 where 予約時間番号 = 101;
