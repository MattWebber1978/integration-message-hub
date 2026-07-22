public class INT_RetryQueueable implements Queueable {

    private INT_BaseInboundPayload payload;
    private Integer maxRetries;

    public INT_RetryQueueable(INT_BaseInboundPayload payload, Integer maxRetries) {
        this.payload    = payload;
        this.maxRetries = maxRetries;
    }

    public void execute(QueueableContext context) {
        payload.markForRetry(maxRetries);

        if(payload.status == INT_BaseEnvelope.MessageStatus.DEAD_LETTER) {
            INT_MessagePersistenceService.persist(payload);
            return;
        }

        try {
            INT_Dispatcher.dispatch(payload);
        } catch(Exception e) {
            payload.markFailed(e.getMessage());
            INT_MessagePersistenceService.persist(payload);

            if(payload.isRetryable) {
                System.enqueueJob(new INT_RetryQueueable(payload, maxRetries));
            }
        }
    }
}