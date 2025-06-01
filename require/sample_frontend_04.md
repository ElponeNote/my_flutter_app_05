# project-overview (프로젝트 개요)

- YouTube Music 스타일을 iOS(Cupertino) 디자인으로 재해석한 음악 플레이어 앱
- 사용자는 음악을 탐색, 재생, 관리할 수 있으며, 직관적인 UX와 세련된 UI를 경험
- Cupertino 위젯을 적극 활용하여 iOS 네이티브와 유사한 사용자 경험 제공
- MVVM 패턴과 Provider 상태관리 적용
- 최종 구현 화면: 1. 메인화면, 2. 재생화면

# feature-requirements (기능 요구사항)

1. **홈 화면**
   - 상단: 카테고리(운동, 에너지 충전, 팟캐스트 등) 버튼 (가로 스크롤)
   - 중단: 인기/추천 플레이리스트(카드형, 가로 스크롤)
   - 하단: 미니 플레이어(현재 재생 곡, 재생/일시정지)
   - 하단 네비게이션: 홈, 샘플, 둘러보기, 보관함 (CupertinoTabBar)

2. **음악 재생 화면**
   - 앨범 커버(큰 이미지), 곡 제목, 아티스트명
   - 좋아요, 저장, 공유 버튼
   - 재생/일시정지, 이전/다음, 반복, 셔플 버튼
   - Cupertino 슬라이더(진행 바), 재생 시간 표시
   - 가사, 다음 트랙, 관련 항목 등 탭

3. **음악 재생 기능**
   - YouTube URL을 활용한 음악 재생 (youtube_player_flutter)
   - 슬라이더/시간 연동, seek 동작

4. **기타**
   - 각 탭(샘플, 둘러보기, 보관함)은 간단한 화면만 구현

# relevant-codes (관련 코드)

- CupertinoApp, CupertinoPageScaffold, CupertinoNavigationBar, CupertinoButton, CupertinoTabBar 등
- Provider 상태관리
- youtube_player_flutter 패키지로 유튜브 음악 재생
- MVVM 패턴 적용 (models, viewmodels, views, widgets)

# Current-file-instruction (현재 파일 구조)

```
lib/
  main.dart
  models/
    music.dart           # 음악 데이터 모델
    playlist.dart        # 플레이리스트 데이터 모델
  viewmodels/
    music_list_viewmodel.dart   # 음악 리스트 상태 관리
    player_viewmodel.dart       # 재생 상태 및 컨트롤 관리
  views/
    home_page.dart      # 홈(메인) 화면
    mini_player.dart    # 하단 미니 플레이어
    player_page.dart    # 음악 재생 화면
    sample_page.dart    # 샘플 탭 화면
    explore_page.dart   # 둘러보기 탭 화면
    library_page.dart   # 보관함 탭 화면
  widgets/
    music_tile.dart           # 음악 리스트 아이템 위젯
    playlist_card.dart        # 플레이리스트 카드 위젯
    cupertino_bottom_nav.dart # 하단 네비게이션 바 위젯
  resources/
    colors.dart         # 컬러 팔레트
    themes.dart         # 테마 설정
    sample_data.dart    # 샘플 데이터
require/
  PRD.md
  frontend.md
README.md
```

# 작업 진행 상황 (Progress)

- [x] 1. 폴더/파일 구조 생성 (완료)
- [x] 2. 데이터 및 모델 정의 (완료)
- [x] 3. MVVM 및 Provider 세팅 (완료)
- [x] 4. UI 구현 (홈화면 1차, 기본 구조 및 주요 위젯 완료)
- [ ] 5. YouTube 음악 재생 연동
- [ ] 6. 추가 기능 및 UX 개선

---

# rules (규칙)

- 모든 UI는 Cupertino 위젯을 우선 사용한다.
- iOS 디자인 가이드라인(여백, 폰트, 컬러톤, 정렬 등)을 최대한 준수한다.
- MVVM 패턴을 적용하여 코드 구조를 명확히 한다.
- Provider로 상태관리를 일관성 있게 적용한다.
- 실제 음악 재생은 YouTube URL 기반으로 구현한다.
- 샘플/둘러보기/보관함 탭은 간단한 화면만 구현한다.
- 코드, UI, UX의 일관성과 가독성을 항상 유지한다. 