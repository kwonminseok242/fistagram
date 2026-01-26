class AppConstants {
  // 앱 정보
  static const String appName = 'Fistagram';
  static const String appVersion = '1.0.0';

  // API (나중에 백엔드 연결 시 사용)
  static const String baseUrl = 'https://api.fistagram.com';

  // 페이지 크기
  static const int postsPerPage = 10;
  static const int commentsPerPage = 20;

  // 이미지
  static const double maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png'];
}
