/*REXX*****************************************************************/
/*                                                                    */
/* Return panel data as json                                          */
/*                                                                    */
/**********************************************************************/
/* trace r */
arg PanelName PrefixValue
if PanelName = "" | PanelName = "PanelName" then do
   call charout,'{"Message":"Panelname must be specified!"}'||esc_n
   return
end
if PrefixValue = "" | PrefixValue = "PrefixValue" then do
   PrefixValue = "*"
end
RC        = ISFCALLS("ON")  /* Create SDSF host command environment */
IF RC <> 0 THEN RETURN      /* Abord if problem                     */
ISFSECTRACE = "ON"
ISFOWNER = "*"
ISFPREFIX = PrefixValue     /* Set filter                           */
ISFJESNAME = "JES2"
ADDRESS SDSF "ISFEXEC "||PanelName /* Panel SDSF command PS  */
IF RC <> 0 THEN do          /* Abord if problem                     */
   call charout,'{"Message":"SDSF error!"}'||esc_n
   return
end
call charout,'['||esc_n
do ix=1 to isfrows
  if ix > 1 then call charout,', '||esc_n
  call charout,'{'||esc_n
          /* List all columns for row */
  do jx=1 to words(isfcols)
    if jx > 1 then call charout,', '||esc_n
    col = word(isfcols,jx)
    call charout,'"'||col||'":"'||VALUE(col"."ix)||'"'
  end
  call charout,'}'||esc_n
end
call charout,']'||esc_n

RC = ISFCALLS("OFF") /* Delete SDSF host command environment */
return RC
