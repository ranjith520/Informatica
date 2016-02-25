/* Formatted on 6/23/2011 12:05:28 PM (QP5 v5.126.903.23003) */
SELECT   REP_WFLOW_RUN.SUBJECT_AREA,
         REP_WFLOW_RUN.WORKFLOW_name,
         REP_WFLOW_RUN.END_TIME,
         REP_TASK_INST.INSTANCE_NAME,
OPB_PERF_COUNT.WORKFLOW_ID 
  FROM   REP_TASK_ATTR, REP_WFLOW_RUN, REP_TASK_INST,OPB_PERF_COUNT
 WHERE       REP_WFLOW_RUN.WORKFLOW_ID = REP_TASK_ATTr.WORKFLOW_ID
         AND REP_TASK_ATTR.ATTR_NAME = 'Collect performance data'
         AND REP_TASK_ATTR.ATTR_VALUE = '1'
         AND REP_TASK_ATTR.WORKFLOW_ID <> 0
         AND REP_TASK_INST.TASK_ID = REP_TASK_ATTR.TASK_ID
         and 
 REP_WFLOW_RUN.WORKFLOW_ID=OPB_PERF_COUNT.WORKFLOW_ID

 
 
 select b.subject_area "Folder Name", c.subj_desc "Application Team", b.task_name "Workflow Name", a.attr_name, a.attr_value, d.last_run_time "Last Run Time"
from 
rep_task_attr a,
rep_all_tasks b, 
opb_subject c,
(select subject_id, workflow_name, max(end_time) last_run_time
from
rep_wflow_run
where subject_id in (select subj_id from opb_subject)
group by subject_id, workflow_name) d
where a.version_number = b.version_number
and a.task_id = b.task_id
and a.task_type = b.task_type
and b.subject_id = c.subj_id
and b.task_name = d.workflow_name(+)
and b.subject_id = d.subject_id(+)
and a.task_type = 68
and a.attr_id = 102
and a.attr_value = 1
order by 1,2,3,4
