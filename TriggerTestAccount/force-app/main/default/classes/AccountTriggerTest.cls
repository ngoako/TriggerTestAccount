@isTest
public with sharing class AccountTriggerTest {
    @isTest
    public static void updateRatingTest(){
        List<Account> lstAcc = new List<Account>();
        for(Integer x = 1; x <+ 5; x++){
            Account acc = new Account();
            acc.Name = 'MondayTech';
            acc.Phone = '0987654321';
            acc.Industry = 'Banking';
            acc.AnnualRevenue = 570000;
            acc.RecordTypeId = '0128d000001ODfvAAG';

            lstAcc.add(acc);
        }
        //Add data
        Test.startTest();
            insert lstAcc;
        Test.stopTest();
        
        //Retrieve data
        List<Account> listAccount = [SELECT Id, Rating FROM Account WHERE Id =: lstAcc[0].Id];

        //Compare data
        System.assertEquals('Hot', listAccount[0].Rating);

    }

    @isTest
    public static void copyBillingToShippingTest(){
        //Create data
        List<Account> listAcc = new List<Account>();
        for(Integer x = 1; x <= 5; x++){
            Account acc = new Account();
            acc.Name = 'YouTube';
            acc.AnnualRevenue = 460000;
            acc.RecordTypeId = '0128d000001ODfvAAG';
            acc.Industry = 'Banking';
            acc.Phone = '9876543210';
            acc.BillingCity = 'Varanasi';
            acc.BillingCountry = 'India';
            acc.BillingState = 'Pretoria';
            acc.BillingStreet = '02 Carnarvon';
            acc.BillingPostalCode = '7803';
            acc.Match_Billing_Address__c = true;

            listAcc.add(acc);
        }
        //Add data
        Test.startTest();
            insert listAcc;
        Test.stopTest();

        //Retrieve data
        List<Account> lstAccount = [SELECT Id, Match_Billing_Address__c FROM Account WHERE Id =: listAcc[0].Id];

        //Compare data
        System.assertEquals(true, lstAccount[0].Match_Billing_Address__c);
    }

    @isTest
    public static void createRelatedContactTest(){
        //Create data
        List<Account> listAcc = new List<Account>();
        for(Integer x = 1; x <= 5; x++){
            Account acc = new Account();
            acc.Name = 'Vaseline';
            acc.RecordTypeId = '0128d000001ODfvAAG';

            listAcc.add(acc);
        }

        //Add data
        Test.startTest();
            insert listAcc;
        Test.stopTest();

        //Retrieve data
        List<Contact> lstContact = [SELECT Id, LastName FROM Contact WHERE AccountId =: listAcc[0].Id];

        //Compare data
        System.assert(lstContact != null, 'Contact was not created');
    }
}