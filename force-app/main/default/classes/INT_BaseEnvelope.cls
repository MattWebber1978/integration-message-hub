public abstract class INT_BaseEnvelope {
    public String correlationId;
    public String sourceSystem;
    public String targetSystem;
    public String messageType;
    public String messageVersion;
    public DateTime messageTimestamp;
    public MessageStatus status;
    public Integer retryCount;
    public String errorMessage;
    public Boolean isRetryable;
    
    public enum MessageStatus {
        PENDING,
        SUCCESS,
        FAILURE,
        RETRYING,
        DEAD_LETTER
    }

    public INT_BaseEnvelope() {
        this.correlationId = generateCorrelationId();
        this.messageTimestamp = DateTime.now();
        this.status = MessageStatus.PENDING;
        this.retryCount = 0;
        this.isRetryable = true;
    }

    public abstract void validate();

    // Concrete classes should call super.validateEnvelope() within their validate() implementation.
    protected void validateEnvelope() {
        if(String.isBlank(correlationId)) {
            throw new INT_ValidationException('correlationId is required on all messages');
        }
        if(String.isBlank(messageType)) {
            throw new INT_ValidationException('messageType is required on all messages');
        }
        if(String.isBlank(sourceSystem)) {
            throw new INT_ValidationException('sourceSystem is required on all messages');
        }
        if(messageTimestamp == null) {
            throw new INT_ValidationException('messageTimestamp is required on all messages');
        }
    }

    public void markFailed(String errorDetail) {
        this.status = MessageStatus.FAILURE;
        this.errorMessage = errorDetail;
    }

    public void markSuccess() {
        this.status = MessageStatus.SUCCESS;
        this.errorMessage = null;
    }

    public void markForRetry(Integer maxRetries) {
        this.retryCount++;
        if(this.retryCount > maxRetries) {
            this.status = MessageStatus.DEAD_LETTER;
        } else {
            this.status = MessageStatus.RETRYING;
        }
    }

    private String generateCorrelationId() {
        return 'MSG-' + String.valueOf(Crypto.getRandomLong()).substring(0, 8)
        + '-' + String.valueOf(DateTime.now().getTime()); 
    }
}