trigger preventDuplicateContactByEmail on Contact (before insert, before update) 
{
    if(Trigger.isBefore &&(Trigger.isInsert || Trigger.isupdate))
    {
        preventDuplicateContactByEmailHandler.checkDuplicateContact(Trigger.New);
    }
}