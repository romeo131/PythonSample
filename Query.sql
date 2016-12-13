
create table shared.sl_acquisition_event_nms as (
  select application_cd, user_id, acquisition_dt
  from pr_rel_vw.acquisition_event
  where application_cd in (2160,2161) --and, ios
  and acquisition_type_cd = 'IN'
  and acquisition_dt between '2016-08-01' and '2016-08-30'-- '2016-08-01' and '2016-08-02'  --between '2016-07-21' and '2016-07-24' 
  group by 1,2,3
) with data primary index(user_id);

select a.level_cd, count(distinct a.user_id)
from pr_rel_vw.user_level_hist a
join shared.sl_acquisition_event_nms b
on a.user_id = b.user_id
and a.application_cd = b.application_cd
and a.user_level_end_dt = '2100-12-31'
and a.user_level_start_dt <= '2016-11-12'
group by 1
