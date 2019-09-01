
drop table if exists [#cids];

select left(mainthumbnail,3) as cid,ia.Name as name,count(*) as count 
INTO #cids

from 
SobekCM_Item as i
join SobekCM_Item_Aggregation_Alias as iaa on left(mainthumbnail,3)=iaa.AggregationAlias
join SobekCM_Item_Aggregation as ia on ia.AggregationID=iaa.AggregationID


where 

CreateDate<'2019-07-01' 

and i.Deleted=0 and dark=0 and IP_Restriction_Mask=0 
and mainthumbnail like '%-%'
and left(mainthumbnail,3) like '[a-zA-Z][0-9][0-9]%'
and left(mainthumbnail,3)!='v00'

group by left(mainthumbnail,3),ia.Name
order by left(mainthumbnail,3);

select * from #cids;

select sum(count) from #cids;