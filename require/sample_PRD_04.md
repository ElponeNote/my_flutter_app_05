# Project Overview (프로젝트 요약)

**프로젝트 이름**: 음악 플레이어 앱 (Flutter Cupertino 위젯 활용)

**목표**: 사용자가 YouTube Music과 유사한 UI를 iOS 스타일로 재해석, 음악을 탐색, 재생, 관리할 수 있는 모바일 앱을 구축합니다. 직관적인 UX와 세련된 UI를 제공하며, 사용자 경험을 강화하기 위해 Cupertino 위젯을 적극 활용합니다.

# Core functionalities (핵심 기능)

1. **홈 화면**
   - 인기 플레이리스트, 추천 플레이리스트, 장르별 분류(운동, 에너지 충전, 팟캐스트 등) 제공
   - 현재 재생 중인 음악을 화면 하단에 미니 플레이어로 표시

2. **음악 재생 화면**
   - 커버 이미지, 아티스트 정보, 좋아요 버튼, 다음/이전 트랙 버튼 제공
   - 재생 시간 표시 및 사용자 상호작용을 위한 플레이어 기능 (일시정지, 재생, 반복 및 셔플 버튼 포함)
   - Cupertino 슬라이더로 재생 위치 조절 기능 구현

3. **하단 네비게이션 바**
   - 홈, 샘플, 둘러보기, 보관함의 네 가지 주요 메뉴 제공
   - 각 메뉴는 Cupertino Icons로 표현하고, 선택된 아이콘은 Cupertino 스타일로 강조 (홈을 제외한 나머지는 버튼만 구현하고 간단한 화면만 구현)

4. **음악 재생 구현**
   - YouTube URL을 활용하여 간단한 음악 재생 기능 구현

# Doc (참고 문서)

- [Flutter Cupertino 공식 문서](https://docs.flutter.dev/ui/cupertino)
- [youtube_player_flutter 패키지](https://pub.dev/packages/youtube_player_flutter)
- [Provider 패키지](https://pub.dev/packages/provider)
- [애플 iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/overview/themes/)

# Current file structure (현재 파일 구조)

```
lib/
  main.dart
  models/
    music.dart
    playlist.dart
  viewmodels/
    music_list_viewmodel.dart
    player_viewmodel.dart
  views/
    home_page.dart
    mini_player.dart
    player_page.dart
    sample_page.dart
    explore_page.dart
    library_page.dart
  widgets/
    music_tile.dart
    cupertino_bottom_nav.dart
  resources/
    (테마, 컬러, 샘플 데이터 등)
frontend.md
README.md
require/PRD.md

## 유지보수/자동화/데이터 검증 (2024-06-10~)
- sample_data.dart 곡 데이터 변경 시 파이썬 스크립트로 앨범아트 자동 동기화
- 곡별 유튜브 영상/썸네일이 실제로 재생 가능한지 주기적 검증
- 영상이 차단/삭제/비공개 등으로 재생 불가 시 최신 인기곡(예: 아이유 최신곡 등)으로 즉시 대체
- 곡별 albumArtUrl은 유튜브 썸네일(hqdefault.jpg)로 통일, 공식 MV 기준으로 관리
- PRD.md와 README.md에 모든 유지보수/자동화/데이터 변경 내역을 반드시 기록
- 예시: 2024-06-10 아이유 최신곡(Shopper, Love wins all, 에잇, Blueming) 반영, Smart/Magnetic 등 영상 미노출 곡 공식 MV로 교체
