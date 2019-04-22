CREATE INDEX IDX_Renew ON C_RetentionDBQuery (
    quarter ASC,
    geo_code ASC,
    product_category,
    route_to_market,
    segment_pivot,
    subscription_offering,
    route_to_market
);
