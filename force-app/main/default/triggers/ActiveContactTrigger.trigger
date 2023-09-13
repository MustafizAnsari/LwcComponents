trigger ActiveContactTrigger on Contact (After Insert, After Update, After Delete, After Undelete) 
{
   If(Trigger.IsAfter &&(Trigger.IsInsert || Trigger.IsUndelete))
   {
     ActiveContactTriggerHandler.CountActiveConAfterInsert(Trigger.New);
   }
   If(Trigger.IsAfter && Trigger.IsUpdate)
   {
     ActiveContactTriggerHandler.CountActiveConAfterUpdate(Trigger.New , Trigger.OldMap );
   }
   If(Trigger.IsAfter && Trigger.IsDelete)
   {
    ActiveContactTriggerHandler.CountActiveConAfterDelete(Trigger.Old);
   }
}