# PRD (Product Requirements Document)
# 뉴스 피드 iOS 앱

## Project Overview (프로젝트 요약)

### 프로젝트 명
뉴스 피드 iOS 앱

### 프로젝트 목적
사용자에게 다양한 뉴스와 관심사 콘텐츠를 제공하는 개인화된 뉴스 피드 앱을 개발합니다. Flutter 환경에서 iOS 네이티브 앱으로 구현하여 직관적이고 사용하기 쉬운 인터페이스를 통해 뉴스 소비 경험을 향상시키는 것이 목표입니다.

### 타겟 사용자
- 일상적으로 뉴스와 정보를 소비하는 사용자
- 모바일에서 빠르고 편리하게 뉴스를 확인하고 싶은 사용자
- 카테고리별로 정리된 뉴스 콘텐츠를 선호하는 사용자

### 주요 가치 제안
- 섹션별로 체계적으로 정리된 뉴스 피드
- 직관적인 검색 기능
- 카테고리별 탭 구성으로 효율적인 정보 접근
- 시각적으로 매력적인 이미지와 텍스트 레이아웃

---

## Core Functionalities (핵심 기능)

### 1. 홈 피드 (Home Feed)
- 더미 데이터 기반 뉴스 기사 표시 (Unsplash API 이미지 포함)
- 카테고리별(주요, 경제, 스포츠, 기술, 엔터테인먼트 등) 섹션 구분
- 각 섹션별 3~5개 뉴스 아이템, 섹션 헤더 표시
- 카드형 뉴스 아이템, 세로 스크롤, 반응형 레이아웃

### 2. 검색 기능 (Search)
- 상단 고정 검색창, 플레이스홀더/아이콘 포함
- 검색창 터치 시 전용 검색 화면 전환, 키보드 자동 활성화
- 검색 기록/추천어(선택), 결과 없을 시 안내 메시지
- 카테고리별 필터링 지원

### 3. 탭 메뉴 (Tab Navigation)
- 하단 고정 탭 바(뉴스/날씨/MY)
- 각 탭별 대표 아이콘, 라벨, 하이라이트 효과
- 뉴스: 전체 피드, 날씨: 위치 기반 날씨(더미/간단 API), MY: 개인화 설정/앱 정보

---

## Technical Requirements (기술 요구사항)

- **개발 프레임워크:** Flutter (Dart)
- **타겟 플랫폼:** iOS (최소 12.0)
- **외부 API:** Unsplash(이미지), 날씨 API(선택)
- **데이터:** 더미 데이터, 로컬 저장소(shared_preferences), 이미지/뉴스 캐싱
- **상태 관리:** provider, bloc, 또는 riverpod (권장: riverpod)
- **네비게이션:** go_router 등
- **테스트:** 단위 테스트, 위젯 테스트, 통합 테스트
- **품질 관리:** 코드 리뷰, 자동화된 빌드/테스트 파이프라인

---

## UI/UX Requirements (UI/UX 요구사항)

- **디자인:** 깔끔/모던, 중성적 색상(화이트/그레이/블루), 시스템 폰트, Material/SF Symbols 아이콘
- **경험:** 탭 기반 구조, 빠른 로딩, 반응형, 접근성(텍스트 크기/대비 등)
- **디자인 가이드:**
  - 기본 색상: #FFFFFF(배경), #F5F5F5(카드), #2196F3(포인트), #333333(텍스트)
  - 폰트: SF Pro, 시스템 폰트
  - 아이콘: Material Icons, SF Symbols
  - 카드형 뉴스 아이템, 섹션 헤더 스타일 명확화

---

## 작업 체크리스트

- [ ] 1. 프로젝트 기본 구조 세팅 (폴더/파일 생성)
- [ ] 2. 다크/라이트 테마 및 디자인 가이드라인 적용
- [ ] 3. 홈 피드 UI 및 더미 데이터 표시
- [ ] 4. 무한 스크롤(페이징) 기능 구현
- [ ] 5. 검색 기능 UI 및 로직 구현
- [ ] 6. 하단 탭 네비게이션 구현
- [ ] 7. 날씨 탭 및 API 연동(더미/실제)
- [ ] 8. MY 탭(개인화/설정) 구현
- [ ] 9. 상태 관리(Riverpod) 적용
- [ ] 10. 라우팅(go_router) 적용
- [ ] 11. 단위/위젯/통합 테스트 작성
- [ ] 12. 코드/구조 정리 및 주석 추가
- [ ] 13. 문서화(README, PRD 등)

---

## Doc (참고 문서)

- [Flutter 공식 문서](https://flutter.dev/docs)
- [Flutter iOS 배포 가이드](https://flutter.dev/docs/deployment/ios)
- [Material Design 가이드라인](https://material.io/design)
- [Unsplash API 문서](https://unsplash.com/developers)
- [OpenWeatherMap API](https://openweathermap.org/api)
- iOS Human Interface Guidelines
- 주요 패키지: http, cached_network_image, shared_preferences, riverpod, go_router

---

## Success Metrics (성공 지표)

- 모든 핵심 기능 정상 동작
- Unsplash API 연동
- 앱스토어 배포 준비
- 홈 피드 3초 이내 로딩, 검색 1초 이내 응답
- 크래시 없는 동작, 클린 코드, 재사용 가능한 구조
- 테스트 커버리지 80% 이상

---

## Current File Structure (예시)

```
lib/
  main.dart
  models/
    news.dart
    weather.dart
  screens/
    home_screen.dart
    search_screen.dart
    weather_screen.dart
    my_screen.dart
  widgets/
    news_card.dart
    section_header.dart
    bottom_nav_bar.dart
  services/
    news_service.dart
    weather_service.dart
  utils/
    dummy_data.dart
  theme/
    app_theme.dart
pubspec.yaml
README.md
require/PRD.md
```

---

## 유지보수/자동화/데이터 검증 규칙

- 더미 데이터/이미지/날씨 API 변경 시 PRD.md와 README.md에 내역 기록
- 주요 API/패키지 버전 업데이트 시 문서화
- 디자인/구조/상태 관리 변경 시 변경점 명확히 기록
- 자동화 스크립트/테스트 추가 시 문서화
