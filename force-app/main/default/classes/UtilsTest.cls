@isTest
public with sharing class UtilsTest{

    @testSetup
    static void makeData(){
        Account a = new Account(Name = 'Company 1', BillingCity = 'San Francisco', NumberOfEmployees = 15);
        Account b = new Account(Name = 'Company 2', BillingCountry = 'Mexico', BillingCity = 'San Antonio', NumberOfEmployees = 10);
        Account c = new Account(Name = 'Company 3', BillingCountry = 'Peru' , BillingCity = 'San Antonio', NumberOfEmployees = 10);
        
        Database.insert(new List<Account>{a,b,c});
    }
    
    @isTest
    static void testGetMapUniqueByCustomField(){
        List<Account> accts = [SELECT Id, Name, BillingCountry, BillingCity FROM Account];
        Map<Object, Sobject> acctsByName = Utils.getMapUniqueByCustomField(accts, 'Name');
        System.debug(LoggingLevel.DEBUG, JSON.serializePretty(acctsByName));
        Account a = (Account) acctsByName.get('Company 1');
        System.assertEquals('San Francisco', a?.BillingCity , 'Should be the same city');
    }
    
    @isTest
    static void testGetMapByCustomField(){
        List<Account> accts = [SELECT Id, Name, BillingCountry, BillingCity FROM Account];
        Map<Object, List<Sobject>> acctsByCityName = Utils.getMapByCustomField(accts, 'BillingCity');
        System.debug(LoggingLevel.DEBUG, JSON.serializePretty(acctsByCityName));
        List<Account> acctsInSanAntonio = (List<Account>) acctsByCityName.get('San Antonio');
        System.assertEquals(2, acctsInSanAntonio?.size() , 'Should have 2 accounts in San Antonio');
    }
    
    @isTest
    static void testGetMapUniqueByNumberField(){
        List<Account> accts = [SELECT Id, Name, BillingCountry, BillingCity, NumberOfEmployees FROM Account];
        Map<Object, Sobject> acctsByNumberEmployees = Utils.getMapUniqueByCustomField(accts, 'NumberOfEmployees');
        System.debug(LoggingLevel.DEBUG, JSON.serializePretty(acctsByNumberEmployees));
        Account a = (Account) acctsByNumberEmployees.get(15);
        System.assertEquals('San Francisco', a?.BillingCity , 'Should be the same city');
    }
    
    @isTest
    static void testGetMapByNumberField(){
        List<Account> accts = [SELECT Id, Name, BillingCountry, BillingCity, NumberOfEmployees FROM Account];
        Map<Object, List<Sobject>> acctsByNumberEmployees = Utils.getMapByCustomField(accts, 'NumberOfEmployees');
        System.debug(LoggingLevel.DEBUG, JSON.serializePretty(acctsByNumberEmployees));
        List<Account> acctsInSanAntonio = (List<Account>) acctsByNumberEmployees.get(10);
        System.assertEquals(2, acctsInSanAntonio?.size() , 'Should have 2 accounts in San Antonio');
    }
}