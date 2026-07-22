public class INT_MessagePersistenceService {

    public static void persist(INT_BaseEnvelope envelope) {
        Integration_Config__mdt config = INT_ConfigProvider.getConfig(envelope.messageType);

        if(!config.IsAuditableChk__c) {
            return;
        }

        Integration_Message__c record = new Integration_Message__c(
            CorrelationIdTxt__c   = envelope.correlationId,
            SourceSystemTxt__c    = envelope.sourceSystem,
            TargetSystemTxt__c    = envelope.targetSystem,
            MessageTypeTxt__c     = envelope.messageType,
            MessageVersionTxt__c  = envelope.messageVersion,
            StatusPL__c           = envelope.status.name(),
            RetryCountNum__c      = envelope.retryCount,
            ErrorMessageTxt__c    = envelope.errorMessage,
            MessageTimestampDT__c = envelope.messageTimestamp
        );

        if(envelope instanceof INT_BaseInboundPayload) {
            record.DirectionPL__c = 'Inbound';
            record.RawPayloadTxt__c = ((INT_BaseInboundPayload) envelope).rawPayload;
        } else if(envelope instanceof INT_BaseOutboundPayload) {
            record.DirectionPL__c = 'Outbound';
            record.RawPayloadTxt__c = ((INT_BaseOutboundPayload) envelope).rawResponse;
        }

        insert record;
    }
}