SELECT * FROM {{ ref('dim_listings_cleaned') }}
INNER JOIN {{ ref('fct_reviews') }}
USING (listing_id)
WHERE dim_listings_cleaned.created_at >= fct_reviews.review_date