enum GptModel {
  gpt35('gpt-3.5-turbo'),
  dalle3('dall-e-3');

  final String key;

  const GptModel(this.key);
}
