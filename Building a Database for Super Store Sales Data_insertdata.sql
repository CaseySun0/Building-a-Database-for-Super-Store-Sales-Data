/*
GROUP NUMBER: 2
NAME: Karan Bhosale, Yingzi Yuan, Priyanka Chahande, Yiming Sun
TITLE: superstore sales data
*/

insert into 201_G02.regional_manager (region_name,manager_name) 
values ('Central','Chris'), 
('East','Erin'), 
('South','Sam'), 
('West','William')
;

insert into 201_G02.cust_segment (cust_seg_name) 
select distinct `Customer Segment`
from 201_G02.superstore
;

insert into 201_G02.shipmode(shipmode_name)
select distinct `Ship Mode`
from 201_G02.superstore
;

insert into 201_G02.product_category(product_category_name)
select distinct `Product Category`
from 201_G02.superstore
;

insert into 201_G02.product_subcategory(product_category_id, product_subcategory_name)
select distinct pc.product_category_id, s.`Product Sub-Category`
from 201_G02.superstore s, 201_G02.product_category pc
where s.`Product Category` = pc.product_category_name
;

insert into 201_G02.address (country,region_id,state,city,zip_code) 
select distinct s.Country,r.region_id,s.`State or Province` as state, s.City, s.`Postal Code` as zip_code
from 201_G02.superstore s, 201_G02.regional_manager r
where s.region = r.region_name
;


insert into 201_G02.customer(cust_id, cust_name)
select distinct `Customer ID`, `Customer Name`
from 201_G02.superstore s
;

insert into 201_G02.order(order_id, order_priority, order_date, address_id, cust_id, cust_seg_id) 
select distinct s.`Order ID`, s.`Order Priority`, str_to_date(s.`Order Date`,'%m/%d/%y') `Order Date`, a.address_id, s.`Customer ID`, cs.cust_seg_id
from 201_G02.superstore s,  201_G02.address a , 201_G02.regional_manager r,  201_G02.cust_segment cs
where s.Country=a.country 
and s.region=r.region_name
and s.`State Or Province`=a.state
and s.city=a.city
and s.`Postal Code`=a.zip_code
and a.region_id =r.region_id
and s.`Customer Segment` =cs.cust_seg_name
;


insert into 201_G02.product(product_subcategory_id, product_name, product_base_margin, product_container, unit_price) 
select distinct ps.product_subcategory_id, s.`Product Name`, s.`Product Base Margin`, s.`Product Container`, s.`Unit Price`
from 201_G02.superstore s, 201_G02.product_subcategory ps 
where s.`Product Sub-Category` = ps.product_subcategory_name 

;

insert into 201_G02.order_product(product_id, order_id, discount, shipmode_id, ship_date, shipping_cost, sales, profit, quantity_order_new) 
select distinct p.product_id, s.`Order ID`, s.`Discount`, sm.shipmode_id, str_to_date(s.`Ship Date`,'%m/%d/%y') `Ship Date`, s.`Shipping Cost`, s.`Sales`, s.`Profit`, s.`Quantity ordered new`
from 201_G02.superstore s, 201_G02.product p, 201_G02.shipmode sm
where s.`Product Name` = p.product_name 
and s.`Ship Mode` =sm.shipmode_name
;

