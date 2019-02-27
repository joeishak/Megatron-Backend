/** Marektable Universe, Traffic, UQFM Conversion, Paid Media Spend, 
    PAid Media Srouced UQFM , New UQFM , Bounce Rate
--Grouped
G1 - Paid Media Spending
G2 - Marketable Universe, Paid Media Sourced UQFMS, 
    UQFM Convserion,  New UQFM
G3 - 
G4 -
G5 - Traffic , bounce
G6 -
G7 -
**/

-- DiscoverActualTargetPrimary
select
	sum(TrafficActual          )      as TrafficActual,
	sum(TrafficTargetFQ          )      as TrafficTargetFQ,
	cast((sum(TrafficActual)-SUM(TrafficTarget)) AS float )/ cast(abs(sum(nullif(TrafficTarget,0))) AS float) as TrafficVsQrf,
    sum(TrafficTarget) as TrafficTarget
from JourneyG5ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)



-- DiscoverG1ActualTargetSecondary
select
	sum( PaidMediaSpendActual) 														as PaidMediaSpendActual,
	sum( PaidMediaSpendTargetFQ) 													as PaidMediaSpendTargetFQ,
	cast((sum(PaidMediaSpendActual)-SUM(PaidMediaSpendTarget)) AS float )/ cast(abs(sum(nullif(PaidMediaSpendTarget,0))) AS float) as PaidMediaSpendVsQrf,
    sum(PaidMediaSpendTarget) as PaidMediaSpendTarget
from JourneyG1ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	
-- DiscoverG2ActualTargetSecondary
select
	  --Marketable Universe
    sum(MarketableUniverseActual          )      as MarketableUniverseActual,
	sum(MarketableUniverseTargetFQ           )      as MarketableUniverseTargetFQ ,
	cast((sum(MarketableUniverseActual)-SUM(MarketableUniverseTarget)) AS float )/ cast(abs(sum(nullif(MarketableUniverseTarget,0))) AS float) as MarketableUniverseVsQrf,
	sum(MarketableUniverseTarget) as MarketableUniverseTarget,
    -- Paid Media Sourced UQFMS
    sum(PaidMediaSourcedUQFMSActual )      as PaidMediaSourcedUQFMSActual,
	sum(PaidMediaSourcedUQFMSTargetFQ  )      as PaidMediaSourcedUQFMSTargetFQ ,
	cast((sum(PaidMediaSourcedUQFMSActual)-SUM(PaidMediaSourcedUQFMSTarget)) AS float )/ cast(abs(sum(nullif(PaidMediaSourcedUQFMSTarget,0))) AS float) as PaidMediaSourcedUQFMSVsQRF,
    sum(PaidMediaSourcedUQFMSTarget) as PaidMediaSourcedUQFMSTarget,
    -- UQFM Convserion
    sum(UQFMConversionActual        )      as UQFMConversionActual,
	sum(UQFMConversionActual         )      as UQFMConversionTargetFQ ,
	cast((sum(UQFMConversionActual)-SUM(UQFMConversionActual)) AS float )/ cast(abs(sum(nullif(UQFMConversionActual,0))) AS float) as UQFMVsQrf,
	sum(UQFMConversionActual         )      as UQFMConversionTarget ,
	-- New UQFM
	sum(NewUQFMSActual        )      as NewUQFMSActual,
	sum(NewUQFMSTargetFQ         )      as NewUQFMSTargetFQ ,
	cast((sum(NewUQFMSActual)-SUM(NewUQFMSTarget)) AS float )/ cast(abs(sum(nullif(NewUQFMSTarget,0))) AS float) as NewUQFMSVsQrf,
	sum(NewUQFMSTarget) as NewUQFMSTarget
from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)

-- DiscoverG5ActualTargetSecondary
select
	--BOunce Rate
cast(sum(BounceRateActual) as float ) / sum(EntriesActual)   AS BounceRateActual
from JourneyG5ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
--DiscoverG1MultiChartQuery
select
	week,
    -- Paid Media Sourced UQFMS
    sum(PaidMediaSpendActual )      as PaidMediaSpendActual,
	sum(PaidMediaSpendTargetFQ  )      as PaidMediaSpendTargetFQ ,
    sum(PaidMediaSpendLQ) as PaidMediaSpendLQ,
	sum(PaidMediaSpendLY) as PaidMediaSpendLY
from JourneyG1ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
group by Week
	order by week desc
--DiscoverG2MultiChartQuery
select
	week,
	  --Marketable Universe
    sum(MarketableUniverseActual          )      as MarketableUniverseActual,
	sum(MarketableUniverseTargetFQ           )      as MarketableUniverseTargetFQ ,
	sum(MarketableUniverseLQ) as MarketableUniverseLQ,
	sum(MarketableUniverseLY) as MarketableUniverseLY,

    -- Paid Media Sourced UQFMS
    sum(PaidMediaSourcedUQFMSActual )      as PaidMediaSourcedUQFMSActual,
	sum(PaidMediaSourcedUQFMSTargetFQ  )      as PaidMediaSourcedUQFMSTargetFQ ,
    sum(PaidMediaSourcedUQFMSLQ) as PaidMediaSourcedUQFMSLQ,
	sum(PaidMediaSourcedUQFMSLY) as PaidMediaSourcedUQFMSLY,
    -- UQFM Convserion
	cast(sum(UQFMNOMActual)    as float) / cast(sum(UQFMDenomActual)as float) AS UQFMConversionActual,
	cast(sum(UQFMNOMLQ)        as float) / cast(sum(UQFMDenomLQ)as float) AS UQFMConversionLQ,
	cast(sum(UQFMNOMLY)        as float) / cast(sum(UQFMDenomLY)as float) AS UQFMConversionLY,
	 -- New UQFM
	sum(NewUQFMSActual        )      as NewUQFMSActual,
	sum(NewUQFMSTargetFQ         )      as NewUQFMSTargetFQ ,
	sum(NewUQFMSLY) as NewUQFMSLY,
	sum(NewUQFMSLQ) as NewUQFMSLQ
	from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
group by Week
	order by week desc
--DiscoverG5MultiChartQuery
select
	Week,
	sum(TrafficActual          )      as TrafficActual,
	sum(TrafficTargetFQ          )      as TrafficTargetFQ,
	sum(TrafficLY   )       as TrafficLY,
	sum(TrafficLQ   )       as TrafficLQ,
 	cast(sum(BounceRateActual) as float ) / sum(EntriesActual)   AS BounceRateActual,
    cast(sum(BounceRateCW) as float ) / sum(EntriesCW)   AS BounceRateCW,
    (sum(BounceRateActual)-sum(BounceRateLYLQ)) / nullIf(sum(BounceRateLYLQ),0) as BounceRateQQLY,
    (sum(BounceRateActual)-sum(BounceRateLQ)) / nullIf(sum(BounceRateLQ),0) as BounceRateQQLY,
    (sum(BounceRateCW)-sum(BounceRateLW)) / nullIf(sum(BounceRateLW),0) as BounceRateWW,
    (sum(BounceRateActual)-sum(BounceRateLY)) / nullIf(sum(BounceRateLY),0) as BounceRateYY
from JourneyG5ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
group by Week
	order by week desc

--DiscoverG1QTD
Select
	sum( PaidMediaSpendActual) 														as PaidMediaSpendActual,
	sum( PaidMediaSpendTargetFQ) 													as PaidMediaSpendTarget,
	sum(PaidMediaSpendCW) 															as PaidMediaSpendCW,
	sum(PaidMediaSpendTargetCW) 														as PaidMediaSpendTargetCW,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY) )as float)/ nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendQQLY,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLQ) ) as float)/ nullIf(sum(PaidMediaSpendLQ),0) as PaidMediaSpendQQTY,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget))as float) / nullIf(sum(PaidMediaSpendTarget),0) as PaidMediaSpendVsQrf,
	 cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW)) as float)/ nullIf(sum(PaidMediaSpendTargetCW),0) as PaidMediaSpendVsQrfCW,
	 cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendLW) ) as float)/ nullIf(sum(PaidMediaSpendLW),0) as PaidMediaSpendWW,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY)) as float) / nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendYY,
	sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget) as PaidMediaSpendVsQrfDiff,
	sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW) as PaidMediaSpendVsQrfDiffCW
