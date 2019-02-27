-- FinancialG8ActualTargetPrimary
select
	sum(NewARRActual          )      as NewARRActual,
	sum(NewARRTargetFQ           )      as NewARRTargetFQ ,
	/**Todo Add ABS to All VS QRF**/
	cast((sum(NewARRActual)-SUM(NewARRTarget)) AS float )/ cast(abs(sum(nullif(NewARRTarget,0))) AS float) as NewVsQrf
from FinancialG8ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and product_name in (@productFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
	and subscription_offering in (@subscriptionFilters)
	and route_to_market in (@routeFilters);



-- FinancialG8ActualTargetSecondary
select
		sum(NewARRActual          )      as NewARRActual,
	sum(NewARRTargetFQ           )      as NewARRTargetFQ ,
	sum(NewARRTarget) NewARRTarget,
	cast((sum(NewARRActual)-SUM(NewARRTarget)) AS float )/ cast(abs(sum(nullif(NewARRTarget,0) )) AS float) as NewVsQrf,
	sum(CancelARRActual )      as CancelARRActual,
	sum(CancelARRTargetFQ  )      as CancelARRTargetFQ ,
	cast((sum(CancelARRActual)-SUM(CancelARRTarget))AS float )/ cast(abs(sum(nullif(CancelARRTarget,0))) AS float)
    as  CancelVsQrf,
	sum(CancelARRTarget) as CancelARRTarget,
	sum(GrossARRTarget) as GrossARRTarget,
	sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget)) as RenewalTarget,
	sum(GrossARRActual        )      as GrossARRActual,
	sum(GrossARRTargetFQ         )      as GrossARRTargetFQ ,
	cast((sum(GrossARRActual)-SUM(GrossARRTarget))AS float )/ cast(abs(sum(nullif(GrossARRTarget,0))) AS float)  as GrossVsQrf,
		sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)) as RenewActuals ,
        sum(NewARRTargetFQ)-(sum(GrossARRTargetFQ)-sum(CancelARRTargetFQ)) as RenewARRTargetFQ,
		cast ((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as float)/ nullIf((sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))),0) as RenewVSQRF

	
from FinancialG8ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and product_name in (@productFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
	and subscription_offering in (@subscriptionFilters)
	and route_to_market in (@routeFilters);

--FinancialG8MultiChartQuery
select
	Week,
	sum(NewARRActual          )      as NewARRActual,
	sum(NewARRTargetFQ          )      as NewARRTargetFQ,
	sum(NewARRLY)   as NewARRLY,
	sum(NewARRLQ             )       as NewARRLQ,
	sum(CancelARRActual )      as CancelARRActual,
	sum(CancelARRTargetFQ  )      as CancelARRTargetFQ ,
	sum(CancelARRLY   )       as CancelARRLY,
	sum(CancelARRLQ   )       as CancelARRLQ,
	sum(GrossARRActual        )      as GrossARRActual,
	sum(GrossARRTargetFQ         )      as GrossARRTargetFQ ,
	sum(GrossARRLY           )       as GrossARRLY,
	sum(GrossARRLQ           )       as GrossARRLQ,
	sum(NewARRActual)-(sum(GrossARRActual) - sum(CancelARRActual))   as RenewARRActual,
	sum(NewARRTargetFQ)-(sum(GrossARRTargetFQ)-sum(CancelARRTargetFQ)) as RenewARRTargetFQ ,
	sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)) as RenewARRLQ,
	sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)) as RenewARRLY
