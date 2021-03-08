--test untuk git hub
--ini test untuk git kedua
select contract_number,count(*) as jml_kontrak ,sum(premi)::money as premi from (
select distinct b.sales_number,b.revision_number,attribute_value as contract_number,a.time_stamp,period1,period2,
sum(amount2* case when balance='credit' then 1 else -1 end) as premi
 from tbl_gl_general_jem x join tbl_so_sales_details a 
on refid1=sales_number and refid2=revision_number and ttype='Insurance premium' 
join tbl_so_object_attributes b using(sales_number, revision_number) 
join tbl_gl_lines_jem using (temp_no)
where campaign_code in ( select campaign_code  from tbl_mstr_marketing_campaign where campaign_name 
ilike '%taf%') and attribute_code='PHK11'and  period1=date_part('YEAR',CURRENT_DATE)::VARCHAR 
and period2::int =date_part('month',CURRENT_DATE)::numeric
and account like '61%'
GROUP BY  b.sales_number,b.revision_number,attribute_value ,a.time_stamp,period1,period2
)x
GROUP BY contract_number
having count(*)>1;

select contract_number,count(*) as jml_kontrak,sum(premi)as premi from (
select distinct  a.sales_number,a.revision_number, product_attribute_option_code as contract_number ,insurance_product_code,
sum(amount2 * case when balance ='credit' then 1 else -1 end ) as premi,period1,period2--into temp a1 
from tbl_so_sales_details a  join tbl_gl_general_jem x
on refid1=a.sales_number and refid2=a.revision_number and ttype='Insurance premium' 
join tbl_list_robot_aplikasi on insurance_product_code=code and campaign_code=campaign
and  product ilike '%kredit plus%' 
join tbl_gl_lines_jem using (temp_no)
join  tbl_so_sales_attributes b on b.sales_number=a.sales_number and a.revision_number=b.revision_Number and
product_attribute_code ='PHK11'
where period1=date_part('YEAR',CURRENT_DATE)::VARCHAR  and period2=date_part('month',CURRENT_DATE)::VARCHAR
  and account like'61%'
GROUP BY  a.sales_number,a.revision_number ,period1,period2,product_attribute_option_code,insurance_product_code)x
GROUP BY contract_number
having count(contract_number)>1 and count(DISTINCT insurance_product_code)=1 ;

--perbaiki spektra, karena kalo ada 2 objek dia ngbentuk polis baru, cek di  table fifspektra_order_log
select contract_number,count(*) as jml_kontrak,sum(premi)as premi from (
select distinct  a.sales_number,a.revision_number, product_attribute_option_code as contract_number ,
sum(amount2 * case when balance ='credit' then 1 else -1 end ) as premi,period1,period2--into temp a1 
from tbl_so_sales_details a  join tbl_gl_general_jem x
on refid1=a.sales_number and refid2=a.revision_number and ttype='Insurance premium' 
join tbl_gl_lines_jem using (temp_no)
join  tbl_so_sales_attributes b on b.sales_number=a.sales_number and a.revision_number=b.revision_Number and
product_attribute_code ='FIFCN'
where campaign_code in (select campaign_code from 
tbl_mstr_marketing_campaign where campaign_name ilike '%spektra%') and 
 period1=date_part('YEAR',CURRENT_DATE)::VARCHAR  and period2=date_part('month',CURRENT_DATE)::VARCHAR
  and account like'61%'  
GROUP BY  a.sales_number,a.revision_number ,period1,period2,product_attribute_option_code)x
GROUP BY contract_number
having count(contract_number)>1;


select contract_number,count(*) as jml_kontrak,sum(premi)as premi from (
select distinct  a.sales_number,a.revision_number, product_attribute_option_code as contract_number ,
sum(amount2 * case when balance ='credit' then 1 else -1 end ) as premi,period1,period2--into temp a1 
from tbl_so_sales_details a join tbl_gl_general_jem x
on refid1=a.sales_number and refid2=a.revision_number and ttype='Insurance premium' 
join tbl_gl_lines_jem using (temp_no)
join  tbl_so_sales_attributes b on b.sales_number=a.sales_number and a.revision_number=b.revision_Number and
product_attribute_code ='AC46'
where insurance_product_code='466' and 
 period1=date_part('YEAR',CURRENT_DATE)::VARCHAR  and period2=date_part('month',CURRENT_DATE)::VARCHAR
  and account like'61%'  
GROUP BY  a.sales_number,a.revision_number ,period1,period2,product_attribute_option_code)x
GROUP BY contract_number
having count(contract_number)>1;

--perbaiki query bss, 
select contract_number,count(*) as jml_kontrak,sum(premi)as premi from (
select distinct  a.sales_number,a.revision_number, product_attribute_option_code as contract_number ,
sum(amount2 * case when balance ='credit' then 1 else -1 end ) as premi,period1,period2--into temp a1 
from tbl_so_sales_details a join tbl_gl_general_jem x
on refid1=a.sales_number and refid2=a.revision_number and ttype='Insurance premium' 
join tbl_gl_lines_jem using (temp_no)
join  tbl_so_sales_attributes b on b.sales_number=a.sales_number and a.revision_number=b.revision_Number and
product_attribute_code ='NOTE'
where insurance_product_code in ('199','388','397','487') and 
campaign_code in (select campaign from tbl_list_robot_aplikasi where  product ilike '%sampoerna%')
and  period1=date_part('YEAR',CURRENT_DATE)::VARCHAR  and period2=date_part('month',CURRENT_DATE)::VARCHAR
  and account like'61%'  
GROUP BY  a.sales_number,a.revision_number ,period1,period2,product_attribute_option_code)x
GROUP BY contract_number
having count(contract_number)>1;

A2019041220362000002_P1-1