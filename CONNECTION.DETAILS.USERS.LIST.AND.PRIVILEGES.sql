/* Formatted on 10/17/2012 3:28:54 PM (QP5 v5.215.12089.38647) */
SELECT DISTINCT
       a.object_name AS connection_name,
       a.user_name AS conn_user_name,
       a.connect_string,
       b.user_name connection_owner,
       b.user_desc AS conn_owner_desc,
       CASE
          WHEN     user_type = '1'
               AND d.user_id IN (SELECT user_id FROM opb_users)
          THEN
             (SELECT 'User - ' || x.user_name
                FROM opb_users x where d.user_id=x.user_id)
                    when user_type = '2' and d.user_id in (select group_id from opb_groups) then (select 'Group - '|| x.group_name from opb_groups x where d.user_id=x.group_id)
                                            when d.user_id = '0' then 'World' end as CONN_USERS_LIST,
          --  d.user_type CONN_USER_TYPE,
          -- d.permissions,
       CASE
                WHEN user_type = 1
                      THEN CASE
                             WHEN permissions = d.user_id + 15
                                THEN 'RWX'
                             WHEN permissions = d.user_id + 13
                                THEN 'RW'
                             WHEN permissions = d.user_id + 11
                                THEN 'RX'
                             WHEN permissions = d.user_id + 9
                                THEN 'R'
                             WHEN permissions = d.user_id + 7
                                THEN 'WX'
                             WHEN permissions = d.user_id + 5
                                THEN 'W'
                             WHEN permissions = d.user_id + 3
                                THEN 'X'
                             ELSE 'NULL'
                          END
                   WHEN user_type = 2
                      THEN CASE
                             WHEN permissions = d.user_id + 29
                                THEN 'RWX'
                             WHEN permissions = d.user_id + 25
                                THEN 'RW'
                             WHEN permissions = d.user_id + 21
                                THEN 'RX'
                             WHEN permissions = d.user_id + 17
                                THEN 'R'
                             WHEN permissions = d.user_id + 13
                                THEN 'WX'
                             WHEN permissions = d.user_id + 9
                                THEN 'W'
                             WHEN permissions = d.user_id + 5
                                THEN 'X'
                             ELSE 'NULL'
                          END
                   WHEN user_type = 3
                      THEN CASE
                             WHEN permissions = d.user_id + 57
                                THEN 'RWX'
                             WHEN permissions = d.user_id + 39
                                THEN 'RW'
                             WHEN permissions = d.user_id + 41
                                THEN 'RX'
                             WHEN permissions = d.user_id + 33
                                THEN 'R'
                             WHEN permissions = d.user_id + 25
                                THEN 'WX'
                             WHEN permissions = d.user_id + 17
                                THEN 'W'
                             WHEN permissions = d.user_id + 9
                                THEN 'X'
                             ELSE 'NULL'
                          END
                END PREVILIGES
         FROM opb_cnx a, opb_users b, opb_groups c, opb_object_access d
          WHERE a.owner_id = b.user_id
            AND a.GROUP_ID = c.group_id
            AND a.object_id = d.object_id and d.object_type=73
            ORDER BY 1