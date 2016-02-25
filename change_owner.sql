/* Formatted on 9/12/2011 2:09:09 PM (QP5 v5.126.903.23003) */
  SELECT  
   DISTINCT  
   --REP_DEPLOY_GROUP_DETAIL.dep_group_name as DG_NAME ,DEPLOY_TIME,TARG_SUBJECT_AREA,
           'pmrep  ChangeOwner -o deploymentgroup -n '|| REP_DEPLOY_GROUP_DETAIL.dep_group_name || ' -u Administrator [-s native ]' AS pmrep ,
                'pmrep  AssignPermission  -o deploymentgroup -n '|| REP_DEPLOY_GROUP_DETAIL.dep_group_name || ' -u ' || REP_DEPLOY_GROUP.CREATED_BY  || ' -p  r ' AS pmrep_2
                      
    FROM   REP_DEPLOY_GROUP_DETAIL, REP_DEPLOY_GROUP
   WHERE   target_rep_name = 'RS_UAT_CIGNA'
           AND REP_DEPLOY_GROUP_DETAIL.dep_group_name =REP_DEPLOY_GROUP.dep_group_name
           And REP_DEPLOY_GROUP.OWNER_ID <> 2
            and TARG_SUBJECT_AREA like '%_fsupp1%'
                   AND TO_DATE (REP_DEPLOY_GROUP.CREATION_TIME,
                        'MM/DD/YYYY HH24:MI:SS') < (SYSDATE )
                          AND TO_DATE (REP_DEPLOY_GROUP.CREATION_TIME,
                        'MM/DD/YYYY HH24:MI:SS') > (SYSDATE -25)
                        
                   
                          
                         

