  SELECT DISTINCT
         ord.order_id,
         emp.user_name,
         emp.birth_ymd,
         date_format(ord.order_date, '%Y-%m-%d %H:%i:%s') AS 'order_date'
        FROM kafe_order ord
        JOIN user emp ON (ord.order_user_no = emp.user_no)
ORDER BY order_date ASC, order_id ASC
limit 10
