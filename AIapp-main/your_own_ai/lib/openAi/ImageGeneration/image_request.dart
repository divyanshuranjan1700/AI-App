class ImageRequest {
  final String prompt;
  final int maxTokens;
  final String size;
  ImageRequest({
    required this.prompt,
    required this.maxTokens,
    required this.size,
  });
}
