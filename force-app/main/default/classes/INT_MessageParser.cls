public class INT_MessageParser {

    public static INT_BaseInboundPayload parse(String messageType, String jsonBody) {
        Integration_Config__mdt config = INT_ConfigProvider.getConfig(messageType);

        Type payloadType = Type.forName(config.MessageClassTxt__c);
        if(payloadType == null) {
            throw new INT_ValidationException(
                'Message class not found: ' + config.MessageClassTxt__c
            );
        }

        try {
            INT_BaseInboundPayload payload =
                (INT_BaseInboundPayload) JSON.deserialize(jsonBody, payloadType);
            payload.rawPayload = jsonBody;
            return payload;
        } catch (JSONException e) {
            throw new INT_ValidationException(
                'Failed to parse payload for messageType: ' + messageType + ' - ' + e.getMessage()
            );
        }
    }
}