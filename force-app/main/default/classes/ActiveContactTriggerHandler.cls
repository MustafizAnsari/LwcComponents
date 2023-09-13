public with sharing class ActiveContactTriggerHandler 
{
    Public Static Void CountActiveConAfterInsert(List<Contact> LstCon)     //After Insert update And Undelete
    {
           Set<Id> AccIds = New Set<Id>();
           For(Contact Con : LstCon)
           {
            if(con.AccountId != Null && con.Active_Contact__c == true)
            {
                AccIds.Add(Con.AccountId);
            }
           }
           If(! AccIds.IsEmpty())
           {
            List<Account> AccounttoUpdate = New List<Account>();
            List<Account> LstAccounts =[Select Id, Case_Count__c ,
                                        (Select Id, AccountId,Active_Contact__c From Contacts Where Active_Contact__c = true)
                                            From Account Where Id IN: AccIds];
                For(Account Acc : LstAccounts)
                {
                    Acc.Case_Count__c = Acc.Contacts.Size();
                    AccounttoUpdate.Add(Acc);
                }
                If(! AccounttoUpdate.IsEmpty())
                {
                    Update AccounttoUpdate;
                }
           }
    }

    Public Static Void CountActiveConAfterDelete(List<Contact> LstCon)     //After delete
    {
           Set<Id> AccIds = New Set<Id>();
           For(Contact Con : LstCon)
           {
            if(con.AccountId != Null)
            {
                AccIds.Add(Con.AccountId);
            }
           }
           If(! AccIds.IsEmpty())
           {
            List<Account> AccounttoUpdate = New List<Account>();
            List<Account> LstAccounts =[Select Id, Case_Count__c ,
                                        ( Select Id, AccountId,Active_Contact__c From Contacts Where Active_Contact__c = true)
                                          From Account Where Id IN: AccIds];
                For(Account Acc : LstAccounts)
                {
                    Acc.Case_Count__c = Acc.Contacts.Size();
                    AccounttoUpdate.Add(Acc);
                }
                If(! AccounttoUpdate.IsEmpty())
                {
                    Update AccounttoUpdate;
                }
           }
    }

    Public Static Void CountActiveConAfterUpdate(List<Contact> LstCon, Map<Id,Contact> OldMapCon)     //After Update
    {
           Set<Id> AccIds = New Set<Id>();
           For(Contact Con : LstCon)
           {
            if(con.AccountId != Null && Con.Active_Contact__c != OldMapCon.Get(Con.id).Active_Contact__c)
            {
                AccIds.Add(Con.AccountId);
            }
           }
           If(! AccIds.IsEmpty())
           {
            List<Account> AccounttoUpdate = New List<Account>();
            List<Account> LstAccounts =[Select Id, Case_Count__c ,
                                        (Select Id, AccountId,Active_Contact__c From Contacts Where Active_Contact__c = true)
                                        From Account Where Id IN: AccIds];
                For(Account Acc : LstAccounts)
                {
                    Acc.Case_Count__c = Acc.Contacts.Size();
                    AccounttoUpdate.Add(Acc);
                }
                If(! AccounttoUpdate.IsEmpty())
                {
                    Update AccounttoUpdate;
                }
           }
    }
}