from FinancialG8ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and product_name in (@productFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
	and subscription_offering in (@subscriptionFilters)
	and route_to_market in (@routeFilters)
group by Week
	order by week desc
-- FinancialG8UnitsMultichart
Select
	week,
	sum(cast (NewUnitsActual as real))               as NewUnitsActual,
	sum(cast (NewUnitsTarget as real))               as NewUnitsTarget,
	sum(cast (NewUnitsLY as real))                   as NewUnitsLY,
	sum(cast (NeWUnitsLQ as real))                   as NeWUnitsLQ,
	sum(NewUnitsACtual)- (sum(GrossUnitsActual) - sum(CancelUnitsActual)) as RenewUnitsActual,
    sum(NewUnitsTarget)-(sum(GrossUnitsTarget) - sum(CancelUnitsTarget)) as RenewUnitsTarget,
	sum(NeWUnitsLQ)-(sum(GrossUnitsLQ)-sum(CancelUnitsLQ)) as RenewUnitsLQ,
    sum(NewUnitsLY)-(sum(GrossUnitsLY) - sum(CancelUnitsLY)) as RenewUnitsLY,
	sum(cast (CancelUnitsActual as real))			as CancelUnitsActual,
	sum(cast (CancelUnitsTarget as real))			as CancelUnitsTarget,
	sum(cast (CancelUnitsLY as real))				as CancelUnitsLY,
	sum(cast (CancelUnitsLQ as real))				as CancelUnitsLQ,
	sum(cast (GrossUnitsActual as real))             as GrossUnitsActual,
	sum(cast (GrossUnitsTarget as real))             as GrossUnitsTarget,
	sum(cast (GrossUnitsLY as real))                 as GrossUnitsLY,
	sum(cast (GrossUnitsLQ as real))                 as GrossUnitsLQ
from FinancialG8Units
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and product_name in (@productFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
	and subscription_offering in (@subscriptionFilters)
	and route_to_market in (@routeFilters)
group by week;

--FinancialG8QTD
Select
			/**Cancel**/
	cast((sum(CancelARRActual)-SUM(CancelARRLY))   		AS float ) / cast(sum(nullif(CancelARRLY,0)) 		AS float )		as CancelARRYY,
	cast((sum(CancelARRActual)-SUM(CancelARRLYLQ)) 		AS float ) / cast(sum(nullif(CancelARRLYLQ,0)) 		AS float )	as CancelARRQQLY,
	cast((sum(CancelARRActual)- SUM(CancelARRLQ))  		AS float ) / cast(sum(nullif(CancelARRLQ,0)) 		AS float ) 		as CancelARRQQTY,
	cast((sum(CancelARRActual)-SUM(CancelARRTarget))	AS float ) / cast(abs(sum(nullif(CancelARRTarget,0))) 	AS float )	as CancelVsQrf,
	sum( CancelARRActual) 														as CancelARRActual,
	sum(CancelUnitsActual)       												as CancelUnitsActual,
	sum( CancelARRTargetFQ) 														as CancelARRTarget,
	sum(CancelARRActual)-sum(CancelARRTarget) 									as CancelArrVsQrfDiff,
	sum(CancelARRCW) 															as CancelCW,
	sum(CancelUnitsCW) 															as CancelUnitsCW,
	sum(CancelARRTargetCW) 														as CancelARRTargetCW,
	sum(CancelARRCW)-sum(CancelARRTargetCW) 									as CancelCWVsQrfDiff,
	cast((sum(CancelARRCW)-SUM(CancelARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(CancelARRTargetCW,0))) AS float )	as CancelCWVsQrf,
	cast((sum(CancelARRCW)-sum(CancelARRLW))	 AS float )/	cast(sum(nullIf(CancelARRLW,0)) AS float )				as CancelWW,
	
	/**Gross**/
	cast((sum(GrossARRActual)-SUM(GrossARRLY))	 AS float )/	cast(SUM(nullIf(GrossARRLY,0))	AS float )		as GrossARRYY,
	cast((sum(GrossARRActual)-SUM(GrossARRLYLQ)) AS float )/	cast(SUM(nullIf(GrossARRLYLQ,0))AS float )		as GrossARRQQLY,
	cast((sum(GrossARRActual)-SUM(GrossARRLQ))	 AS float )/	cast(SUM(nullIf(GrossARRLQ,0))	AS float )		as GrossARRQQTY,
	cast((sum(GrossARRActual)-sum(GrossARRTarget)) AS float )/	cast(abs(SUM(nullIf(GrossARRTarget,0))) 	AS float )	as GrossVsQrf,
	sum(GrossARRActual) 														as GrossARRActual,
	sum(GrossUnitsActual)           											as GrossUnitsActual,
	sum(GrossARRTargetFQ) 														as GrossARRTarget,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossVsQrfDiff,
	sum(GrossARRCW) 															as GrossCW,
	sum(GrossUnitsCW) 															as GrossUnitsCW,
	sum(GrossARRTargetCW) 														as GrossARRTargetCW,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossCWVsQrfDiff,
		cast((sum(GrossARRCW)-sum(GrossARRTargetCW)) AS float ) / cast(abs(sum(nullIf(GrossARRTargetCW,0))) AS float ) 	as GrossCWVsQrf,
	cast((sum(GrossARRCW)-sum(GrossARRLW)) AS float )/cast(sum(nullIf(GrossARRLW,0))AS float ) 				as GrossWW,
	/**Net New**/

		cast((sum(NewARRActual)-SUM(NewARRLY))   		AS float ) / cast(sum(nullif(NewARRLY,0)) 		AS float )		as NewYY,
	cast((sum(NewARRActual)-SUM(NewARRLYLQ)) 		AS float ) / cast(sum(nullif(NewARRLYLQ,0)) 		AS float )	as NewARRQQLY,
	cast((sum(NewARRActual)- SUM(NewARRLQ))  		AS float ) / cast(sum(nullif(NewARRLQ,0)) 		AS float ) 		as NewARRQQTY,
	cast((sum(NewARRActual)-SUM(NewARRTarget))	AS float ) / cast(abs(sum(nullif(NewARRTarget,0))) 	AS float )	as NewARRVsQrf,
	sum( NewARRActual) 														as NewActuals,
	sum(NewUnitsActual)       												as NewUnitsActual,
	sum( NewARRTargetFQ) 														as NewTarget,
	sum(NewARRActual)-sum(NewARRTargetFQ) 									as NewVsQrfDiff,
	sum(NewARRCW) 															as NewARRCW,
	sum(NewUnitsCW) 															as NewUnitsCW,
	sum(NewARRTargetCW) 														as NewARRTargetCW,
	sum(NewARRCW)-sum(NewARRTargetCW) 									as NewCWVsQrfDiff,
	cast((sum(NewARRCW)-SUM(NewARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewARRTargetCW,0))) AS float )	as NewCWVsQrf,
	cast((sum(NewARRCW)-sum(NewARRLW))	 AS float )/	cast(sum(nullIf(NewARRLW,0)) AS float )				as NewWW,
	/**Renewal **/
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)))) AS float )	/	cast(nullIf(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)),0) 	AS float )  			as RenewYY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)))) AS float )	/	cast(nullIf(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)),0) 	AS float )  		as RenewARRQQTY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq))))	AS float) /	cast(nullIf(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq)),0) AS float )   	as RenewARRQQLY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)))) AS float )	/	cast(nullIf(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)),0)	AS float )  			as RenewWW,
	cast((sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW))) as float) /	nullIf(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)),0) as RenewCWVsQrfDiff,
	(sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as RenewVsQrfDiff,
	cast ((sum(NewARRcw)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRTargetcw)- (sum(GrossARRTargetcW) - sum(CancelARRTargetCW))) as float)/ abs(nullIf((sum(NewARRTargetCW)- (sum(GrossARRTargetCW) - sum(CancelARRTargetCW))),0)) as RenewCWVSQRF,
	sum(NewARRTargetFQ)-(sum(GrossARRTargetFQ)-sum(CancelARRTargetFQ)) as RenewARRTargetFQ,
	cast ((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as float)/ abs(nullIf((sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))),0)) as RenewVSQRF,
	sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)) as RenewActuals ,
	sum(NewUnitsACtual)- (sum(GrossUnitsActual) - sum(CancelUnitsActual)) as RenewUnitsActual,
	sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)) as RenewARRCW,
	sum(NewUnitsCW)- (sum(GrossUnitsCW) - sum(CancelUnitsCW)) as RenewUnitsCW,
	sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)) as RenewARRTargetCW
