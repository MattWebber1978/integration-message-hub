public class INT_Dispatcher {
    
    public static void dispatch(INT_BaseInboundPayload payload) {
        payload.validate();

        Integration_Config__mdt config = INT_ConfigProvider.getConfig(payload.messageType);

        Type handlerType = Type.forName(config.ProcessorClassTxt__c);

        if(handlerType == null) {
            throw new INT_HandlerNotFoundException('Processor class not found: ' +  config.ProcessorClassTxt__c);
        }

        INT_IHandler handler = (INT_IHandler) handlerType.newInstance();
        handler.execute(payload);
    }
}