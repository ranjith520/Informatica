/* Formatted on 10/9/2015 2:57:19 PM (QP5 v5.267.14150.38599) */
WITH "Union19"
     AS (SELECT "T0"."C0" "BATCH_ID",
                "T0"."C1" "BATCH_GROUP_NAME",
                "T0"."C2" "BATCH_START_TIME",
                "T0"."C3" "STAGE_END_TIME",
                "T0"."C4" "DW_END_TIME",
                "T0"."C5" "DATAMART_END_TIME",
                "T0"."C6" "STATUS",
                RANK ()
                OVER (PARTITION BY "T0"."C1"
                      ORDER BY "T0"."C0" DESC NULLS LAST)
                   "Rank_of_Batch_ID",
                "T0"."C7" "Month_Day_Year",
                "T0"."C8" "Day10",
                "T0"."C9" "Time11",
                "T0"."C10" "BaaN_5C_Exclude",
                "T0"."C11" "hours_extraction"
           FROM (SELECT "BI_ETL_BATCH7"."ETL_BATCH_ID" "C0",
                        "BI_ETL_BATCH7"."ETL_BATCH_GROUP_NAME" "C1",
                        "BI_ETL_BATCH7"."BATCH_START_TS" "C2",
                        "BI_ETL_BATCH7"."SRC_STG_END_TS" "C3",
                        "BI_ETL_BATCH7"."STG_DW_END_TS" "C4",
                        "BI_ETL_BATCH7"."DW_DM_END_TS" "C5",
                        CASE
                           WHEN "BI_ETL_BATCH7"."DW_DM_END_TS" IS NULL
                           THEN
                              'Not Completed'
                           ELSE
                              'Completed'
                        END
                           "C6",
                        TO_CHAR ("BI_ETL_BATCH7"."BATCH_START_TS",
                                 'MM-DD-YYYY')
                           "C7",
                        TO_CHAR ("BI_ETL_BATCH7"."BATCH_START_TS", 'DD') "C8",
                        TO_CHAR ("BI_ETL_BATCH7"."BATCH_START_TS",
                                 'HH12:MI:SS AM')
                           "C9",
                        CASE
                           WHEN     "BI_ETL_BATCH7"."ETL_BATCH_GROUP_NAME" =
                                       'BaaN_5C'
                                AND TO_CHAR (
                                       "BI_ETL_BATCH7"."BATCH_START_TS",
                                       'DD') <= 8
                                AND EXTRACT (
                                       HOUR FROM CAST (
                                                    ("BI_ETL_BATCH7"."BATCH_START_TS") AS TIMESTAMP (2))) >=
                                       10
                                AND EXTRACT (
                                       HOUR FROM CAST (
                                                    ("BI_ETL_BATCH7"."BATCH_START_TS") AS TIMESTAMP (2))) <=
                                       15
                           THEN
                              '1'
                           ELSE
                              '2'
                        END
                           "C10",
                        EXTRACT (
                           HOUR FROM CAST (
                                        ("BI_ETL_BATCH7"."BATCH_START_TS") AS TIMESTAMP (2)))
                           "C11",
                        RANK ()
                        OVER (
                           PARTITION BY "BI_ETL_BATCH7"."ETL_BATCH_GROUP_NAME"
                           ORDER BY
                              "BI_ETL_BATCH7"."ETL_BATCH_ID" DESC NULLS LAST)
                           "C12"
                   FROM "BI_ETL"."BI_ETL_BATCH" "BI_ETL_BATCH7"
                  WHERE     NOT "BI_ETL_BATCH7"."DW_DM_END_TS" IS NULL
                        AND CASE
                               WHEN (    "BI_ETL_BATCH7"."ETL_BATCH_GROUP_NAME" =
                                            'BaaN_5C'
                                     AND TO_CHAR (
                                            "BI_ETL_BATCH7"."BATCH_START_TS",
                                            'DD') <= 8
                                     AND EXTRACT (
                                            HOUR FROM CAST (
                                                         ("BI_ETL_BATCH7"."BATCH_START_TS") AS TIMESTAMP (2))) >=
                                            10
                                     AND EXTRACT (
                                            HOUR FROM CAST (
                                                         ("BI_ETL_BATCH7"."BATCH_START_TS") AS TIMESTAMP (2))) <=
                                            15)
                               THEN
                                  '1'
                               ELSE
                                  '2'
                            END <> 1) "T0"
          WHERE "T0"."C12" = 1
         UNION
         SELECT "BI_ETL_BATCH8"."ETL_BATCH_ID" "BATCH_ID",
                "BI_ETL_BATCH8"."ETL_BATCH_GROUP_NAME" "BATCH_GROUP_NAME",
                "BI_ETL_BATCH8"."BATCH_START_TS" "BATCH_START_TIME",
                "BI_ETL_BATCH8"."SRC_STG_END_TS" "STAGE_END_TIME",
                "BI_ETL_BATCH8"."STG_DW_END_TS" "DW_END_TIME",
                "BI_ETL_BATCH8"."DW_DM_END_TS" "DATAMART_END_TIME",
                CASE
                   WHEN "BI_ETL_BATCH8"."DW_DM_END_TS" IS NULL
                   THEN
                      'Not Completed'
                   ELSE
                      'Completed'
                END
                   "STATUS",
                RANK ()
                OVER (
                   PARTITION BY "BI_ETL_BATCH8"."ETL_BATCH_GROUP_NAME"
                   ORDER BY "BI_ETL_BATCH8"."ETL_BATCH_ID" DESC NULLS LAST)
                   "Rank_of_Batch_ID",
                TO_CHAR ("BI_ETL_BATCH8"."BATCH_START_TS", 'MM-DD-YYYY')
                   "Month_Day_Year",
                TO_CHAR ("BI_ETL_BATCH8"."BATCH_START_TS", 'DD') "Day10",
                TO_CHAR ("BI_ETL_BATCH8"."BATCH_START_TS", 'HH12:MI:SS AM')
                   "Time11",
                CASE
                   WHEN     "BI_ETL_BATCH8"."ETL_BATCH_GROUP_NAME" =
                               'BaaN_5C'
                        AND TO_CHAR ("BI_ETL_BATCH8"."BATCH_START_TS", 'DD') <=
                               8
                        AND EXTRACT (
                               HOUR FROM CAST (
                                            ("BI_ETL_BATCH8"."BATCH_START_TS") AS TIMESTAMP (2))) >=
                               10
                        AND EXTRACT (
                               HOUR FROM CAST (
                                            ("BI_ETL_BATCH8"."BATCH_START_TS") AS TIMESTAMP (2))) <=
                               15
                   THEN
                      '1'
                   ELSE
                      '2'
                END
                   "BaaN_5C_Exclude",
                EXTRACT (
                   HOUR FROM CAST (
                                ("BI_ETL_BATCH8"."BATCH_START_TS") AS TIMESTAMP (2)))
                   "hours_extraction"
           FROM "BI_ETL"."BI_ETL_BATCH" "BI_ETL_BATCH8"
          WHERE     "BI_ETL_BATCH8"."DW_DM_END_TS" IS NULL
                AND CASE
                       WHEN (    "BI_ETL_BATCH8"."ETL_BATCH_GROUP_NAME" =
                                    'BaaN_5C'
                             AND TO_CHAR ("BI_ETL_BATCH8"."BATCH_START_TS",
                                          'DD') <= 8
                             AND EXTRACT (
                                    HOUR FROM CAST (
                                                 ("BI_ETL_BATCH8"."BATCH_START_TS") AS TIMESTAMP (2))) >=
                                    10
                             AND EXTRACT (
                                    HOUR FROM CAST (
                                                 ("BI_ETL_BATCH8"."BATCH_START_TS") AS TIMESTAMP (2))) <=
                                    15)
                       THEN
                          '1'
                       ELSE
                          '2'
                    END <> 1)
SELECT DISTINCT "Union19"."BATCH_ID" "BATCH_ID",
                "Union19"."BATCH_GROUP_NAME" "Source_System_Name",
                "Union19"."BATCH_START_TIME" "Data_Sourcing_Start_Time",
                "Union19"."STAGE_END_TIME" "Data_Sourcing_End_Time",
                "Union19"."DW_END_TIME" "Data_Warehouse_Load_End_Time",
                "Union19"."DATAMART_END_TIME" "Datamart_Load_End_Time",
                "Union19"."STATUS" "STATUS",
              --  "Union19"."Rank_of_Batch_ID" "Rank_of_Batch_ID",
                "Union19"."Month_Day_Year" "Month_Day_Year",
                "Union19"."Day10" "Day10",
                "Union19"."Time11" "Time11",
               -- "Union19"."BaaN_5C_Exclude" "BaaN_5C_Exclude",
                "Union19"."hours_extraction" "hours_extraction"
  FROM "Union19"