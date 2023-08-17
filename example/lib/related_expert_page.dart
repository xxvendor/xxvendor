import 'package:example/indicator.dart';
import 'package:flutter/material.dart';

class RelatedExpertPage extends StatefulWidget {
  const RelatedExpertPage({super.key});

  @override
  State<RelatedExpertPage> createState() => _RelatedExpertPageState();
}

class _RelatedExpertPageState extends State<RelatedExpertPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<String> tabs = ["---", "+++"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('旗下达人'),
      ),
      body: Column(
        children: [
          Container(
            height: 42,
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: tabController,
              tabs: tabs
                  .map((e) => Text(
                        e,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ))
                  .toList(),
              indicator: ComeinTabIndicator(
                  borderSide: BorderSide.none, indicatorWidth: 12),
            ),
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              Container(
                width: 200,
                height: 300,
              ),
              Container(
                width: 200,
                height: 300,
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class WrapIndicator extends StatefulWidget {
  final TabController tabController;

  const WrapIndicator({super.key, required this.tabController});

  @override
  State<WrapIndicator> createState() => _WrapIndicatorState();
}

class _WrapIndicatorState extends State<WrapIndicator> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
