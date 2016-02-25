/* Formatted on 8/31/2011 3:32:59 PM (QP5 v5.126.903.23003) */
SELECT   DISTINCT DEP_GROUP_NAME, DEPLOY_TIME
  FROM   REP_DEPLOY_GROUP_DETAIL
 WHERE   REP_DEPLOY_GROUP_DETAIL.TARGET_REP_NAME = 'cs_dev_repo_cigna'
         AND DEP_GROUP_NAME IN
                  (SELECT   DISTINCT PROD.DEP_GROUP_NAME
                     FROM   REP_DEPLOY_GROUP_DETAIL PROD,
                            REP_DEPLOY_GROUP_DETAIL TST
                    WHERE   PROD.DEP_GROUP_NAME = TST.DEP_GROUP_NAME
                            AND PROD.TARGET_REP_NAME = 'RS_PROD_CIGNA'
                            AND TST.TARGET_REP_NAME = 'RS_TEST_CIGNA'
                            AND TO_DATE (PROD.deploy_time,'MM/DD/YYYY HH24:MI:SS') < ADD_MONTHS (SYSDATE, -7));