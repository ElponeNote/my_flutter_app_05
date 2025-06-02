import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../core/utils/dummy_data.dart';
import 'widgets/main_news_horizontal_list.dart';
import 'widgets/news_card.dart';
import 'news_detail_page.dart';
import '../../bloc/news/search_bloc.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/horizontal_news_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchActive = false;
  List<String> recentKeywords = [];
  final List<String> suggestedKeywords = ['경제', '스포츠', '기술', '엔터테인먼트', '주요 뉴스'];

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchActive = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Widget _buildSearchBar({bool expanded = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
      width: expanded ? MediaQuery.of(context).size.width * 0.92 : double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        decoration: InputDecoration(
          hintText: '검색',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
        style: const TextStyle(color: Colors.black),
        onChanged: (value) {
          context.read<SearchBloc>().add(SearchQueryChanged(value));
        },
        onSubmitted: (value) {
          if (value.trim().isNotEmpty && !recentKeywords.contains(value.trim())) {
            setState(() {
              recentKeywords.insert(0, value.trim());
              if (recentKeywords.length > 5) recentKeywords.removeLast();
            });
          }
          _searchFocusNode.unfocus();
        },
      ),
    );
  }

  Widget _buildKeywordTags(List<String> keywords, {void Function(String)? onTap}) {
    return Wrap(
      spacing: 8,
      children: keywords.map((keyword) {
        return ActionChip(
          label: Text(keyword),
          onPressed: onTap != null ? () => onTap(keyword) : null,
          backgroundColor: Colors.grey[200],
          labelStyle: const TextStyle(color: Colors.black),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 오버레이가 뜨면 자동으로 포커스
    if (_isSearchActive && !_searchFocusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _searchFocusNode.requestFocus();
      });
    }
    final mainNews = dummyNewsList.where((n) => n.category == NewsCategory.main).toList();
    final economyNews = dummyNewsList.where((n) => n.category == NewsCategory.economy).toList();
    final sportsNews = dummyNewsList.where((n) => n.category == NewsCategory.sports).toList();
    final techNews = dummyNewsList.where((n) => n.category == NewsCategory.tech).toList();
    final entertainmentNews = dummyNewsList.where((n) => n.category == NewsCategory.entertainment).toList();
    return BlocProvider(
      create: (_) => SearchBloc(dummyNewsList),
      child: Scaffold(
        backgroundColor: const Color(0xFF101014),
        body: Stack(
          children: [
            // 1. 검색 비활성화 시: 기존 뉴스 피드
            if (!_isSearchActive)
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                children: [
                  Center(
                    child: Text(
                      '뉴스 피드',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.white,
                          ) ?? const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // 플레이스홀더 검색창 (SearchBarWidget)
                  SearchBarWidget(
                    onTap: () => _searchFocusNode.requestFocus(),
                  ),
                  const SizedBox(height: 32),
                  const SizedBox(height: 8),
                  MainNewsHorizontalList(
                    sectionTitle: '주요 뉴스',
                    newsList: mainNews,
                  ),
                  HorizontalNewsList(
                    sectionTitle: 'AI 추천 뉴스',
                    newsList: mainNews, // 실제 AI 추천 리스트로 교체 필요
                  ),
                  buildSection('경제', economyNews),
                  buildSection('스포츠', sportsNews),
                  buildSection('기술', techNews),
                  buildSection('엔터테인먼트', entertainmentNews),
                ],
              ),
            // 2. 검색 활성화 시: 오버레이 + Center(검색창, 키워드, BlocBuilder)
            if (_isSearchActive) ...[
              // 1) 오버레이(블러+어두운 배경)만 GestureDetector로 감쌈
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _searchFocusNode.unfocus(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    ),
                  ),
                ),
              ),
              // 2) Center(검색창/키워드/BlocBuilder)는 GestureDetector 바깥에 위치
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 600,
                    minWidth: 0,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSearchBar(expanded: true),
                      const SizedBox(height: 18),
                      if (recentKeywords.isNotEmpty) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('최근 검색어', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                        const SizedBox(height: 8),
                        _buildKeywordTags(recentKeywords, onTap: (kw) {
                          _searchController.text = kw;
                          context.read<SearchBloc>().add(SearchQueryChanged(kw));
                          _searchFocusNode.unfocus();
                        }),
                        const SizedBox(height: 18),
                      ],
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('추천 키워드', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      const SizedBox(height: 8),
                      _buildKeywordTags(suggestedKeywords, onTap: (kw) {
                        _searchController.text = kw;
                        context.read<SearchBloc>().add(SearchQueryChanged(kw));
                        _searchFocusNode.unfocus();
                      }),
                      const SizedBox(height: 24),
                      // 검색 결과 리스트
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: BlocBuilder<SearchBloc, SearchState>(
                          builder: (context, state) {
                            if (state is SearchInitial) {
                              return Center(child: Text('검색어를 입력하세요.', style: TextStyle(color: Colors.grey[300], fontSize: 16)));
                            } else if (state is SearchLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is SearchLoaded) {
                              return ListView(
                                children: state.results.map((news) => NewsCard(
                                  news: news,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => NewsDetailPage(news: news),
                                      ),
                                    );
                                  },
                                )).toList(),
                              );
                            } else if (state is SearchEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 40),
                                  Lottie.asset(
                                    'assets/lottie/empty.json',
                                    width: 180,
                                    repeat: false,
                                  ),
                                  const SizedBox(height: 24),
                                  Text('검색 결과가 없습니다', style: TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600)),
                                ],
                              );
                            } else if (state is SearchError) {
                              return Center(child: Text('에러: \\${state.message}', style: TextStyle(color: Colors.red[200])));
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, List<News> newsList) {
    if (newsList.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ) ?? const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ...newsList.map((news) => NewsCard(
              news: news,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewsDetailPage(news: news),
                  ),
                );
              },
            )),
      ],
    );
  }
} 