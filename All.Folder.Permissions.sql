SELECT *
  FROM (SELECT SUBJ.SUBJ_NAME,
               NVL(USER_GROUP.NAME, 'Others') USER_NAME, -- NVL added to support "Others" group
               CASE
                 WHEN ((USER_GROUP.ID = SUBJ.OWNER_ID) AND
                      USER_GROUP.TYPE = 1) THEN
                  USER_GROUP.NAME
                 ELSE
                  '#'
               END OWNER_NAME,
               DECODE(OBJ_ACCESS.USER_TYPE, 1, 'USER', 2, 'GROUP', 'GROUP') TYPE,
               CASE
                 WHEN ((OBJ_ACCESS.PERMISSIONS - (OBJ_ACCESS.USER_ID + 1)) IN
                      (8, 16)) THEN
                  'READ'
                 WHEN ((OBJ_ACCESS.PERMISSIONS - (OBJ_ACCESS.USER_ID + 1)) IN
                      (10, 20)) THEN
                  'READ & EXECUTE'
                 WHEN ((OBJ_ACCESS.PERMISSIONS - (OBJ_ACCESS.USER_ID + 1)) IN
                      (12, 24)) THEN
                  'READ & WRITE'
                 WHEN ((OBJ_ACCESS.PERMISSIONS - (OBJ_ACCESS.USER_ID + 1)) IN
                      (14, 28)) THEN
                  'READ, WRITE & EXECUTE'
                 WHEN (OBJ_ACCESS.PERMISSIONS = 33 AND
                      (OBJ_ACCESS.USER_ID = 0)) THEN -- OBJ_ACCESS.USER_ID =0 this is the "Others" group
                  'READ'
                 WHEN (OBJ_ACCESS.PERMISSIONS = 41 AND
                      (OBJ_ACCESS.USER_ID = 0)) THEN
                  'READ & EXECUTE'
                 WHEN (OBJ_ACCESS.PERMISSIONS = 49 AND
                      (OBJ_ACCESS.USER_ID = 0)) THEN
                  'READ & WRITE'
                 WHEN (OBJ_ACCESS.PERMISSIONS = 57 AND
                      (OBJ_ACCESS.USER_ID = 0)) THEN
                  'READ, WRITE & EXECUTE'
                 ELSE
                  'NO PERMISSIONS'
               END PERMISSIONS,
               SUBJ.SUBJ_DESC
          FROM OPB_OBJECT_ACCESS OBJ_ACCESS,
               OPB_SUBJECT       SUBJ,
               OPB_USER_GROUP    USER_GROUP
         WHERE OBJ_ACCESS.OBJECT_TYPE = 29
           AND OBJ_ACCESS.OBJECT_ID = SUBJ.SUBJ_ID
           AND OBJ_ACCESS.USER_ID = USER_GROUP.ID(+) -- Outer Join added to support "Others" group
           AND OBJ_ACCESS.USER_TYPE = USER_GROUP.TYPE(+)) -- Outer Join added to support "Others" group
ORDER BY 1, 4 DESC, 2