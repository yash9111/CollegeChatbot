import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class chatWidget extends StatefulWidget {
  const chatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;

  @override
  State<chatWidget> createState() => _chatWidgetState();
}

class _chatWidgetState extends State<chatWidget> {
  ScrollController _scrollController = ScrollController();
  bool _isTextVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _isTextVisible = _scrollController.offset > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment:
            widget.chatIndex == 0 ? Alignment.topRight : Alignment.topLeft,
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: widget.chatIndex == 0
              ? const Color.fromRGBO(51, 50, 48, 10)
              : Colors.blueGrey.shade800,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      widget.chatIndex == 0
                          ? Icons.access_alarm_rounded
                          : Icons.manage_accounts_outlined,
                      color: Colors.white,
                    ),
                    Expanded(
                        child: widget.chatIndex == 0
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.msg,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  displayFullTextOnTap: true,
                                  totalRepeatCount: 0,
                                  repeatForever: false,
                                  animatedTexts: [
                                    if (_isTextVisible)
                                      TypewriterAnimatedText(
                                        widget.msg.trim(),
                                        textStyle: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                  ],
                                ),
                              )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
