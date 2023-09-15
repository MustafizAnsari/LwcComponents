public with sharing class preventDuplicateContactByEmailHandler 
{
  public static void checkDuplicateContact(List<Contact> LstContact)
  {
    map<Id,String> newMapOfEmail = New map<Id,String>();
    for(contact con : LstContact)
    {
        if(con.AccountId != Null && con.email != Null)
        {
            newMapOfEmail.put(Con.AccountId, con.email);
        }
    }

    list<string> lstduplicateContact = new list<string>();
    list<Contact> getRelatedCon =[Select Id,AccountId,Email from Contact Where AccountId IN : newMapOfEmail.KeySet()];

    for(contact co: getRelatedCon)
    {
        lstduplicateContact.Add(co.Email);
    }
    for(contact con: lstContact)
    {
        if(lstduplicateContact.Contains(Con.email))
        {
            con.email.AddError('You Cannot insert the same Email in contact with the same account');
        }
    }
  }  
}