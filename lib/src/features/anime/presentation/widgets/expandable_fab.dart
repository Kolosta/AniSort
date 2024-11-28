import 'package:flutter/material.dart';

class ExpandableFab extends StatefulWidget {
  final List<Widget> children;

  const ExpandableFab({Key? key, required this.children}) : super(key: key);

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isExpanded)
          ...widget.children.map((child) {
            return ScaleTransition(
              scale: _expandAnimation,
              child: child,
            );
          }).toList(),
        FloatingActionButton(
          onPressed: _toggle,
          child: Icon(_isExpanded ? Icons.close : Icons.menu),
        ),
      ],
    );
  }
}