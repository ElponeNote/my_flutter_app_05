import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ProfileHeader extends StatefulWidget {
  final double imageRadius;
  final TextStyle? nameStyle;
  final TextStyle? emailStyle;

  const ProfileHeader({
    Key? key,
    this.imageRadius = 32,
    this.nameStyle,
    this.emailStyle,
  }) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
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

  Widget _buildProfileImage() {
    if (userPhotoPath != null && userPhotoPath!.isNotEmpty) {
      final file = File(userPhotoPath!);
      if (file.existsSync()) {
        return CircleAvatar(
          radius: widget.imageRadius,
          backgroundImage: FileImage(file),
        );
      }
    }
    return CircleAvatar(
      radius: widget.imageRadius,
      backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=3'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildProfileImage(),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userName, style: widget.nameStyle ?? Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(userEmail, style: widget.emailStyle ?? Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
} 