from FinancialG8ARR

where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and product_name in (@productFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
	and route_to_market in (@routeFilters);

-- FinancialG8GeoQTD
Select
	geo_code, market_area_group,
				/**Cancel**/
	cast((sum(CancelARRActual)-SUM(CancelARRLY))   		AS float ) / cast(sum(nullif(CancelARRLY,0)) 		AS float )		as CancelARRYY,
	cast((sum(CancelARRActual)-SUM(CancelARRLYLQ)) 		AS float ) / cast(sum(nullif(CancelARRLYLQ,0)) 		AS float )	as CancelARRQQLY,
	cast((sum(CancelARRActual)- SUM(CancelARRLQ))  		AS float ) / cast(sum(nullif(CancelARRLQ,0)) 		AS float ) 		as CancelARRQQTY,
	cast((sum(CancelARRActual)-SUM(CancelARRTarget))	AS float ) / cast(abs(sum(nullif(CancelARRTarget,0))) 	AS float )	as CancelVsQrf,
	sum( CancelARRActual) 														as CancelARRActual,
	sum(CancelUnitsActual)       												as CancelUnitsActual,
	sum( CancelARRTargetFQ) 														as CancelARRTarget,
	sum(CancelARRActual)-sum(CancelARRTarget) 									as CancelArrVsQrfDiff,
	sum(CancelARRCW) 															as CancelCW,
	sum(CancelUnitsCW) 															as CancelUnitsCW,
	sum(CancelARRTargetCW) 														as CancelARRTargetCW,
	sum(CancelARRCW)-sum(CancelARRTargetCW) 									as CancelCWVsQrfDiff,
	cast((sum(CancelARRCW)-SUM(CancelARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(CancelARRTargetCW,0))) AS float )	as CancelCWVsQrf,
	cast((sum(CancelARRCW)-sum(CancelARRLW))	 AS float )/	cast(sum(nullIf(CancelARRLW,0)) AS float )				as CancelWW,
	
	/**Gross**/
	cast((sum(GrossARRActual)-SUM(GrossARRLY))	 AS float )/	cast(SUM(nullIf(GrossARRLY,0))	AS float )		as GrossARRYY,
	cast((sum(GrossARRActual)-SUM(GrossARRLYLQ)) AS float )/	cast(SUM(nullIf(GrossARRLYLQ,0))AS float )		as GrossARRQQLY,
	cast((sum(GrossARRActual)-SUM(GrossARRLQ))	 AS float )/	cast(SUM(nullIf(GrossARRLQ,0))	AS float )		as GrossARRQQTY,
	cast((sum(GrossARRActual)-sum(GrossARRTarget)) AS float )/	cast(abs(SUM(nullIf(GrossARRTarget,0))) 	AS float )	as GrossVsQrf,
	sum(GrossARRActual) 														as GrossARRActual,
	sum(GrossUnitsActual)           											as GrossUnitsActual,
	sum(GrossARRTargetFQ) 														as GrossARRTarget,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossVsQrfDiff,
	sum(GrossARRCW) 															as GrossCW,
	sum(GrossUnitsCW) 															as GrossUnitsCW,
	sum(GrossARRTargetCW) 														as GrossARRTargetCW,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossCWVsQrfDiff,
		cast((sum(GrossARRCW)-sum(GrossARRTargetCW)) AS float ) / cast(abs(sum(nullIf(GrossARRTargetCW,0))) AS float ) 	as GrossCWVsQrf,
	cast((sum(GrossARRCW)-sum(GrossARRLW)) AS float )/cast(sum(nullIf(GrossARRLW,0))AS float ) 				as GrossWW,
	/**Net New**/

		cast((sum(NewARRActual)-SUM(NewARRLY))   		AS float ) / cast(sum(nullif(NewARRLY,0)) 		AS float )		as NewYY,
	cast((sum(NewARRActual)-SUM(NewARRLYLQ)) 		AS float ) / cast(sum(nullif(NewARRLYLQ,0)) 		AS float )	as NewARRQQLY,
	cast((sum(NewARRActual)- SUM(NewARRLQ))  		AS float ) / cast(sum(nullif(NewARRLQ,0)) 		AS float ) 		as NewARRQQTY,
	cast((sum(NewARRActual)-SUM(NewARRTarget))	AS float ) / cast(abs(sum(nullif(NewARRTarget,0))) 	AS float )	as NewARRVsQrf,
	sum( NewARRActual) 														as NewActuals,
	sum(NewUnitsActual)       												as NewUnitsActual,
	sum( NewARRTargetFQ) 														as NewTarget,
	sum(NewARRActual)-sum(NewARRTargetFQ) 									as NewVsQrfDiff,
	sum(NewARRCW) 															as NewARRCW,
	sum(NewUnitsCW) 															as NewUnitsCW,
	sum(NewARRTargetCW) 														as NewARRTargetCW,
	sum(NewARRCW)-sum(NewARRTargetCW) 									as NewCWVsQrfDiff,
	cast((sum(NewARRCW)-SUM(NewARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewARRTargetCW,0))) AS float )	as NewCWVsQrf,
	cast((sum(NewARRCW)-sum(NewARRLW))	 AS float )/	cast(sum(nullIf(NewARRLW,0)) AS float )				as NewWW,
	/**Renewal **/
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)))) AS float )	/	cast(nullIf(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)),0) 	AS float )  			as RenewYY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)))) AS float )	/	cast(nullIf(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)),0) 	AS float )  		as RenewARRQQTY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq))))	AS float) /	cast(nullIf(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq)),0) AS float )   	as RenewARRQQLY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)))) AS float )	/	cast(nullIf(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)),0)	AS float )  			as RenewWW,
	cast((sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW))) as float) /	nullIf(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)),0) as RenewCWVsQrfDiff,
	(sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as RenewVsQrfDiff,
	cast ((sum(NewARRcw)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRTargetcw)- (sum(GrossARRTargetcW) - sum(CancelARRTargetCW))) as float)/ abs(nullIf((sum(NewARRTargetCW)- (sum(GrossARRTargetCW) - sum(CancelARRTargetCW))),0)) as RenewCWVSQRF,
	sum(NewARRTargetFQ)-(sum(GrossARRTargetFQ)-sum(CancelARRTargetFQ)) as RenewARRTargetFQ,
	cast ((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as float)/ abs(nullIf((sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))),0)) as RenewVSQRF,
	sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)) as RenewActuals ,
	sum(NewUnitsACtual)- (sum(GrossUnitsActual) - sum(CancelUnitsActual)) as RenewUnitsActual,
	sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)) as RenewARRCW,
	sum(NewUnitsCW)- (sum(GrossUnitsCW) - sum(CancelUnitsCW)) as RenewUnitsCW,
	sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)) as RenewARRTargetCW
