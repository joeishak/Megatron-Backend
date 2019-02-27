
-- Groups for Financials
-- G5 = QTR Payment Failure Rate, QTR UI Rate
-- G7 = EOT Retention Rate, QTF Fin Retention Rate
-- G8 = Cancellations ARR, Gross New ARr, Net New ARR, Renewal ARR

/*********************************************************************************************/
/**************************************Queries************************************************/
/*********************************************************************************************/
-- FinancialG5ARR - Payment Failure, QTr UI Rate, PF Cancel, QTR Begin Active, Gross New Units, Renewal @ FP, UI Cancel, 
    Select
        quarter,
		    week,
        geo_code,
        product_name,
        market_area_code,
		case 	when market_area_code = 'US' then 'US' 
					when market_area_code = 'UK' then 'UK'
					when market_area_code = 'GER' then 'GER'
					when market_area_code = 'ANZ' then 'ANZ'
					when market_area_code = 'JPN' then 'JPN'
					else 'ROW'
		end as market_area_group,					
        route_to_market,
        segment_pivot,
        subscription_offering,
		 sum(gross_new_Units_actual)           as GrossUnitsActual,
		sum(gross_new_Units_cw )                 as GrossUnitsCW,
		sum(gross_new_Units_lw )                 as GrossUnitsLW,
        sum(gross_new_Units_ly)                 as GrossUnitsLY,
        sum(gross_new_Units_lq )                 as GrossUnitsLQ,
        sum(gross_new_Units_lylq )                 as GrossUnitsLYLQ,
        sum(gross_new_Units_target)           as GrossUnitsTarget,
		sum(pf_cancel_actual) as PFCancelActual,
		sum(pf_cancel_cw) as PFCacncelCW,
		sum(pf_cancel_lw) as PFCacncelLW,
		sum(pf_cancel_lq) as PFCacncelLQ,
		sum(pf_cancel_ly) as PFCacncelLY,
		sum(pf_cancel_lylq) as PFCacncelLYLQ,
		sum(pf_cancel_target) as PFCacncelTarget,
		sum(pf_cancel_target_cw) as PFCacncelTargetCW,
		sum(pf_cancel_target_fq) as PFCacncelTargetFQ,
		sum(qtr_begin_active_actual) as QTRBeginActiveActual,
		sum(qtr_begin_active_cw) as QTRBeginActiveCW,
		sum(qtr_begin_active_lw) as QTRBeginActiveLW,
		sum(qtr_begin_active_lq) as QTRBeginActiveLQ,
		sum(qtr_begin_active_ly) as QTRBeginActiveLY,
		sum(qtr_begin_active_lylq) as QTRBeginActiveLYLQ,
		sum(qtr_begin_active_target) as QTRBeginActiveTarget,
		sum(qtr_begin_active_target_cw) as QTRBeginActiveTargetCW,
		sum(qtr_begin_active_target_fq) as QTRBeginActiveTargetFQ,
		sum(renewal_at_fp_arr_actual)              as RenewARRActual,
		sum(renewal_at_fp_arr_cw )            as RenewARRCW	,
        sum(renewal_at_fp_arr_lw )            as RenewARRLW,
        sum(renewal_at_fp_arr_lq )            as RenewARRLQ,
		sum(renewal_at_fp_arr_ly )            as RenewARRLY	,
		sum(renewal_at_fp_arr_lylq )            as RenewARRLYLQ	,
        sum(renewal_at_fp_arr_target)       as RenewARRTarget,
        sum(renewal_at_fp_arr_target_cw)       as RenewARRTargetCW,
        sum(renewal_at_fp_arr_target_fq)       as RenewARRTargetFQ,
        sum(renewal_at_fp_Units_actual)              as RenewUnitsActual,
		sum(renewal_at_fp_Units_cw )            as RenewUnitsCW	,
		sum(ui_cancel_actual) as UICancelActual,
		sum(ui_cancel_cw) as UICancelCW,
		sum(ui_cancel_lw) as UICancelLW,
		sum(ui_cancel_lq) as UICancelLQ,
		sum(ui_cancel_ly) as UICancelLY,
		sum(ui_cancel_lylq) as UICancelLYLQ,
		sum(ui_cancel_target) as UICancelTarget,
		sum(ui_cancel_target_cw) as UICancelTargetCW,
		sum(ui_cancel_target_fq) as UICancelTargetFQ
		 from newFin
    group by 
        quarter, week, geo_code,product_name, market_area_code, 
		case 	when market_area_code = 'US' then 'US' 
					when market_area_code = 'UK' then 'UK'
					when market_area_code = 'GER' then 'GER'
					when market_area_code = 'ANZ' then 'ANZ'
					when market_area_code = 'JPN' then 'JPN'
					else 'ROW'
		end ,route_to_market, segment_pivot, subscription_offering 

