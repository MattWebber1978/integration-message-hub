public class INT_MessageParser {
    private static final Map<String, Type> MESSAGE_TYPE_REGISTRY = new Map<String, Type>{
        'UserAccountRegistration' => INT_UserAccountRegistrationRequest.class,
        'IdentityVerification'    => INT_IdentityVerificationRequest.class,
        'BACSPayment'             => INT_BacsPaymentRequest.class
    };
    
    public INT_BaseInboundPayload parse(String messageType, String jsonBody) {
        Type payloadType = MESSAGE_TYPE_REGISTRY.get(messageType);

        if(payloadType == null) {
            throw new INT_HandlerNotFoundException('No payload type registered for messageType: ' + messageType
            );
        }

        try {
            INT_BaseInboundPayload payload = 
                (INT_BaseInboundPayload) JSON.deserialize(jsonBody, payloadType);
            payload.rawPayload = jsonBody;
            return payload;
        } catch (JSONException e) {
            throw new INT_ValidationException('Failed to parse payload for messageType: ' + messageType + ' - ' + e.getMessage()
            );
        }
    }
}