from FinancialG8ARR

where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and product_name in (@productFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
	and subscription_offering in (@subscriptionFilters)
	and route_to_market in (@routeFilters)
group by geo_code,
market_area_group
order by quarter;


-- FinancialG8MarketAreaQTD
Select market_area_code,
				/**Cancel**/
	cast((sum(CancelARRActual)-SUM(CancelARRLY))   		AS float ) / cast(sum(nullif(CancelARRLY,0)) 		AS float )		as CancelARRYY,
	cast((sum(CancelARRActual)-SUM(CancelARRLYLQ)) 		AS float ) / cast(sum(nullif(CancelARRLYLQ,0)) 		AS float )	as CancelARRQQLY,
	cast((sum(CancelARRActual)- SUM(CancelARRLQ))  		AS float ) / cast(sum(nullif(CancelARRLQ,0)) 		AS float ) 		as CancelARRQQTY,
	cast((sum(CancelARRActual)-SUM(CancelARRTarget))	AS float ) / cast(abs(sum(nullif(CancelARRTarget,0))) 	AS float )	as CancelVsQrf,
	sum( CancelARRActual) 														as CancelARRActual,
	sum(CancelUnitsActual)       												as CancelUnitsActual,
	sum( CancelARRTargetFQ) 														as CancelARRTarget,
	sum(CancelARRActual)-sum(CancelARRTarget) 									as CancelArrVsQrfDiff,
	sum(CancelARRCW) 															as CancelCW,
	sum(CancelUnitsCW) 															as CancelUnitsCW,
	sum(CancelARRTargetCW) 														as CancelARRTargetCW,
	sum(CancelARRCW)-sum(CancelARRTargetCW) 									as CancelCWVsQrfDiff,
	cast((sum(CancelARRCW)-SUM(CancelARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(CancelARRTargetCW,0))) AS float )	as CancelCWVsQrf,
	cast((sum(CancelARRCW)-sum(CancelARRLW))	 AS float )/	cast(sum(nullIf(CancelARRLW,0)) AS float )				as CancelWW,
	
	/**Gross**/
	cast((sum(GrossARRActual)-SUM(GrossARRLY))	 AS float )/	cast(SUM(nullIf(GrossARRLY,0))	AS float )		as GrossARRYY,
	cast((sum(GrossARRActual)-SUM(GrossARRLYLQ)) AS float )/	cast(SUM(nullIf(GrossARRLYLQ,0))AS float )		as GrossARRQQLY,
	cast((sum(GrossARRActual)-SUM(GrossARRLQ))	 AS float )/	cast(SUM(nullIf(GrossARRLQ,0))	AS float )		as GrossARRQQTY,
	cast((sum(GrossARRActual)-sum(GrossARRTarget)) AS float )/	cast(abs(SUM(nullIf(GrossARRTarget,0))) 	AS float )	as GrossVsQrf,
	sum(GrossARRActual) 														as GrossARRActual,
	sum(GrossUnitsActual)           											as GrossUnitsActual,
	sum(GrossARRTargetFQ) 														as GrossARRTarget,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossVsQrfDiff,
	sum(GrossARRCW) 															as GrossCW,
	sum(GrossUnitsCW) 															as GrossUnitsCW,
	sum(GrossARRTargetCW) 														as GrossARRTargetCW,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossCWVsQrfDiff,
		cast((sum(GrossARRCW)-sum(GrossARRTargetCW)) AS float ) / cast(abs(sum(nullIf(GrossARRTargetCW,0))) AS float ) 	as GrossCWVsQrf,
	cast((sum(GrossARRCW)-sum(GrossARRLW)) AS float )/cast(sum(nullIf(GrossARRLW,0))AS float ) 				as GrossWW,
	/**Net New**/

		cast((sum(NewARRActual)-SUM(NewARRLY))   		AS float ) / cast(sum(nullif(NewARRLY,0)) 		AS float )		as NewYY,
	cast((sum(NewARRActual)-SUM(NewARRLYLQ)) 		AS float ) / cast(sum(nullif(NewARRLYLQ,0)) 		AS float )	as NewARRQQLY,
	cast((sum(NewARRActual)- SUM(NewARRLQ))  		AS float ) / cast(sum(nullif(NewARRLQ,0)) 		AS float ) 		as NewARRQQTY,
	cast((sum(NewARRActual)-SUM(NewARRTarget))	AS float ) / cast(abs(sum(nullif(NewARRTarget,0))) 	AS float )	as NewARRVsQrf,
	sum( NewARRActual) 														as NewActuals,
	sum(NewUnitsActual)       												as NewUnitsActual,
	sum( NewARRTargetFQ) 														as NewTarget,
	sum(NewARRActual)-sum(NewARRTargetFQ) 									as NewVsQrfDiff,
	sum(NewARRCW) 															as NewARRCW,
	sum(NewUnitsCW) 															as NewUnitsCW,
	sum(NewARRTargetCW) 														as NewARRTargetCW,
	sum(NewARRCW)-sum(NewARRTargetCW) 									as NewCWVsQrfDiff,
	cast((sum(NewARRCW)-SUM(NewARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewARRTargetCW,0))) AS float )	as NewCWVsQrf,
	cast((sum(NewARRCW)-sum(NewARRLW))	 AS float )/	cast(sum(nullIf(NewARRLW,0)) AS float )				as NewWW,
	/**Renewal **/
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)))) AS float )	/	cast(nullIf(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)),0) 	AS float )  			as RenewYY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)))) AS float )	/	cast(nullIf(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)),0) 	AS float )  		as RenewARRQQTY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq))))	AS float) /	cast(nullIf(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq)),0) AS float )   	as RenewARRQQLY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)))) AS float )	/	cast(nullIf(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)),0)	AS float )  			as RenewWW,
	cast((sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW))) as float) /	nullIf(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)),0) as RenewCWVsQrfDiff,
	(sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as RenewVsQrfDiff,
	cast ((sum(NewARRcw)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRTargetcw)- (sum(GrossARRTargetcW) - sum(CancelARRTargetCW))) as float)/ abs(nullIf((sum(NewARRTargetCW)- (sum(GrossARRTargetCW) - sum(CancelARRTargetCW))),0)) as RenewCWVSQRF,
	sum(NewARRTargetFQ)-(sum(GrossARRTargetFQ)-sum(CancelARRTargetFQ)) as RenewARRTargetFQ,
	cast ((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as float)/ abs(nullIf((sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))),0)) as RenewVSQRF,
	sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)) as RenewActuals ,
	sum(NewUnitsACtual)- (sum(GrossUnitsActual) - sum(CancelUnitsActual)) as RenewUnitsActual,
	sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)) as RenewARRCW,
	sum(NewUnitsCW)- (sum(GrossUnitsCW) - sum(CancelUnitsCW)) as RenewUnitsCW,
	sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)) as RenewARRTargetCW
