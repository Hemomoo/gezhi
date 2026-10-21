import 'package:flutter/material.dart';

import 'package:gezhi/sqlite/diary_dao.dart';

/// 写日记 / 编辑日记
class RevisedDiary extends StatefulWidget {
  final Map arguments;
  RevisedDiary({Key? key, this.arguments = const {}}) : super(key: key);

  @override
  _RevisedDiaryState createState() => _RevisedDiaryState();
}

class _RevisedDiaryState extends State<RevisedDiary> {
  final TextEditingController _controller = TextEditingController();

  int? _diaryId;
  late String _date;
  late String _tip;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final args = widget.arguments;
    final now = DateTime.now();

    _diaryId = args['id'] is int ? args['id'] as int : null;
    _date = args['date'] is String ? args['date'] as String : _formatDate(now);
    _tip = args['tit'] is String ? args['tit'] as String : _formatDateCn(now);

    _loadDiary();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadDiary() async {
    final id = _diaryId;
    if (id != null) {
      final row = await DiaryDao.findById(id);
      if (!mounted) return;
      if (row != null) {
        _controller.text = row['diaryInfo'] as String? ?? '';
        _date = row['date'] as String? ?? _date;
        _tip = row['tip'] as String? ?? _tip;
      }
    }
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }

  Future<void> _save() async {
    final content = _controller.text.trim();
    if (content.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('先写点什么吧')));
      return;
    }

    setState(() {
      _saving = true;
    });

    final id = _diaryId;
    if (id == null) {
      await DiaryDao.insert(tip: _tip, date: _date, diaryInfo: content);
    } else {
      await DiaryDao.update(
        id: id,
        tip: _tip,
        date: _date,
        diaryInfo: content,
      );
    }

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text(
          _tip,
          style: TextStyle(color: Colors.black),
        ),
        actionsIconTheme: IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: Text(
              _saving ? '保存中...' : '保存',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _controller,
                  autofocus: _diaryId == null,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontSize: 18, height: 1.6),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '今天过得怎么样？',
                  ),
                ),
              ),
            ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatDateCn(DateTime date) {
    return '${date.year}年${date.month.toString().padLeft(2, '0')}月${date.day.toString().padLeft(2, '0')}日';
  }
}
