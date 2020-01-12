/*REXX*****************************************************************/
/*                                                                    */
/* Return last execution of job                                       */
/*                                                                    */
/**********************************************************************/
/*trace r*/
arg OwnerValue PrefixValue
 
if OwnerValue = "" | OwnerValue = "OwnerValue" then do
   OwnerValue = Userid()
end
 
if PrefixValue = "" | PrefixValue = "PrefixValue" then do
   PrefixValue = OwnerValue||"*"
end
 
RC        = ISFCALLS("ON")  /* Create SDSF host command environment */
if RC <> 0 then do          /* Abord if problem                     */
   say 'SDSF error!'
   return
end
 
isfowner = OwnerValue
isfprefix = PrefixValue     /* Set filter                           */
isfjesname = "JES2"
isfcols   = "jname jtype jobid phasename retcode datee timee"
isfsort   = "jtype a DATEE D TIMEE D"
 
ADDRESS SDSF "ISFEXEC ST (PRIMARY ALTERNATE DELAYED)"
 
if RC <> 0 then do          /* Abord if problem                     */
   say 'SDSF error!'
   return
end
 
do ix=1 to isfrows
  strLine = ''
  do jx=1 to words(isfcols)
    if jx > 1 then strLine = strLine || ' '
    col = word(isfcols,jx)
    if col /= "TOKEN" then strLine = strLine ||  VALUE(col"."ix)
  end
  say strLine
end
 
RC = isfcalls("OFF") /* Delete SDSF host command environment */
return RC