from FinancialG8ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and product_name in (@productFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
	and subscription_offering in (@subscriptionFilters)
	and route_to_market in (@routeFilters)
group by market_area_code
order by quarter;

--FinancialG8ProductQTD
Select product_name,
				/**Cancel**/
	cast((sum(CancelARRActual)-SUM(CancelARRLY))   		AS float ) / cast(sum(nullif(CancelARRLY,0)) 		AS float )		as CancelARRYY,
	cast((sum(CancelARRActual)-SUM(CancelARRLYLQ)) 		AS float ) / cast(sum(nullif(CancelARRLYLQ,0)) 		AS float )	as CancelARRQQLY,
	cast((sum(CancelARRActual)- SUM(CancelARRLQ))  		AS float ) / cast(sum(nullif(CancelARRLQ,0)) 		AS float ) 		as CancelARRQQTY,
	cast((sum(CancelARRActual)-SUM(CancelARRTarget))	AS float ) / cast(abs(sum(nullif(CancelARRTarget,0))) 	AS float )	as CancelVsQrf,
	sum( CancelARRActual) 														as CancelARRActual,
	sum(CancelUnitsActual)       												as CancelUnitsActual,
	sum( CancelARRTargetFQ) 														as CancelARRTarget,
	sum(CancelARRActual)-sum(CancelARRTarget) 									as CancelArrVsQrfDiff,
	sum(CancelARRCW) 															as CancelCW,
	sum(CancelUnitsCW) 															as CancelUnitsCW,
	sum(CancelARRTargetCW) 														as CancelARRTargetCW,
	sum(CancelARRCW)-sum(CancelARRTargetCW) 									as CancelCWVsQrfDiff,
	cast((sum(CancelARRCW)-SUM(CancelARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(CancelARRTargetCW,0))) AS float )	as CancelCWVsQrf,
	cast((sum(CancelARRCW)-sum(CancelARRLW))	 AS float )/	cast(sum(nullIf(CancelARRLW,0)) AS float )				as CancelWW,
	
	/**Gross**/
	cast((sum(GrossARRActual)-SUM(GrossARRLY))	 AS float )/	cast(SUM(nullIf(GrossARRLY,0))	AS float )		as GrossARRYY,
	cast((sum(GrossARRActual)-SUM(GrossARRLYLQ)) AS float )/	cast(SUM(nullIf(GrossARRLYLQ,0))AS float )		as GrossARRQQLY,
	cast((sum(GrossARRActual)-SUM(GrossARRLQ))	 AS float )/	cast(SUM(nullIf(GrossARRLQ,0))	AS float )		as GrossARRQQTY,
	cast((sum(GrossARRActual)-sum(GrossARRTarget)) AS float )/	cast(abs(SUM(nullIf(GrossARRTarget,0))) 	AS float )	as GrossVsQrf,
	sum(GrossARRActual) 														as GrossARRActual,
	sum(GrossUnitsActual)           											as GrossUnitsActual,
	sum(GrossARRTargetFQ) 														as GrossARRTarget,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossVsQrfDiff,
	sum(GrossARRCW) 															as GrossCW,
	sum(GrossUnitsCW) 															as GrossUnitsCW,
	sum(GrossARRTargetCW) 														as GrossARRTargetCW,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossCWVsQrfDiff,
		cast((sum(GrossARRCW)-sum(GrossARRTargetCW)) AS float ) / cast(abs(sum(nullIf(GrossARRTargetCW,0))) AS float ) 	as GrossCWVsQrf,
	cast((sum(GrossARRCW)-sum(GrossARRLW)) AS float )/cast(sum(nullIf(GrossARRLW,0))AS float ) 				as GrossWW,
	/**Net New**/

		cast((sum(NewARRActual)-SUM(NewARRLY))   		AS float ) / cast(sum(nullif(NewARRLY,0)) 		AS float )		as NewYY,
	cast((sum(NewARRActual)-SUM(NewARRLYLQ)) 		AS float ) / cast(sum(nullif(NewARRLYLQ,0)) 		AS float )	as NewARRQQLY,
	cast((sum(NewARRActual)- SUM(NewARRLQ))  		AS float ) / cast(sum(nullif(NewARRLQ,0)) 		AS float ) 		as NewARRQQTY,
	cast((sum(NewARRActual)-SUM(NewARRTarget))	AS float ) / cast(abs(sum(nullif(NewARRTarget,0))) 	AS float )	as NewARRVsQrf,
	sum( NewARRActual) 														as NewActuals,
	sum(NewUnitsActual)       												as NewUnitsActual,
	sum( NewARRTargetFQ) 														as NewTarget,
	sum(NewARRActual)-sum(NewARRTargetFQ) 									as NewVsQrfDiff,
	sum(NewARRCW) 															as NewARRCW,
	sum(NewUnitsCW) 															as NewUnitsCW,
	sum(NewARRTargetCW) 														as NewARRTargetCW,
	sum(NewARRCW)-sum(NewARRTargetCW) 									as NewCWVsQrfDiff,
	cast((sum(NewARRCW)-SUM(NewARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewARRTargetCW,0))) AS float )	as NewCWVsQrf,
	cast((sum(NewARRCW)-sum(NewARRLW))	 AS float )/	cast(sum(nullIf(NewARRLW,0)) AS float )				as NewWW,
	/**Renewal **/
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)))) AS float )	/	cast(nullIf(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)),0) 	AS float )  			as RenewYY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)))) AS float )	/	cast(nullIf(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)),0) 	AS float )  		as RenewARRQQTY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq))))	AS float) /	cast(nullIf(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq)),0) AS float )   	as RenewARRQQLY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)))) AS float )	/	cast(nullIf(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)),0)	AS float )  			as RenewWW,
	cast((sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW))) as float) /	nullIf(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)),0) as RenewCWVsQrfDiff,
	(sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as RenewVsQrfDiff,
	cast ((sum(NewARRcw)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRTargetcw)- (sum(GrossARRTargetcW) - sum(CancelARRTargetCW))) as float)/ abs(nullIf((sum(NewARRTargetCW)- (sum(GrossARRTargetCW) - sum(CancelARRTargetCW))),0)) as RenewCWVSQRF,
	sum(NewARRTargetFQ)-(sum(GrossARRTargetFQ)-sum(CancelARRTargetFQ)) as RenewARRTargetFQ,
	cast ((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as float)/ abs(nullIf((sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))),0)) as RenewVSQRF,
	sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)) as RenewActuals ,
	sum(NewUnitsACtual)- (sum(GrossUnitsActual) - sum(CancelUnitsActual)) as RenewUnitsActual,
	sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)) as RenewARRCW,
	sum(NewUnitsCW)- (sum(GrossUnitsCW) - sum(CancelUnitsCW)) as RenewUnitsCW,
	sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)) as RenewARRTargetCW
