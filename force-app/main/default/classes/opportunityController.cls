public with sharing class opportunityController 
{
   @AuraEnabled(cacheable=true)
   public static list<opportunity> getOpportunities()
   {
     Date Today = Date.Today();
     Integer amountThereShold = 100000;

     return [SELECT Id,Name,Amount FROM opportunity WHERE CreatedDate >=  :Today AND Amount >= :amountThereShold];
   }  
}