from JourneyG1ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
--DiscoverG2QTD
Select

	 --Marketable Universe
	 
	sum( MarketableUniverseActual) 														as MarketableUniverseActual,
	sum( MarketableUniverseTargetFQ) 													as MarketableUniverseTargetFQ,
	sum(MarketableUniverseCW) 															as MarketableUniverseCW,
	sum(MarketableUniverseTargetCW) 	as MarketableUniverseTargetCW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLYLQ) ) 	as float) / nullIf(sum(MarketableUniverseLYLQ),0) as MarketableUniverseQQLY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLQ) )	 	as float) / nullIf(sum(MarketableUniverseLQ),0) as MarketableUniverseQQTY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseTarget)) as float) / nullIf(sum(MarketableUniverseTarget),0) as MarketableUniverseVsQrf,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW)) 	as float) / nullIf(sum(MarketableUniverseTargetCW),0) as MarketableUniverseVsQrfCW,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseLW) )			as float) / nullIf(sum(MarketableUniverseLW),0) as MarketableUniverseWW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLY)) 		as float) / nullIf(sum(MarketableUniverseLY),0) as MarketableUniverseYY,
	sum(MarketableUniverseActual) - sum(MarketableUniverseTarget) as MarketableUniverseVsQrfDiff,
	sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW) as MarketableUniverseVsQrfDiffCW,
	-- Paid Media Sourced UQFMS
	sum( PaidMediaSourcedUQFMSActual) 														as PaidMediaSourcedUQFMSActual,
	sum( PaidMediaSourcedUQFMSTargetFQ) 													as PaidMediaSourcedUQFMSTargetFQ,
	sum(PaidMediaSourcedUQFMSCW) 															as PaidMediaSourcedUQFMSCW,
	sum(PaidMediaSourcedUQFMSTargetCW) 	as PaidMediaSourcedUQFMSTargetCW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLYLQ) )	as float) / nullIf(sum(PaidMediaSourcedUQFMSLYLQ),0) as PaidMediaSourcedUQFMSQQLY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLQ) )		as float) / nullIf(sum(PaidMediaSourcedUQFMSLQ),0) as PaidMediaSourcedUQFMSQQTY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget)) as float) / nullIf(sum(PaidMediaSourcedUQFMSTarget),0) as PaidMediaSourcedUQFMSVsQrf,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW)) 	as float) / nullIf(sum(PaidMediaSourcedUQFMSTargetCW),0) as PaidMediaSourcedUQFMSVsQrfCW,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSLW) )			as float) / nullIf(sum(PaidMediaSourcedUQFMSLW),0) as PaidMediaSourcedUQFMSWW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLY)) 		as float) / nullIf(sum(PaidMediaSourcedUQFMSLY),0) as PaidMediaSourcedUQFMSYY,
	sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget) as PaidMediaSourcedUQFMSVsQrfDiff,
	sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW) as PaidMediaSourcedUQFMSVsQrfDiffCW,
	 -- UQFM Convserion
	 /**TODO: DEBUG ARITHEMETIC ERROR
	 cast(sum(UQFMNOMActual)    as float) / cast(sum(UQFMDenomActual)as float) AS UQFMConversionActual,
	cast(sum(UQFMNOMCW)        as float) / cast(sum(UQFMDenomCW)as float) AS UQFMConversionCW,
	cast(sum(UQFMNOMLQ)        as float) / cast(sum(UQFMDenomLQ)as float) AS UQFMConversionLQ,
	cast(sum(UQFMNOMLW)        as float) / cast(sum(UQFMDenomLW)as float) AS UQFMConversionLW,
	cast(sum(UQFMNOMLY)        as float) / cast(sum(UQFMDenomLY)as float) AS UQFMConversionLY,
	cast(sum(UQFMNOMLYLQ)      as float) / cast(sum(UQFMDenomLYLQ)as float) AS UQFMConversionLYLQ
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ))) / (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ)) as UQFMConversionQQLY,
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLQ) / sum(UQFMDenomLQ))) / (sum(UQFMNOMLQ) / sum(UQFMDenomLQ)) as UQFMConversionQQTY

	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LQ)) / sum(UQFM Conversion LQ)
	(sum(UQFM Conversion CW) - sum(UQFM Conversion  LW))    / sum(UQFM Conversion  LW)
	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LY)) / sum(UQFM Conversion LY)
	sum((UQFMConversionActual-UQFMConversionLYLQ))/sum(nullIf(UQFMConversionLYLQ,0)) as UQFMConversionQQLY,
	sum((UQFMConversionActual-UQFMConversionLQ))/sum(nullIf(UQFMConversionLQ,0)) as UQFMConversionQQTY,
	sum((UQFMConversionCW-UQFMConversionLW))/sum(nullIf(UQFMConversionLW,0)) as UQFMConversionWW,
	sum((UQFMConversionActual-UQFMConversionLY))/sum(nullIf(UQFMConversionLY,0)) as UQFMConversionYY,
	**/
	 -- New UQFM
	sum( NewUQFMSActual) 														as NewUQFMSActual,
	sum( NewUQFMSTargetFQ) 													as NewUQFMSTargetFQ,
	sum(NewUQFMSCW) 															as NewUQFMSCW,
	sum(NewUQFMSTargetCW) 	as NewUQFMSTargetCW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLYLQ) )	as float) / nullIf(sum(NewUQFMSLYLQ),0) as NewUQFMSQQLY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLQ) )		as float) / nullIf(sum(NewUQFMSLQ),0) as NewUQFMSQQTY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSTarget)) as float) / nullIf(sum(NewUQFMSTarget),0) as NewUQFMSVsQrf,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSTargetCW)) 	as float) / nullIf(sum(NewUQFMSTargetCW),0) as NewUQFMSVsQrfCW,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSLW) )			as float) / nullIf(sum(NewUQFMSLW),0) as NewUQFMSWW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLY)) 		as float) / nullIf(sum(NewUQFMSLY),0) as NewUQFMSYY,
	sum(NewUQFMSActual) - sum(NewUQFMSTarget) as NewUQFMSVsQrfDiff,
	sum(NewUQFMSCW) - sum(NewUQFMSTargetCW) as NewUQFMSVsQrfDiffCW						as NewUQFMSTargetCW
	

from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
--DiscoverG5QTD
Select
	 --Traffic
	sum(TrafficYY)	as TrafficYY,
	sum( TrafficActual) 														as TrafficActual,
	sum( TrafficTargetFQ) 													as TrafficTargetFQ,
	sum(TrafficCW) 															as TrafficCW,
	sum(TrafficTargetCW) 	as TrafficTargetCW,
	cast((sum(TrafficActual) - sum(TrafficLYLQ) )	as float) / nullIf(sum(TrafficLYLQ),0) as TrafficQQLY,
	cast((sum(TrafficActual) - sum(TrafficLQ) )		as float) / nullIf(sum(TrafficLQ),0) as TrafficQQTY,
	cast((sum(TrafficActual) - sum(TrafficTarget)) as float) / nullIf(sum(TrafficTarget),0) as TrafficVsQrf,
	cast((sum(TrafficCW) - sum(TrafficTargetCW)) 	as float) / nullIf(sum(TrafficTargetCW),0) as TrafficVsQrfCW,
	cast((sum(TrafficCW) - sum(TrafficLW) )			as float) / nullIf(sum(TrafficLW),0) as TrafficWW,
	cast((sum(TrafficActual) - sum(TrafficLY)) 		as float) / nullIf(sum(TrafficLY),0) as TrafficYY,
	sum(TrafficActual) - sum(TrafficTarget) as TrafficVsQrfDiff,
	sum(TrafficCW) - sum(TrafficTargetCW) as TrafficVsQrfDiffCW,
    cast(sum(BounceRateActual) as float ) / sum(EntriesActual)   AS BounceRateActual,
    cast(sum(BounceRateCW) as float ) / sum(EntriesCW)   AS BounceRateCW,
    (sum(BounceRateActual)-sum(BounceRateLYLQ)) / nullIf(sum(BounceRateLYLQ),0) as BounceRateQQLY,
    (sum(BounceRateActual)-sum(BounceRateLQ)) / nullIf(sum(BounceRateLQ),0) as BounceRateQQLY,
    (sum(BounceRateCW)-sum(BounceRateLW)) / nullIf(sum(BounceRateLW),0) as BounceRateWW,
    (sum(BounceRateActual)-sum(BounceRateLY)) / nullIf(sum(BounceRateLY),0) as BounceRateYY

from JourneyG5ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)

