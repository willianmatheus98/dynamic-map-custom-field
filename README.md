# Explanation
The default Map constructor for Sobjects use the <b>Id</b> as key, so with these methods, you can use any field (standard or custom) of the Sobject (unique or duplicated)

Bellow examples of how to use the <i>Utils</i> methods and examples

## Get 1 item by a custom field 

Return 1 account that are in the list and have the field <b>MyExternalField__c</b> with value <b>123456789</b>

```java
List<Account> accts = [SELECT Id, Name, MyExternalField__c FROM Account];
Map<Object, Sobject> acctsByName = Utils.getMapUniqueByCustomField(accts, 'MyExternalField__c');

Account a = (Account) acctsByName.get('123456789');
```

## Get many items by a standard field 

Return 10 accounts that are in the list and are from billing city equals San Antonio

```java
List<Account> accts = [SELECT Id, Name, BillingCountry, BillingCity FROM Account];
Map<Object, List<Sobject>> acctsByCityName = Utils.getMapByCustomField(accts, 'BillingCity');

List<Account> acctsInSanAntonio = (List<Account>) acctsByCityName.get('San Antonio');