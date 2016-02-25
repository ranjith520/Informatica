/* Formatted on 9/1/2011 3:28:50 PM (QP5 v5.126.903.23003) */
  SELECT   DISTINCT
           REP_DEPLOY_GROUP_DETAIL.dep_group_name AS aaa,
           TO_CHAR (
              TO_DATE (REP_DEPLOY_GROUP.CREATION_TIME, 'MM/DD/YYYY HH24:MI:SS'),
              'MM/DD/YYYY'
           )
              AS create_Date,
              'pmrep  deletedeploymentgroup  -p  '
           || REP_DEPLOY_GROUP_DETAIL.dep_group_name
           || '  -f  force  delete'
              AS premp
    FROM   REP_DEPLOY_GROUP_DETAIL, REP_DEPLOY_GROUP
   WHERE   
   Target_rep_name = 'RS_TEST_CIGNA' AND 
   REP_DEPLOY_GROUP_DETAIL.dep_group_name = REP_DEPLOY_GROUP.dep_group_name
           AND TO_DATE (REP_DEPLOY_GROUP.CREATION_TIME,
                        'MM/DD/YYYY HH24:MI:SS') < ADD_MONTHS (SYSDATE, -8)
ORDER BY   TO_CHAR (
              TO_DATE (REP_DEPLOY_GROUP.CREATION_TIME,
                       'MM/DD/YYYY HH24:MI:SS'),
              'MM/DD/YYYY'
           ) ASC;