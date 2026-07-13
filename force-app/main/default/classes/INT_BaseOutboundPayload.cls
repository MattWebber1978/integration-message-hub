public abstract class INT_BaseOutboundPayload extends INT_BaseEnvelope {
    public String rawResponse;

    public abstract HttpRequest buildRequest();
    public abstract void handleResponse(HttpResponse res);
    
    // Concrete classes should call super.validateEnvelope() within their validate() implementation.

    public override void validate() {
        validateEnvelope();
    }
}