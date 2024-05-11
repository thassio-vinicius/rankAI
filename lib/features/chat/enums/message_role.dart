enum MessageRole {
  none("none"),
  system("system"),
  user("user"),
  assistant("assistant");

  final String key;
  const MessageRole(this.key);
}
