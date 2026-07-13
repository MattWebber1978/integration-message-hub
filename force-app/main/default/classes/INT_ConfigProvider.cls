public class INT_ConfigProvider {
    private static Map<String, Integration_Config__mdt> configByMessageType;

    public static Map<String, Integration_Config__mdt> getAllConfigs() {
        if(configByMessageType == null) {
            configByMessageType = new Map<String, Integration_Config__mdt>();

            Map<String, Integration_Config__mdt> allRecords = Integration_Config__mdt.getAll();
            for(Integration_Config__mdt config : allRecords.values()) {
                configByMessageType.put(config.MessageTypeTxt__c, config);
            }
        }
        return configByMessageType;

    }
    
    public static Integration_Config__mdt getConfig(String messageType) {
        Integration_Config__mdt config = getAllConfigs().get(messageType);
        if(config == null) {
            throw new INT_HandlerNotFoundException('No configuration found for messageType: ' + messageType
            );
        }
        return config;
    }
}