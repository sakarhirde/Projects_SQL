
# Query to get the ticket age in days Brand wise and Client wise which are not closed

select * from adm_store_info where city is not null;
select * from adm_store_regdetails;
select * from adm_client_regdetails;
select * from adm_client_info;
select * from adm_store_regdetails;
select * from adm_brand_regdetails;
select * from adm_brand_info;
select * from adm_ticket_info order by ENTRYTIME desc;
select * from adm_ticket_status;
select * from smr_ticket_type;

select
        a.*,
        case
            when ticket_age between 0 and 7 then '0-7'
            when ticket_age between 8 and 15 then '8-15'
            when ticket_age > 15 then '15+'
        end as ticket_age_group
        from (
    select
        asr.STORE_ID,
        asi.COMPANY_NAME as store_name,
        adm_client_info.COMPANY_NAME as client,
        abi.COMPANY_NAME as brand,
        ati.TICKET_ID,
        ati.CALL_TITLE,
        ats.CAT_NAME as status,
        ati.ENTRYTIME as ticket_time,
        TIMESTAMPDIFF(DAY , ati.ENTRYTIME, date_add(now(), interval 330 minute)) as ticket_age
    from adm_ticket_info ati
        join adm_ticket_status ats on ati.STATUS = ats.CAT_ID

        join adm_store_regdetails asr on ati.STORE_ID = asr.ID
        join adm_store_info asi on asr.ID = asi.ADMIN_ID

        join adm_client_regdetails acr on asr.COMPANY_ID = acr.ID
        join adm_client_info adm_client_info on acr.ID = adm_client_info.ADMIN_ID

        join adm_brand_regdetails abr on asr.BRAND_ID = abr.ID
        join adm_brand_info abi on abr.ID = abi.ADMIN_ID

    where ats.CAT_ID not in (3)
        order by ati.ENTRYTIME desc) a;


select
    count(*),
    ticket_age_group,
    client,
    status
from (
    select
        a.*,
        case
            when ticket_age between 0 and 7 then '0-7'
            when ticket_age between 8 and 15 then '8-15'
            when ticket_age > 15 then '15+'
        end as ticket_age_group
        from (
    select
        asr.STORE_ID,
        asi.COMPANY_NAME as store_name,
        adm_client_info.COMPANY_NAME as client,
        abi.COMPANY_NAME as brand,
        ati.TICKET_ID,
        ati.CALL_TITLE,
        ats.CAT_NAME as status,
        ati.ENTRYTIME as ticket_time,
        TIMESTAMPDIFF(DAY , ati.ENTRYTIME, date_add(now(), interval 330 minute)) as ticket_age
    from adm_ticket_info ati
        join adm_ticket_status ats on ati.STATUS = ats.CAT_ID

        join adm_store_regdetails asr on ati.STORE_ID = asr.ID
        join adm_store_info asi on asr.ID = asi.ADMIN_ID

        join adm_client_regdetails acr on asr.COMPANY_ID = acr.ID
        join adm_client_info adm_client_info on acr.ID = adm_client_info.ADMIN_ID

        join adm_brand_regdetails abr on asr.BRAND_ID = abr.ID
        join adm_brand_info abi on abr.ID = abi.ADMIN_ID

    where ats.CAT_ID not in (3)
        order by ati.ENTRYTIME desc) a
) b group by ticket_age_group, client, status order by ticket_age_group, client, status;


select
    count(*),
    ticket_age_group,
    client,
    status
