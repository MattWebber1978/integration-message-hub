public class INT_MessageArchiveBatch imlements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context) {

    }

    public execute(Database.BatchableContext context, List<IntegrationMessage__c> records) {
        delete records;
    }

    public finish(Database.BatchableContext context) {

    }
}