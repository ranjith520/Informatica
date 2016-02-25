/* Formatted on 8/20/2012 2:24:29 PM (QP5 v5.215.12089.38647) */
  SELECT DISTINCT
         MP.MAPPING_NAME,
         SUB.SUBJECT_AREA,
         CASE MP.IS_VALID WHEN 1 THEN 'VALID' ELSE 'NOT VALID' END
            AS MAPPING_STATUS
    FROM    INFADMIN9.OPB_MAPPING MP
         JOIN
            REP_SUBJECT SUB
         ON SUB.SUBJECT_ID = MP.SUBJECT_ID
   WHERE SUB.SUBJECT_ID IN
            ('114',
             '113',
             '112',
             '111',
             '110',
             '109',
             '108',
             '106',
             '105',
             '104',
             '103',
             '102',
             '101',
             '100',
             '99',
             '98',
             '97',
             '96',
             '95',
             '94',
             '93',
             '92')
ORDER BY MP.MAPPING_NAME