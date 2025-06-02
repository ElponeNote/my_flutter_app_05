import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<String> categories = ['기술', '경제', '정책'];
  final List<String> allCategories = ['기술', '경제', '정책', '스포츠', '연예', '날씨', '주식'];

  bool newsAlert = true;
  bool weatherAlert = true;
  bool stockAlert = false;
  bool darkMode = false;
  bool autoPlay = true;
  bool dataSaver = false;

  String userName = '사용자';
  String userEmail = 'user@example.com';
  String? userPhotoPath;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '사용자';
      userEmail = prefs.getString('userEmail') ?? 'user@example.com';
      userPhotoPath = prefs.getString('userPhotoPath');
    });
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
    await prefs.setString('userEmail', userEmail);
    if (userPhotoPath != null) {
      await prefs.setString('userPhotoPath', userPhotoPath!);
    }
  }

  void _addCategory(String cat) {
    if (!categories.contains(cat)) {
      setState(() => categories.add(cat));
    }
  }

  void _removeCategory(String cat) {
    setState(() => categories.remove(cat));
  }

  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('카테고리 추가'),
          children: allCategories
              .where((cat) => !categories.contains(cat))
              .map((cat) => SimpleDialogOption(
                    child: Text(cat),
                    onPressed: () {
                      _addCategory(cat);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        );
      },
    );
  }

  void _showEditProfileDialog() async {
    final nameController = TextEditingController(text: userName);
    final emailController = TextEditingController(text: userEmail);
    String? tempPhotoPath = userPhotoPath;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundImage: (tempPhotoPath != null && tempPhotoPath!.isNotEmpty)
                            ? FileImage(File(tempPhotoPath!))
                            : const NetworkImage('https://i.pravatar.cc/150?img=3') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                            final picker = ImagePicker();
                            final picked = await picker.pickImage(source: ImageSource.gallery);
                            if (picked != null) {
                              setModalState(() {
                                tempPhotoPath = picked.path;
                              });
                            }
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.blue,
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: '이름'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: '이메일'),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () async {
                        setState(() {
                          userName = nameController.text.trim();
                          userEmail = emailController.text.trim();
                          userPhotoPath = tempPhotoPath;
                        });
                        await _saveProfile();
                        if (mounted) Navigator.pop(context);
                      },
                      child: const Text('저장', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // 프로필
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: (userPhotoPath != null && userPhotoPath!.isNotEmpty)
                    ? FileImage(File(userPhotoPath!))
                    : const NetworkImage('https://i.pravatar.cc/150?img=3') as ImageProvider,
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(userEmail, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _showEditProfileDialog,
              ),
            ],
          ),
          const SizedBox(height: 28),
          // 관심 카테고리
          Text('관심 카테고리', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...categories.map((cat) => Chip(
                    label: Text(cat),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () => _removeCategory(cat),
                  )),
              ActionChip(
                label: const Text('+ 카테고리 추가'),
                onPressed: _showAddCategoryDialog,
              ),
            ],
          ),
          const SizedBox(height: 28),
          // 알림 설정
          Text('알림 설정', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
          const Divider(height: 24),
          _buildSwitchTile('뉴스 알림', newsAlert, (v) => setState(() => newsAlert = v)),
          _buildSwitchTile('날씨 알림', weatherAlert, (v) => setState(() => weatherAlert = v)),
          _buildSwitchTile('주식 알림', stockAlert, (v) => setState(() => stockAlert = v)),
          const SizedBox(height: 28),
          // 앱 설정
          Text('앱 설정', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
          const Divider(height: 24),
          _buildSwitchTile('다크 모드', darkMode, (v) => setState(() => darkMode = v)),
          _buildSwitchTile('자동 재생', autoPlay, (v) => setState(() => autoPlay = v)),
          _buildSwitchTile('데이터 절약', dataSaver, (v) => setState(() => dataSaver = v)),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue,
    );
  }
} 