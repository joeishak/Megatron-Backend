/**  New UQFM, Cumulative UQFM, New QFM,
     Cumulative QFM, 28 Day , Cum UQFM to QFM
G1 - 
G2 -  28 Day New UQFM to QFM, New UQFM, Cumulative QFM to QFM,
      Cumulative QFM, Cumulative UQFMs, New QFMS
G3 - 
G4 -
G5 - 
G6 -
G7 -
**/

-- TryActualTargetPrimary
select
	sum(NewQFMSActual          )      as NewQFMSActual,
	sum(NewQFMSTargetFQ          )      as NewQFMSTargetFQ,
    cast((sum(NewQfmsActual)-SUM(NewQFMSTarget)) AS float )/ cast(abs(sum(nullif(NewQFMSTarget,0))) AS float) as NewQFMSVsQrf
from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
	
-- TryG2ActualTargetSecondary
select
	week,
	  --New QFMs
    sum(NewQFMSActual          )      as NewQFMSActual,
	sum(NewQFMSTargetFQ          )      as NewQFMSTargetFQ,
    cast((sum(NewQfmsActual)-SUM(NewQFMSTarget)) AS float )/ cast(abs(sum(nullif(NewQFMSTarget,0))) AS float) as NewQFMSVsQrf,
    -- Cumulative QFMs
    Max(CumulativeQFMSActual )      as CumulativeQFMSActual,
	Max(CumulativeQFMSTargetFQ  )      as CumulativeQFMSTargetFQ ,
    cast((Max(CumulativeQFMSActual)-Max(CumulativeQFMSTarget)) AS float )/ cast(abs(Max(nullif(CumulativeQFMSTarget,0))) AS float) as CumulativeQFMSVsQrf,
    -- New UQFMs
    sum(NewUQFMSActual        )      as NewUQFMSActual,
	sum(NewUQFMSTargetFQ         )      as NewUQFMSTargetFQ ,
	cast((sum(NewUQFMSActual)-SUM(NewUQFMSTarget)) AS float )/ cast(abs(sum(nullif(NewUQFMSTarget,0))) AS float) as NewUQFMSVsQrf,
	 -- Cumulative UQFMs
	Max(CumulativeUqfmsActual        )      as CumulativeUqfmsActual,
	Max(CumulativeUqfmsTargetFQ         )      as CumulativeUqfmsTargetFQ ,
	cast((Max(CumulativeUqfmsActual)-Max(CumulativeUqfmsTarget)) AS float )/ cast(abs(Max(nullif(CumulativeUqfmsTarget,0))) AS float) as CumulativeUQFMSVsQrf,
	-- 28 Day UQFMs to QFM Conversion
	sum(Day28NewUQFMBaseActual        )   / nullif(sum( NewUQFMSActual),0)  as Day28NewUQFMActual,
	sum(Day28NewUQFMBaseTargetFQ         )  /nullif(sum( NewUQFMSTargetFQ),0)   as Day28NewUQFMTargetFQ ,
	cast(((sum(Day28NewUQFMBaseActual        )   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0))) AS float )/ cast(abs(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0)) AS float) as Day28NewUQFMVsQrf,
	-- Cum UQFM to QFM Conversion
	Max(CumulativeUqfmsActual        )   / nullif(sum( NewQfmsActual),0)  as CumulativeUqfmToQFMActual,
	Max(CumulativeUqfmsTargetFQ         )   /nullif(sum( NewQFMSTargetFQ),0)   as CumulativeUqfmToQFMTargetFQ ,
	cast(((Max(CumulativeUqfmsActual        )   / nullif(sum( NewQFMSActual),0)) -(Max(CumulativeUqfmsTarget         )   /nullif(sum( NewQFMSTarget),0))) AS float )/ cast(abs(Max(CumulativeUqfmsTarget)   /nullif(sum( NewQFMSTarget),0)) AS float) as Day28NewUQFMVsQrf
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
	
--TryG2MultiChartQuery
select
	    --New QFMs
    sum(NewQFMSActual          )      as NewQFMSActual,
	sum(NewQFMSTargetFQ          )      as NewQFMSTargetFQ,
    sum(NewQFMSLQ) as NewQFMSLQ,
	sum(NewQFMSLY) as NewQFMSLY,

    -- Cumulative QFMs
    Max(CumulativeQFMSActual )      as CumulativeQFMSActual,
	Max(CumulativeQFMSTargetFQ  )      as CumulativeQFMSTargetFQ ,
	Max(CumulativeQFMSLQ) as CumulativeQFMSLQ,
	Max(CumulativeQFMSLY) as CumulativeQFMSLY,
    -- New UQFMs
    sum(NewUQFMSActual        )      as NewUQFMSActual,
	sum(NewUQFMSTargetFQ         )      as NewUQFMSTargetFQ ,   
	 sum(NewUQFMSLQ) as NewUQFMSLQ,
	sum(NewUQFMSLY) as NewUQFMSLY,
	 -- Cumulative UQFMs
	Max(CumulativeUqfmsActual        )      as CumulativeUqfmsActual,
	Max(CumulativeUqfmsTargetFQ         )      as CumulativeUqfmsTargetFQ ,    
	Max(CumulativeUqfmsLQ) as CumulativeUqfmsLQ,
	Max(CumulativeUqfmsLY) as CumulativeUqfmsLY,
	-- 28 Day UQFMs to QFM Conversion
	sum(Day28NewUQFMBaseActual        )   / nullif(sum( NewUQFMSActual),0)  as Day28NewUQFMActual,
	sum(Day28NewUQFMBaseTargetFQ         )  /nullif(sum( NewUQFMSTargetFQ),0)   as Day28NewUQFMTargetFQ ,
	sum(Day28NewUQFMBaseLQ        )   / nullif(sum( NewUQFMSLQ),0)  as Day28NewUQFMLQ,
	sum(Day28NewUQFMBaseLY       )   / nullif(sum( NewUQFMSLY),0)  as Day28NewUQFMLY,
	-- Cum UQFM to QFM Conversion
	Max(CumulativeUqfmsActual        )   / nullif(sum( NewQFMSActual),0)  as CumulativeUqfmToQFMActual,
	Max(CumulativeUqfmsTargetFQ         )   /nullif(sum( NewQFMSTargetFQ),0)   as CumulativeUqfmToQFMTargetFQ ,
	Max(CumulativeUqfmsLQ        )   / nullif(sum( NewQFMSLQ),0)  as CumulativeUqfmToQFMLQ,
	Max(CumulativeUqfmsLY        )   / nullif(sum( NewQFMSLY),0)  as CumulativeUqfmToQFMLY
	from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
