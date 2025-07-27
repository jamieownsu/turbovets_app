class SendMessageParams {
  final String message;
  final String userId;
  final String recipientUserId;

  SendMessageParams({
    required this.message,
    required this.userId,
    required this.recipientUserId,
  });
}
