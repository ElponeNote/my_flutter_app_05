import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/news/news_bloc.dart';
import '../bloc/news/news_event.dart';
import '../bloc/news/news_state.dart';
import '../../domain/usecases/get_news_usecase.dart';
import '../../data/repositories/news_repository.dart';
import '../../core/utils/dummy_data.dart';
import '../../data/repositories/news_repository_impl.dart';
import 'home/news_detail_page.dart';
import 'home/widgets/news_card.dart';
import 'home/widgets/search_bar_widget.dart';
import 'home/widgets/horizontal_news_list.dart';
import 'home/widgets/main_news_horizontal_list.dart';
import 'dart:async';
import 'dart:ui';
import 'profile/profile_header.dart';
import 'home/search_result_page.dart';

const List<String> _suggestedKeywords = [
  '주식', '날씨', '스포츠', '경제', '기술', '연예', '정치', '세계', '코로나', 'AI'
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool _searchActive = false;
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  List<News> _searchResults = [];
  List<String> _recentSearches = [];
  final NewsRepository newsRepository = NewsRepository();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }
    setState(() {
      _searchResults = newsRepository.getAllNews().where((news) {
        return news.title.toLowerCase().contains(query) ||
               news.summary.toLowerCase().contains(query) ||
               news.category.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _onSearchSubmitted(String value) {
    final keyword = value.trim();
    if (keyword.isEmpty) return;
    setState(() {
      _recentSearches.remove(keyword); // 중복 제거
      _recentSearches.insert(0, keyword);
      if (_recentSearches.length > 8) {
        _recentSearches = _recentSearches.sublist(0, 8);
      }
    });
    // 검색 결과 페이지로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultPage(query: keyword),
      ),
    );
  }

  void _activateSearch() {
    setState(() => _searchActive = true);
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) _searchFocusNode.requestFocus();
    });
  }

  void _deactivateSearch() {
    setState(() {
      _searchActive = false;
      _searchResults = [];
    });
    _searchController.clear();
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) _searchFocusNode.unfocus();
    });
  }

  void _searchByKeyword(String keyword) {
    _searchController.text = keyword;
    _onSearchChanged();
    _onSearchSubmitted(keyword);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _searchFocusNode.requestFocus();
    });
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
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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

  @override
  Widget build(BuildContext context) {
    // 카테고리별 섹션 변수화
    final mainNews = newsRepository.getAllNews().where((n) => n.category == NewsCategory.main).toList();
    final economyNews = newsRepository.getAllNews().where((n) => n.category == NewsCategory.economy).toList();
    final sportsNews = newsRepository.getAllNews().where((n) => n.category == NewsCategory.sports).toList();
    final techNews = newsRepository.getAllNews().where((n) => n.category == NewsCategory.tech).toList();
    final entertainmentNews = newsRepository.getAllNews().where((n) => n.category == NewsCategory.entertainment).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileHeader(imageRadius: 24),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '뉴스 피드',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'www.skoolkorea.com',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 80),
              Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                    minWidth: 0,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 18),
                        if (!_searchActive) ...[
                          HorizontalNewsList(
                            sectionTitle: 'AI 추천 뉴스',
                            newsList: newsRepository.getAINews(),
                          ),
                          MainNewsHorizontalList(
                            sectionTitle: '주요 뉴스',
                            newsList: mainNews,
                          ),
                          buildSection('경제', economyNews),
                          buildSection('스포츠', sportsNews),
                          buildSection('기술', techNews),
                          buildSection('엔터테인먼트', entertainmentNews),
                        ],
                        if (_searchActive)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: _searchController.text.isEmpty
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (_recentSearches.isNotEmpty) ...[
                                        const Text('최근 검색어', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: _recentSearches
                                              .map((keyword) => ActionChip(
                                                    label: Text(keyword),
                                                    onPressed: () => _searchByKeyword(keyword),
                                                  ))
                                              .toList(),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                      const Text('추천 검색어', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: _suggestedKeywords
                                            .map((keyword) => ActionChip(
                                                  label: Text(keyword),
                                                  onPressed: () => _searchByKeyword(keyword),
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  )
                                : _searchResults.isEmpty
                                    ? const Text(
                                        '검색 결과가 없습니다.',
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      )
                                    : Column(
                                        children: _searchResults
                                            .map((news) => NewsCard(
                                                  news: news,
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) => NewsDetailPage(news: news),
                                                      ),
                                                    );
                                                  },
                                                ))
                                            .toList(),
                                      ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_searchActive)
            Positioned.fill(
              child: GestureDetector(
                onTap: _deactivateSearch,
                child: AnimatedOpacity(
                  opacity: _searchActive ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOutCubic,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: _buildSearchBar(expanded: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar({bool expanded = false}) {
    return AnimatedAlign(
      alignment: _searchActive ? Alignment.topCenter : Alignment.topLeft,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutBack,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutBack,
        width: _searchActive ? MediaQuery.of(context).size.width * 0.92 : MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: _searchActive
            ? Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                elevation: 4,
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '무엇을 찾고 계신가요?',
                        ),
                        style: const TextStyle(
                          color: Colors.black, // 글자색을 검정으로 고정
                        ),
                        onSubmitted: _onSearchSubmitted,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _deactivateSearch,
                    ),
                  ],
                ),
              )
            : SearchBarWidget(onTap: _activateSearch),
      ),
    );
  }
}