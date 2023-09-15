@Istest
Private class preventDuplicateContactByEmail_Test 
{
    @IsTest
    Static Void testDuplicateContact()
    {
        Account testAccount = new Account(Name ='Test Account');
        Insert testAccount;
        
        Contact testContact1 = new Contact(FirstName='John',Lastname='doe',AccountId=testAccount.Id, Email='test1@example.com');
        Contact testContact2 = new Contact(FirstName='John',Lastname='smith',AccountId=testAccount.Id, Email='test1@example.com');
        
        List<Contact> LstTestContacts = New List<Contact>{testContact1, testContact2};
            insert LstTestContacts;
           
         Test.startTest();
         preventDuplicateContactByEmailHandler.checkDuplicateContact(LstTestContacts);
         Test.stopTest();
        
        List<Contact> queryContacts =[Select email from contact where Id IN : LstTestContacts];
        
        System.assertEquals('test1@example.com', queryContacts[1].Email, 'Error message is incorrect');
        
    }
    }