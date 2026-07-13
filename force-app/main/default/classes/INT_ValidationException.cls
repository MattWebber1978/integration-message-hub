public class INT_ValidationException extends INT_FrameworkException {

    public INT_ValidationException(String message) {
        this.setMessage(message);
        this.errorCode = ErrorCode.VALIDATION_ERROR;
    }
}