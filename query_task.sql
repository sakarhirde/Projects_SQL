select
    ati.ticket_id as ticket_id,
    ati.ticket_id as unique_ticket_id,

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
        when asa.area is null then
            (case
            when aba.AREA is null then
                (case
                 when aca.AREA is null then 'N/A'
                 when aca.AREA is not null then aca.AREA
                 end)
            when aba.AREA is not null then aba.AREA
            end)
        when asa.AREA is not null then asa.AREA
     end) as region,


     (case
        when concat(aei.FIRST_NAME, '  ' , aei.last_name)  is not null then concat(aei.FIRST_NAME,' ', aei.last_name)
        else 'No information available'
     end) as assigned_to,

    (case
        when ata.ASSIGNED_TYPE  is not null then ata.ASSIGNED_TYPE
        else 'No information available'
     end) as assigned_type,

    ats.cat_name as ticket_status,       /* problem increase 5.7k to 7.8k*/
    (case
        when ats2.CAT_NAME is not null then ats2.CAT_NAME
        else 'No sub status assigned'
    end) as sub_status,
    stt.type_name as ticket_type,        /* problem increase 5.7k to 7.8k*/
    atf.DATE  as last_follow_up_date,

    (case
        when atf.details is not null then atf.details
        else 'No followup message'
    end) as last_follow_up_message,
    timestampdiff(day , ati.ENTRYTIME, date_add(now(), interval 330 minute)) as ticket_age,
    timestampdiff(day , atf.date, date_add(now(), interval 330 minute)) as followup_age,
    ati.call_title as call_title,
    (case
        when timestampdiff(day , ati.ENTRYTIME, date_add(now(), interval 330 minute)) between 0 and 3 then '0-3'
        when timestampdiff(day , ati.ENTRYTIME, date_add(now(), interval 330 minute)) between 3 and 7 then '3-7'
        when timestampdiff(day , ati.ENTRYTIME, date_add(now(), interval 330 minute)) >7 then '7+'
        else 'No information'
    end) as ticket_age_group

from adm_ticket_info ati
     left join adm_store_regdetails asr on asr.id = ati.STORE_ID
     left join adm_store_info asi on asi.ADMIN_ID = asr.ID

     left join adm_brand_regdetails abr on abr.ID = asr.BRAND_ID /*65 vs 67*/
     left join adm_brand_info abi on abr.ID = abi.ADMIN_ID

     left join adm_client_regdetails acr on acr.ID = abr.COMPANY_ID /*checked*/
     left join adm_client_info aci on aci.ADMIN_ID = acr.ID


     left join adm_ticket_status ats on ats.CAT_ID = ati.STATUS /*checked*/
     left join adm_ticket_status ats2 on ats2.CAT_ID = ati.SUB_STATUS

     left join smr_ticket_type stt on stt.TEMP_ID = ati.TICKET_TYPE
     left join (select * from adm_ticket_assigned where TEMP_ID in (
                select max(adm_ticket_assigned.TEMP_ID) from adm_ticket_assigned group by adm_ticket_assigned.TICKET_ID)) ata on ata.TICKET_ID = ati.TEMP_ID

     left join adm_employee_info aei on aei.ID = ata.ASSIGNED_ENGG_ID
     left join (select * from adm_ticket_followups where F_ID in (
                select max(F_ID) from adm_ticket_followups group by TICKET_ID)) atf on atf.TICKET_ID = ati.TEMP_ID

     left join adm_client_address aca on aca.ID = aci.ADMIN_ID
     left join adm_brand_address aba on aba.ID = abi.ADMIN_ID
     left join adm_store_address asa on asa.ID = asi.admin_id;