-- DiscoverG1GeoQTD
Select
	geo_code,
	market_area_group,
	sum( PaidMediaSpendActual) 														as PaidMediaSpendActual,
	sum( PaidMediaSpendTargetFQ) 													as PaidMediaSpendTarget,
	sum(PaidMediaSpendCW) 															as PaidMediaSpendCW,
	sum(PaidMediaSpendTargetCW) 														as PaidMediaSpendTargetCW,
	cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY) )as float)/ nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendQQLY,
	cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLQ) ) as float)/ nullIf(sum(PaidMediaSpendLQ),0) as PaidMediaSpendQQTY,
	cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget))as float) / nullIf(sum(PaidMediaSpendTarget),0) as PaidMediaSpendVsQrf,
	cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW)) as float)/ nullIf(sum(PaidMediaSpendTargetCW),0) as PaidMediaSpendVsQrfCW,
	cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendLW) ) as float)/ nullIf(sum(PaidMediaSpendLW),0) as PaidMediaSpendWW,
	cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY)) as float) / nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendYY,
	sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget) as PaidMediaSpendVsQrfDiff,
	sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW) as PaidMediaSpendVsQrfDiffCW
from JourneyG1ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
group by geo_code, market_area_group
order by 1, 2
-- DiscoverG2GeoQTD
Select
	geo_code,
	market_area_code,
	--Marketable Universe
	 
	sum(MarketableUniverseYY)	as MarketableUniverseYY,
	sum( MarketableUniverseActual) 														as MarketableUniverseActual,
	sum( MarketableUniverseTargetFQ) 													as MarketableUniverseTargetFQ,
	sum(MarketableUniverseCW) 															as MarketableUniverseCW,
	sum(MarketableUniverseTargetCW) 	as MarketableUniverseTargetCW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLYLQ) ) 	as float) / nullIf(sum(MarketableUniverseLYLQ),0) as MarketableUniverseQQLY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLQ) )	 	as float) / nullIf(sum(MarketableUniverseLQ),0) as MarketableUniverseQQTY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseTarget)) as float) / nullIf(sum(MarketableUniverseTarget),0) as MarketableUniverseVsQrf,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW)) 	as float) / nullIf(sum(MarketableUniverseTargetCW),0) as MarketableUniverseVsQrfCW,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseLW) )			as float) / nullIf(sum(MarketableUniverseLW),0) as MarketableUniverseWW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLY)) 		as float) / nullIf(sum(MarketableUniverseLY),0) as MarketableUniverseYY,
	sum(MarketableUniverseActual) - sum(MarketableUniverseTarget) as MarketableUniverseVsQrfDiff,
	sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW) as MarketableUniverseVsQrfDiffCW,
	-- Paid Media Sourced UQFMS
	sum(PaidMediaSourcedUQFMSYY)	as PaidMediaSourcedUQFMSYY,
	sum( PaidMediaSourcedUQFMSActual) 														as PaidMediaSourcedUQFMSActual,
	sum( PaidMediaSourcedUQFMSTargetFQ) 													as PaidMediaSourcedUQFMSTargetFQ,
	sum(PaidMediaSourcedUQFMSCW) 															as PaidMediaSourcedUQFMSCW,
	sum(PaidMediaSourcedUQFMSTargetCW) 	as PaidMediaSourcedUQFMSTargetCW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLYLQ) )	as float) / nullIf(sum(PaidMediaSourcedUQFMSLYLQ),0) as PaidMediaSourcedUQFMSQQLY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLQ) )		as float) / nullIf(sum(PaidMediaSourcedUQFMSLQ),0) as PaidMediaSourcedUQFMSQQTY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget)) as float) / nullIf(sum(PaidMediaSourcedUQFMSTarget),0) as PaidMediaSourcedUQFMSVsQrf,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW)) 	as float) / nullIf(sum(PaidMediaSourcedUQFMSTargetCW),0) as PaidMediaSourcedUQFMSVsQrfCW,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSLW) )			as float) / nullIf(sum(PaidMediaSourcedUQFMSLW),0) as PaidMediaSourcedUQFMSWW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLY)) 		as float) / nullIf(sum(PaidMediaSourcedUQFMSLY),0) as PaidMediaSourcedUQFMSYY,
	sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget) as PaidMediaSourcedUQFMSVsQrfDiff,
	sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW) as PaidMediaSourcedUQFMSVsQrfDiffCW,
	 -- UQFM Convserion
	 /**TODO: DEBUG ARITHEMETIC ERROR
	 cast(sum(UQFMNOMActual)    as float) / cast(sum(UQFMDenomActual)as float) AS UQFMConversionActual,
	cast(sum(UQFMNOMCW)        as float) / cast(sum(UQFMDenomCW)as float) AS UQFMConversionCW,
	cast(sum(UQFMNOMLQ)        as float) / cast(sum(UQFMDenomLQ)as float) AS UQFMConversionLQ,
	cast(sum(UQFMNOMLW)        as float) / cast(sum(UQFMDenomLW)as float) AS UQFMConversionLW,
	cast(sum(UQFMNOMLY)        as float) / cast(sum(UQFMDenomLY)as float) AS UQFMConversionLY,
	cast(sum(UQFMNOMLYLQ)      as float) / cast(sum(UQFMDenomLYLQ)as float) AS UQFMConversionLYLQ
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ))) / (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ)) as UQFMConversionQQLY,
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLQ) / sum(UQFMDenomLQ))) / (sum(UQFMNOMLQ) / sum(UQFMDenomLQ)) as UQFMConversionQQTY

	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LQ)) / sum(UQFM Conversion LQ)
	(sum(UQFM Conversion CW) - sum(UQFM Conversion  LW))    / sum(UQFM Conversion  LW)
	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LY)) / sum(UQFM Conversion LY)
	sum((UQFMConversionActual-UQFMConversionLYLQ))/sum(nullIf(UQFMConversionLYLQ,0)) as UQFMConversionQQLY,
	sum((UQFMConversionActual-UQFMConversionLQ))/sum(nullIf(UQFMConversionLQ,0)) as UQFMConversionQQTY,
	sum((UQFMConversionCW-UQFMConversionLW))/sum(nullIf(UQFMConversionLW,0)) as UQFMConversionWW,
	sum((UQFMConversionActual-UQFMConversionLY))/sum(nullIf(UQFMConversionLY,0)) as UQFMConversionYY,
	**/
	 -- New UQFM
	sum(NewUQFMSYY)	as NewUQFMSYY,
	sum( NewUQFMSActual) 														as NewUQFMSActual,
	sum( NewUQFMSTargetFQ) 													as NewUQFMSTargetFQ,
	sum(NewUQFMSCW) 															as NewUQFMSCW,
	sum(NewUQFMSTargetCW) 	as NewUQFMSTargetCW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLYLQ) )	as float) / nullIf(sum(NewUQFMSLYLQ),0) as NewUQFMSQQLY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLQ) )		as float) / nullIf(sum(NewUQFMSLQ),0) as NewUQFMSQQTY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSTarget)) as float) / nullIf(sum(NewUQFMSTarget),0) as NewUQFMSVsQrf,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSTargetCW)) 	as float) / nullIf(sum(NewUQFMSTargetCW),0) as NewUQFMSVsQrfCW,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSLW) )			as float) / nullIf(sum(NewUQFMSLW),0) as NewUQFMSWW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLY)) 		as float) / nullIf(sum(NewUQFMSLY),0) as NewUQFMSYY,
	sum(NewUQFMSActual) - sum(NewUQFMSTarget) as NewUQFMSVsQrfDiff,
	sum(NewUQFMSCW) - sum(NewUQFMSTargetCW) as NewUQFMSVsQrfDiffCW						as NewUQFMSTargetCW
	
