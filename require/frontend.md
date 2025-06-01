# Frontend Development Guide
# 뉴스 피드 iOS 앱 - Flutter 구현

## Progress (진행 상황)

- [x] Phase 1: Core Structure (1-2주)
  - [x] 프로젝트 설정 및 의존성 추가 (완료)
  - [ ] Clean Architecture 구조 설정
  - [ ] BLoC 패턴 구현 기반
- [ ] Phase 2: UI Implementation (2-3주)
  - [ ] 홈 피드 화면 구현
  - [ ] 검색 기능 구현
  - [ ] 탭 네비게이션 구현
- [ ] Phase 3: API Integration (1-2주)
  - [ ] Unsplash API 연동
  - [ ] 더미 데이터 서비스 구현
  - [ ] 날씨 API 연동
- [ ] Phase 4: Testing & Optimization (1-2주)
  - [ ] 단위 테스트 작성
  - [ ] 위젯 테스트 구현
  - [ ] 성능 최적화
- [ ] Phase 5: Deployment (1주)
  - [ ] iOS 설정 완료
  - [ ] 앱스토어 제출 준비
  - [ ] 문서화 완료

---

## Architecture Overview (아키텍처 개요)

### Clean Architecture + BLoC Pattern
Clean Architecture와 BLoC 패턴을 결합하여 관심사 분리와 유지보수성을 확보하고, 비즈니스 로직과 UI 컴포넌트를 명확히 분리합니다.

```
├── presentation/          # UI Layer
│   ├── pages/            # 화면별 페이지
│   ├── widgets/          # 재사용 가능한 위젯
│   └── bloc/             # BLoC 상태 관리
├── domain/               # Business Logic Layer
│   ├── entities/         # 핵심 데이터 모델
│   ├── repositories/     # 추상 레포지토리
│   └── usecases/         # 비즈니스 로직
├── data/                 # Data Layer
│   ├── models/           # 데이터 모델
│   ├── repositories/     # 구체적 레포지토리 구현
│   └── datasources/      # API 및 로컬 데이터
└── core/                 # 공통 유틸리티
    ├── constants/        # 상수
    ├── utils/           # 헬퍼 함수
    └── errors/          # 에러 처리
```

### State Management Strategy
Flutter Provider는 2025년에도 신뢰할 수 있는 상태 관리 솔루션으로 간단함과 다양성으로 인정받고 있으며, BLoC 패턴은 반응형 프로그래밍 원칙에 따라 스트림을 사용하여 애플리케이션 상태를 관리합니다.

**선택된 상태 관리: Flutter BLoC**
- 복잡한 상태 로직에 적합
- 테스트 용이성
- 명확한 데이터 플로우
- 확장성과 유지보수성

## Project Structure (프로젝트 구조)

### Core Dependencies (핵심 의존성)
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  
  # Network & API
  http: ^1.1.0
  dio: ^5.3.2
  
  # Image Handling
  cached_network_image: ^3.3.0
  
  # Local Storage
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # UI & Design
  google_fonts: ^6.1.0
  shimmer: ^3.0.0
  
  # Utilities
  intl: ^0.18.1
  connectivity_plus: ^5.0.1
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.4
  mockito: ^5.4.2
  build_runner: ^2.4.7