from FinancialG8ARR

where geo_code in
(@geofilters)
and quarter in
(@quarterFilters)
and product_name in
(@productFilters)
and market_area_code in
(@maFilters)
and segment_pivot in
(@segmentFilters)
and subscription_offering in
(@subscriptionFilters)
and route_to_market in
(@routeFilters)
group by  product_name
order by quarter;



--FinancialG8RoutesQTD
Select route_to_market,
			/**Cancel**/
				/**Cancel**/
	cast((sum(CancelARRActual)-SUM(CancelARRLY))   		AS float ) / cast(sum(nullif(CancelARRLY,0)) 		AS float )		as CancelARRYY,
	cast((sum(CancelARRActual)-SUM(CancelARRLYLQ)) 		AS float ) / cast(sum(nullif(CancelARRLYLQ,0)) 		AS float )	as CancelARRQQLY,
	cast((sum(CancelARRActual)- SUM(CancelARRLQ))  		AS float ) / cast(sum(nullif(CancelARRLQ,0)) 		AS float ) 		as CancelARRQQTY,
	cast((sum(CancelARRActual)-SUM(CancelARRTarget))	AS float ) / cast(abs(sum(nullif(CancelARRTarget,0))) 	AS float )	as CancelVsQrf,
	sum( CancelARRActual) 														as CancelARRActual,
	sum(CancelUnitsActual)       												as CancelUnitsActual,
	sum( CancelARRTargetFQ) 														as CancelARRTarget,
	sum(CancelARRActual)-sum(CancelARRTarget) 									as CancelArrVsQrfDiff,
	sum(CancelARRCW) 															as CancelCW,
	sum(CancelUnitsCW) 															as CancelUnitsCW,
	sum(CancelARRTargetCW) 														as CancelARRTargetCW,
	sum(CancelARRCW)-sum(CancelARRTargetCW) 									as CancelCWVsQrfDiff,
	cast((sum(CancelARRCW)-SUM(CancelARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(CancelARRTargetCW,0))) AS float )	as CancelCWVsQrf,
	cast((sum(CancelARRCW)-sum(CancelARRLW))	 AS float )/	cast(sum(nullIf(CancelARRLW,0)) AS float )				as CancelWW,
	
	/**Gross**/
	cast((sum(GrossARRActual)-SUM(GrossARRLY))	 AS float )/	cast(SUM(nullIf(GrossARRLY,0))	AS float )		as GrossARRYY,
	cast((sum(GrossARRActual)-SUM(GrossARRLYLQ)) AS float )/	cast(SUM(nullIf(GrossARRLYLQ,0))AS float )		as GrossARRQQLY,
	cast((sum(GrossARRActual)-SUM(GrossARRLQ))	 AS float )/	cast(SUM(nullIf(GrossARRLQ,0))	AS float )		as GrossARRQQTY,
	cast((sum(GrossARRActual)-sum(GrossARRTarget)) AS float )/	cast(abs(SUM(nullIf(GrossARRTarget,0))) 	AS float )	as GrossVsQrf,
	sum(GrossARRActual) 														as GrossARRActual,
	sum(GrossUnitsActual)           											as GrossUnitsActual,
	sum(GrossARRTargetFQ) 														as GrossARRTarget,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossVsQrfDiff,
	sum(GrossARRCW) 															as GrossCW,
	sum(GrossUnitsCW) 															as GrossUnitsCW,
	sum(GrossARRTargetCW) 														as GrossARRTargetCW,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossCWVsQrfDiff,
		cast((sum(GrossARRCW)-sum(GrossARRTargetCW)) AS float ) / cast(abs(sum(nullIf(GrossARRTargetCW,0))) AS float ) 	as GrossCWVsQrf,
	cast((sum(GrossARRCW)-sum(GrossARRLW)) AS float )/cast(sum(nullIf(GrossARRLW,0))AS float ) 				as GrossWW,
	/**Net New**/

		cast((sum(NewARRActual)-SUM(NewARRLY))   		AS float ) / cast(sum(nullif(NewARRLY,0)) 		AS float )		as NewYY,
	cast((sum(NewARRActual)-SUM(NewARRLYLQ)) 		AS float ) / cast(sum(nullif(NewARRLYLQ,0)) 		AS float )	as NewARRQQLY,
	cast((sum(NewARRActual)- SUM(NewARRLQ))  		AS float ) / cast(sum(nullif(NewARRLQ,0)) 		AS float ) 		as NewARRQQTY,
	cast((sum(NewARRActual)-SUM(NewARRTarget))	AS float ) / cast(abs(sum(nullif(NewARRTarget,0))) 	AS float )	as NewARRVsQrf,
	sum( NewARRActual) 														as NewActuals,
	sum(NewUnitsActual)       												as NewUnitsActual,
	sum( NewARRTargetFQ) 														as NewTarget,
	sum(NewARRActual)-sum(NewARRTargetFQ) 									as NewVsQrfDiff,
	sum(NewARRCW) 															as NewARRCW,
	sum(NewUnitsCW) 															as NewUnitsCW,
	sum(NewARRTargetCW) 														as NewARRTargetCW,
	sum(NewARRCW)-sum(NewARRTargetCW) 									as NewCWVsQrfDiff,
	cast((sum(NewARRCW)-SUM(NewARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewARRTargetCW,0))) AS float )	as NewCWVsQrf,
	cast((sum(NewARRCW)-sum(NewARRLW))	 AS float )/	cast(sum(nullIf(NewARRLW,0)) AS float )				as NewWW,
	/**Renewal **/
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)))) AS float )	/	cast(nullIf(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)),0) 	AS float )  			as RenewYY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)))) AS float )	/	cast(nullIf(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)),0) 	AS float )  		as RenewARRQQTY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq))))	AS float) /	cast(nullIf(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq)),0) AS float )   	as RenewARRQQLY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)))) AS float )	/	cast(nullIf(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)),0)	AS float )  			as RenewWW,
	cast((sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW))) as float) /	nullIf(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)),0) as RenewCWVsQrfDiff,
	(sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as RenewVsQrfDiff,
	cast ((sum(NewARRcw)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRTargetcw)- (sum(GrossARRTargetcW) - sum(CancelARRTargetCW))) as float)/ abs(nullIf((sum(NewARRTargetCW)- (sum(GrossARRTargetCW) - sum(CancelARRTargetCW))),0)) as RenewCWVSQRF,
	sum(NewARRTargetFQ)-(sum(GrossARRTargetFQ)-sum(CancelARRTargetFQ)) as RenewARRTargetFQ,
	cast ((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as float)/ abs(nullIf((sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))),0)) as RenewVSQRF,
	sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)) as RenewActuals ,
	sum(NewUnitsACtual)- (sum(GrossUnitsActual) - sum(CancelUnitsActual)) as RenewUnitsActual,
	sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)) as RenewARRCW,
	sum(NewUnitsCW)- (sum(GrossUnitsCW) - sum(CancelUnitsCW)) as RenewUnitsCW,
	sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)) as RenewARRTargetCW
