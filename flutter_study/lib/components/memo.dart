import 'package:flutter/material.dart';

class Memo extends StatefulWidget {
  final String title;

  const Memo({Key? key, required this.title}) : super(key: key);

  @override
  _MemoState createState() => _MemoState();
}

class _MemoState extends State<Memo> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Color _borderColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _borderColor = _focusNode.hasFocus ? Colors.blue : Colors.grey;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            labelText: 'Enter your memo',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _borderColor),
            ),
          ),
          maxLines: null,
        ),
      ),
    );
  }
}