group by Week
	order by week desc


--TryG2QTD
select

	 cast((sum(NewQFMSActual)-SUM(NewQFMSLY))   		AS float ) / cast(sum(nullif(NewQFMSLY,0)) 		AS float )		as NewQFMSYY,
	cast((sum(NewQFMSActual)-SUM(NewQFMSLYLQ)) 		AS float ) / cast(sum(nullif(NewQFMSLYLQ,0)) 		AS float )	as NewQFMSQQLY,
	cast((sum(NewQFMSActual)- SUM(NewQFMSLQ))  		AS float ) / cast(sum(nullif(NewQFMSLQ,0)) 		AS float ) 		as NewQFMSQQTY,
	cast((sum(NewQFMSActual)-SUM(NewQFMSTarget))	AS float ) / cast(abs(sum(nullif(NewQFMSTarget,0))) 	AS float )	as NewQFMSVsQrf,
	sum( NewQFMSActual) 														as NewQFMSActual,
	sum( NewQFMSTargetFQ) 														as NewQFMSTarget,
	sum(NewQFMSActual)-sum(NewQFMSTarget) 									as NewQFMSVsQrfDiff,
	sum(NewQFMSCW) 															as NewQFMSCW,
		sum(NewQFMSTargetCW) 														as NewQFMSTargetCW,
	sum(NewQFMSCW)-sum(NewQFMSTargetCW) 									as NewQFMSCWVsQrfDiff,
	cast((sum(NewQFMSCW)-SUM(NewQFMSTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewQFMSTargetCW,0))) AS float )	as NewQFMSCWVsQrf,
	cast((sum(NewQFMSCW)-sum(NewQFMSLW))	 AS float )/	cast(sum(nullIf(NewQFMSLW,0)) AS float )				as NewQFMSWW,
	 -- Cumulative QFMS
	cast((Max(CumulativeQFMSActual)-Max(CumulativeQFMSLY))   		AS float ) / cast(Max(nullif(CumulativeQFMSLY,0)) 		AS float )		as CumulativeQFMSYY,
	cast((Max(CumulativeQFMSActual)-Max(CumulativeQFMSLYLQ)) 		AS float ) / cast(Max(nullif(CumulativeQFMSLYLQ,0)) 		AS float )	as CumulativeQFMSQQLY,
	cast((Max(CumulativeQFMSActual)- Max(CumulativeQFMSLQ))  		AS float ) / cast(Max(nullif(CumulativeQFMSLQ,0)) 		AS float ) 		as CumulativeQFMSQQTY,
	cast((Max(CumulativeQFMSActual)-Max(CumulativeQFMSTarget))	AS float ) / cast(abs(Max(nullif(CumulativeQFMSTarget,0))) 	AS float )	as CumulativeQFMSVsQrf,
	Max( CumulativeQFMSActual) 														as CumulativeQFMSActual,
	Max( CumulativeQFMSTargetFQ) 														as CumulativeQFMSTarget,
	Max(CumulativeQFMSActual)-Max(CumulativeQFMSTarget) 									as CumulativeQFMSVsQrfDiff,
	--Max(CumulativeQFMSCW) 															as CumulativeQFMSCW,
		Max(CumulativeQFMSTargetCW) 														as CumulativeQFMSTargetCW,
	--Max(CumulativeQFMSCW)-Max(CumulativeQFMSTargetCW) 									as CumulativeQFMSCWVsQrfDiff,
	--cast((Max(CumulativeQFMSCW)-Max(CumulativeQFMSTargetCW)) AS float )/ 	cast(abs(Max(nullIf(CumulativeQFMSTargetCW,0))) AS float )	as CumulativeQFMSCWVsQrf,
	--cast((Max(CumulativeQFMSCW)-Max(CumulativeQFMSLW))	 AS float )/	cast(Max(nullIf(CumulativeQFMSLW,0)) AS float )				as CumulativeQFMSWW,
	 -- New UQFMS
	 cast((sum(NewUQFMSActual)-SUM(NewUQFMSLY))   		AS float ) / cast(sum(nullif(NewUQFMSLY,0)) 		AS float )		as NewUQFMSYY,
	cast((sum(NewUQFMSActual)-SUM(NewUQFMSLYLQ)) 		AS float ) / cast(sum(nullif(NewUQFMSLYLQ,0)) 		AS float )	as NewUQFMSQQLY,
	cast((sum(NewUQFMSActual)- SUM(NewUQFMSLQ))  		AS float ) / cast(sum(nullif(NewUQFMSLQ,0)) 		AS float ) 		as NewUQFMSQQTY,
	cast((sum(NewUQFMSActual)-SUM(NewUQFMSTarget))	AS float ) / cast(abs(sum(nullif(NewUQFMSTarget,0))) 	AS float )	as NewUQFMSVsQrf,
	sum( NewUQFMSActual) 														as NewUQFMSActual,
	sum( NewUQFMSTargetFQ) 														as NewUQFMSTarget,
	sum(NewUQFMSActual)-sum(NewUQFMSTarget) 									as NewUQFMSVsQrfDiff,
	sum(NewUQFMSCW) 															as NewUQFMSCW,
		sum(NewUQFMSTargetCW) 														as NewUQFMSTargetCW,
	sum(NewUQFMSCW)-sum(NewUQFMSTargetCW) 									as NewUQFMSCWVsQrfDiff,
	cast((sum(NewUQFMSCW)-SUM(NewUQFMSTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewUQFMSTargetCW,0))) AS float )	as NewUQFMSCWVsQrf,
	cast((sum(NewUQFMSCW)-sum(NewUQFMSLW))	 AS float )/	cast(sum(nullIf(NewUQFMSLW,0)) AS float )				as NewUQFMSWW,		
	-- Cumulative UQFMS
	cast((Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSLY))   		AS float ) / cast(Max(nullif(CumulativeUQFMSLY,0)) 		AS float )		as CumulativeUQFMSYY,
	cast((Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSLYLQ)) 		AS float ) / cast(Max(nullif(CumulativeUQFMSLYLQ,0)) 		AS float )	as CumulativeUQFMSQQLY,
	cast((Max(CumulativeUQFMSActual)- Max(CumulativeUQFMSLQ))  		AS float ) / cast(Max(nullif(CumulativeUQFMSLQ,0)) 		AS float ) 		as CumulativeUQFMSQQTY,
	cast((Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSTarget))	AS float ) / cast(abs(Max(nullif(CumulativeUQFMSTarget,0))) 	AS float )	as CumulativeUQFMSVsQrf,
	Max( CumulativeUQFMSActual) 														as CumulativeUQFMSActual,
	Max( CumulativeUQFMSTargetFQ) 														as CumulativeUQFMSTarget,
	Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSTarget) 									as CumulativeUQFMSVsQrfDiff,
	--Max(CumulativeUQFMSCW) 															as CumulativeUQFMSCW,
		Max(CumulativeUQFMSTargetCW) 														as CumulativeUQFMSTargetCW,
	--Max(CumulativeUQFMSCW)-Max(CumulativeUQFMSTargetCW) 									as CumulativeUQFMSCWVsQrfDiff,
	--cast((Max(CumulativeUQFMSCW)-Max(CumulativeUQFMSTargetCW)) AS float )/ 	cast(abs(Max(nullIf(CumulativeUQFMSTargetCW,0))) AS float )	as CumulativeUQFMSCWVsQrf,
	--cast((Max(CumulativeUQFMSCW)-Max(CumulativeUQFMSLW))	 AS float )/	cast(Max(nullIf(CumulativeUQFMSLW,0)) AS float )				as CumulativeUQFMSWW,
	-- Day 28 New UQFMS
	cast(((sum(Day28NewUQFMBaseActual)   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseLY       )   / nullif(sum( NewUQFMSLY),0)))   		AS float ) / cast(sum(Day28NewUQFMBaseLY       )   / nullif(sum( NewUQFMSLY),0) 		AS float )		as Day28NewUQFMYY,
	cast(((sum(Day28NewUQFMBaseActual)   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseLQ       )   / nullif(sum( NewUQFMSLQ),0)))   		AS float ) / cast(sum(Day28NewUQFMBaseLQ       )   / nullif(sum( NewUQFMSLQ),0) 		AS float )		as Day28NewUQFMQQTY,
	cast(((sum(Day28NewUQFMBaseActual)   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseLYLQ       )   / nullif(sum( NewUQFMSLYLQ),0)))   		AS float ) / cast(sum(Day28NewUQFMBaseLYLQ       )   / nullif(sum( NewUQFMSLYLQ),0) 		AS float )		as Day28NewUQFMQQLY,
	cast(((sum(Day28NewUQFMBaseActual        )   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0))) AS float )/ cast(abs(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0)) AS float) as Day28NewUQFMVsQrf,
	cast(sum(Day28NewUQFMBaseActual        )   / nullif(sum(NewUQFMSActual),0) as float)  as Day28NewUQFMActual,
	cast(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0) as float)   as Day28NewUQFMTarget ,
	cast((sum(Day28NewUQFMBaseActual        )   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0) )	as float) as Day28NewUQFMVsQrfDiff,
	cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)as Day28NewUQFMCW,
	cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float)		as Day28UNewQFMTargetCW,
	cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)-cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float)	as Day28NewUQFMCWVsQrfDiff,
	--cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)-cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float)/ 	cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float)	as Day28NewUQFMCWVsQrf,
	(cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)-cast(sum(Day28NewUQFMBaseLW        )   / nullif(sum( NewUQFMSLW),0) as float))/	cast(sum(Day28NewUQFMBaseLW        )   / nullif(sum( NewUQFMSLW),0) as float)				as Day28NewUQFMWW,
	 
	-- Cumulative UQFM to QFM Conversion
	cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsLY       )   / nullif(sum( NewQFMSLY),0)))   		AS float ) / cast(sum(CumulativeUqfmsLY       )   / nullif(sum( NewQFMSLY),0) 		AS float )		as CumulativeUqfmToQFMYY,
	cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsLQ       )   / nullif(sum( NewQFMSLQ),0)))   		AS float ) / cast(sum(CumulativeUqfmsLQ       )   / nullif(sum( NewQFMSLQ),0) 		AS float )		as CumulativeUqfmToQFMQQTY,
	cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsLYLQ       )   / nullif(sum( NewQFMSLYLQ),0)))   		AS float ) / cast(sum(CumulativeUqfmsLYLQ       )   / nullif(sum( NewQFMSLYLQ),0) 		AS float )		as CumulativeUqfmToQFMQQLY,
	cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsTarget         )  /nullif(sum( NewQFMSTarget),0))) AS float )/ cast(abs(sum(CumulativeUqfmsTarget         )  /nullif(sum( NewQFMSTarget),0)) AS float) as CumulativeUqfmToQFMVsQrf,
	cast(sum(CumulativeUqfmsActual)     / nullif(sum( NewQFMSActual),0) as float)  as CumulativeUqfmToQFMActual,
	cast(sum(CumulativeUqfmsTarget)     / nullif(sum( NewQFMSTarget),0) as float)   as CumulativeUqfmToQFMTarget ,
	cast((sum(CumulativeUqfmsActual)    / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsTarget         )  /nullif(sum( NewQFMSTarget),0) )	as float) as CumulativeUqfmToQFMVsQrfDiff,
	--cast(sum(CumulativeUqfmsCW)			/ nullif(sum( NewQFMSCW),0) as float)as CumulativeUqfmToQFMCW,
	cast(sum(CumulativeUqfmsTargetCW)   / nullif(sum( NewQFMSTargetCW),0) as float)		as Day28UNewQFMTargetCW
	--cast(sum(CumulativeUqfmsCW)			/ nullif(sum( NewQFMSCW),0) as float)-cast(sum(CumulativeUqfmsTargetCW        )   / nullif(sum( NewQFMSTargetCW),0) as float)	as CumulativeUqfmToQFMCWVsQrfDiff,
	--cast(sum(CumulativeUqfmsCW)			/ nullif(sum( NewQFMSCW),0) as float)-cast(sum(CumulativeUqfmsTargetCW        )   / nullif(sum( NewQFMSTargetCW),0) as float))/ 	cast(sum(CumulativeUqfmsTargetCW        )   / nullif(sum( NewQFMSTargetCW),0) as float)	as CumulativeUqfmToQFMCWVsQrf,
	--(cast(sum(CumulativeUqfmsCW)		/ nullif(sum( NewQFMSCW),0) as float)-cast(sum(CumulativeUqfmsLW        )   / nullif(sum( NewQFMSLW),0) as float))/	cast(sum(CumulativeUqfmsLW        )   / nullif(sum( NewQFMSLW),0) as float)				as CumulativeUqfmToQFMWW