```

### Folder Structure (폴더 구조)
```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── api_constants.dart
│   │   └── ui_constants.dart
│   ├── errors/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── utils/
│   │   ├── date_utils.dart
│   │   ├── image_utils.dart
│   │   └── network_utils.dart
│   └── theme/
│       └── app_theme.dart
├── data/
│   ├── datasources/
│   │   ├── news_remote_datasource.dart
│   │   ├── weather_remote_datasource.dart
│   │   └── local_datasource.dart
│   ├── models/
│   │   ├── news_model.dart
│   │   ├── weather_model.dart
│   │   └── user_preferences_model.dart
│   └── repositories/
│       ├── news_repository_impl.dart
│       ├── weather_repository_impl.dart
│       └── user_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── news.dart
│   │   ├── weather.dart
│   │   └── user_preferences.dart
│   ├── repositories/
│   │   ├── news_repository.dart
│   │   ├── weather_repository.dart
│   │   └── user_repository.dart
│   └── usecases/
│       ├── get_news_usecase.dart
│       ├── search_news_usecase.dart
│       ├── get_weather_usecase.dart
│       └── manage_preferences_usecase.dart
├── presentation/
│   ├── bloc/
│   │   ├── news/
│   │   │   ├── news_bloc.dart
│   │   │   ├── news_event.dart
│   │   │   └── news_state.dart
│   │   ├── search/
│   │   │   ├── search_bloc.dart
│   │   │   ├── search_event.dart
│   │   │   └── search_state.dart
│   │   ├── weather/
│   │   │   ├── weather_bloc.dart
│   │   │   ├── weather_event.dart
│   │   │   └── weather_state.dart
│   │   └── navigation/
│   │       ├── navigation_bloc.dart
│   │       ├── navigation_event.dart
│   │       └── navigation_state.dart
│   ├── pages/
│   │   ├── home/
│   │   │   ├── home_page.dart
│   │   │   └── widgets/
│   │   │       ├── news_section.dart
│   │   │       ├── news_card.dart
│   │   │       └── search_bar.dart
│   │   ├── search/
│   │   │   ├── search_page.dart
│   │   │   └── widgets/
│   │   │       ├── search_results.dart
│   │   │       └── search_suggestions.dart
│   │   ├── weather/
│   │   │   ├── weather_page.dart
│   │   │   └── widgets/
│   │   │       ├── weather_card.dart
│   │   │       └── weather_details.dart
│   │   └── profile/
│   │       ├── profile_page.dart
│   │       └── widgets/
│   │           ├── preference_settings.dart
│   │           └── app_settings.dart
│   ├── widgets/
│   │   ├── common/
│   │   │   ├── custom_app_bar.dart
│   │   │   ├── loading_widget.dart
│   │   │   ├── error_widget.dart
│   │   │   └── empty_state_widget.dart
│   │   ├── navigation/
│   │   │   └── bottom_nav_bar.dart
│   │   └── images/
│   │       └── cached_image_widget.dart
│   └── theme/
│       ├── colors.dart
│       ├── text_styles.dart
│       └── dimensions.dart
└── injection_container.dart
```

## Best Practices Implementation (모범 사례 구현)

### 1. Widget Optimization
Flutter 모범 사례는 코드를 더 결정적으로 보이게 하여 하드코딩된 값이 없기 때문에 unit test를 더 쉽게 만들고, 코드를 위젯으로 리팩토링하는 것이 최선의 옵션입니다.

```dart
// Good: 재사용 가능한 위젯 구성
class NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback? onTap;
  
  const NewsCard({
    Key? key,
    required this.news,
    this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImageWidget(imageUrl: news.imageUrl),
            Padding(
              padding: EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    news.summary,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2. Performance Optimization
Flutter는 위젯을 배치할 때 하나의 레이아웃 패스만 거쳐야 하며, 리소스 사용을 최소화하고 최상의 품질로 최소 크기를 사용하여 로딩 시간을 줄이고 속도와 효율성을 위해 코드를 최적화해야 합니다.

```dart
// 이미지 최적화
class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  
  const CachedImageWidget({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: Icon(Icons.error),
      ),
      memCacheWidth: width?.toInt(),
      memCacheHeight: height?.toInt(),
    );
  }
}
```

### 3. State Management with BLoC
Flutter Bloc은 BLoC(Business Logic Component) 패턴을 사용하여 애플리케이션의 상태를 관리하고 구성하는 데 도움이 되는 상태 관리 라이브러리로, 비즈니스 로직을 UI 컴포넌트와 분리합니다.

```dart
// News BLoC 구현 예시
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNewsUseCase;
  final SearchNewsUseCase searchNewsUseCase;
  
  NewsBloc({
    required this.getNewsUseCase,
    required this.searchNewsUseCase,
  }) : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
    on<RefreshNews>(_onRefreshNews);
    on<LoadMoreNews>(_onLoadMoreNews);
  }
  
  Future<void> _onLoadNews(
    LoadNews event,
    Emitter<NewsState> emit,
  ) async {
    try {
      emit(NewsLoading());
      final news = await getNewsUseCase(event.category);
      emit(NewsLoaded(news: news));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }
  
  // 기타 이벤트 핸들러들...
}
```

## UI/UX Implementation (UI/UX 구현)

### Design System
```dart
// 테마 설정
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.robotoTextTheme(),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        margin: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

// 컬러 팔레트
class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFB00020);
  
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
}
```

### Responsive Design
```dart
// 반응형 레이아웃 유틸리티
class ResponsiveHelper {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  static bool isMobile(BuildContext context) {
    return getScreenWidth(context) < 768;
  }
  
  static bool isTablet(BuildContext context) {
    final width = getScreenWidth(context);
    return width >= 768 && width < 1024;
  }
  
  static int getCrossAxisCount(BuildContext context) {
    if (isTablet(context)) return 2;
    return 1;
  }
}
```

## API Integration (API 통합)

### Unsplash API Implementation
```dart
class UnsplashService {
  static const String baseUrl = 'https://api.unsplash.com';
  static const String accessKey = 'YOUR_ACCESS_KEY';
  
  final Dio _dio = Dio();
  
  Future<String> getRandomNewsImage({String? query}) async {
    try {
      final response = await _dio.get(
        '$baseUrl/photos/random',
        queryParameters: {
          'client_id': accessKey,
          'query': query ?? 'news',
          'orientation': 'landscape',
          'w': 400,
          'h': 250,
        },
      );
      
      return response.data['urls']['regular'];
    } catch (e) {
      return 'https://via.placeholder.com/400x250?text=News';
    }
  }
}
```

### News Data Service
```dart
class NewsService {
  // 더미 뉴스 데이터 생성
  static List<News> generateDummyNews() {
    return [
      News(
        id: '1',
        title: '경제 뉴스: 새로운 경제 정책 발표',
        summary: '정부가 새로운 경제 활성화 정책을 발표했습니다...',
        category: NewsCategory.economy,
        publishedAt: DateTime.now().subtract(Duration(hours: 2)),
        imageUrl: 'https://source.unsplash.com/400x250/?economy',
      ),
      // 더 많은 더미 데이터...
    ];
  }
}
```

## Testing Strategy (테스트 전략)

### Unit Tests
```dart
// BLoC 테스트 예시
void main() {
  group('NewsBloc', () {
    late NewsBloc newsBloc;
    late MockGetNewsUseCase mockGetNewsUseCase;
    
    setUp(() {
      mockGetNewsUseCase = MockGetNewsUseCase();
      newsBloc = NewsBloc(getNewsUseCase: mockGetNewsUseCase);
    });
    
    blocTest<NewsBloc, NewsState>(
      'emits [NewsLoading, NewsLoaded] when LoadNews is added',
      build: () {
        when(mockGetNewsUseCase(any))
            .thenAnswer((_) async => [testNews]);
        return newsBloc;
      },
      act: (bloc) => bloc.add(LoadNews()),
      expect: () => [
        NewsLoading(),
        NewsLoaded(news: [testNews]),
      ],
    );
  });
}
```

### Widget Tests
```dart
void main() {
  group('NewsCard Widget', () {
    testWidgets('displays news information correctly', (tester) async {
      final testNews = News(
        id: '1',
        title: 'Test Title',
        summary: 'Test Summary',
        category: NewsCategory.general,
        publishedAt: DateTime.now(),
        imageUrl: 'test_url',
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NewsCard(news: testNews),
          ),
        ),
      );
      
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Summary'), findsOneWidget);
    });
  });
}
```

## Performance Considerations (성능 고려사항)

### Memory Management
- 이미지 캐싱 최적화
- 위젯 트리 최소화
- 불필요한 rebuild 방지

### Network Optimization
- HTTP 요청 최적화
- 연결성 체크
- 오프라인 지원

### Battery Optimization
- 백그라운드 작업 최소화
- 적절한 폴링 간격
- 에너지 효율적인 애니메이션

## Deployment Preparation (배포 준비)

### iOS Configuration
```yaml
# ios/Runner/Info.plist
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>

<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to provide weather information.</string>
```

### Build Commands
```bash
# 개발 빌드
flutter run --flavor dev -t lib/main_dev.dart

# 프로덕션 빌드
flutter build ios --release --flavor prod -t lib/main_prod.dart

# 앱스토어 업로드용 빌드
flutter build ipa --release --flavor prod -t lib/main_prod.dart
```

## Development Roadmap (개발 로드맵)

### Phase 1: Core Structure (1-2주)
- 프로젝트 설정 및 의존성 추가
- Clean Architecture 구조 설정
- BLoC 패턴 구현 기반

### Phase 2: UI Implementation (2-3주)
- 홈 피드 화면 구현
- 검색 기능 구현
- 탭 네비게이션 구현

### Phase 3: API Integration (1-2주)
- Unsplash API 연동
- 더미 데이터 서비스 구현
- 날씨 API 연동

### Phase 4: Testing & Optimization (1-2주)
- 단위 테스트 작성
- 위젯 테스트 구현
- 성능 최적화

### Phase 5: Deployment (1주)
- iOS 설정 완료
- 앱스토어 제출 준비
- 문서화 완료

이 Frontend 개발 가이드를 통해 체계적이고 확장 가능한 뉴스 앱을 구현할 수 있습니다. 각 단계별로 모범 사례를 적용하여 고품질의 iOS 앱을 완성하시기 바랍니다.
