@IsTest
Private class ActiveContactHandler_Test 
{
    @IsTest
    Static Void testCountActiveConAfterInsert()
    {
      // Create test data (insert Contacts and related Accounts with Active_Contact__c set to true)
          Account testAccount = New Account(Name ='TestAccount');
            Insert testAccount;
        
          Contact testContact1 = New Contact(AccountId = testAccount.Id, Active_Contact__c = True, LastName='Test1');
        
          Contact testContact2 = New Contact(AccountId = testAccount.Id, Active_Contact__c = False, LastName='Test2');
        
        List<Contact> ContactsToInsert = New List<Contact>{testContact1 , testContact2};
          Insert ContactsToInsert;
           
        // Call the ActiveContactTriggerHandler.CountActiveConAfterInsert method
           ActiveContactTriggerHandler.CountActiveConAfterInsert(ContactsToInsert);
        
        // Query and verify the updated Account records
        testAccount =[Select Id, Case_Count__c from Account Where Id = :testAccount.Id];
        
        // Add assertions to verify the expected behavior
        system.assertEquals(1, testAccount.Case_Count__c, 'Case_Count__c should be updated to 1 for the Test Account');
    }
    
    @IsTest
    Static Void testCountActiveConAfterDelete()
    {
        Account testAccount = New Account(Name ='Test Account');
        Insert testAccount;
        
        Contact testcontact1 = New Contact(LastName='Test1',AccountId=testAccount.Id, Active_Contact__c=true);
        Contact testcontact2 = New Contact(LastName='Test2',AccountId=testAccount.Id, Active_Contact__c=true);
        
        List<Contact> ContactsToInsert = New List<Contact>{testcontact1, testcontact2};
            Insert ContactsToInsert;
        
        delete testcontact1;
        
        testAccount =[Select id,Case_count__c from Account Where Id = :testAccount.Id];
        
        system.AssertEquals(1, testAccount.Case_Count__c, 'Case_Count__c should be updated to 1 after deleting one active contact');
        
    }
        
     @IsTest
    Static Void testCountActiveConAfterupdate()
    {
        Account testAccount = New Account(Name ='Test Account');
        Insert testAccount;
        
        Contact testcontact1 = New Contact(LastName='Test1',AccountId=testAccount.Id, Active_Contact__c=true);
        
            Insert testcontact1;
        
        testcontact1.Active_Contact__c = false;
        Update testcontact1;
        
        testAccount =[Select id,Case_count__c from Account Where Id = :testAccount.Id];
        
        system.AssertEquals(0, testAccount.Case_Count__c, 'Case_Count__c should be updated to 0 after updating an active contact to inactive');
        
    }          
        
}