from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)

-- TryG2GeoQTD
Select
	geo_code,
	market_area_code,	
		 cast((sum(NewQFMSActual)-SUM(NewQFMSLY))   		AS float ) / cast(sum(nullif(NewQFMSLY,0)) 		AS float )		as NewQFMSYY,
	cast((sum(NewQFMSActual)-SUM(NewQFMSLYLQ)) 		AS float ) / cast(sum(nullif(NewQFMSLYLQ,0)) 		AS float )	as NewQFMSQQLY,
	cast((sum(NewQFMSActual)- SUM(NewQFMSLQ))  		AS float ) / cast(sum(nullif(NewQFMSLQ,0)) 		AS float ) 		as NewQFMSQQTY,
	cast((sum(NewQFMSActual)-SUM(NewQFMSTarget))	AS float ) / cast(abs(sum(nullif(NewQFMSTarget,0))) 	AS float )	as NewQFMSVsQrf,
	sum( NewQFMSActual) 														as NewQFMSActual,
	sum( NewQFMSTargetFQ) 														as NewQFMSTarget,
	sum(NewQFMSActual)-sum(NewQFMSTarget) 									as NewQFMSVsQrfDiff,
	sum(NewQFMSCW) 															as NewQFMSCW,
		sum(NewQFMSTargetCW) 														as NewQFMSTargetCW,
	sum(NewQFMSCW)-sum(NewQFMSTargetCW) 									as NewQFMSCWVsQrfDiff,
	cast((sum(NewQFMSCW)-SUM(NewQFMSTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewQFMSTargetCW,0))) AS float )	as NewQFMSCWVsQrf,
	cast((sum(NewQFMSCW)-sum(NewQFMSLW))	 AS float )/	cast(sum(nullIf(NewQFMSLW,0)) AS float )				as NewQFMSWW,
	 -- Cumulative QFMS
	cast((Max(CumulativeQFMSActual)-Max(CumulativeQFMSLY))   		AS float ) / cast(Max(nullif(CumulativeQFMSLY,0)) 		AS float )		as CumulativeQFMSYY,
	cast((Max(CumulativeQFMSActual)-Max(CumulativeQFMSLYLQ)) 		AS float ) / cast(Max(nullif(CumulativeQFMSLYLQ,0)) 		AS float )	as CumulativeQFMSQQLY,
	cast((Max(CumulativeQFMSActual)- Max(CumulativeQFMSLQ))  		AS float ) / cast(Max(nullif(CumulativeQFMSLQ,0)) 		AS float ) 		as CumulativeQFMSQQTY,
	cast((Max(CumulativeQFMSActual)-Max(CumulativeQFMSTarget))	AS float ) / cast(abs(Max(nullif(CumulativeQFMSTarget,0))) 	AS float )	as CumulativeQFMSVsQrf,
	Max( CumulativeQFMSActual) 														as CumulativeQFMSActual,
	Max( CumulativeQFMSTargetFQ) 														as CumulativeQFMSTarget,
	Max(CumulativeQFMSActual)-Max(CumulativeQFMSTarget) 									as CumulativeQFMSVsQrfDiff,
	--Max(CumulativeQFMSCW) 															as CumulativeQFMSCW,
		Max(CumulativeQFMSTargetCW) 														as CumulativeQFMSTargetCW,
	--Max(CumulativeQFMSCW)-Max(CumulativeQFMSTargetCW) 									as CumulativeQFMSCWVsQrfDiff,
	--cast((Max(CumulativeQFMSCW)-Max(CumulativeQFMSTargetCW)) AS float )/ 	cast(abs(Max(nullIf(CumulativeQFMSTargetCW,0))) AS float )	as CumulativeQFMSCWVsQrf,
	--cast((Max(CumulativeQFMSCW)-Max(CumulativeQFMSLW))	 AS float )/	cast(Max(nullIf(CumulativeQFMSLW,0)) AS float )				as CumulativeQFMSWW,
	 -- New UQFMS
	 cast((sum(NewUQFMSActual)-SUM(NewUQFMSLY))   		AS float ) / cast(sum(nullif(NewUQFMSLY,0)) 		AS float )		as NewUQFMSYY,
	cast((sum(NewUQFMSActual)-SUM(NewUQFMSLYLQ)) 		AS float ) / cast(sum(nullif(NewUQFMSLYLQ,0)) 		AS float )	as NewUQFMSQQLY,
	cast((sum(NewUQFMSActual)- SUM(NewUQFMSLQ))  		AS float ) / cast(sum(nullif(NewUQFMSLQ,0)) 		AS float ) 		as NewUQFMSQQTY,
	cast((sum(NewUQFMSActual)-SUM(NewUQFMSTarget))	AS float ) / cast(abs(sum(nullif(NewUQFMSTarget,0))) 	AS float )	as NewUQFMSVsQrf,
	sum( NewUQFMSActual) 														as NewUQFMSActual,
	sum( NewUQFMSTargetFQ) 														as NewUQFMSTarget,
	sum(NewUQFMSActual)-sum(NewUQFMSTarget) 									as NewUQFMSVsQrfDiff,
	sum(NewUQFMSCW) 															as NewUQFMSCW,
		sum(NewUQFMSTargetCW) 														as NewUQFMSTargetCW,
	sum(NewUQFMSCW)-sum(NewUQFMSTargetCW) 									as NewUQFMSCWVsQrfDiff,
	cast((sum(NewUQFMSCW)-SUM(NewUQFMSTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewUQFMSTargetCW,0))) AS float )	as NewUQFMSCWVsQrf,
	cast((sum(NewUQFMSCW)-sum(NewUQFMSLW))	 AS float )/	cast(sum(nullIf(NewUQFMSLW,0)) AS float )				as NewUQFMSWW,		
	-- Cumulative UQFMS
	cast((Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSLY))   		AS float ) / cast(Max(nullif(CumulativeUQFMSLY,0)) 		AS float )		as CumulativeUQFMSYY,
	cast((Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSLYLQ)) 		AS float ) / cast(Max(nullif(CumulativeUQFMSLYLQ,0)) 		AS float )	as CumulativeUQFMSQQLY,
	cast((Max(CumulativeUQFMSActual)- Max(CumulativeUQFMSLQ))  		AS float ) / cast(Max(nullif(CumulativeUQFMSLQ,0)) 		AS float ) 		as CumulativeUQFMSQQTY,
	cast((Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSTarget))	AS float ) / cast(abs(Max(nullif(CumulativeUQFMSTarget,0))) 	AS float )	as CumulativeUQFMSVsQrf,
	Max( CumulativeUQFMSActual) 														as CumulativeUQFMSActual,
	Max( CumulativeUQFMSTargetFQ) 														as CumulativeUQFMSTarget,
	Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSTarget) 									as CumulativeUQFMSVsQrfDiff,
	--Max(CumulativeUQFMSCW) 															as CumulativeUQFMSCW,
		Max(CumulativeUQFMSTargetCW) 														as CumulativeUQFMSTargetCW,
	--Max(CumulativeUQFMSCW)-Max(CumulativeUQFMSTargetCW) 									as CumulativeUQFMSCWVsQrfDiff,
	--cast((Max(CumulativeUQFMSCW)-Max(CumulativeUQFMSTargetCW)) AS float )/ 	cast(abs(Max(nullIf(CumulativeUQFMSTargetCW,0))) AS float )	as CumulativeUQFMSCWVsQrf,
	--cast((Max(CumulativeUQFMSCW)-Max(CumulativeUQFMSLW))	 AS float )/	cast(Max(nullIf(CumulativeUQFMSLW,0)) AS float )				as CumulativeUQFMSWW,
	-- Day 28 New UQFMS
	cast(((sum(Day28NewUQFMBaseActual)   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseLY       )   / nullif(sum( NewUQFMSLY),0)))   		AS float ) / cast(sum(Day28NewUQFMBaseLY       )   / nullif(sum( NewUQFMSLY),0) 		AS float )		as Day28NewUQFMYY,
	cast(((sum(Day28NewUQFMBaseActual)   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseLQ       )   / nullif(sum( NewUQFMSLQ),0)))   		AS float ) / cast(sum(Day28NewUQFMBaseLQ       )   / nullif(sum( NewUQFMSLQ),0) 		AS float )		as Day28NewUQFMQQTY,
	cast(((sum(Day28NewUQFMBaseActual)   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseLYLQ       )   / nullif(sum( NewUQFMSLYLQ),0)))   		AS float ) / cast(sum(Day28NewUQFMBaseLYLQ       )   / nullif(sum( NewUQFMSLYLQ),0) 		AS float )		as Day28NewUQFMQQLY,
	--cast(((sum(Day28NewUQFMBaseActual        )   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0))) AS float )/ cast(abs(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0))) AS float) as Day28NewUQFMVsQrf,
	cast(sum(Day28NewUQFMBaseActual        )   / nullif(sum(NewUQFMSActual),0) as float)  as Day28NewUQFMActual,
	cast(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0) as float)   as Day28NewUQFMTarget ,
	cast((sum(Day28NewUQFMBaseActual        )   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0) )	as float) as Day28NewUQFMVsQrfDiff,
	cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)as Day28NewUQFMCW,
	cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float)		as Day28UNewQFMTargetCW,
	cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)-cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float)	as Day28NewUQFMCWVsQrfDiff,
	--cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)-cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float))/ 	cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float)	as Day28NewUQFMCWVsQrf,
	(cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)-cast(sum(Day28NewUQFMBaseLW        )   / nullif(sum( NewUQFMSLW),0) as float))/	cast(sum(Day28NewUQFMBaseLW        )   / nullif(sum( NewUQFMSLW),0) as float)				as Day28NewUQFMWW,
	 
	-- Cumulative UQFM to QFM Conversion
	--cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsLY       )   / nullif(sum( NewQFMSLY),0)))   		AS float ) / cast(sum(CumulativeUqfmsLY       )   / nullif(sum( NewQFMSLY),0) 		AS float )		as CumulativeUqfmToQFMYY,
	--cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsLQ       )   / nullif(sum( NewQFMSLQ),0)))   		AS float ) / cast(sum(CumulativeUqfmsLQ       )   / nullif(sum( NewQFMSLQ),0) 		AS float )		as CumulativeUqfmToQFMQQTY,
	--cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsLYLQ       )   / nullif(sum( NewQFMSLYLQ),0)))   		AS float ) / cast(sum(CumulativeUqfmsLYLQ       )   / nullif(sum( NewQFMSLYLQ),0) 		AS float )		as CumulativeUqfmToQFMQQLY,
	--cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsTarget         )  /nullif(sum( NewQFMSTarget),0))) AS float )/ cast(abs(sum(CumulativeUqfmsTarget         )  /nullif(sum( NewQFMSTarget),0))) AS float) as CumulativeUqfmToQFMVsQrf,
	cast(sum(CumulativeUqfmsActual)     / nullif(sum( NewQFMSActual),0) as float)  as CumulativeUqfmToQFMActual,
	cast(sum(CumulativeUqfmsTarget)     / nullif(sum( NewQFMSTarget),0) as float)   as CumulativeUqfmToQFMTarget ,
	cast((sum(CumulativeUqfmsActual)    / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsTarget         )  /nullif(sum( NewQFMSTarget),0) )	as float) as CumulativeUqfmToQFMVsQrfDiff,
	--cast(sum(CumulativeUqfmsCW)			/ nullif(sum( NewQFMSCW),0) as float)as CumulativeUqfmToQFMCW,
	cast(sum(CumulativeUqfmsTargetCW)   / nullif(sum( NewQFMSTargetCW),0) as float)		as Day28UNewQFMTargetCW
	--cast(sum(CumulativeUqfmsCW)			/ nullif(sum( NewQFMSCW),0) as float)-cast(sum(CumulativeUqfmsTargetCW        )   / nullif(sum( NewQFMSTargetCW),0) as float)	as CumulativeUqfmToQFMCWVsQrfDiff,
	--cast(sum(CumulativeUqfmsCW)			/ nullif(sum( NewQFMSCW),0) as float)-cast(sum(CumulativeUqfmsTargetCW        )   / nullif(sum( NewQFMSTargetCW),0) as float))/ 	cast(sum(CumulativeUqfmsTargetCW        )   / nullif(sum( NewQFMSTargetCW),0) as float)	as CumulativeUqfmToQFMCWVsQrf,
	--(cast(sum(CumulativeUqfmsCW)		/ nullif(sum( NewQFMSCW),0) as float)-cast(sum(CumulativeUqfmsLW        )   / nullif(sum( NewQFMSLW),0) as float))/	cast(sum(CumulativeUqfmsLW        )   / nullif(sum( NewQFMSLW),0) as float)				as CumulativeUqfmToQFMWW