from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
group by geo_code, market_area_code
order by 1, 2
-- DiscoverG5GeoQTD
Select
	geo_code,
	market_area_code,
	 --Traffic
	    sum(TrafficYY)	as TrafficYY,
	sum( TrafficActual) 														as TrafficActual,
	sum( TrafficTargetFQ) 													as TrafficTargetFQ,
	sum(TrafficCW) 															as TrafficCW,
	sum(TrafficTargetCW) 	as TrafficTargetCW,
	cast((sum(TrafficActual) - sum(TrafficLYLQ) )	as float) / nullIf(sum(TrafficLYLQ),0) as TrafficQQLY,
	cast((sum(TrafficActual) - sum(TrafficLQ) )		as float) / nullIf(sum(TrafficLQ),0) as TrafficQQTY,
	cast((sum(TrafficActual) - sum(TrafficTarget)) as float) / nullIf(sum(TrafficTarget),0) as TrafficVsQrf,
	cast((sum(TrafficCW) - sum(TrafficTargetCW)) 	as float) / nullIf(sum(TrafficTargetCW),0) as TrafficVsQrfCW,
	cast((sum(TrafficCW) - sum(TrafficLW) )			as float) / nullIf(sum(TrafficLW),0) as TrafficWW,
	cast((sum(TrafficActual) - sum(TrafficLY)) 		as float) / nullIf(sum(TrafficLY),0) as TrafficYY,
	sum(TrafficActual) - sum(TrafficTarget) as TrafficVsQrfDiff,
	sum(TrafficCW) - sum(TrafficTargetCW) as TrafficVsQrfDiffCW,
    cast(sum(BounceRateActual) as float ) / sum(EntriesActual)   AS BounceRateActual,
    cast(sum(BounceRateCW) as float ) / sum(EntriesCW)   AS BounceRateCW,
    (sum(BounceRateActual)-sum(BounceRateLYLQ)) / nullIf(sum(BounceRateLYLQ),0) as BounceRateQQLY,
    (sum(BounceRateActual)-sum(BounceRateLQ)) / nullIf(sum(BounceRateLQ),0) as BounceRateQQLY,
    (sum(BounceRateCW)-sum(BounceRateLW)) / nullIf(sum(BounceRateLW),0) as BounceRateWW,
    (sum(BounceRateActual)-sum(BounceRateLY)) / nullIf(sum(BounceRateLY),0) as BounceRateYY

from JourneyG5ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
group by geo_code, market_area_code
order by 1, 2
-- DiscoverG1MarketAreaQTD
Select
	market_area_code,
	sum( PaidMediaSpendActual) 														as PaidMediaSpendActual,
	sum( PaidMediaSpendTargetFQ) 													as PaidMediaSpendTarget,
	sum(PaidMediaSpendCW) 															as PaidMediaSpendCW,
	sum(PaidMediaSpendTargetCW) 														as PaidMediaSpendTargetCW,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY) )as float)/ nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendQQLY,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLQ) ) as float)/ nullIf(sum(PaidMediaSpendLQ),0) as PaidMediaSpendQQTY,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget))as float) / nullIf(sum(PaidMediaSpendTarget),0) as PaidMediaSpendVsQrf,
	 cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW)) as float)/ nullIf(sum(PaidMediaSpendTargetCW),0) as PaidMediaSpendVsQrfCW,
	 cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendLW) ) as float)/ nullIf(sum(PaidMediaSpendLW),0) as PaidMediaSpendWW,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY)) as float) / nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendYY,
	sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget) as PaidMediaSpendVsQrfDiff,
	sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW) as PaidMediaSpendVsQrfDiffCW
from JourneyG1ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
group by market_area_code
order by 1
-- DiscoverG2MarketAreaQTD
Select
	market_area_code,
	--Marketable Universe
	 
	sum(MarketableUniverseYY)	as MarketableUniverseYY,
	sum( MarketableUniverseActual) 														as MarketableUniverseActual,
	sum( MarketableUniverseTargetFQ) 													as MarketableUniverseTargetFQ,
	sum(MarketableUniverseCW) 															as MarketableUniverseCW,
	sum(MarketableUniverseTargetCW) 	as MarketableUniverseTargetCW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLYLQ) ) 	as float) / nullIf(sum(MarketableUniverseLYLQ),0) as MarketableUniverseQQLY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLQ) )	 	as float) / nullIf(sum(MarketableUniverseLQ),0) as MarketableUniverseQQTY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseTarget)) as float) / nullIf(sum(MarketableUniverseTarget),0) as MarketableUniverseVsQrf,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW)) 	as float) / nullIf(sum(MarketableUniverseTargetCW),0) as MarketableUniverseVsQrfCW,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseLW) )			as float) / nullIf(sum(MarketableUniverseLW),0) as MarketableUniverseWW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLY)) 		as float) / nullIf(sum(MarketableUniverseLY),0) as MarketableUniverseYY,
	sum(MarketableUniverseActual) - sum(MarketableUniverseTarget) as MarketableUniverseVsQrfDiff,
	sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW) as MarketableUniverseVsQrfDiffCW
	-- Paid Media Sourced UQFMS
	sum(PaidMediaSourcedUQFMSYY)	as PaidMediaSourcedUQFMSYY,
	sum( PaidMediaSourcedUQFMSActual) 														as PaidMediaSourcedUQFMSActual,
	sum( PaidMediaSourcedUQFMSTargetFQ) 													as PaidMediaSourcedUQFMSTargetFQ,
	sum(PaidMediaSourcedUQFMSCW) 															as PaidMediaSourcedUQFMSCW,
	sum(PaidMediaSourcedUQFMSTargetCW) 	as PaidMediaSourcedUQFMSTargetCW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLYLQ) )	as float) / nullIf(sum(PaidMediaSourcedUQFMSLYLQ),0) as PaidMediaSourcedUQFMSQQLY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLQ) )		as float) / nullIf(sum(PaidMediaSourcedUQFMSLQ),0) as PaidMediaSourcedUQFMSQQTY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget)) as float) / nullIf(sum(PaidMediaSourcedUQFMSTarget),0) as PaidMediaSourcedUQFMSVsQrf,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW)) 	as float) / nullIf(sum(PaidMediaSourcedUQFMSTargetCW),0) as PaidMediaSourcedUQFMSVsQrfCW,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSLW) )			as float) / nullIf(sum(PaidMediaSourcedUQFMSLW),0) as PaidMediaSourcedUQFMSWW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLY)) 		as float) / nullIf(sum(PaidMediaSourcedUQFMSLY),0) as PaidMediaSourcedUQFMSYY,
	sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget) as PaidMediaSourcedUQFMSVsQrfDiff,
	sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW) as PaidMediaSourcedUQFMSVsQrfDiffCW,
	 -- UQFM Convserion
	 /**TODO: DEBUG ARITHEMETIC ERROR
	 cast(sum(UQFMNOMActual)    as float) / cast(sum(UQFMDenomActual)as float) AS UQFMConversionActual,
	cast(sum(UQFMNOMCW)        as float) / cast(sum(UQFMDenomCW)as float) AS UQFMConversionCW,
	cast(sum(UQFMNOMLQ)        as float) / cast(sum(UQFMDenomLQ)as float) AS UQFMConversionLQ,
	cast(sum(UQFMNOMLW)        as float) / cast(sum(UQFMDenomLW)as float) AS UQFMConversionLW,
	cast(sum(UQFMNOMLY)        as float) / cast(sum(UQFMDenomLY)as float) AS UQFMConversionLY,
	cast(sum(UQFMNOMLYLQ)      as float) / cast(sum(UQFMDenomLYLQ)as float) AS UQFMConversionLYLQ
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ))) / (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ)) as UQFMConversionQQLY,
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLQ) / sum(UQFMDenomLQ))) / (sum(UQFMNOMLQ) / sum(UQFMDenomLQ)) as UQFMConversionQQTY

	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LQ)) / sum(UQFM Conversion LQ)
	(sum(UQFM Conversion CW) - sum(UQFM Conversion  LW))    / sum(UQFM Conversion  LW)
	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LY)) / sum(UQFM Conversion LY)
	sum((UQFMConversionActual-UQFMConversionLYLQ))/sum(nullIf(UQFMConversionLYLQ,0)) as UQFMConversionQQLY,
	sum((UQFMConversionActual-UQFMConversionLQ))/sum(nullIf(UQFMConversionLQ,0)) as UQFMConversionQQTY,
	sum((UQFMConversionCW-UQFMConversionLW))/sum(nullIf(UQFMConversionLW,0)) as UQFMConversionWW,
	sum((UQFMConversionActual-UQFMConversionLY))/sum(nullIf(UQFMConversionLY,0)) as UQFMConversionYY,
	**/
	 -- New UQFM
	sum(NewUQFMSYY)	as NewUQFMSYY,
	sum( NewUQFMSActual) 														as NewUQFMSActual,
	sum( NewUQFMSTargetFQ) 													as NewUQFMSTargetFQ,
	sum(NewUQFMSCW) 															as NewUQFMSCW,
	sum(NewUQFMSTargetCW) 	as NewUQFMSTargetCW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLYLQ) )	as float) / nullIf(sum(NewUQFMSLYLQ),0) as NewUQFMSQQLY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLQ) )		as float) / nullIf(sum(NewUQFMSLQ),0) as NewUQFMSQQTY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSTarget)) as float) / nullIf(sum(NewUQFMSTarget),0) as NewUQFMSVsQrf,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSTargetCW)) 	as float) / nullIf(sum(NewUQFMSTargetCW),0) as NewUQFMSVsQrfCW,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSLW) )			as float) / nullIf(sum(NewUQFMSLW),0) as NewUQFMSWW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLY)) 		as float) / nullIf(sum(NewUQFMSLY),0) as NewUQFMSYY,
	sum(NewUQFMSActual) - sum(NewUQFMSTarget) as NewUQFMSVsQrfDiff,
	sum(NewUQFMSCW) - sum(NewUQFMSTargetCW) as NewUQFMSVsQrfDiffCW						as NewUQFMSTargetCW
	
