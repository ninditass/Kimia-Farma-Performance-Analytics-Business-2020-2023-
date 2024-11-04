WITH DuplicateCheck AS (
  SELECT 
    transaction_id,
    COUNT(*) AS count
  FROM 
    `rakamin-kf-analytics-440201.Kimia_Farma.kf_gabungan`
  GROUP BY 
    transaction_id
  HAVING 
    COUNT(*) > 1
),
NullCheck AS (
  SELECT 
    COUNT(*) AS total_nulls_customer_name
  FROM 
    `rakamin-kf-analytics-440201.Kimia_Farma.kf_gabungan`
  WHERE 
    customer_name IS NULL
)

SELECT 
  (SELECT COUNT(*) FROM DuplicateCheck) AS total_duplicates,
  (SELECT total_nulls_customer_name FROM NullCheck) AS total_nulls_customer_name;