select 
  
  /* convert(varchar(7),format(ias.year,'####') + '-' + format(ias.month,'0#')) as year_month,ias.year,ias.month, */
  
  ia.code, /*ia.AggregationID, iaa.AggregationAlias,*/ ia.name,
  
  sum(ias.hits) as aggregation_hits
  
  /*
  sum(ias.sessions) as aggregation_sessions_visits, sum(ias.Home_Page_Views) as home_page_views, sum(ias.Browse_Views) as browse_views, 
  sum(ias.Advanced_Search_Views) as advanced_search_views, sum(search_results_views) as search_results_views /* sum(ids.downloads) as pdf_downloads */
  */
  
  from SobekCM_Item_Aggregation_Hierarchy as iah
    
 join SobekCM_Item_Aggregation as ia on ia.AggregationID=iah.ChildID
 
 join SobekCM_Item_Aggregation_Statistics as ias on iah.ChildID=ias.AggregationID

 join SobekCM_Item_Aggregation_Alias as iaa on iaa.AggregationID=ias.AggregationID

/* join SobekCM_Item_Download_Statistics as ids on ids.cid=iaa.AggregationAlias and ids.year=ias.Year
  */
   where /* iah.ParentID=1 and */ ( (ias.year=2018 and ias.month between 7 and 12) or (ias.year=2019 and ias.month between 1 and 6) ) and ia.Deleted=0 
   
   and ia.isActive=1 and ia.Deleted=0 and ia.Hidden=0

   and code not in ('test')

   and ias.AggregationID not in (select parentid from SobekCM_Item_Aggregation_Hierarchy)

   group by 
   /* ias.year,ias.month, */
   
   code, /*iaa.AggregationAlias,*/
   
   /* ,ia.AggregationID,*/ ia.name 
   
   order by 
   
   /* ias.year,ias.month, */
   
  /* ia.name */

  ia.code
  