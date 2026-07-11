public class INT_Dispatcher {
    private static final Map<String, Type> HANDLER_REGISTRY = new Map<String, Type>{
        'UserAccountRegistration' => INT_UserAccountRegistrationHandler.class,
        'IdentityVerification'    => INT_IdentityVerificationHandler.class,
        'BacsPayment'             => INT_BacsPaymentHandler.class
    };

    public static void dispatch(INT_BaseInboundPayload payload) {
        payload.validate();

        Type handlerType = HANDLER_REGISTRY.get(payload.messageType);

        if(handlerType == null) {
            throw new INT_HandlerNotFoundException('No handler registered for messageType: ' +  payload.messageType);
        }

        INT_IHandler handler = (INT_IHandler) handlerType.newInstance();
        handler.execute(payload);
    }
}