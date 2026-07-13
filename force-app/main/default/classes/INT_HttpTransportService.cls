public class INT_HttpTransportService {
    public static void send(INT_BaseOutboundPayload payload) {
        payload.validate();

        HttpRequest req = payload.buildRequest();
        Http http = new Http();

        try {
            HttpResponse res = http.send(req);
            payload.handleResponse(res);

            if(res.getStatusCode() >= 200 && res.getStatusCode() < 300) {
                payload.markSuccess();
            } else {
                payload.markFailed('Unexpected status code: ' + res.getStatusCode());
            }
        } catch (CalloutException e) {
            payload.markFailed(e.getMessage());
            throw new INT_FrameworkException(
                'Callout failed for messageType: ' + payload.messageType + ' - ' + e.getMessage()
            );
        }
    }
}