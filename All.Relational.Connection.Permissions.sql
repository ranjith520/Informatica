SELECT * 
  FROM (SELECT a.REPOSITORY_NAME as REPO_NAME, CNX.OBJECT_NAME,
               NVL(USER_GROUP.NAME, 'Others') USER_NAME,
               CASE
                 WHEN ((USER_GROUP.ID = CNX.OWNER_ID) AND
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
                      (OBJ_ACCESS.USER_ID = 0)) THEN 
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
               END 
               PERMISSIONS
              
          FROM OPB_OBJECT_ACCESS OBJ_ACCESS,
               OPB_CNX       CNX,
               OPB_USER_GROUP    USER_GROUP,
               OPB_REPOSIT_INFO a
         WHERE 
         OBJ_ACCESS.OBJECT_TYPE = 73
            --CNX.OBJECT_NAME like '%FSA%'
            AND OBJ_ACCESS.OBJECT_ID = CNX.OBJECT_ID
           AND OBJ_ACCESS.USER_ID = USER_GROUP.ID(+) 
           AND OBJ_ACCESS.USER_TYPE = USER_GROUP.TYPE(+))
           
           ORDER BY 2, 5 DESC, 3