--FinancialG7ARR: EOT Retention, QTR Fin Retention, Cancellation Units Actual, QTR Begin ACtive, 
				  --Gross New Units, Term End Active, Term end REnewal
   Select
        quarter,
		    week,
        geo_code,
        product_name,
        market_area_code,
		case 	when market_area_code = 'US' then 'US' 
					when market_area_code = 'UK' then 'UK'
					when market_area_code = 'GER' then 'GER'
					when market_area_code = 'ANZ' then 'ANZ'
					when market_area_code = 'JPN' then 'JPN'
					else 'ROW'
		end as market_area_group,
        route_to_market,
        segment_pivot,
        subscription_offering,
		
		 sum(cancellations_Units_actual)       as CancelUnitsActual,
		sum(cancellations_Units_cw )             as CancelUnitsCW,
		sum(cancellations_Units_lw )             as CancelUnitsLW,
		sum(cancellations_Units_lq )             as CancelUnitsLQ,
		sum(cancellations_Units_ly )             as CancelUnitsLY,
		sum(cancellations_Units_lylq )             as CancelUnitsLYLQ,
        sum(cancellations_Units_target)       as CancelUnitsTarget,
		sum(qtr_begin_active_actual) as QTRBeginActiveActual,
		sum(qtr_begin_active_cw) as QTRBeginActiveCW,
		sum(qtr_begin_active_lw) as QTRBeginActiveLW,
		sum(qtr_begin_active_lq) as QTRBeginActiveLQ,
		sum(qtr_begin_active_ly) as QTRBeginActiveLY,
		sum(qtr_begin_active_lylq) as QTRBeginActiveLYLQ,
		sum(qtr_begin_active_target) as QTRBeginActiveTarget,
		sum(qtr_begin_active_target_cw) as QTRBeginActiveTargetCW,
		sum(qtr_begin_active_target_fq) as QTRBeginActiveTargetFQ,
		 sum(gross_new_Units_actual)           as GrossUnitsActual,
		sum(gross_new_Units_cw )                 as GrossUnitsCW,
		sum(gross_new_Units_lw )                 as GrossUnitsLW,
        sum(gross_new_Units_ly)                 as GrossUnitsLY,
        sum(gross_new_Units_lq )                 as GrossUnitsLQ,
        sum(gross_new_Units_lylq )                 as GrossUnitsLYLQ,
        sum(gross_new_Units_target)           as GrossUnitsTarget,
		sum(term_end_active_actual) as TermEndActiveActual,
		sum(term_end_active_cw) as TermEndActiveCW,
		sum(term_end_active_lw) as TermEndActiveLW,
		sum(term_end_active_lq) as TermEndActiveLQ,
		sum(term_end_active_ly) as TermEndActiveLY,
		sum(term_end_active_lylq) as TermEndActiveLYLQ,
		sum(term_end_renewal_actual) as TermEndRenewalActual,
		sum(term_end_renewal_cw) as TermEndRenewalCW,
		sum(term_end_renewal_lw) as TermEndRenewalLW,
		sum(term_end_renewal_lq) as TermEndRenewalLQ,
		sum(term_end_renewal_ly) as TermEndRenewalLY,
		sum(term_end_renewal_lylq) as TermEndRenewalLYLQ
		 from newFin
    group by
        quarter, week, geo_code,product_name, market_area_code, 
		case 	when market_area_code = 'US' then 'US' 
					when market_area_code = 'UK' then 'UK'
					when market_area_code = 'GER' then 'GER'
					when market_area_code = 'ANZ' then 'ANZ'
					when market_area_code = 'JPN' then 'JPN'
					else 'ROW'
		end , route_to_market, segment_pivot, subscription_offering 