from (
select
        a.*,
        case
            when ticket_age between 0 and 7 then '0-7'
            when ticket_age between 8 and 15 then '8-15'
            when ticket_age > 15 then '15+'
        end as ticket_age_group
        from (
    select
        asr.STORE_ID,
        asi.COMPANY_NAME as store_name,
        adm_client_info.COMPANY_NAME as client,
        abi.COMPANY_NAME as brand,
        ati.TICKET_ID,
        ati.CALL_TITLE,
        ats.CAT_NAME as status,
        ati.ENTRYTIME as ticket_time,
        TIMESTAMPDIFF(DAY , ati.ENTRYTIME, date_add(now(), interval 330 minute)) as ticket_age
    from adm_ticket_info ati
        join adm_ticket_status ats on ati.STATUS = ats.CAT_ID

        join adm_store_regdetails asr on ati.STORE_ID = asr.ID
        join adm_store_info asi on asr.ID = asi.ADMIN_ID

        join adm_client_regdetails acr on asr.COMPANY_ID = acr.ID
        join adm_client_info adm_client_info on acr.ID = adm_client_info.ADMIN_ID

        join adm_brand_regdetails abr on asr.BRAND_ID = abr.ID
        join adm_brand_info abi on abr.ID = abi.ADMIN_ID

    where ats.CAT_ID not in (3)
        order by ati.ENTRYTIME desc) a)
        b group by ticket_age_group, client, status order by ticket_age_group, client, status;

select id, admin_name
from adm_client_regdetails


select count(admin_name), company_id
from adm_store_regdetails join adm_store_regdetails.company_id = adm_client_regdetails.company_id;
group by company_id
order by company_id

join

select COMPANY_ID, admin_name as brand_name
from adm_brand_regdetails;
on adm_brand_regdetails.company_id = adm_client_regdetails.company_id;


select * from adm_brand_regdetails
select * from adm_brand_info

select * from adm_client_info where ADMIN_ID=5;





group by aci.COMPANY_NAME, abi.COMPANY_NAME, asi.COMPANY_NAME;



select
    ati.TEMP_ID as ticket_id,
    aci.COMPANY_NAME as client_name,
    abi.COMPANY_NAME as brand_name,
    asi.COMPANY_NAME as store_name,
    asi.ID as unique_store_id

from adm_ticket_info ati
    join adm_store_regdetails asr
    join adm_store_info asi on asi.ADMIN_ID = asr.ID
    join adm_brand_regdetails abr on abr.ID = asr.BRAND_ID
    join adm_brand_info abi on abr.ID = abi.ADMIN_ID
    join adm_client_regdetails acr on acr.ID = abr.COMPANY_ID
    join adm_client_info aci on aci.ADMIN_ID = acr.ID

ati.CALL_TITLE as ticket_call_title,
    ati.STATUS as status,
    ati.TICKET_TYPE as ticket_type,
    ati.DESCRIPTION as comment,

select
    ati.TICKET_ID as ticket_id,
    ati.CALL_TITLE as ticket_call_title,
    ati.STATUS as status,
    ati.TICKET_TYPE as ticket_type,
    ati.DESCRIPTION as comment,

    aci.COMPANY_NAME as client_name,
    abi.COMPANY_NAME as brand_name,
    asi.COMPANY_NAME as store_name,
    asr.STORE_ID as store_id

from adm_ticket_info ati
    join adm_store_regdetails asr on asr.STORE_ID = ati.STORE_ID
    join adm_store_info asi on asi.ADMIN_ID = asr.ID
    join adm_brand_regdetails abr on abr.ID = asr.BRAND_ID
    join adm_brand_info abi on abr.ID = abi.ADMIN_ID
    join adm_client_regdetails acr on acr.ID = abr.COMPANY_ID
    join adm_client_info aci on aci.ADMIN_ID = acr.ID;


select *
from adm_ticket_info

/*ticket age*/
select datediff(year(), '2023/06/02', 'ENTRYTIME') as yeardiff, datediff(day(), '2023/06/02', 'ENTRYTIME') as daydiff, datediff(time(), '2023/06/02', 'ENTRYTIME') as timediff
    from adm_ticket_info




select count(*)
from adm_ticket_info
    join adm_store_regdetails on adm_ticket_info.STORE_ID = adm_store_regdetails.ID;

