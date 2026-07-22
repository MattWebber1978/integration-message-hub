public class INT_MessageArchiveBatch imlements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context) {
        Date cutoffDate = date.today().addDays(-getMaxRetentionDays());
        return Database.getQueryLocator([
            SELECT Id
            FROM IntegrationMessage__c
            WHERE MessageTimeStampDT__c < :cutoffDate
        ]);
    }

    public execute(Database.BatchableContext context, List<IntegrationMessage__c> records) {
        delete records;
    }

    public finish(Database.BatchableContext context) {
        private Integer getMaxRetentionDays() {
        Integer maxDays = 0;
        for(Integration_Config__mdt config : INT_ConfigProvider.getAllConfigs().values()) {
            if(config.RetentionDaysNum__c != null && config.RetentionDaysNum__c > maxDays) {
                maxDays = Integer.valueOf(config.RetentionDaysNum__c);
            }
        }
        return maxDays > 0 ? maxDays : 90;
    }
}