from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
group by market_area_code
order by 1
-- DiscoverG5MarketAreaQTD
Select
	market_area_code,
	 --Traffic
	 --Traffic
	    sum(TrafficYY)	as TrafficYY,
	sum( TrafficActual) 														as TrafficActual,
	sum( TrafficTargetFQ) 													as TrafficTargetFQ,
	sum(TrafficCW) 															as TrafficCW,
	sum(TrafficTargetCW) 	as TrafficTargetCW,
	cast((sum(TrafficActual) - sum(TrafficLYLQ) )	as float) / nullIf(sum(TrafficLYLQ),0) as TrafficQQLY,
	cast((sum(TrafficActual) - sum(TrafficLQ) )		as float) / nullIf(sum(TrafficLQ),0) as TrafficQQTY,
	cast((sum(TrafficActual) - sum(TrafficTarget)) as float) / nullIf(sum(TrafficTarget),0) as TrafficVsQrf,
	cast((sum(TrafficCW) - sum(TrafficTargetCW)) 	as float) / nullIf(sum(TrafficTargetCW),0) as TrafficVsQrfCW,
	cast((sum(TrafficCW) - sum(TrafficLW) )			as float) / nullIf(sum(TrafficLW),0) as TrafficWW,
	cast((sum(TrafficActual) - sum(TrafficLY)) 		as float) / nullIf(sum(TrafficLY),0) as TrafficYY,
	sum(TrafficActual) - sum(TrafficTarget) as TrafficVsQrfDiff,
	sum(TrafficCW) - sum(TrafficTargetCW) as TrafficVsQrfDiffCW,
   cast(sum(BounceRateActual) as float ) / sum(EntriesActual)   AS BounceRateActual,
    cast(sum(BounceRateCW) as float ) / sum(EntriesCW)   AS BounceRateCW,
    (sum(BounceRateActual)-sum(BounceRateLYLQ)) / nullIf(sum(BounceRateLYLQ),0) as BounceRateQQLY,
    (sum(BounceRateActual)-sum(BounceRateLQ)) / nullIf(sum(BounceRateLQ),0) as BounceRateQQLY,
    (sum(BounceRateCW)-sum(BounceRateLW)) / nullIf(sum(BounceRateLW),0) as BounceRateWW,
    (sum(BounceRateActual)-sum(BounceRateLY)) / nullIf(sum(BounceRateLY),0) as BounceRateYY

from JourneyG5ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
group by market_area_code
order by 1
-- DiscoverG1SegmentQTD
Select
	segment_pivot,
    sum( PaidMediaSpendActual) 														as PaidMediaSpendActual,
	sum( PaidMediaSpendTargetFQ) 													as PaidMediaSpendTarget,
	sum(PaidMediaSpendCW) 															as PaidMediaSpendCW,
	sum(PaidMediaSpendTargetCW) 														as PaidMediaSpendTargetCW,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY) )as float)/ nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendQQLY,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLQ) ) as float)/ nullIf(sum(PaidMediaSpendLQ),0) as PaidMediaSpendQQTY,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget))as float) / nullIf(sum(PaidMediaSpendTarget),0) as PaidMediaSpendVsQrf,
	 cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW)) as float)/ nullIf(sum(PaidMediaSpendTargetCW),0) as PaidMediaSpendVsQrfCW,
	 cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendLW) ) as float)/ nullIf(sum(PaidMediaSpendLW),0) as PaidMediaSpendWW,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY)) as float) / nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendYY,
	sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget) as PaidMediaSpendVsQrfDiff,
	sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW) as PaidMediaSpendVsQrfDiffCW
from JourneyG1ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
group by  segment_pivot
order by 1;
-- DiscoverG2SegmentQTD
Select
	segment_pivot,
    --Marketable Universe
	 
	sum(MarketableUniverseYY)	as MarketableUniverseYY,
	sum( MarketableUniverseActual) 														as MarketableUniverseActual,
	sum( MarketableUniverseTargetFQ) 													as MarketableUniverseTargetFQ,
	sum(MarketableUniverseCW) 															as MarketableUniverseCW,
	sum(MarketableUniverseTargetCW) 	as MarketableUniverseTargetCW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLYLQ) ) 	as float) / nullIf(sum(MarketableUniverseLYLQ),0) as MarketableUniverseQQLY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLQ) )	 	as float) / nullIf(sum(MarketableUniverseLQ),0) as MarketableUniverseQQTY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseTarget)) as float) / nullIf(sum(MarketableUniverseTarget),0) as MarketableUniverseVsQrf,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW)) 	as float) / nullIf(sum(MarketableUniverseTargetCW),0) as MarketableUniverseVsQrfCW,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseLW) )			as float) / nullIf(sum(MarketableUniverseLW),0) as MarketableUniverseWW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLY)) 		as float) / nullIf(sum(MarketableUniverseLY),0) as MarketableUniverseYY,
	sum(MarketableUniverseActual) - sum(MarketableUniverseTarget) as MarketableUniverseVsQrfDiff,
	sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW) as MarketableUniverseVsQrfDiffCW
	-- Paid Media Sourced UQFMS
	sum(PaidMediaSourcedUQFMSYY)	as PaidMediaSourcedUQFMSYY,
	sum( PaidMediaSourcedUQFMSActual) 														as PaidMediaSourcedUQFMSActual,
	sum( PaidMediaSourcedUQFMSTargetFQ) 													as PaidMediaSourcedUQFMSTargetFQ,
	sum(PaidMediaSourcedUQFMSCW) 															as PaidMediaSourcedUQFMSCW,
	sum(PaidMediaSourcedUQFMSTargetCW) 	as PaidMediaSourcedUQFMSTargetCW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLYLQ) )	as float) / nullIf(sum(PaidMediaSourcedUQFMSLYLQ),0) as PaidMediaSourcedUQFMSQQLY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLQ) )		as float) / nullIf(sum(PaidMediaSourcedUQFMSLQ),0) as PaidMediaSourcedUQFMSQQTY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget)) as float) / nullIf(sum(PaidMediaSourcedUQFMSTarget),0) as PaidMediaSourcedUQFMSVsQrf,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW)) 	as float) / nullIf(sum(PaidMediaSourcedUQFMSTargetCW),0) as PaidMediaSourcedUQFMSVsQrfCW,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSLW) )			as float) / nullIf(sum(PaidMediaSourcedUQFMSLW),0) as PaidMediaSourcedUQFMSWW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLY)) 		as float) / nullIf(sum(PaidMediaSourcedUQFMSLY),0) as PaidMediaSourcedUQFMSYY,
	sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget) as PaidMediaSourcedUQFMSVsQrfDiff,
	sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW) as PaidMediaSourcedUQFMSVsQrfDiffCW,
	 -- UQFM Convserion
	 /**TODO: DEBUG ARITHEMETIC ERROR
	 cast(sum(UQFMNOMActual)    as float) / cast(sum(UQFMDenomActual)as float) AS UQFMConversionActual,
	cast(sum(UQFMNOMCW)        as float) / cast(sum(UQFMDenomCW)as float) AS UQFMConversionCW,
	cast(sum(UQFMNOMLQ)        as float) / cast(sum(UQFMDenomLQ)as float) AS UQFMConversionLQ,
	cast(sum(UQFMNOMLW)        as float) / cast(sum(UQFMDenomLW)as float) AS UQFMConversionLW,
	cast(sum(UQFMNOMLY)        as float) / cast(sum(UQFMDenomLY)as float) AS UQFMConversionLY,
	cast(sum(UQFMNOMLYLQ)      as float) / cast(sum(UQFMDenomLYLQ)as float) AS UQFMConversionLYLQ
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ))) / (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ)) as UQFMConversionQQLY,
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLQ) / sum(UQFMDenomLQ))) / (sum(UQFMNOMLQ) / sum(UQFMDenomLQ)) as UQFMConversionQQTY

	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LQ)) / sum(UQFM Conversion LQ)
	(sum(UQFM Conversion CW) - sum(UQFM Conversion  LW))    / sum(UQFM Conversion  LW)
	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LY)) / sum(UQFM Conversion LY)
	sum((UQFMConversionActual-UQFMConversionLYLQ))/sum(nullIf(UQFMConversionLYLQ,0)) as UQFMConversionQQLY,
	sum((UQFMConversionActual-UQFMConversionLQ))/sum(nullIf(UQFMConversionLQ,0)) as UQFMConversionQQTY,
	sum((UQFMConversionCW-UQFMConversionLW))/sum(nullIf(UQFMConversionLW,0)) as UQFMConversionWW,
	sum((UQFMConversionActual-UQFMConversionLY))/sum(nullIf(UQFMConversionLY,0)) as UQFMConversionYY,
	**/
	 -- New UQFM
	sum(NewUQFMSYY)	as NewUQFMSYY,
	sum( NewUQFMSActual) 														as NewUQFMSActual,
	sum( NewUQFMSTargetFQ) 													as NewUQFMSTargetFQ,
	sum(NewUQFMSCW) 															as NewUQFMSCW,
	sum(NewUQFMSTargetCW) 	as NewUQFMSTargetCW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLYLQ) )	as float) / nullIf(sum(NewUQFMSLYLQ),0) as NewUQFMSQQLY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLQ) )		as float) / nullIf(sum(NewUQFMSLQ),0) as NewUQFMSQQTY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSTarget)) as float) / nullIf(sum(NewUQFMSTarget),0) as NewUQFMSVsQrf,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSTargetCW)) 	as float) / nullIf(sum(NewUQFMSTargetCW),0) as NewUQFMSVsQrfCW,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSLW) )			as float) / nullIf(sum(NewUQFMSLW),0) as NewUQFMSWW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLY)) 		as float) / nullIf(sum(NewUQFMSLY),0) as NewUQFMSYY,
	sum(NewUQFMSActual) - sum(NewUQFMSTarget) as NewUQFMSVsQrfDiff,
	sum(NewUQFMSCW) - sum(NewUQFMSTargetCW) as NewUQFMSVsQrfDiffCW						as NewUQFMSTargetCW
	
