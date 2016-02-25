 SELECT   DISTINCT  
 ' Permissions on Deployment Group "'|| REP_DEPLOY_GROUP_DETAIL.dep_group_name ||'" created by Informatica User Id" ' || REP_DEPLOY_GROUP.CREATED_BY  ||'" was modified by Informatica Administrator at : ' || TO_CHAR(CURRENT_DATE, 'DD-MON-YYYY HH:MI:SS')  AS "Hello Inf Admin"
    FROM   REP_DEPLOY_GROUP_DETAIL, REP_DEPLOY_GROUP,DUAL
   WHERE   target_rep_name = 'RS_TST'
           AND REP_DEPLOY_GROUP_DETAIL.dep_group_name =REP_DEPLOY_GROUP.dep_group_name
           And REP_DEPLOY_GROUP.OWNER_ID <> 2
           AND TO_DATE (REP_DEPLOY_GROUP.CREATION_TIME,'MM/DD/YYYY HH24:MI:SS') < (SYSDATE )
           AND TO_DATE (REP_DEPLOY_GROUP.CREATION_TIME,'MM/DD/YYYY HH24:MI:SS') > (SYSDATE -1)
                                           
                          
                         

