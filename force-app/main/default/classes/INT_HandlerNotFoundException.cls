public class INT_HandlerNotFoundException extends INT_FrameworkException {

    public INT_HandlerNotFoundException(String message) {
        this.setMessage(message);
        this.errorCode = ErrorCode.HANDLER_NOT_FOUND;
    }
}