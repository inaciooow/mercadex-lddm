class AppConfig {
  const AppConfig._();

  static const useMockData = bool.fromEnvironment(
    'USE_MOCK_DATA',
    defaultValue: true,
  );
}