from FinancialG8ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and product_name in (@productFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
	and subscription_offering in (@subscriptionFilters)
	and route_to_market in (@routeFilters)
group by  route_to_market
order by quarter;

-- FinancialG8SegmentsQTD
Select segment_pivot,
				/**Cancel**/
	cast((sum(CancelARRActual)-SUM(CancelARRLY))   		AS float ) / cast(sum(nullif(CancelARRLY,0)) 		AS float )		as CancelARRYY,
	cast((sum(CancelARRActual)-SUM(CancelARRLYLQ)) 		AS float ) / cast(sum(nullif(CancelARRLYLQ,0)) 		AS float )	as CancelARRQQLY,
	cast((sum(CancelARRActual)- SUM(CancelARRLQ))  		AS float ) / cast(sum(nullif(CancelARRLQ,0)) 		AS float ) 		as CancelARRQQTY,
	cast((sum(CancelARRActual)-SUM(CancelARRTarget))	AS float ) / cast(abs(sum(nullif(CancelARRTarget,0))) 	AS float )	as CancelVsQrf,
	sum( CancelARRActual) 														as CancelARRActual,
	sum(CancelUnitsActual)       												as CancelUnitsActual,
	sum( CancelARRTargetFQ) 														as CancelARRTarget,
	sum(CancelARRActual)-sum(CancelARRTarget) 									as CancelArrVsQrfDiff,
	sum(CancelARRCW) 															as CancelCW,
	sum(CancelUnitsCW) 															as CancelUnitsCW,
	sum(CancelARRTargetCW) 														as CancelARRTargetCW,
	sum(CancelARRCW)-sum(CancelARRTargetCW) 									as CancelCWVsQrfDiff,
	cast((sum(CancelARRCW)-SUM(CancelARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(CancelARRTargetCW,0))) AS float )	as CancelCWVsQrf,
	cast((sum(CancelARRCW)-sum(CancelARRLW))	 AS float )/	cast(sum(nullIf(CancelARRLW,0)) AS float )				as CancelWW,
	
	/**Gross**/
	cast((sum(GrossARRActual)-SUM(GrossARRLY))	 AS float )/	cast(SUM(nullIf(GrossARRLY,0))	AS float )		as GrossARRYY,
	cast((sum(GrossARRActual)-SUM(GrossARRLYLQ)) AS float )/	cast(SUM(nullIf(GrossARRLYLQ,0))AS float )		as GrossARRQQLY,
	cast((sum(GrossARRActual)-SUM(GrossARRLQ))	 AS float )/	cast(SUM(nullIf(GrossARRLQ,0))	AS float )		as GrossARRQQTY,
	cast((sum(GrossARRActual)-sum(GrossARRTarget)) AS float )/	cast(abs(SUM(nullIf(GrossARRTarget,0))) 	AS float )	as GrossVsQrf,
	sum(GrossARRActual) 														as GrossARRActual,
	sum(GrossUnitsActual)           											as GrossUnitsActual,
	sum(GrossARRTargetFQ) 														as GrossARRTarget,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossVsQrfDiff,
	sum(GrossARRCW) 															as GrossCW,
	sum(GrossUnitsCW) 															as GrossUnitsCW,
	sum(GrossARRTargetCW) 														as GrossARRTargetCW,
	sum(GrossARRActual)-sum(GrossARRTarget) 									as GrossCWVsQrfDiff,
		cast((sum(GrossARRCW)-sum(GrossARRTargetCW)) AS float ) / cast(abs(sum(nullIf(GrossARRTargetCW,0))) AS float ) 	as GrossCWVsQrf,
	cast((sum(GrossARRCW)-sum(GrossARRLW)) AS float )/cast(sum(nullIf(GrossARRLW,0))AS float ) 				as GrossWW,
	/**Net New**/

		cast((sum(NewARRActual)-SUM(NewARRLY))   		AS float ) / cast(sum(nullif(NewARRLY,0)) 		AS float )		as NewYY,
	cast((sum(NewARRActual)-SUM(NewARRLYLQ)) 		AS float ) / cast(sum(nullif(NewARRLYLQ,0)) 		AS float )	as NewARRQQLY,
	cast((sum(NewARRActual)- SUM(NewARRLQ))  		AS float ) / cast(sum(nullif(NewARRLQ,0)) 		AS float ) 		as NewARRQQTY,
	cast((sum(NewARRActual)-SUM(NewARRTarget))	AS float ) / cast(abs(sum(nullif(NewARRTarget,0))) 	AS float )	as NewARRVsQrf,
	sum( NewARRActual) 														as NewActuals,
	sum(NewUnitsActual)       												as NewUnitsActual,
	sum( NewARRTargetFQ) 														as NewTarget,
	sum(NewARRActual)-sum(NewARRTargetFQ) 									as NewVsQrfDiff,
	sum(NewARRCW) 															as NewARRCW,
	sum(NewUnitsCW) 															as NewUnitsCW,
	sum(NewARRTargetCW) 														as NewARRTargetCW,
	sum(NewARRCW)-sum(NewARRTargetCW) 									as NewCWVsQrfDiff,
	cast((sum(NewARRCW)-SUM(NewARRTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewARRTargetCW,0))) AS float )	as NewCWVsQrf,
	cast((sum(NewARRCW)-sum(NewARRLW))	 AS float )/	cast(sum(nullIf(NewARRLW,0)) AS float )				as NewWW,
	/**Renewal **/
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)))) AS float )	/	cast(nullIf(sum(NewARRLY)-(sum(GrossARRly) - sum(CancelARRly)),0) 	AS float )  			as RenewYY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)))) AS float )	/	cast(nullIf(sum(NewARRLQ)-(sum(GrossARRlq) - sum(CancelARRlq)),0) 	AS float )  		as RenewARRQQTY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq))))	AS float) /	cast(nullIf(sum(NewARRLYlq)-(sum(GrossARRlylq) - sum(CancelARRlylq)),0) AS float )   	as RenewARRQQLY,
	cast((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual))-(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)))) AS float )	/	cast(nullIf(sum(NewARRLW)-(sum(GrossARRlw)-sum(CancelARRlw)),0)	AS float )  			as RenewWW,
	cast((sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW))) as float) /	nullIf(sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)),0) as RenewCWVsQrfDiff,
	(sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as RenewVsQrfDiff,
	cast ((sum(NewARRcw)-(sum(GrossARRcw)-sum(CancelARRcw)))-(sum(NewARRTargetcw)- (sum(GrossARRTargetcW) - sum(CancelARRTargetCW))) as float)/ abs(nullIf((sum(NewARRTargetCW)- (sum(GrossARRTargetCW) - sum(CancelARRTargetCW))),0)) as RenewCWVSQRF,
	sum(NewARRTargetFQ)-(sum(GrossARRTargetFQ)-sum(CancelARRTargetFQ)) as RenewARRTargetFQ,
	cast ((sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)))-(sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))) as float)/ abs(nullIf((sum(NewARRTarget)- (sum(GrossARRTarget) - sum(CancelARRTarget))),0)) as RenewVSQRF,
	sum(NewARRActual)-(sum(GrossARRActual)-sum(CancelARRActual)) as RenewActuals ,
	sum(NewUnitsACtual)- (sum(GrossUnitsActual) - sum(CancelUnitsActual)) as RenewUnitsActual,
	sum(NewARRCW)-(sum(GrossARRcw)-sum(CancelARRcw)) as RenewARRCW,
	sum(NewUnitsCW)- (sum(GrossUnitsCW) - sum(CancelUnitsCW)) as RenewUnitsCW,
	sum(NewARRCW)-(sum(GrossUnitsLQ)-sum(CancelARRTargetCW)) as RenewARRTargetCW
from FinancialG8ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and product_name in (@productFilters)
	and market_area_code in (@maFilters)
	and segment_pivot in (@segmentFilters)
	and subscription_offering in (@subscriptionFilters)
	and route_to_market in (@routeFilters)
group by  segment_pivot
order by quarter;

