public class INT_FrameworkException extends Exception {

        public enum ErrorCode {
        VALIDATION_ERROR,
        HANDLER_NOT_FOUND,
        PARSING_ERROR,
        TRANSPORT_ERROR,
        CONFIGURATION_ERROR
    }

    public ErrorCode errorCode;
}