select count(*)
from adm_store_regdetails;


/*
ati.ticket_id as ticket_id
ati.cust_ticket_number as cust_tick_number
aci.company_name as client
abi.company_name as brand
asi.company_name as store_name
asr.store_id as store_id

ats.cat_name as ticket_status
stt.type_name as ticket_type
atf.date as last_follow_up_date if atf.date is not null
    else select "No follow-ups"
 */




select * from (
select
    ati.ticket_id as ticket_id,
    ati.TEMP_ID as unique_t_id,
    ati.STORE_ID as ticket_store_id,
    ati.cust_ticket_number as cust_tick_number,
    abi.company_name as brand,
    aci.company_name as client,
    asi.company_name as store_name,
    asr.store_id as store_id,

    ats.cat_name as ticket_status,       /* problem increase 5.7k to 7.8k*/
    stt.type_name as ticket_type,        /* problem increase 5.7k to 7.8k*/
    lfu.DATE  as Last_follow_up_date,    /* problem increase 5.7k to 7.6k*/
    (case
        when atf.details is not null then atf.details
        else 'No followup message'
    end) as last_follow_up_message,
    timestampdiff(month , ati.ENTRYTIME, date_add(now(), interval 330 minute)) as ticket_age,
    timestampdiff(month , atf.date, date_add(now(), interval 330 minute)) as followup_age,
    ati.call_title as call_title,
    (case
        when timestampdiff(month , ati.ENTRYTIME, date_add(now(), interval 330 minute)) between 0 and 3 then '0-3'
        when timestampdiff(month , ati.ENTRYTIME, date_add(now(), interval 330 minute)) between 3 and 7 then '3-7'
        when timestampdiff(month , ati.ENTRYTIME, date_add(now(), interval 330 minute)) >7 then '7+'
        else 'No information'
    end) as ticket_age_group

from adm_ticket_info ati
    left join adm_store_regdetails asr on ati.STORE_ID = asr.ID
    left join adm_store_info asi on asi.ADMIN_ID = asr.ID          /*checked*/
    left join adm_brand_regdetails abr on abr.ID = asr.BRAND_ID /*65 vs 67*/
    left join adm_brand_info abi on abr.ID = abi.ADMIN_ID      /*checked*/
    left join adm_client_regdetails acr on acr.ID = abr.COMPANY_ID /*checked*/
    left join adm_client_info aci on aci.ADMIN_ID = acr.ID     /*checked*/
    left join adm_ticket_status ats on ats.CAT_ID = ati.STATUS /*checked*/
    join smr_ticket_type stt on stt.TEMP_ID = ati.TICKET_TYPE
    left join adm_ticket_followups atf on atf.TICKET_ID = ati.TEMP_ID /*checked*/
     join (select TICKET_ID, date
                from adm_ticket_followups
                WHERE (TICKET_ID, date ) IN (
                    SELECT TICKET_ID, MAX(date)
                    FROM adm_ticket_followups
                    GROUP BY TICKET_ID)) lfu on lfu.TICKET_ID = ati.TEMP_ID
) a;



select * from adm_ticket_info where TICKET_TYPE not in (select TEMP_ID from smr_ticket_type);


select * from adm_ticket_info where TEMP_ID in (
                                                1741,
                                                1914,
                                                1741,
                                                1741,
                                                2244,
                                                2505,
                                                2558,
                                                2745,
                                                2747,
                                                3872,
                                                4286,

    )


select count(distinct(TICKET_ID)) from adm_ticket_followups
select ati.temp_ID, atf.TICKET_ID
from adm_ticket_info ati
left join adm_ticket_followups atf on atf.ticket_id = ati.temp_id where (atf.TICKET_ID, date ) IN (
    SELECT TICKET_ID, MAX(date)
    FROM adm_ticket_followups
    GROUP BY TICKET_ID )
#

select distinct(TICKET_ID) from adm_ticket_followups

