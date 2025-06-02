import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/news/news_bloc.dart';
import '../bloc/news/news_event.dart';
import '../bloc/news/news_state.dart';
import '../../domain/usecases/get_news_usecase.dart';
import '../../core/utils/dummy_data.dart' as dummy;
import '../../data/models/news.dart';
import '../../data/repositories/news_repository_impl.dart';
import 'home/news_detail_page.dart';
import 'home/widgets/news_card.dart';
import 'home/widgets/search_bar_widget.dart';
import 'home/widgets/horizontal_news_list.dart';
import 'home/widgets/main_news_horizontal_list.dart';
import 'dart:async';
import 'dart:ui';

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
  List<dummy.News> _searchResults = [];
  List<String> _recentSearches = [];

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
      _searchResults = dummy.dummyNewsList.where((news) {
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

  Widget buildSection(String title, List<dummy.News> newsList) {
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
    return BlocProvider(
      create: (_) => NewsBloc(getNewsUseCase: GetNewsUseCase())..add(LoadNews()),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '뉴스 피드',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'www.skoolkorea.com',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              final newsList = state.newsList;
              return Stack(
                children: [
                  ListView(
                    children: [
                      const SizedBox(height: 13),
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
                                _buildSearchBar(expanded: true),
                                const SizedBox(height: 18),
                                if (!_searchActive) ...[
                                  HorizontalNewsList(
                                    sectionTitle: 'AI 추천 뉴스',
                                    newsList: dummy.aiRecommendedNewsList,
                                  ),
                                  MainNewsHorizontalList(
                                    sectionTitle: '주요 뉴스',
                                    newsList: dummy.dummyNewsList.where((n) => n.category.name == 'main').toList(),
                                  ),
                                  buildSection('경제', dummy.dummyNewsList.where((n) => n.category.name == 'economy').toList()),
                                  buildSection('스포츠', dummy.dummyNewsList.where((n) => n.category.name == 'sports').toList()),
                                  buildSection('기술', dummy.dummyNewsList.where((n) => n.category.name == 'tech').toList()),
                                  buildSection('엔터테인먼트', dummy.dummyNewsList.where((n) => n.category.name == 'entertainment').toList()),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text('실시간 뉴스', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  FutureBuilder<List<News>>(
                                    future: NewsRepositoryImpl().fetchNews(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(child: Text('에러 발생: [36m${snapshot.error}[0m'));
                                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                        return const Center(child: Text('뉴스가 없습니다'));
                                      }
                                      final newsList = snapshot.data!;
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: newsList.length,
                                        itemBuilder: (context, index) {
                                          final news = newsList[index];
                                          return NewsCard(
                                            news: news,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => NewsDetailPage(news: news),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
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
                    GestureDetector(
                      onTap: _deactivateSearch,
                      child: AnimatedOpacity(
                        opacity: _searchActive ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOutCubic,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            color: Colors.black.withAlpha((0.3 * 255).toInt()),
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            } else if (state is NewsError) {
              return Center(child: Text('에러: ${state.message}'));
            }
            return const Center(child: Text('뉴스를 불러오세요'));
          },
        ),
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
                        style: Theme.of(context).textTheme.bodyLarge,
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