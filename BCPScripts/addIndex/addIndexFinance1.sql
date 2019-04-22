CREATE INDEX IDX_Finance1 ON C_FinanceDBQuery (
    quarter ASC,
    geo_code ASC,
    product_category,
    market_area_code,
    route_to_market,
    segment_pivot,
    subscription_offering
);
