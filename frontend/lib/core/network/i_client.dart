abstract class IClient {
  Future<T> getAsync<T>(
    String resourcePath, {
    Map<String, dynamic> queryParams = const {},
  });

  Future<T> postAsync<T>(
    String resourcePath,
    Map data, {
    Map<String, dynamic> queryParams = const {},
  });
}