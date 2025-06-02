enum NewsCategory { main, economy, sports, tech, entertainment }

class News {
  final String title;
  final String summary;
  final String imageUrl;
  final NewsCategory category;
  final String source;
  final String timeAgo;

  News({
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.category,
    required this.source,
    required this.timeAgo,
  });
}

final dummyNewsList = [
  // 주요 뉴스
  News(
    title: '주요 뉴스 1',
    summary: '주요 뉴스 1의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400&h=250&fit=crop',
    category: NewsCategory.main,
    source: '연합뉴스',
    timeAgo: '1시간 전',
  ),
  News(
    title: '주요 뉴스 2',
    summary: '주요 뉴스 2의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?w=400&h=250&fit=crop',
    category: NewsCategory.main,
    source: '조선일보',
    timeAgo: '2시간 전',
  ),
  News(
    title: '주요 뉴스 3',
    summary: '주요 뉴스 3의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?w=400&h=250&fit=crop',
    category: NewsCategory.main,
    source: '한겨레',
    timeAgo: '3시간 전',
  ),
  // 경제
  News(
    title: '경제 뉴스 1',
    summary: '경제 뉴스 1의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1444653614773-995cb1ef9efa?w=400&h=250&fit=crop',
    category: NewsCategory.economy,
    source: '매일경제',
    timeAgo: '1시간 전',
  ),
  News(
    title: '경제 뉴스 2',
    summary: '경제 뉴스 2의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=400&h=250&fit=crop',
    category: NewsCategory.economy,
    source: '한국경제',
    timeAgo: '2시간 전',
  ),
  News(
    title: '경제 뉴스 3',
    summary: '경제 뉴스 3의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1464983953574-0892a716854b?w=400&h=250&fit=crop',
    category: NewsCategory.economy,
    source: '머니투데이',
    timeAgo: '3시간 전',
  ),
  // 스포츠
  News(
    title: '스포츠 뉴스 1',
    summary: '스포츠 뉴스 1의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1517649763962-0c623066013b?w=400&h=250&fit=crop',
    category: NewsCategory.sports,
    source: '스포츠서울',
    timeAgo: '1시간 전',
  ),
  News(
    title: '스포츠 뉴스 2',
    summary: '스포츠 뉴스 2의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1517649763962-0c623066013b?w=400&h=250&fit=crop',
    category: NewsCategory.sports,
    source: 'OSEN',
    timeAgo: '2시간 전',
  ),
  News(
    title: '스포츠 뉴스 3',
    summary: '스포츠 뉴스 3의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1461897104016-0b3b00cc81ee?w=400&h=250&fit=crop',
    category: NewsCategory.sports,
    source: '스포티비',
    timeAgo: '3시간 전',
  ),
  // 기술
  News(
    title: '기술 뉴스 1',
    summary: '기술 뉴스 1의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=400&h=250&fit=crop',
    category: NewsCategory.tech,
    source: 'ZDNet',
    timeAgo: '1시간 전',
  ),
  News(
    title: '기술 뉴스 2',
    summary: '기술 뉴스 2의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=400&h=250&fit=crop',
    category: NewsCategory.tech,
    source: 'IT조선',
    timeAgo: '2시간 전',
  ),
  News(
    title: '기술 뉴스 3',
    summary: '기술 뉴스 3의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=400&h=250&fit=crop',
    category: NewsCategory.tech,
    source: '블로터',
    timeAgo: '3시간 전',
  ),
  // 엔터테인먼트
  News(
    title: '엔터테인먼트 뉴스 1',
    summary: '엔터테인먼트 뉴스 1의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400&h=250&fit=crop',
    category: NewsCategory.entertainment,
    source: '스포츠조선',
    timeAgo: '1시간 전',
  ),
  News(
    title: '엔터테인먼트 뉴스 2',
    summary: '엔터테인먼트 뉴스 2의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1468327768560-75b778cbb551?w=400&h=250&fit=crop',
    category: NewsCategory.entertainment,
    source: '일간스포츠',
    timeAgo: '2시간 전',
  ),
  News(
    title: '엔터테인먼트 뉴스 3',
    summary: '엔터테인먼트 뉴스 3의 요약입니다.',
    imageUrl: 'https://images.unsplash.com/photo-1509228468518-180dd4864904?w=400&h=250&fit=crop',
    category: NewsCategory.entertainment,
    source: '텐아시아',
    timeAgo: '3시간 전',
  ),
];

// AI 추천 뉴스 더미 데이터
final aiRecommendedNewsList = [
  News(
    title: 'AI가 선정한 미래 모빌리티',
    summary: '자율주행, 전기차, 미래 교통의 혁신을 이끄는 기술 분석',
    imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400&h=250&fit=crop',
    category: NewsCategory.tech,
    source: 'AI Times',
    timeAgo: '방금 전',
  ),
  News(
    title: 'AI가 뽑은 메타버스 시장 동향',
    summary: 'AI가 분석한 메타버스, 시장의 새로운 기회와 도전',
    imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?w=400&h=250&fit=crop',
    category: NewsCategory.tech,
    source: 'AI Times',
    timeAgo: '10분 전',
  ),
  News(
    title: 'AI 추천: 친환경 에너지 트렌드',
    summary: 'AI가 주목한 신재생에너지와 글로벌 정책 변화',
    imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?w=400&h=250&fit=crop',
    category: NewsCategory.economy,
    source: 'AI Times',
    timeAgo: '30분 전',
  ),
  News(
    title: 'AI가 본 스포츠 혁신',
    summary: '스포츠 산업에 불어오는 AI 혁신 바람',
    imageUrl: 'https://images.unsplash.com/photo-1517649763962-0c623066013b?w=400&h=250&fit=crop',
    category: NewsCategory.sports,
    source: 'AI Times',
    timeAgo: '1시간 전',
  ),
]; 