SELECT
        ID_CALENDAR,
        DATEOFBUSINESS as BUSINESSDAY,
        MMX_STORENUMBER, 
        SALEDATETIME,
        transactionsaleid,
        Count(distinct ID_INVOICE) as NB_INVOICES,
        Count(distinct TRANSACTIONSALEID) as NB_TRANSACTIONSALEID,
        round(SUM(AMOUNT_HT),4) as AMOUNT,
        round(SUM(TAX),4) as TAX
    FROM KFC_FRANCE_DW_PROD.DWH.SF_DSFI017_B0_MMX_REFUND_DETAILS_V01
    WHERE 
        ID_INVOICE in ( SELECT ID_INVOICE 
                            FROM KFC_FRANCE_DW_PROD.DWH.SF_DSFI017_B0_MMX_REFUND_DETAILS_V01
                            WHERE ID_CALENDAR>20231231
                            GROUP BY ID_INVOICE 
                            HAVING  SUM(AMOUNT_HT) <  0.02 AND (abs((nvl(sum(DISCOUNT_AMOUNT),0)+nvl(sum(COUPON_AMOUNT),0)))<abs(SUM(AMOUNT_HT))) 
                        )
    GROUP BY 
        ID_CALENDAR,
         DATEOFBUSINESS,
        SALEDATETIME,
        transactionsaleid,
        MMX_STORENUMBER
    ORDER BY 
        ID_CALENDAR DESC,
        MMX_STORENUMBER