public abstract class INT_BaseInboundPayload extends INT_BaseEnvelope {
    public String rawPayload;
    
    public abstract void process();

    // Concrete classes should call super.validateEnvelope() within their validate() implementation
    public override void validate() {
        validateEnvelope();
    }
}