
## 기본 파일 구조

'''text
/instagram-clone
├── /android                        # Android 프로젝트 관련 파일들
├── /ios                            # iOS 프로젝트 관련 파일들
├── /lib
│   ├── /core                       # 핵심 기능들
│   │   ├── /constants              # 상수들 (API URLs, 색상 코드 등)
│   │   │   ├── app_constants.dart
│   │   │   └── api_constants.dart
│   │   ├── /theme                  # 앱 테마 관련 파일들
│   │   │   ├── app_theme.dart      # 앱의 색상, 폰트, 스타일 설정
│   │   │   └── text_styles.dart    # 텍스트 스타일 설정
│   │   └── /utils                  # 유틸리티 함수들
│   │       ├── date_utils.dart     # 날짜 포맷
│   │       ├── validators.dart     # 검증 함수
│   │       └── image_utils.dart    # 이미지 처리
│   │
│   ├── /data                       # 데이터 레이어
│   │   ├── /models                 # 데이터 모델들
│   │   │   ├── post_model.dart
│   │   │   ├── user_model.dart
│   │   │   ├── comment_model.dart
│   │   │   └── story_model.dart
│   │   ├── /repositories           # 데이터 저장소 (비즈니스 로직)
│   │   │   ├── post_repository.dart
│   │   │   ├── user_repository.dart
│   │   │   └── auth_repository.dart
│   │   └── /services               # API 호출 및 외부 서비스
│   │       ├── api_service.dart
│   │       ├── auth_service.dart
│   │       └── storage_service.dart # 로컬 저장소
│   │
│   ├── /presentation               # UI 레이어
│   │   ├── /pages                  # 각 페이지들
│   │   │   ├── /home
│   │   │   │   └── home_page.dart
│   │   │   ├── /profile
│   │   │   │   ├── profile_page.dart
│   │   │   │   └── edit_profile_page.dart
│   │   │   ├── /explore
│   │   │   │   └── explore_page.dart
│   │   │   ├── /auth
│   │   │   │   ├── login_page.dart
│   │   │   │   └── signup_page.dart
│   │   │   ├── /post
│   │   │   │   ├── post_detail_page.dart
│   │   │   │   └── create_post_page.dart
│   │   │   ├── /reels
│   │   │   │   └── reels_page.dart
│   │   │   ├── /messages
│   │   │   │   ├── messages_page.dart
│   │   │   │   └── chat_page.dart
│   │   │   └── /notifications
│   │   │       └── notifications_page.dart
│   │   │
│   │   ├── /widgets                # 재사용 가능한 위젯들
│   │   │   ├── /common             # 공통 위젯
│   │   │   │   ├── custom_button.dart
│   │   │   │   ├── custom_text_field.dart
│   │   │   │   ├── loading_indicator.dart
│   │   │   │   └── custom_app_bar.dart
│   │   │   ├── /post               # 포스트 관련 위젯
│   │   │   │   ├── post_card.dart
│   │   │   │   ├── post_header.dart
│   │   │   │   ├── post_actions.dart
│   │   │   │   └── comment_widget.dart
│   │   │   ├── /story              # 스토리 관련 위젯
│   │   │   │   ├── story_circle.dart
│   │   │   │   └── story_list.dart
│   │   │   └── /navigation
│   │   │       ├── bottom_nav_bar.dart
│   │   │       └── sidebar.dart
│   │   │
│   │   └── /providers              # 상태 관리 (Provider/Riverpod)
│   │       ├── auth_provider.dart
│   │       ├── post_provider.dart
│   │       ├── user_provider.dart
│   │       └── theme_provider.dart
│   │
│   ├── /routes                     # 라우팅 관련
│   │   ├── app_routes.dart         # 라우트 정의
│   │   └── route_generator.dart    # 라우트 생성기
│   │
│   └── main.dart                   # 앱의 엔트리 파일
│
├── /assets                         # 정적 자원
│   ├── /images
│   │   ├── logo.png
│   │   └── placeholder.png
│   ├── /icons
│   └── /fonts
│
├── /test                           # 테스트 파일들
│   ├── /unit                       # 단위 테스트
│   ├── /widget                     # 위젯 테스트
│   └── /integration                # 통합 테스트
│
├── pubspec.yaml                    # 의존성 파일
├── analysis_options.yaml           # 린트 규칙
└── README.md                       # 프로젝트 설명 파일

--# fistagram