from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
group by  segment_pivot
order by 1;
-- DiscoverG5SegmentQTD
Select
	segment_pivot,
     --Traffic
	 --Traffic
	    sum(TrafficYY)	as TrafficYY,
	sum( TrafficActual) 														as TrafficActual,
	sum( TrafficTargetFQ) 													as TrafficTargetFQ,
	sum(TrafficCW) 															as TrafficCW,
	sum(TrafficTargetCW) 	as TrafficTargetCW,
	cast((sum(TrafficActual) - sum(TrafficLYLQ) )	as float) / nullIf(sum(TrafficLYLQ),0) as TrafficQQLY,
	cast((sum(TrafficActual) - sum(TrafficLQ) )		as float) / nullIf(sum(TrafficLQ),0) as TrafficQQTY,
	cast((sum(TrafficActual) - sum(TrafficTarget)) as float) / nullIf(sum(TrafficTarget),0) as TrafficVsQrf,
	cast((sum(TrafficCW) - sum(TrafficTargetCW)) 	as float) / nullIf(sum(TrafficTargetCW),0) as TrafficVsQrfCW,
	cast((sum(TrafficCW) - sum(TrafficLW) )			as float) / nullIf(sum(TrafficLW),0) as TrafficWW,
	cast((sum(TrafficActual) - sum(TrafficLY)) 		as float) / nullIf(sum(TrafficLY),0) as TrafficYY,
	sum(TrafficActual) - sum(TrafficTarget) as TrafficVsQrfDiff,
	sum(TrafficCW) - sum(TrafficTargetCW) as TrafficVsQrfDiffCW,
   cast(sum(BounceRateActual) as float ) / sum(EntriesActual)   AS BounceRateActual,
    cast(sum(BounceRateCW) as float ) / sum(EntriesCW)   AS BounceRateCW,
    (sum(BounceRateActual)-sum(BounceRateLYLQ)) / nullIf(sum(BounceRateLYLQ),0) as BounceRateQQLY,
    (sum(BounceRateActual)-sum(BounceRateLQ)) / nullIf(sum(BounceRateLQ),0) as BounceRateQQLY,
    (sum(BounceRateCW)-sum(BounceRateLW)) / nullIf(sum(BounceRateLW),0) as BounceRateWW,
    (sum(BounceRateActual)-sum(BounceRateLY)) / nullIf(sum(BounceRateLY),0) as BounceRateYY
from JourneyG5ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
group by  segment_pivot
order by 1;
-- DiscoverG1RouteQTD
Select
	route_to_market,
    sum( PaidMediaSpendActual) 														as PaidMediaSpendActual,
	sum( PaidMediaSpendTargetFQ) 													as PaidMediaSpendTarget,
	sum(PaidMediaSpendCW) 															as PaidMediaSpendCW,
	sum(PaidMediaSpendTargetCW) 														as PaidMediaSpendTargetCW,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY) )as float)/ nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendQQLY,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLQ) ) as float)/ nullIf(sum(PaidMediaSpendLQ),0) as PaidMediaSpendQQTY,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget))as float) / nullIf(sum(PaidMediaSpendTarget),0) as PaidMediaSpendVsQrf,
	 cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW)) as float)/ nullIf(sum(PaidMediaSpendTargetCW),0) as PaidMediaSpendVsQrfCW,
	 cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendLW) ) as float)/ nullIf(sum(PaidMediaSpendLW),0) as PaidMediaSpendWW,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY)) as float) / nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendYY,
	sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget) as PaidMediaSpendVsQrfDiff,
	sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW) as PaidMediaSpendVsQrfDiffCW