--FinancialG8ARR -Net New Arr, Gross New ARr, Cancellations ARr, Renewal ARR
       Select
        quarter,
		    week,
        geo_code,
        product_name,
        market_area_code,		
		case 	when market_area_code = 'US' then 'US' 
					when market_area_code = 'UK' then 'UK'
					when market_area_code = 'GER' then 'GER'
					when market_area_code = 'ANZ' then 'ANZ'
					when market_area_code = 'JPN' then 'JPN'
					else 'ROW'
		end as market_area_group,
        route_to_market,
        segment_pivot,
        subscription_offering,
		/**Cancellations**/
         sum(cancellations_arr_actual)       as CancelARRActual,
    	sum(cancellations_arr_cw )            as CancelARRCW,
    	sum(cancellations_arr_lw )            as CancelARRLW,
    	sum(cancellations_arr_lq )            as CancelARRLQ,
    	sum(cancellations_arr_ly )            as CancelARRLY,
    	sum(cancellations_arr_lylq )            as CancelARRLYLQ,
        sum(cancellations_arr_target)       as CancelARRTarget,
        sum(cancellations_arr_target_cw)       as CancelARRTargetCW,
        sum(cancellations_arr_target_fq)       as CancelARRTargetFQ,
		sum(cancellations_arr_cw)-sum(cancellations_arr_target_cw) as CancelARRVsQrfDiffCW,
		sum(cancellations_arr_actual)-sum(cancellations_arr_target) as CancelARRVsQrfDiff,
		(sum(cancellations_arr_cw)-SUM(cancellations_arr_target_cw))/nullIf(SUM(cancellations_arr_target_cw),0) as CancelARRVsQrfCW,
        (sum(cancellations_arr_actual)-SUM(cancellations_arr_target))/ nullIf(SUM(cancellations_arr_target),0) as CancelARRVsQrf,
        (sum(cancellations_arr_cw)-sum(cancellations_arr_lw))/ nullIf(SUM(cancellations_arr_lw),0) as CancelARRWW,
        (sum(cancellations_arr_actual)-SUM(cancellations_arr_lq))/ nullIf(SUM(cancellations_arr_lq),0) as CancelARRQQTY,
        (sum(cancellations_arr_actual)-SUM(cancellations_arr_lylq))/ nullIf(SUM(cancellations_arr_lylq),0) as CancelARRQQLY,
        (sum(cancellations_arr_actual)-SUM(cancellations_arr_ly))/ nullIf(SUM(cancellations_arr_ly),0) as CancelARRYY,
        sum(cancellations_units_actual)       as CancelUnitsActual,
		sum(cancellations_Units_cw )             as CancelUnitsCW,
		sum(cancellations_Units_target )             as CancelUnitsTarget,
		sum(cancellations_Units_lq )             as CancelUnitsLQ,
		sum(cancellations_Units_ly )             as CancelUnitsLY,

        /**Gross**/
   		sum(gross_new_arr_actual)           as GrossARRActual,
		sum(gross_new_arr_cw )                 as GrossARRCW,
        sum(gross_new_arr_lw )                 as GrossARRLW,
        sum(gross_new_arr_lq )                 as GrossARRLQ,
		sum(gross_new_arr_ly )                 as GrossARRLY,
		sum(gross_new_arr_lylq )                 as GrossARRLYLQ,
        sum(gross_new_arr_target)           as GrossARRTarget,
        sum(gross_new_arr_target_cw)           as GrossARRTargetCW,
        sum(gross_new_arr_target_fq)           as GrossARRTargetFQ,
        sum(gross_new_Units_actual)           as GrossUnitsActual,
		sum(gross_new_Units_cw )                 as GrossUnitsCW,
		sum(gross_new_Units_target )                 as GrossUnitsTarget,
		sum(gross_new_Units_lq )                 as GrossUnitsLQ,
		sum(gross_new_Units_ly )                 as GrossUnitsLY,
		sum(gross_new_arr_cw)-sum(gross_new_arr_target_cw) as GrossARRVsQrfDiffCW,
		sum(gross_new_arr_actual)-sum(gross_new_arr_target) as GrossARRVsQrfDiff,
		(sum(gross_new_arr_cw)-SUM(gross_new_arr_target_cw))/nullIf(SUM(gross_new_arr_target_cw),0) as GrossARRVsQrfCW,
        (sum(gross_new_arr_actual)-SUM(gross_new_arr_target))/ nullIf(SUM(gross_new_arr_target),0) as GrossARRVsQrf,
        (sum(gross_new_arr_cw)-sum(gross_new_arr_lw))/ nullIf(SUM(gross_new_arr_lw),0) as GrossARRWW,
        (sum(gross_new_arr_actual)-SUM(gross_new_arr_lq))/ nullIf(SUM(gross_new_arr_lq),0) as GrossARRQQTY,
        (sum(gross_new_arr_actual)-SUM(gross_new_arr_lylq))/ nullIf(SUM(gross_new_arr_lylq),0) as GrossARRQQLY,
        (sum(gross_new_arr_actual)-SUM(gross_new_arr_ly))/ nullIf(SUM(gross_new_arr_ly),0) as GrossARRYY,
		/**Net New**/
		sum(net_new_arr_actual)             as NewARRActual,
		sum(net_new_arr_cw )				as NewARRCW,
        sum(net_new_arr_lw )				as NewARRLW,
        sum(net_new_arr_lq )				as NewARRLQ,
		sum(net_new_arr_ly )				as NewARRLY,
		sum(net_new_arr_lylq )				as NewARRLYLQ,
        sum(net_new_arr_target)             as NewARRTarget,
        sum(net_new_arr_target_cw)             as NewARRTargetCW,
        sum(net_new_arr_target_fq)             as NewARRTargetFQ,
        sum(net_new_Units_actual)             as NewUnitsActual,
		sum(net_new_Units_cw )				as NewUnitsCW,
		sum(net_new_Units_target )				as NewUnitsTarget,
		sum(net_new_Units_lq )				as NewUnitsLQ,
		sum(net_new_Units_ly )				as NewUnitsLY,
		sum(net_new_arr_cw)-sum(net_new_arr_target_cw) as NewARRVsQrfDiffCW,
		sum(net_new_arr_actual)-sum(net_new_arr_target) as NewARRVsQrfDiff,
		(sum(net_new_arr_cw)-SUM(net_new_arr_target_cw))/nullIf(SUM(net_new_arr_target_cw),0) as NewARRVsQrfCW,
        (sum(net_new_arr_actual)-SUM(net_new_arr_target))/ nullIf(SUM(net_new_arr_target),0) as NewARRVsQrf,
        (sum(net_new_arr_cw)-sum(net_new_arr_lw))/ nullIf(SUM(net_new_arr_lw),0) as NewARRWW,
        (sum(net_new_arr_actual)-SUM(net_new_arr_lq))/ nullIf(SUM(net_new_arr_lq),0) as NewARRQQTY,
        (sum(net_new_arr_actual)-SUM(net_new_arr_lylq))/ nullIf(SUM(net_new_arr_lylq),0) as NewARRQQLY,
        (sum(net_new_arr_actual)-SUM(net_new_arr_ly))/ nullIf(SUM(net_new_arr_ly),0) as NewARRYY,
		/**Renewal**/
        /**Handled IN XDC **/
		/**Others**/
		sum(pf_cancel_actual) as PFCancelActual,
		sum(pf_cancel_cw) as PFCacncelCW,
		sum(pf_cancel_lw) as PFCacncelLW,
		sum(pf_cancel_lq) as PFCacncelLQ,
		sum(pf_cancel_ly) as PFCacncelLY,
		sum(pf_cancel_lylq) as PFCacncelLYLQ,
		sum(pf_cancel_target) as PFCacncelTarget,
		sum(pf_cancel_target_cw) as PFCacncelTargetCW,
		sum(pf_cancel_target_fq) as PFCacncelTargetFQ,
		sum(qtr_begin_active_actual) as QTRBeginActiveActual,
		sum(qtr_begin_active_cw) as QTRBeginActiveCW,
		sum(qtr_begin_active_lw) as QTRBeginActiveLW,
		sum(qtr_begin_active_lq) as QTRBeginActiveLQ,
		sum(qtr_begin_active_ly) as QTRBeginActiveLY,
		sum(qtr_begin_active_lylq) as QTRBeginActiveLYLQ,
		sum(qtr_begin_active_target) as QTRBeginActiveTarget,
		sum(qtr_begin_active_target_cw) as QTRBeginActiveTargetCW,
		sum(qtr_begin_active_target_fq) as QTRBeginActiveTargetFQ,
		sum(ui_cancel_actual) as UICancelActual,
		sum(ui_cancel_cw) as UICancelCW,
		sum(ui_cancel_lw) as UICancelLW,
		sum(ui_cancel_lq) as UICancelLQ,
		sum(ui_cancel_ly) as UICancelLY,
		sum(ui_cancel_lylq) as UICancelLYLQ,
		sum(ui_cancel_target) as UICancelTarget,
		sum(ui_cancel_target_cw) as UICancelTargetCW,
		sum(ui_cancel_target_fq) as UICancelTargetFQ,
		sum(term_end_active_actual) as TermEndActiveActual,
		sum(term_end_active_cw) as TermEndActiveCW,
		sum(term_end_active_lw) as TermEndActiveLW,
		sum(term_end_active_lq) as TermEndActiveLQ,
		sum(term_end_active_ly) as TermEndActiveLY,
		sum(term_end_active_lylq) as TermEndActiveLYLQ,

		sum(term_end_renewal_actual) as TermEndRenewalActual,
		sum(term_end_renewal_cw) as TermEndRenewalCW,
		sum(term_end_renewal_lw) as TermEndRenewalLW,
		sum(term_end_renewal_lq) as TermEndRenewalLQ,
		sum(term_end_renewal_ly) as TermEndRenewalLY,
		sum(term_end_renewal_lylq) as TermEndRenewalLYLQ

    from newFin
    group by
        quarter, week, geo_code,product_name, market_area_code,
		case 	when market_area_code = 'US' then 'US' 
					when market_area_code = 'UK' then 'UK'
					when market_area_code = 'GER' then 'GER'
					when market_area_code = 'ANZ' then 'ANZ'
					when market_area_code = 'JPN' then 'JPN'
					else 'ROW'
		end ,  route_to_market, segment_pivot, subscription_offering 
