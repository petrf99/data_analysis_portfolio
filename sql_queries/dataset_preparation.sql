CREATE TABLE customer_features_raw AS
    WITH geo AS 
    (
    SELECT geolocation_zip_code_prefix::varchar || geolocation_city || geolocation_state as address, 
           AVG(geolocation_lat) AS geolocation_lat, 
           AVG(geolocation_lng) AS geolocation_lng
    FROM geolocation
    GROUP BY geolocation_zip_code_prefix::varchar || geolocation_city || geolocation_state
    )
    SELECT c.customer_unique_id as cid
    , c.customer_id, c.customer_zip_code_prefix, c.customer_city, c.customer_state
    , gc.geolocation_lat as customer_lat, gc.geolocation_lng as customer_lng
    FROM customers c
    LEFT JOIN geo gc
    ON gc.address = c.customer_zip_code_prefix::varchar || c.customer_city || c.customer_state

;





CREATE TABLE seller_features_raw AS
    WITH geo AS 
    (
    SELECT geolocation_zip_code_prefix::varchar || geolocation_city || geolocation_state as address, 
           AVG(geolocation_lat) AS geolocation_lat, 
           AVG(geolocation_lng) AS geolocation_lng
    FROM geolocation
    GROUP BY geolocation_zip_code_prefix::varchar || geolocation_city || geolocation_state
    )
    SELECT s.seller_id as sid
    , s.seller_zip_code_prefix, s.seller_city, s.seller_state
    , gs.geolocation_lat as seller_lat, gs.geolocation_lng as seller_lng
    , AVG(orev.review_score) as avg_review_score
    , MIN(orev.review_score) as min_review_score
    , MAX(orev.review_score) as max_review_score
    , STDDEV_POP(orev.review_score) as std_review_score
    FROM sellers s
    LEFT JOIN order_items oi
    ON oi.seller_id = s.seller_id
    LEFT JOIN order_reviews orev
    ON oi.order_id = orev.order_id
    LEFT JOIN geo gs
    ON gs.address = s.seller_zip_code_prefix::varchar || s.seller_city || s.seller_state
    GROUP BY s.seller_id
    , s.seller_zip_code_prefix, s.seller_city, s.seller_state
    , gs.geolocation_lat, gs.geolocation_lng

;




CREATE TABLE order_features_raw AS
    SELECT o.*
    , p.*
    , oi.seller_id, oi.order_item_id, oi.price, oi.freight_value, oi.shipping_limit_date - o.order_approved_at as shipping_limit_days
    , op.payment_sequential, op.payment_type, op.payment_installments, op.payment_value
    , o.order_delivered_customer_date::date - o.order_approved_at::date as delivery_time 
    FROM orders o
    LEFT JOIN order_items oi
    ON oi.order_id = o.order_id
    LEFT JOIN products p
    ON p.product_id = oi.product_id
    LEFT JOIN order_payments op
    ON op.order_id = o.order_id
    WHERE op.payment_sequential = 1

;





CREATE TABLE order_features_raw_w_cust_n_sell AS
    SELECT o.*
    , seller_zip_code_prefix, seller_city, seller_state, seller_lat, seller_lng
    , avg_review_score, min_review_score, max_review_score, std_review_score
    , cid, customer_zip_code_prefix, customer_city, customer_state, customer_lat, customer_lng
    FROM order_features_raw o
    LEFT JOIN customer_features_raw c
    ON c.customer_id = o.customer_id
    LEFT JOIN seller_features_raw s
    ON s.sid = o.seller_id

;



