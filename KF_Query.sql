WITH PersentaseGrossLaba AS (
  SELECT DISTINCT
    product_id,
    CASE 
      WHEN price <= 50000 THEN 0.1
      WHEN price > 50000 AND price <= 100000 THEN 0.15
      WHEN price > 100000 AND price <= 300000 THEN 0.20
      WHEN price > 300000 AND price <= 500000 THEN 0.25
      WHEN price > 500000 THEN 0.3
    END AS persentase_gross_laba
  FROM `rakamin-kf-analytics-440201.Kimia_Farma.kf_final_transaction`
)

SELECT DISTINCT
  FT.transaction_id,
  FT.date,
  KC.branch_id,
  KC.branch_name,
  KC.kota AS kota,
  KC.provinsi AS provinsi,
  KC.rating AS rating_cabang,
  FT.customer_name,
  FT.product_id,
  PD.product_name,
  FT.price AS actual_price,
  FT.discount_percentage,
  PGL.persentase_gross_laba,
  (FT.price - FT.price * FT.discount_percentage) AS nett_sales,
  (FT.price - FT.price * FT.discount_percentage) * PGL.persentase_gross_laba AS nett_profit,
  FT.rating AS rating_transaksi
FROM
  `rakamin-kf-analytics-440201.Kimia_Farma.kf_final_transaction` AS FT
LEFT JOIN
  `rakamin-kf-analytics-440201.Kimia_Farma.kf_kantor_cabang` AS KC
ON
  FT.branch_id = KC.branch_id
LEFT JOIN
  `rakamin-kf-analytics-440201.Kimia_Farma.kf_product` AS PD
ON
  FT.product_id = PD.product_id
JOIN
  PersentaseGrossLaba AS PGL
ON
  FT.product_id = PGL.product_id