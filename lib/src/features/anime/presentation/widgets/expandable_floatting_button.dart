import 'package:flutter/material.dart';

class ExpandableFloatingButton extends StatefulWidget {
  final List<ExpandableAction> actions;

  const ExpandableFloatingButton({
    Key? key,
    required this.actions,
  }) : super(key: key);

  @override
  _ExpandableFloatingButtonState createState() =>
      _ExpandableFloatingButtonState();
}

class _ExpandableFloatingButtonState extends State<ExpandableFloatingButton>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.8), // Adjust opacity here
          borderRadius: BorderRadius.circular(_isExpanded ? 11 : 11),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (_isExpanded)
                ...widget.actions.map((action) => GestureDetector(
                  onTap: action.onTap,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          action.icon,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )),
              GestureDetector(
                onTap: _toggleExpansion,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        _isExpanded ? Icons.close : Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandableAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  ExpandableAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}