### dbt

##### steps to populate redshift from s3

`create schemas`

```
create schema if not exists jaffle_shop;
create schema if not exists stripe;
```

`create the tables for those schemas`

```
create table jaffle_shop.customers(
  id integer,
  first_name varchar(50),
  last_name varchar(50)
);

create table jaffle_shop.orders(
  id integer,
  user_id integer,
  order_date date,
  status varchar(50),
  _etl_loaded_at timestamp default current_timestamp
);

create table stripe.payment(
  id integer,
  orderid integer,
  paymentmethod varchar(50),
  status varchar(50),
  amount integer,
  created date,
  _batched_at timestamp default current_timestamp
);
```

`populate the tables from the s3`

```
copy jaffle_shop.customers( id, first_name, last_name)
from 's3://.../jaffle_shop_customers.csv'
iam_role '...'
region '...'
delimiter ','
ignoreheader 1
acceptinvchars;

copy jaffle_shop.orders(id, user_id, order_date, status)
from '...jaffle_shop_orders.csv'
iam_role '...'
region '...'
delimiter ','
ignoreheader 1
acceptinvchars;

copy stripe.payment(id, orderid, paymentmethod, status, amount, created)
from '...stripe_payments.csv'
iam_role '...'
region '...'
delimiter ','
ignoreheader 1
Acceptinvchars;
```