  SELECT DISTINCT
         ord.order_id,
         ord.order_user_no,
         CASE
            WHEN ord.emp_at IS TRUE THEN '임직원'
            ELSE '협력사/방문자'
         END
            AS 'emp_at',
         emp.user_name,
         emp.position_name,
         emp.duty_name,
         emp.enter_name,
         emp.birth_ymd,
         login.login_ip,
         paycd.code_name                                AS 'pay_mth',
         ordcd.code_name                                AS 'order_mth',
         hist.prd_order_count,
         hist.prd_order_price,
         cate.prd_cate_name,
         prd.prd_name,
         CASE
            WHEN hist.option IS NOT NULL
            THEN
               (SELECT group_concat(tmp.option_name)
                  FROM kafe_option tmp
                 WHERE find_in_set(tmp.option_id, hist.option))
            ELSE
               ''
         END
            AS 'prd_option',
         date_format(ord.order_date, '%Y%m%d%H%i%s') AS 'order_date'
    FROM kafe_order ord
         JOIN kafe_order_hist hist USING (order_id)
         JOIN user emp ON (ord.order_user_no = emp.user_no)
         JOIN kafe_login_hist login USING (user_no)
         JOIN kafe_prd prd USING (prd_id)
         JOIN kafe_prd_cate cate USING (prd_cate_id)
         JOIN code paycd ON (paycd.code_no = ord.pay_mth)
         JOIN code ordcd ON (ordcd.code_no = ord.order_mth)
--    WHERE ord.order_date > :sql_last_value
ORDER BY order_date ASC, order_id ASC
