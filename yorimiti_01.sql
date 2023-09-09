----------- 寄り道　SQL 01

--- 【副問い合わせ】例: ---

------*******************
----- ********** 例 01 , 前提条件 , テーブル 2 , 顧客テーブル(customers) , 注文テーブル(orders)
------*******************

--- ※ 主クエリが顧客テーブルから顧客の名前を選択し、副問い合わせが各顧客の注文数を計算する。
-----  副問い合わせは主クエリ内で実行され、各顧客に対して注文数が計算される。

SELECT customer_name , (
	SELECT COUNT(*)
	   FROM orders
	   WHERE orders.customer_id = customers.customer_id
	) AS 注文数
FROM customers;

------*******************
----- ********** 例 02 副問い合わせを使った、フィルタリング
------*******************

------このクエリでは、副問い合わせが条件を満たす最初の行の値を見つけ、
------その値を持つ行を主クエリで取得する。

SELECT column1, column2
 FROM table1
  WHERE columnN = (
	SELECT columnN
	 FROM table1
	  WHERE condition
	  LIMIT 1
);

------*******************
----- ********** 例 03  FROM句の中に、サブクエリ（副問い合わせ）
------*******************

SELECT column1, column2, ...
   FROM (SELECT subquery_columns
	   FROM subquery_tables
	   WHERE subquery_conditions) AS サブクエリアイテム
   WHERE main_query_conditions;

--- 主要なポイントは以下。

--- １：副問い合わせ（サブクエリ）は、主クエリのFROM句内に配置されます。
--- ２：副問い合わせ内で必要な列、テーブル、条件を指定します。
--- ３：副問い合わせは主クエリからのデータを生成し、その結果を仮想テーブルとして扱います。
-------４：この仮想テーブルには、ASキーワードで名前（subquery_alias）を付けることができます。
--- ５：主クエリは副問い合わせから生成された仮想テーブルを使用し、必要な列と条件を指定してデータを抽出します。

------*******************
------ ********* 例 04 FROM句の中に、サブクエリ（副問い合わせ）
------*******************

SELECT customer_name, order_count
  FROM (
      SELECT customer_id, COUNT(*) AS order_count
       FROM  orders
       GROUP BY customer_id
) AS order_summary
JOIN customers ON customers.customer_id = order_summary.customer_id;

--- ※上記例
------- このクエリでは、副問い合わせが注文テーブルから各顧客の注文数を計算し、
--- その結果をorder_summaryという仮想テーブルとして生成します。
--- 次に、この仮想テーブルを顧客テーブルと結合して、顧客名と注文数を取得します。


--- 【副問い合わせ】例: END ---

------*******************
--------- Q47 全ての選手のポジションの1文字目（GKであればG、FWであればF）を出力してください。
------*******************
SELECT id,country_id,uniform_num ,substring("position", 1, 1)  from players; 

------*******************
---------------------- Q48 出場国の国名が長いものから順に出力してください。
------*******************
SELECT name, length(name) as LEN from countries order by LEN desc;


------*******************
---------------------- Q64　【副問い合わせ】 全てのゴール時間と得点を上げたプレイヤー名を表示してください。
----------- オウンゴールは表示しないでください。ただし、結合は使わずに副問合せを用いてください。
------*******************
SELECT id, goal_time, 
	(select p.name from players p where p.id = g.player_id) as name 
	from goals g
	where g.player_id is not null;
 
------*******************
---------------------- Q65　【副問い合わせ】 全てのゴール時間と得点を上げたプレイヤー名を表示してください。
------------  オウンゴールは表示しないでください。ただし、副問合せは使わずに、結合を用いてください。
------*******************
SELECT p.id, g.goal_time, p.name 
	from goals g 
	left outer join players p on g.player_id = p.id 
	where g.player_id is not null;


------*******************
---------------------- Q66　【副問い合わせ】 GOOD
------*******************
SELECT pp.position, pp.最大身長,p.name, p.club
 FROM(
 	SELECT position , MAX(height) as 最大身長
 		FROM players p2 
 	        GROUP BY position
 ) as pp
 LEFT OUTER JOIN players p on p.position = pp.position and pp.最大身長 = p.height;


------*******************
---------------------- Q67　【副問い合わせ】
------******************* 
select p.position, MAX(p.height) as 最大身長, 
	(select p2.name as 名前 
		from players p2 
		where p.position = p2.position AND MAX(p.height) = p2.height
	)
	from players p 
	group by p.position;