from JourneyG2ARR

where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
group by geo_code, market_area_code
order by 1, 2

-- TryG2MarketAreaQTD
Select
	market_area_code,
	 cast((sum(NewQFMSActual)-SUM(NewQFMSLY))   		AS float ) / cast(sum(nullif(NewQFMSLY,0)) 		AS float )		as NewQFMSYY,
	cast((sum(NewQFMSActual)-SUM(NewQFMSLYLQ)) 		AS float ) / cast(sum(nullif(NewQFMSLYLQ,0)) 		AS float )	as NewQFMSQQLY,
	cast((sum(NewQFMSActual)- SUM(NewQFMSLQ))  		AS float ) / cast(sum(nullif(NewQFMSLQ,0)) 		AS float ) 		as NewQFMSQQTY,
	cast((sum(NewQFMSActual)-SUM(NewQFMSTarget))	AS float ) / cast(abs(sum(nullif(NewQFMSTarget,0))) 	AS float )	as NewQFMSVsQrf,
	sum( NewQFMSActual) 														as NewQFMSActual,
	sum( NewQFMSTargetFQ) 														as NewQFMSTarget,
	sum(NewQFMSActual)-sum(NewQFMSTarget) 									as NewQFMSVsQrfDiff,
	sum(NewQFMSCW) 															as NewQFMSCW,
		sum(NewQFMSTargetCW) 														as NewQFMSTargetCW,
	sum(NewQFMSCW)-sum(NewQFMSTargetCW) 									as NewQFMSCWVsQrfDiff,
	cast((sum(NewQFMSCW)-SUM(NewQFMSTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewQFMSTargetCW,0))) AS float )	as NewQFMSCWVsQrf,
	cast((sum(NewQFMSCW)-sum(NewQFMSLW))	 AS float )/	cast(sum(nullIf(NewQFMSLW,0)) AS float )				as NewQFMSWW,
	 -- Cumulative QFMS
	cast((Max(CumulativeQFMSActual)-Max(CumulativeQFMSLY))   		AS float ) / cast(Max(nullif(CumulativeQFMSLY,0)) 		AS float )		as CumulativeQFMSYY,
	cast((Max(CumulativeQFMSActual)-Max(CumulativeQFMSLYLQ)) 		AS float ) / cast(Max(nullif(CumulativeQFMSLYLQ,0)) 		AS float )	as CumulativeQFMSQQLY,
	cast((Max(CumulativeQFMSActual)- Max(CumulativeQFMSLQ))  		AS float ) / cast(Max(nullif(CumulativeQFMSLQ,0)) 		AS float ) 		as CumulativeQFMSQQTY,
	cast((Max(CumulativeQFMSActual)-Max(CumulativeQFMSTarget))	AS float ) / cast(abs(Max(nullif(CumulativeQFMSTarget,0))) 	AS float )	as CumulativeQFMSVsQrf,
	Max( CumulativeQFMSActual) 														as CumulativeQFMSActual,
	Max( CumulativeQFMSTargetFQ) 														as CumulativeQFMSTarget,
	Max(CumulativeQFMSActual)-Max(CumulativeQFMSTarget) 									as CumulativeQFMSVsQrfDiff,
	--Max(CumulativeQFMSCW) 															as CumulativeQFMSCW,
		Max(CumulativeQFMSTargetCW) 														as CumulativeQFMSTargetCW,
	--Max(CumulativeQFMSCW)-Max(CumulativeQFMSTargetCW) 									as CumulativeQFMSCWVsQrfDiff,
	--cast((Max(CumulativeQFMSCW)-Max(CumulativeQFMSTargetCW)) AS float )/ 	cast(abs(Max(nullIf(CumulativeQFMSTargetCW,0))) AS float )	as CumulativeQFMSCWVsQrf,
	--cast((Max(CumulativeQFMSCW)-Max(CumulativeQFMSLW))	 AS float )/	cast(Max(nullIf(CumulativeQFMSLW,0)) AS float )				as CumulativeQFMSWW,
	 -- New UQFMS
	 cast((sum(NewUQFMSActual)-SUM(NewUQFMSLY))   		AS float ) / cast(sum(nullif(NewUQFMSLY,0)) 		AS float )		as NewUQFMSYY,
	cast((sum(NewUQFMSActual)-SUM(NewUQFMSLYLQ)) 		AS float ) / cast(sum(nullif(NewUQFMSLYLQ,0)) 		AS float )	as NewUQFMSQQLY,
	cast((sum(NewUQFMSActual)- SUM(NewUQFMSLQ))  		AS float ) / cast(sum(nullif(NewUQFMSLQ,0)) 		AS float ) 		as NewUQFMSQQTY,
	cast((sum(NewUQFMSActual)-SUM(NewUQFMSTarget))	AS float ) / cast(abs(sum(nullif(NewUQFMSTarget,0))) 	AS float )	as NewUQFMSVsQrf,
	sum( NewUQFMSActual) 														as NewUQFMSActual,
	sum( NewUQFMSTargetFQ) 														as NewUQFMSTarget,
	sum(NewUQFMSActual)-sum(NewUQFMSTarget) 									as NewUQFMSVsQrfDiff,
	sum(NewUQFMSCW) 															as NewUQFMSCW,
		sum(NewUQFMSTargetCW) 														as NewUQFMSTargetCW,
	sum(NewUQFMSCW)-sum(NewUQFMSTargetCW) 									as NewUQFMSCWVsQrfDiff,
	cast((sum(NewUQFMSCW)-SUM(NewUQFMSTargetCW)) AS float )/ 	cast(abs(SUM(nullIf(NewUQFMSTargetCW,0))) AS float )	as NewUQFMSCWVsQrf,
	cast((sum(NewUQFMSCW)-sum(NewUQFMSLW))	 AS float )/	cast(sum(nullIf(NewUQFMSLW,0)) AS float )				as NewUQFMSWW,		
	-- Cumulative UQFMS
	cast((Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSLY))   		AS float ) / cast(Max(nullif(CumulativeUQFMSLY,0)) 		AS float )		as CumulativeUQFMSYY,
	cast((Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSLYLQ)) 		AS float ) / cast(Max(nullif(CumulativeUQFMSLYLQ,0)) 		AS float )	as CumulativeUQFMSQQLY,
	cast((Max(CumulativeUQFMSActual)- Max(CumulativeUQFMSLQ))  		AS float ) / cast(Max(nullif(CumulativeUQFMSLQ,0)) 		AS float ) 		as CumulativeUQFMSQQTY,
	cast((Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSTarget))	AS float ) / cast(abs(Max(nullif(CumulativeUQFMSTarget,0))) 	AS float )	as CumulativeUQFMSVsQrf,
	Max( CumulativeUQFMSActual) 														as CumulativeUQFMSActual,
	Max( CumulativeUQFMSTargetFQ) 														as CumulativeUQFMSTarget,
	Max(CumulativeUQFMSActual)-Max(CumulativeUQFMSTarget) 									as CumulativeUQFMSVsQrfDiff,
	--Max(CumulativeUQFMSCW) 															as CumulativeUQFMSCW,
		Max(CumulativeUQFMSTargetCW) 														as CumulativeUQFMSTargetCW,
	--Max(CumulativeUQFMSCW)-Max(CumulativeUQFMSTargetCW) 									as CumulativeUQFMSCWVsQrfDiff,
	--cast((Max(CumulativeUQFMSCW)-Max(CumulativeUQFMSTargetCW)) AS float )/ 	cast(abs(Max(nullIf(CumulativeUQFMSTargetCW,0))) AS float )	as CumulativeUQFMSCWVsQrf,
	--cast((Max(CumulativeUQFMSCW)-Max(CumulativeUQFMSLW))	 AS float )/	cast(Max(nullIf(CumulativeUQFMSLW,0)) AS float )				as CumulativeUQFMSWW,
	-- Day 28 New UQFMS
	cast(((sum(Day28NewUQFMBaseActual)   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseLY       )   / nullif(sum( NewUQFMSLY),0)))   		AS float ) / cast(sum(Day28NewUQFMBaseLY       )   / nullif(sum( NewUQFMSLY),0) 		AS float )		as Day28NewUQFMYY,
	cast(((sum(Day28NewUQFMBaseActual)   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseLQ       )   / nullif(sum( NewUQFMSLQ),0)))   		AS float ) / cast(sum(Day28NewUQFMBaseLQ       )   / nullif(sum( NewUQFMSLQ),0) 		AS float )		as Day28NewUQFMQQTY,
	cast(((sum(Day28NewUQFMBaseActual)   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseLYLQ       )   / nullif(sum( NewUQFMSLYLQ),0)))   		AS float ) / cast(sum(Day28NewUQFMBaseLYLQ       )   / nullif(sum( NewUQFMSLYLQ),0) 		AS float )		as Day28NewUQFMQQLY,
	--cast(((sum(Day28NewUQFMBaseActual        )   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0))) AS float )/ cast(abs(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0))) AS float) as Day28NewUQFMVsQrf,
	cast(sum(Day28NewUQFMBaseActual        )   / nullif(sum(NewUQFMSActual),0) as float)  as Day28NewUQFMActual,
	cast(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0) as float)   as Day28NewUQFMTarget ,
	cast((sum(Day28NewUQFMBaseActual        )   / nullif(sum( NewUQFMSActual),0))-(sum(Day28NewUQFMBaseTarget         )  /nullif(sum( NewUQFMSTarget),0) )	as float) as Day28NewUQFMVsQrfDiff,
	cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)as Day28NewUQFMCW,
	cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float)		as Day28UNewQFMTargetCW,
	cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)-cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float)	as Day28NewUQFMCWVsQrfDiff,
	--cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)-cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float))/ 	cast(sum(Day28NewUQFMBaseTargetCW        )   / nullif(sum( NewUQFMSTargetCW),0) as float)	as Day28NewUQFMCWVsQrf,
	(cast(sum(Day28NewUQFMBaseCW        )   / nullif(sum( NewUQFMSCW),0) as float)-cast(sum(Day28NewUQFMBaseLW        )   / nullif(sum( NewUQFMSLW),0) as float))/	cast(sum(Day28NewUQFMBaseLW        )   / nullif(sum( NewUQFMSLW),0) as float)				as Day28NewUQFMWW,
	 
	-- Cumulative UQFM to QFM Conversion
	--cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsLY       )   / nullif(sum( NewQFMSLY),0)))   		AS float ) / cast(sum(CumulativeUqfmsLY       )   / nullif(sum( NewQFMSLY),0) 		AS float )		as CumulativeUqfmToQFMYY,
	--cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsLQ       )   / nullif(sum( NewQFMSLQ),0)))   		AS float ) / cast(sum(CumulativeUqfmsLQ       )   / nullif(sum( NewQFMSLQ),0) 		AS float )		as CumulativeUqfmToQFMQQTY,
	--cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsLYLQ       )   / nullif(sum( NewQFMSLYLQ),0)))   		AS float ) / cast(sum(CumulativeUqfmsLYLQ       )   / nullif(sum( NewQFMSLYLQ),0) 		AS float )		as CumulativeUqfmToQFMQQLY,
	--cast(((sum(CumulativeUqfmsActual)   / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsTarget         )  /nullif(sum( NewQFMSTarget),0))) AS float )/ cast(abs(sum(CumulativeUqfmsTarget         )  /nullif(sum( NewQFMSTarget),0))) AS float) as CumulativeUqfmToQFMVsQrf,
	cast(sum(CumulativeUqfmsActual)     / nullif(sum( NewQFMSActual),0) as float)  as CumulativeUqfmToQFMActual,
	cast(sum(CumulativeUqfmsTarget)     / nullif(sum( NewQFMSTarget),0) as float)   as CumulativeUqfmToQFMTarget ,
	cast((sum(CumulativeUqfmsActual)    / nullif(sum( NewQFMSActual),0))-(sum(CumulativeUqfmsTarget         )  /nullif(sum( NewQFMSTarget),0) )	as float) as CumulativeUqfmToQFMVsQrfDiff,
	--cast(sum(CumulativeUqfmsCW)			/ nullif(sum( NewQFMSCW),0) as float)as CumulativeUqfmToQFMCW,
	cast(sum(CumulativeUqfmsTargetCW)   / nullif(sum( NewQFMSTargetCW),0) as float)		as Day28UNewQFMTargetCW
	--cast(sum(CumulativeUqfmsCW)			/ nullif(sum( NewQFMSCW),0) as float)-cast(sum(CumulativeUqfmsTargetCW        )   / nullif(sum( NewQFMSTargetCW),0) as float)	as CumulativeUqfmToQFMCWVsQrfDiff,
	--cast(sum(CumulativeUqfmsCW)			/ nullif(sum( NewQFMSCW),0) as float)-cast(sum(CumulativeUqfmsTargetCW        )   / nullif(sum( NewQFMSTargetCW),0) as float))/ 	cast(sum(CumulativeUqfmsTargetCW        )   / nullif(sum( NewQFMSTargetCW),0) as float)	as CumulativeUqfmToQFMCWVsQrf,
	--(cast(sum(CumulativeUqfmsCW)		/ nullif(sum( NewQFMSCW),0) as float)-cast(sum(CumulativeUqfmsLW        )   / nullif(sum( NewQFMSLW),0) as float))/	cast(sum(CumulativeUqfmsLW        )   / nullif(sum( NewQFMSLW),0) as float)				as CumulativeUqfmToQFMWW
from JourneyG2ARR
from JourneyG2ARR
where geo_code in (@geofilters)
	and quarter in (@quarterFilters)
	and market_area_code in (@maFilters)
group by market_area_code
order by 1;
