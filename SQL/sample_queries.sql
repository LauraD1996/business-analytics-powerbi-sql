/*
  Purpose:
  This file analyzes practitioner adherence by joining protocol, product, and order tables.
  It helps identify how many recommended products are being purchased (compliance),
  and highlights opportunities to cross-check competitor pricing via popular SKUs.
*/


-- 1. Sample query to preview data after import to see if successful

SELECT * FROM some_table_name LIMIT 10;

-- 2. Rename database for clarity
ALTER DATABASE "Amrita data dump" RENAME TO amrita_data_dump;  


-- 3. Order volume trend by year - checking data
SELECT EXTRACT(YEAR FROM created_at) AS year, COUNT(*) AS total_orders
FROM orders
GROUP BY year
ORDER BY year;

-- 4. Protocol details: what products are included, and their SKUs
SELECT
    pi.protocol_id,
    p.name AS protocol_name,
    pr.name AS product_name,
    iv.sku AS product_sku,
    pi.quantity,
    pi.price
FROM protocol_items pi
JOIN protocols p ON pi.protocol_id = p.id
JOIN products pr ON pi.product_id = pr.id
LEFT JOIN ip_variants iv ON pi.product_variant_id = iv.id
ORDER BY pi.protocol_id, pr.name;

-- 5. View all available tables in the schema
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';