from JourneyG1ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
group by  route_to_market
order by 1;
-- DiscoverG2RouteQTD
Select
	route_to_market,
   --Marketable Universe
	 
	sum(MarketableUniverseYY)	as MarketableUniverseYY,
	sum( MarketableUniverseActual) 														as MarketableUniverseActual,
	sum( MarketableUniverseTargetFQ) 													as MarketableUniverseTargetFQ,
	sum(MarketableUniverseCW) 															as MarketableUniverseCW,
	sum(MarketableUniverseTargetCW) 	as MarketableUniverseTargetCW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLYLQ) ) 	as float) / nullIf(sum(MarketableUniverseLYLQ),0) as MarketableUniverseQQLY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLQ) )	 	as float) / nullIf(sum(MarketableUniverseLQ),0) as MarketableUniverseQQTY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseTarget)) as float) / nullIf(sum(MarketableUniverseTarget),0) as MarketableUniverseVsQrf,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW)) 	as float) / nullIf(sum(MarketableUniverseTargetCW),0) as MarketableUniverseVsQrfCW,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseLW) )			as float) / nullIf(sum(MarketableUniverseLW),0) as MarketableUniverseWW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLY)) 		as float) / nullIf(sum(MarketableUniverseLY),0) as MarketableUniverseYY,
	sum(MarketableUniverseActual) - sum(MarketableUniverseTarget) as MarketableUniverseVsQrfDiff,
	sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW) as MarketableUniverseVsQrfDiffCW
	-- Paid Media Sourced UQFMS
	sum(PaidMediaSourcedUQFMSYY)	as PaidMediaSourcedUQFMSYY,
	sum( PaidMediaSourcedUQFMSActual) 														as PaidMediaSourcedUQFMSActual,
	sum( PaidMediaSourcedUQFMSTargetFQ) 													as PaidMediaSourcedUQFMSTargetFQ,
	sum(PaidMediaSourcedUQFMSCW) 															as PaidMediaSourcedUQFMSCW,
	sum(PaidMediaSourcedUQFMSTargetCW) 	as PaidMediaSourcedUQFMSTargetCW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLYLQ) )	as float) / nullIf(sum(PaidMediaSourcedUQFMSLYLQ),0) as PaidMediaSourcedUQFMSQQLY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLQ) )		as float) / nullIf(sum(PaidMediaSourcedUQFMSLQ),0) as PaidMediaSourcedUQFMSQQTY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget)) as float) / nullIf(sum(PaidMediaSourcedUQFMSTarget),0) as PaidMediaSourcedUQFMSVsQrf,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW)) 	as float) / nullIf(sum(PaidMediaSourcedUQFMSTargetCW),0) as PaidMediaSourcedUQFMSVsQrfCW,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSLW) )			as float) / nullIf(sum(PaidMediaSourcedUQFMSLW),0) as PaidMediaSourcedUQFMSWW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLY)) 		as float) / nullIf(sum(PaidMediaSourcedUQFMSLY),0) as PaidMediaSourcedUQFMSYY,
	sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget) as PaidMediaSourcedUQFMSVsQrfDiff,
	sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW) as PaidMediaSourcedUQFMSVsQrfDiffCW
	 -- UQFM Convserion
	 /**TODO: DEBUG ARITHEMETIC ERROR
	 cast(sum(UQFMNOMActual)    as float) / cast(sum(UQFMDenomActual)as float) AS UQFMConversionActual,
	cast(sum(UQFMNOMCW)        as float) / cast(sum(UQFMDenomCW)as float) AS UQFMConversionCW,
	cast(sum(UQFMNOMLQ)        as float) / cast(sum(UQFMDenomLQ)as float) AS UQFMConversionLQ,
	cast(sum(UQFMNOMLW)        as float) / cast(sum(UQFMDenomLW)as float) AS UQFMConversionLW,
	cast(sum(UQFMNOMLY)        as float) / cast(sum(UQFMDenomLY)as float) AS UQFMConversionLY,
	cast(sum(UQFMNOMLYLQ)      as float) / cast(sum(UQFMDenomLYLQ)as float) AS UQFMConversionLYLQ
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ))) / (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ)) as UQFMConversionQQLY,
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLQ) / sum(UQFMDenomLQ))) / (sum(UQFMNOMLQ) / sum(UQFMDenomLQ)) as UQFMConversionQQTY

	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LQ)) / sum(UQFM Conversion LQ)
	(sum(UQFM Conversion CW) - sum(UQFM Conversion  LW))    / sum(UQFM Conversion  LW)
	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LY)) / sum(UQFM Conversion LY)
	sum((UQFMConversionActual-UQFMConversionLYLQ))/sum(nullIf(UQFMConversionLYLQ,0)) as UQFMConversionQQLY,
	sum((UQFMConversionActual-UQFMConversionLQ))/sum(nullIf(UQFMConversionLQ,0)) as UQFMConversionQQTY,
	sum((UQFMConversionCW-UQFMConversionLW))/sum(nullIf(UQFMConversionLW,0)) as UQFMConversionWW,
	sum((UQFMConversionActual-UQFMConversionLY))/sum(nullIf(UQFMConversionLY,0)) as UQFMConversionYY,
	**/
	 -- New UQFM
	sum(NewUQFMSYY)	as NewUQFMSYY,
	sum( NewUQFMSActual) 														as NewUQFMSActual,
	sum( NewUQFMSTargetFQ) 													as NewUQFMSTargetFQ,
	sum(NewUQFMSCW) 															as NewUQFMSCW,
	sum(NewUQFMSTargetCW) 	as NewUQFMSTargetCW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLYLQ) )	as float) / nullIf(sum(NewUQFMSLYLQ),0) as NewUQFMSQQLY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLQ) )		as float) / nullIf(sum(NewUQFMSLQ),0) as NewUQFMSQQTY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSTarget)) as float) / nullIf(sum(NewUQFMSTarget),0) as NewUQFMSVsQrf,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSTargetCW)) 	as float) / nullIf(sum(NewUQFMSTargetCW),0) as NewUQFMSVsQrfCW,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSLW) )			as float) / nullIf(sum(NewUQFMSLW),0) as NewUQFMSWW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLY)) 		as float) / nullIf(sum(NewUQFMSLY),0) as NewUQFMSYY,
	sum(NewUQFMSActual) - sum(NewUQFMSTarget) as NewUQFMSVsQrfDiff,
	sum(NewUQFMSCW) - sum(NewUQFMSTargetCW) as NewUQFMSVsQrfDiffCW						as NewUQFMSTargetCW
	
from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
group by  route_to_market
order by 1;
-- DiscoverG5RouteQTD
Select
	route_to_market,
     --Traffic
	--Traffic
	    sum(TrafficYY)	as TrafficYY,
	sum( TrafficActual) 														as TrafficActual,
	sum( TrafficTargetFQ) 													as TrafficTargetFQ,
	sum(TrafficCW) 															as TrafficCW,
	sum(TrafficTargetCW) 	as TrafficTargetCW,
	cast((sum(TrafficActual) - sum(TrafficLYLQ) )	as float) / nullIf(sum(TrafficLYLQ),0) as TrafficQQLY,
	cast((sum(TrafficActual) - sum(TrafficLQ) )		as float) / nullIf(sum(TrafficLQ),0) as TrafficQQTY,
	cast((sum(TrafficActual) - sum(TrafficTarget)) as float) / nullIf(sum(TrafficTarget),0) as TrafficVsQrf,
	cast((sum(TrafficCW) - sum(TrafficTargetCW)) 	as float) / nullIf(sum(TrafficTargetCW),0) as TrafficVsQrfCW,
	cast((sum(TrafficCW) - sum(TrafficLW) )			as float) / nullIf(sum(TrafficLW),0) as TrafficWW,
	cast((sum(TrafficActual) - sum(TrafficLY)) 		as float) / nullIf(sum(TrafficLY),0) as TrafficYY,
	sum(TrafficActual) - sum(TrafficTarget) as TrafficVsQrfDiff,
	sum(TrafficCW) - sum(TrafficTargetCW) as TrafficVsQrfDiffCW,
    cast(sum(BounceRateActual) as float ) / sum(EntriesActual)   AS BounceRateActual,
    cast(sum(BounceRateCW) as float ) / sum(EntriesCW)   AS BounceRateCW,
    (sum(BounceRateActual)-sum(BounceRateLYLQ)) / nullIf(sum(BounceRateLYLQ),0) as BounceRateQQLY,
    (sum(BounceRateActual)-sum(BounceRateLQ)) / nullIf(sum(BounceRateLQ),0) as BounceRateQQLY,
    (sum(BounceRateCW)-sum(BounceRateLW)) / nullIf(sum(BounceRateLW),0) as BounceRateWW,
    (sum(BounceRateActual)-sum(BounceRateLY)) / nullIf(sum(BounceRateLY),0) as BounceRateYY

from JourneyG5ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
group by  route_to_market
order by 1;
-- DiscoverG1ProductQTD
Select
	product_name,
   sum( PaidMediaSpendActual) 														as PaidMediaSpendActual,
	sum( PaidMediaSpendTargetFQ) 													as PaidMediaSpendTarget,
	sum(PaidMediaSpendCW) 															as PaidMediaSpendCW,
	sum(PaidMediaSpendTargetCW) 														as PaidMediaSpendTargetCW,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY) )as float)/ nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendQQLY,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLQ) ) as float)/ nullIf(sum(PaidMediaSpendLQ),0) as PaidMediaSpendQQTY,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget))as float) / nullIf(sum(PaidMediaSpendTarget),0) as PaidMediaSpendVsQrf,
	 cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW)) as float)/ nullIf(sum(PaidMediaSpendTargetCW),0) as PaidMediaSpendVsQrfCW,
	 cast((sum(PaidMediaSpendCW) - sum(PaidMediaSpendLW) ) as float)/ nullIf(sum(PaidMediaSpendLW),0) as PaidMediaSpendWW,
	 cast((sum(PaidMediaSpendActual) - sum(PaidMediaSpendLY)) as float) / nullIf(sum(PaidMediaSpendLY),0) as PaidMediaSpendYY,
	sum(PaidMediaSpendActual) - sum(PaidMediaSpendTarget) as PaidMediaSpendVsQrfDiff,
	sum(PaidMediaSpendCW) - sum(PaidMediaSpendTargetCW) as PaidMediaSpendVsQrfDiffCW
