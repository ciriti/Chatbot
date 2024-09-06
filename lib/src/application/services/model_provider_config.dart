class ModelProviderConfig {
  final String apiUrl;
  final String model;
  final Map<String, dynamic> Function(String message) buildRequestData;
  final Map<String, String> Function(String apiKey) buildHeaders;

  ModelProviderConfig({
    required this.apiUrl,
    required this.model,
    required this.buildRequestData,
    required this.buildHeaders,
  });
}