--FinancialG8Units - Net New Units, Gross New Units, Cancellation Units, REnewal Units
    Select
        quarter,
		week,
        geo_code,
        product_name,
        market_area_code,
				case 	when market_area_code = 'US' then 'US' 
					when market_area_code = 'UK' then 'UK'
					when market_area_code = 'GER' then 'GER'
					when market_area_code = 'ANZ' then 'ANZ'
					when market_area_code = 'JPN' then 'JPN'
					else 'ROW'
		end as market_area_group,
        route_to_market,
        segment_pivot,
        subscription_offering,
        sum(cancellations_Units_actual)       as CancelUnitsActual,
		sum(cancellations_Units_cw )             as CancelUnitsCW,
		sum(cancellations_Units_lw )             as CancelUnitsLW,
		sum(cancellations_Units_lq )             as CancelUnitsLQ,
		sum(cancellations_Units_ly )             as CancelUnitsLY,
		sum(cancellations_Units_lylq )             as CancelUnitsLYLQ,
        sum(cancellations_Units_target)       as CancelUnitsTarget,
        sum(gross_new_Units_actual)           as GrossUnitsActual,
		sum(gross_new_Units_cw )                 as GrossUnitsCW,
		sum(gross_new_Units_lw )                 as GrossUnitsLW,
        sum(gross_new_Units_ly)                 as GrossUnitsLY,
        sum(gross_new_Units_lq )                 as GrossUnitsLQ,
        sum(gross_new_Units_lylq )                 as GrossUnitsLYLQ,
        sum(gross_new_Units_target)           as GrossUnitsTarget,
        sum(net_new_Units_actual)             as NewUnitsActual,
		sum(net_new_Units_cw )				as NewUnitsCW,
		sum(net_new_Units_lw )				as NewUnitsLW,
		sum(net_new_Units_ly )				as NewUnitsLY,
        sum(net_new_Units_lq )				as NewUnitsLQ,
        sum(net_new_Units_lylq )				as NewUnitsLYLQ,
        sum(net_new_Units_target)             as NewUnitsTarget,
       	/**Renew In XDC**/
    from newfin
        group by
        quarter, week, geo_code,product_name, market_area_code, 
		case 	when market_area_code = 'US' then 'US' 
					when market_area_code = 'UK' then 'UK'
					when market_area_code = 'GER' then 'GER'
					when market_area_code = 'ANZ' then 'ANZ'
					when market_area_code = 'JPN' then 'JPN'
					else 'ROW'
		end , route_to_market, segment_pivot, subscription_offering 