from JourneyG1ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
group by  product_name 
order by 1;
-- DiscoverG2ProductQTD
Select
	product_name,
    --Marketable Universe
	 
	sum(MarketableUniverseYY)	as MarketableUniverseYY,
	sum( MarketableUniverseActual) 														as MarketableUniverseActual,
	sum( MarketableUniverseTargetFQ) 													as MarketableUniverseTargetFQ,
	sum(MarketableUniverseCW) 															as MarketableUniverseCW,
	sum(MarketableUniverseTargetCW) 	as MarketableUniverseTargetCW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLYLQ) ) 	as float) / nullIf(sum(MarketableUniverseLYLQ),0) as MarketableUniverseQQLY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLQ) )	 	as float) / nullIf(sum(MarketableUniverseLQ),0) as MarketableUniverseQQTY,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseTarget)) as float) / nullIf(sum(MarketableUniverseTarget),0) as MarketableUniverseVsQrf,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW)) 	as float) / nullIf(sum(MarketableUniverseTargetCW),0) as MarketableUniverseVsQrfCW,
	 cast((sum(MarketableUniverseCW) - sum(MarketableUniverseLW) )			as float) / nullIf(sum(MarketableUniverseLW),0) as MarketableUniverseWW,
	 cast((sum(MarketableUniverseActual) - sum(MarketableUniverseLY)) 		as float) / nullIf(sum(MarketableUniverseLY),0) as MarketableUniverseYY,
	sum(MarketableUniverseActual) - sum(MarketableUniverseTarget) as MarketableUniverseVsQrfDiff,
	sum(MarketableUniverseCW) - sum(MarketableUniverseTargetCW) as MarketableUniverseVsQrfDiffCW
	-- Paid Media Sourced UQFMS
	sum(PaidMediaSourcedUQFMSYY)	as PaidMediaSourcedUQFMSYY,
	sum( PaidMediaSourcedUQFMSActual) 														as PaidMediaSourcedUQFMSActual,
	sum( PaidMediaSourcedUQFMSTargetFQ) 													as PaidMediaSourcedUQFMSTargetFQ,
	sum(PaidMediaSourcedUQFMSCW) 															as PaidMediaSourcedUQFMSCW,
	sum(PaidMediaSourcedUQFMSTargetCW) 	as PaidMediaSourcedUQFMSTargetCW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLYLQ) )	as float) / nullIf(sum(PaidMediaSourcedUQFMSLYLQ),0) as PaidMediaSourcedUQFMSQQLY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLQ) )		as float) / nullIf(sum(PaidMediaSourcedUQFMSLQ),0) as PaidMediaSourcedUQFMSQQTY,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget)) as float) / nullIf(sum(PaidMediaSourcedUQFMSTarget),0) as PaidMediaSourcedUQFMSVsQrf,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW)) 	as float) / nullIf(sum(PaidMediaSourcedUQFMSTargetCW),0) as PaidMediaSourcedUQFMSVsQrfCW,
	cast((sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSLW) )			as float) / nullIf(sum(PaidMediaSourcedUQFMSLW),0) as PaidMediaSourcedUQFMSWW,
	cast((sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSLY)) 		as float) / nullIf(sum(PaidMediaSourcedUQFMSLY),0) as PaidMediaSourcedUQFMSYY,
	sum(PaidMediaSourcedUQFMSActual) - sum(PaidMediaSourcedUQFMSTarget) as PaidMediaSourcedUQFMSVsQrfDiff,
	sum(PaidMediaSourcedUQFMSCW) - sum(PaidMediaSourcedUQFMSTargetCW) as PaidMediaSourcedUQFMSVsQrfDiffCW
	 -- UQFM Convserion
	 /**TODO: DEBUG ARITHEMETIC ERROR
	 cast(sum(UQFMNOMActual)    as float) / cast(sum(UQFMDenomActual)as float) AS UQFMConversionActual,
	cast(sum(UQFMNOMCW)        as float) / cast(sum(UQFMDenomCW)as float) AS UQFMConversionCW,
	cast(sum(UQFMNOMLQ)        as float) / cast(sum(UQFMDenomLQ)as float) AS UQFMConversionLQ,
	cast(sum(UQFMNOMLW)        as float) / cast(sum(UQFMDenomLW)as float) AS UQFMConversionLW,
	cast(sum(UQFMNOMLY)        as float) / cast(sum(UQFMDenomLY)as float) AS UQFMConversionLY,
	cast(sum(UQFMNOMLYLQ)      as float) / cast(sum(UQFMDenomLYLQ)as float) AS UQFMConversionLYLQ
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ))) / (sum(UQFMNOMLYLQ) / sum(UQFMDenomLYLQ)) as UQFMConversionQQLY,
	cast(((sum(UQFMNOMActual)   as float) / sum(UQFMDenomActual)) - (sum(UQFMNOMLQ) / sum(UQFMDenomLQ))) / (sum(UQFMNOMLQ) / sum(UQFMDenomLQ)) as UQFMConversionQQTY

	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LQ)) / sum(UQFM Conversion LQ)
	(sum(UQFM Conversion CW) - sum(UQFM Conversion  LW))    / sum(UQFM Conversion  LW)
	(sum(UQFM Conversion Actual) - sum(UQFM Conversion LY)) / sum(UQFM Conversion LY)
	sum((UQFMConversionActual-UQFMConversionLYLQ))/sum(nullIf(UQFMConversionLYLQ,0)) as UQFMConversionQQLY,
	sum((UQFMConversionActual-UQFMConversionLQ))/sum(nullIf(UQFMConversionLQ,0)) as UQFMConversionQQTY,
	sum((UQFMConversionCW-UQFMConversionLW))/sum(nullIf(UQFMConversionLW,0)) as UQFMConversionWW,
	sum((UQFMConversionActual-UQFMConversionLY))/sum(nullIf(UQFMConversionLY,0)) as UQFMConversionYY,
	**/
	 -- New UQFM
	sum(NewUQFMSYY)	as NewUQFMSYY,
	sum( NewUQFMSActual) 														as NewUQFMSActual,
	sum( NewUQFMSTargetFQ) 													as NewUQFMSTargetFQ,
	sum(NewUQFMSCW) 															as NewUQFMSCW,
	sum(NewUQFMSTargetCW) 	as NewUQFMSTargetCW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLYLQ) )	as float) / nullIf(sum(NewUQFMSLYLQ),0) as NewUQFMSQQLY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLQ) )		as float) / nullIf(sum(NewUQFMSLQ),0) as NewUQFMSQQTY,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSTarget)) as float) / nullIf(sum(NewUQFMSTarget),0) as NewUQFMSVsQrf,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSTargetCW)) 	as float) / nullIf(sum(NewUQFMSTargetCW),0) as NewUQFMSVsQrfCW,
	cast((sum(NewUQFMSCW) - sum(NewUQFMSLW) )			as float) / nullIf(sum(NewUQFMSLW),0) as NewUQFMSWW,
	cast((sum(NewUQFMSActual) - sum(NewUQFMSLY)) 		as float) / nullIf(sum(NewUQFMSLY),0) as NewUQFMSYY,
	sum(NewUQFMSActual) - sum(NewUQFMSTarget) as NewUQFMSVsQrfDiff,
	sum(NewUQFMSCW) - sum(NewUQFMSTargetCW) as NewUQFMSVsQrfDiffCW						as NewUQFMSTargetCW
	
from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
group by  product_name 
order by 1;
-- DiscoverG5ProductQTD
Select
	product_name,
   --Traffic
	    sum(TrafficYY)	as TrafficYY,
	sum( TrafficActual) 														as TrafficActual,
	sum( TrafficTargetFQ) 													as TrafficTargetFQ,
	sum(TrafficCW) 															as TrafficCW,
	sum(TrafficTargetCW) 	as TrafficTargetCW,
	cast((sum(TrafficActual) - sum(TrafficLYLQ) )	as float) / nullIf(sum(TrafficLYLQ),0) as TrafficQQLY,
	cast((sum(TrafficActual) - sum(TrafficLQ) )		as float) / nullIf(sum(TrafficLQ),0) as TrafficQQTY,
	cast((sum(TrafficActual) - sum(TrafficTarget)) as float) / nullIf(sum(TrafficTarget),0) as TrafficVsQrf,
	cast((sum(TrafficCW) - sum(TrafficTargetCW)) 	as float) / nullIf(sum(TrafficTargetCW),0) as TrafficVsQrfCW,
	cast((sum(TrafficCW) - sum(TrafficLW) )			as float) / nullIf(sum(TrafficLW),0) as TrafficWW,
	cast((sum(TrafficActual) - sum(TrafficLY)) 		as float) / nullIf(sum(TrafficLY),0) as TrafficYY,
	sum(TrafficActual) - sum(TrafficTarget) as TrafficVsQrfDiff,
	sum(TrafficCW) - sum(TrafficTargetCW) as TrafficVsQrfDiffCW,
   	cast(sum(BounceRateActual) as float ) / sum(EntriesActual)   AS BounceRateActual,
    cast(sum(BounceRateCW) as float ) / sum(EntriesCW)   AS BounceRateCW,
    (sum(BounceRateActual)-sum(BounceRateLYLQ)) / nullIf(sum(BounceRateLYLQ),0) as BounceRateQQLY,
    (sum(BounceRateActual)-sum(BounceRateLQ)) / nullIf(sum(BounceRateLQ),0) as BounceRateQQLY,
    (sum(BounceRateCW)-sum(BounceRateLW)) / nullIf(sum(BounceRateLW),0) as BounceRateWW,
    (sum(BounceRateActual)-sum(BounceRateLY)) / nullIf(sum(BounceRateLY),0) as BounceRateYY

from JourneyG5ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
group by  product_name 
order by 1;
