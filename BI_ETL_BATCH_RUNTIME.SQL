/* Formatted on 10/13/2015 2:41:47 PM (QP5 v5.267.14150.38599) */
  SELECT DISTINCT
         ROWID,
         ETL_BATCH_ID,
         ETL_BATCH_GROUP_NAME,
        -- BATCH_START_TS,
        -- SRC_STG_END_TS,
        -- STG_DW_END_TS,
       --  DW_DM_END_TS,
         CASE
            WHEN DW_DM_END_TS IS NULL THEN 'Not Completed'
            ELSE 'Completed'
         END
            STATUS,
         RANK ()
         OVER (PARTITION BY ETL_BATCH_GROUP_NAME
               ORDER BY ETL_BATCH_ID DESC NULLS LAST)
            Rank_of_Batch_ID,
         (CASE
             WHEN ETL_BATCH_ID IS NOT NULL
             THEN
                (SRC_STG_END_TS - BATCH_START_TS) * 1440
          END)
            STAGE_RUN_TIME,
         (CASE
             WHEN ETL_BATCH_ID IS NOT NULL
             THEN
                (STG_DW_END_TS - SRC_STG_END_TS) * 1440
          END)
            DW_RUN_TIME,
         (CASE
             WHEN ETL_BATCH_ID IS NOT NULL
             THEN
                (DW_DM_END_TS - STG_DW_END_TS) * 1440
          END)
            DM_RUN_TIME,
         (CASE
             WHEN ETL_BATCH_ID IS NOT NULL
             THEN
                (DW_DM_END_TS - BATCH_START_TS) * 1440
          END)
            TOTAL_RUN_TIME,
             CASE
          WHEN DW_DM_END_TS IS NULL THEN '75'
          WHEN STG_DW_END_TS IS NULL THEN '50'
          WHEN SRC_STG_END_TS IS NULL THEN '25'
          ELSE '100'
       END
          Percentage
    FROM BI_ETL.BI_ETL_BATCH
ORDER BY ETL_BATCH_ID DESC