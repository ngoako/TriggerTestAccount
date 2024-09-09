public with sharing class AccountHandler {
    //Make rating to be HOT when the annual revenue on the account is greater or eqaul to 500000
    public static void updateRating(List<Account> lstAccount){
        if(!lstAccount.isEmpty()){
            for(Account acc : lstAccount){
                List<Account> listAcc = new List<Account>();
                if(acc.AnnualRevenue >= 500000){
                    acc.Rating = 'Hot';
                    listAcc.add(acc);
                }
            }
        }
    }
    //Copy billing address to shipping address when the Match_Billing_Address__c checkbox is true
    public static void copyBillingToShipping(List<Account> lstAccount){
        if(!lstAccount.isEmpty()){
                for(Account acc : lstAccount){
                    List<Account> listAcc = new List<Account>();
                    if(acc.Match_Billing_Address__c == true && acc.BillingCity != null){
                        acc.ShippingCity = acc.BillingCity;
                        acc.ShippingCountry = acc.BillingCountry;
                        acc.ShippingState = acc.BillingState;
                        acc.ShippingStreet = acc.BillingStreet;
                        acc.ShippingPostalCode = acc.BillingPostalCode;
                    }
                }
        }
    }
    //Create a related Contact when a new Account is created
    public static void createRelatedContact(List<Account> accList){
        if(!accList.isEmpty()){
            List<Contact> listContact = new List<Contact>();
            for(Account acc : accList){
                Contact con = new Contact();
                con.FirstName = 'Ecco';
                con.LastName = 'Television';
                con.Email = 'eccotele@'+ acc.Name + '.com';
                con.Phone = '0987654321';
                con.RecordTypeId = '0128d000001ODgBAAW';

                con.AccountId = acc.Id;
                listContact.add(con);
            }
            if(!listContact.isEmpty()){
                insert listContact;
            }
        }
    }
    //When an Account record is created the create a related Opportunity
    public static void createRelatedOpportunity(List<Account> listAccount){
        if(!listAccount.isEmpty()){
            List<Opportunity> lstOpp = new List<Opportunity>();
            for(Account acc : listAccount){
                Opportunity opp = new Opportunity();
                opp.Name = 'Festival';
                opp.CloseDate = system.today().addDays(20);
                opp.StageName = 'Prospecting';

                opp.AccountId = acc.Id;
                lstOpp.add(opp);
            }
            if(!lstOpp.isEmpty()){
                insert lstOpp;
            }
        }
    }
}