select date
from adm_ticket_followups
WHERE (TICKET_ID, date ) IN (
    SELECT TICKET_ID, MAX(date)
    FROM adm_ticket_followups
    GROUP BY TICKET_ID)
# checking code















select
    ati.ticket_id as ticket_id,
    ati.TEMP_ID as unique_t_id,
    ati.STORE_ID as ticket_store_id,
    ati.cust_ticket_number as cust_tick_number,
    asi.company_name as store_name,
    asr.store_id as store_id,
    aci.company_name as client,
    abi.company_name as brand,

    (case
        when ati.CREATED_BY   is not null then ati.CREATED_BY
        else 'No information available'
    end) as created_by,

    (case
        when ati.REGION   is not null then ati.REGION
        else 'No information available'
    end) as region,

     (case
        when ata.ASSIGNED_ENGG_ID  is not null then ata.ASSIGNED_ENGG_ID
        else 'No information available'
     end) as assigned_to,

    (case
        when ata.ASSIGNED_TYPE  is not null then ata.ASSIGNED_TYPE
        else 'No information available'
     end) as assigned_type,

    ats.cat_name as ticket_status,       /* problem increase 5.7k to 7.8k*/
    stt.type_name as ticket_type,        /* problem increase 5.7k to 7.8k*/
    atf.DATE  as last_follow_up_date,

    (case
        when atf.details is not null then atf.details
        else 'No followup message'
    end) as last_follow_up_message,
    timestampdiff(month , ati.ENTRYTIME, date_add(now(), interval 330 minute)) as ticket_age,
    timestampdiff(month , atf.date, date_add(now(), interval 330 minute)) as followup_age,
    ati.call_title as call_title,
    (case
        when timestampdiff(month , ati.ENTRYTIME, date_add(now(), interval 330 minute)) between 0 and 3 then '0-3'
        when timestampdiff(month , ati.ENTRYTIME, date_add(now(), interval 330 minute)) between 3 and 7 then '3-7'
        when timestampdiff(month , ati.ENTRYTIME, date_add(now(), interval 330 minute)) >7 then '7+'
        else 'No information'
    end) as ticket_age_group

from adm_ticket_info ati
     left join adm_store_regdetails asr on ati.temp_ID = asr.ID
     left join adm_store_info asi on asi.ADMIN_ID = asr.ID

     left join adm_brand_regdetails abr on abr.ID = asr.BRAND_ID /*65 vs 67*/
     left join adm_brand_info abi on abr.ID = abi.ADMIN_ID

     left join adm_client_regdetails acr on acr.ID = abr.COMPANY_ID /*checked*/
     left join adm_client_info aci on aci.ADMIN_ID = acr.ID

     left join adm_ticket_status ats on ats.CAT_ID = ati.STATUS /*checked*/


     left join smr_ticket_type stt on stt.TEMP_ID = ati.TICKET_TYPE
     left join (select * from adm_ticket_assigned where TEMP_ID in (
                select min(adm_ticket_assigned.TEMP_ID) from adm_ticket_assigned group by adm_ticket_assigned.TICKET_ID)) ata on ata.TICKET_ID = ati.TEMP_ID

     left join (select * from adm_ticket_followups where F_ID in (
                select max(F_ID) from adm_ticket_followups group by TICKET_ID)) atf on atf.TICKET_ID = ati.TEMP_ID;


#      left join adm_ticket_followups atf on ati.temp_id = atf.ticket_id where (atf.TICKET_ID, atf.DATE ) IN (
#             SELECT TICKET_ID, MAX(date)
#             FROM adm_ticket_followups
#             GROUP BY TICKET_ID );

select * from adm_ticket_followups where F_ID in (
select max(F_ID) from adm_ticket_followups group by TICKET_ID)






select * from adm_ticket_info

select * from adm_tbl_employee_type_link_rel
select * from adm_tbl_customer_access_enqtype_rel
select t_id