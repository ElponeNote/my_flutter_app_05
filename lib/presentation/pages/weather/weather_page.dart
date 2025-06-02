import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // 더미 데이터 (서울 기준)
  final String location = '서울';
  final int currentTemp = 24;
  final String weatherDesc = '맑음';
  final int highTemp = 27;
  final int lowTemp = 18;
  final IconData weatherIcon = CupertinoIcons.sun_max_fill;

  final List<Map<String, dynamic>> hourly = List.generate(24, (i) => {
    'hour': i == 0 ? '지금' : '${i}시',
    'icon': i < 6 || i > 19 ? CupertinoIcons.moon_stars_fill : CupertinoIcons.sun_max_fill,
    'temp': 20 + (i % 6),
  });

  final List<Map<String, dynamic>> weekly = [
    {'day': '오늘', 'icon': CupertinoIcons.sun_max_fill, 'high': 27, 'low': 18},
    {'day': '일', 'icon': CupertinoIcons.cloud_sun_fill, 'high': 25, 'low': 17},
    {'day': '월', 'icon': CupertinoIcons.cloud_fill, 'high': 23, 'low': 16},
    {'day': '화', 'icon': CupertinoIcons.cloud_rain_fill, 'high': 22, 'low': 15},
    {'day': '수', 'icon': CupertinoIcons.sun_max_fill, 'high': 26, 'low': 18},
    {'day': '목', 'icon': CupertinoIcons.cloud_sun_fill, 'high': 24, 'low': 17},
    {'day': '금', 'icon': CupertinoIcons.cloud_bolt_fill, 'high': 21, 'low': 14},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = true;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // 다크 그라데이션 배경
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF101522), Color(0xFF23345C)],
                ),
              ),
            ),
            // 메인 내용
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(location,
                              style: const TextStyle(
                                fontFamily: '.SF Pro Display',
                                fontWeight: FontWeight.w600,
                                fontSize: 28,
                                color: Colors.white,
                              )),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('$currentTemp°',
                                  style: const TextStyle(
                                    fontFamily: '.SF Pro Display',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 90,
                                    color: Colors.white,
                                    height: 1,
                                  )),
                              const SizedBox(width: 12),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18),
                                child: Icon(weatherIcon, color: Colors.yellow, size: 38),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(weatherDesc,
                              style: const TextStyle(
                                fontFamily: '.SF Pro Display',
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                                color: Colors.white,
                              )),
                          const SizedBox(height: 4),
                          Text('최고 $highTemp° · 최저 $lowTemp°',
                              style: const TextStyle(
                                fontFamily: '.SF Pro Display',
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                color: Colors.white70,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                // 시간별 예보
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          color: Colors.white.withOpacity(0.08),
                          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                          child: SizedBox(
                            height: 110,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: hourly.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (context, i) {
                                final h = hourly[i];
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                  width: 64,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.13),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(h['hour'],
                                          style: const TextStyle(
                                            fontFamily: '.SF Pro Text',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          )),
                                      const SizedBox(height: 8),
                                      Icon(h['icon'], color: Colors.white, size: 28),
                                      const SizedBox(height: 8),
                                      Text('${h['temp']}°',
                                          style: const TextStyle(
                                            fontFamily: '.SF Pro Text',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // 주간 예보
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          color: Colors.white.withOpacity(0.08),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          child: Column(
                            children: weekly.map((w) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      child: Text(w['day'],
                                          style: const TextStyle(
                                            fontFamily: '.SF Pro Text',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          )),
                                    ),
                                    Icon(w['icon'], color: Colors.white, size: 26),
                                    const Spacer(),
                                    Text('${w['low']}°',
                                        style: const TextStyle(
                                          fontFamily: '.SF Pro Text',
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        )),
                                    Container(
                                      width: 60,
                                      alignment: Alignment.centerRight,
                                      child: Text('${w['high']}°',
                                          style: const TextStyle(
                                            fontFamily: '.SF Pro Text',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // 하단 여백
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 