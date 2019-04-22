CREATE INDEX IDX_TrafficQry ON C_TrafficDBQuery (
    quarter ASC,
    geo_code ASC,
    market_area_code,
    web_segment,
    visit_type,
    last_touch_channel
);
