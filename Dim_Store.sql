select distinct a.NCR_NAMESTORE as "Store-Description",
	a.MMX_STORENUMBER as "Store",
	a.MMX_AREAMANAGER as "Area",
	SPLIT_PART(a.MMX_TERRITORY, ' - ', 2) as "Franchise_Partner",
	a.MMX_MAILCOUNTRY as "Category "
from KFC_FRANCE_DW_PROD.DWH.DIM_STORE a
where a.MMX_STORENUMBER is not NULL 
	and a.MMX_STATUS Like 'Open'