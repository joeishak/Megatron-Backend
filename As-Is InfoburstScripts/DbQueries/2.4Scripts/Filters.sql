--GeoFilters
SELECT DISTINCT geo_code  from availablefilters;
--MarketFilters
SELECT DISTINCT market_area_code  from availablefilters;
--QuarterFilters
SELECT DISTINCT quarter from availablefilters;
--SegmenntFilters
SELECT DISTINCT segment_pivot  from availablefilters;
--SubscriptionFilters
SELECT DISTINCT subscription_offering  from availablefilters;
--ProductFilters
SELECT DISTINCT product_name  from availablefilters;
--RouteFilters
SELECT DISTINCT route_to_market  from availablefilters;
--ChannelFilters
SELECT DISTINCT channel  from availablefilters where visit_type  != 'NULL';
--SignUpFilters
SELECT DISTINCT signup_category  from availablefilters where visit_type  != 'NULL';
--VisitFilters
SELECT DISTINCT visit_type  from availablefilters where visit_type  != 'NULL';