@IsTest
Private class ActiveContactHandler_Test 
{
    @IsTest
    Static Void testCountActiveConAfterInsert()
    {
      // Create test data (insert Contacts and related Accounts with Active_Contact__c set to true)
          Account testAccount = New Account(Name ='TestAccount');
            Insert testAccount;
        
          Contact testContact1 = New Contact(LastName='Test1',AccountId = testAccount.Id, Active_Contact__c = True);
          Contact testContact2 = New Contact(LastName='Test2',AccountId = testAccount.Id, Active_Contact__c = False);
        
          List<Contact> ContactsToInsert = New List<Contact>{testContact1 , testContact2};
          Insert ContactsToInsert;
           
        // Call the ActiveContactTriggerHandler.CountActiveConAfterInsert method
           ActiveContactTriggerHandler.CountActiveConAfterInsert(ContactsToInsert);
        
        // Query and verify the updated Account records
          testAccount =[Select Id, Case_Count__c from Account Where Id = :testAccount.Id];
        
        // Add assertions to verify the expected behavior
         system.assertEquals(1, testAccount.Case_Count__c, 'Case_Count__c should be updated to 1 for the Test Account');
    }
    
    @isTest
    static void testCountActiveConAfterDelete() {
        
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact1 = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = testAccount.Id, Active_Contact__c = true);
        Contact testContact2 = new Contact(FirstName = 'Jane', LastName = 'Smith', AccountId = testAccount.Id, Active_Contact__c = true);
        Contact testContact3 = new Contact(FirstName = 'Inactive', LastName = 'Contact', AccountId = testAccount.Id, Active_Contact__c = false);
        List<Contact> testContacts = new List<Contact>{testContact1, testContact2, testContact3};
        insert testContacts;

        // Delete the inactive contact
        delete testContact3;

        // Call the trigger handler method
        Test.startTest();
        ActiveContactTriggerHandler.CountActiveConAfterDelete(testContacts);
        Test.stopTest();

        // Verify that the Account's Case_Count__c field has been updated
        Account updatedAccount = [SELECT Case_Count__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(2, updatedAccount.Case_Count__c, 'Case_Count__c should be updated to 2');
    }
        
     @isTest
    static void testCountActiveConAfterUpdate() {
        // Create test data - Accounts and Contacts
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact1 = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = testAccount.Id, Active_Contact__c = true);
        Contact testContact2 = new Contact(FirstName = 'Jane', LastName = 'Smith', AccountId = testAccount.Id, Active_Contact__c = true);
        Contact testContact3 = new Contact(FirstName = 'Inactive', LastName = 'Contact', AccountId = testAccount.Id, Active_Contact__c = false);
        List<Contact> testContacts = new List<Contact>{testContact1, testContact2, testContact3};
        insert testContacts;

        // Map of old Contacts with their previous values
        Map<Id, Contact> oldContacts = new Map<Id, Contact>();
        for (Contact contact : testContacts) {
            oldContacts.put(contact.Id, contact.clone());
        }

        // Update a contact to make it inactive
        testContact1.Active_Contact__c = false;
        update testContact1;

        // Call the trigger handler method
        Test.startTest();
        ActiveContactTriggerHandler.CountActiveConAfterUpdate(testContacts, oldContacts);
        Test.stopTest();

        // Verify that the Account's Case_Count__c field has been updated
        Account updatedAccount = [SELECT Case_Count__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(1, updatedAccount.Case_Count__c, 'Case_Count__c should be updated to 1');
    }
        
}