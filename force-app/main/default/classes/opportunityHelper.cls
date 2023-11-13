public with sharing class opportunityHelper 
{
    private static final Integer PAGE_SIZE = 5;

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getRecentOpportunities(String opportunityName, Integer pageNumber){
        try {
            String query ='SELECT Id, Name,Amount, CloseDate FROM Opportunity';
            if(! String.isEmpty(opportunityName))
            {
                String condition = ' WHERE Name LIKE \'%'+ opportunityName + '%\'';
                query += condition;
            }
             query += ' ORDER BY CloseDate DESC LIMIT :PAGE_SIZE OFFSET :pageNumber';

             return Database.query(query);
        } catch (Exception e) {
            System.debug(e.getMessage());
            return new List<Opportunity>();
        }
    }
}