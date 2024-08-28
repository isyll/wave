import 'package:flutter/material.dart';
import 'package:waveapp/screens/gitfts/types/gift_item.dart';
import 'package:waveapp/screens/gitfts/widgets/gift_item_widget.dart';
import 'package:waveapp/screens/gitfts/widgets/max_revenue_widget.dart';

class GiftsDashboardScreen extends StatefulWidget {
  static String routeName = '/gifts';

  const GiftsDashboardScreen({super.key});

  @override
  State<GiftsDashboardScreen> createState() => _GiftsDashboardScreenState();
}

class _GiftsDashboardScreenState extends State<GiftsDashboardScreen>
    with SingleTickerProviderStateMixin {
  late OverlayEntry _overlayEntry;
  late AnimationController _animationController;
  late Animation<Offset> _animationFromTop;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _animationFromTop =
        Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  OverlayEntry _createOverlayEntry(GiftItem item) {
    return OverlayEntry(
      builder: (context) => Material(
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        color: Colors.black.withOpacity(0.25),
        child: InkWell(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: _hideOverlay,
          child: SafeArea(
            child: Column(
              children: [
                SlideTransition(
                    position: _animationFromTop,
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 50),
                        width: 320,
                        height: 200,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 6)),
                          ],
                        ),
                        child: GiftItemWidget(item: item))),
                const Flexible(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay(GiftItem item) {
    _overlayEntry = _createOverlayEntry(item);
    Overlay.of(context).insert(_overlayEntry);
    _animationController.reset();
    _animationController.forward();
  }

  void _hideOverlay() {
    _animationController.reverse().then((_) {
      _overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe2f6fd),
        centerTitle: true,
        title: const Text(
          'TOTAL GAGNE',
          style: TextStyle(
            color: Color(0xff003e6c),
          ),
        ),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(32),
            child: Center(
                child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'OF',
                style: TextStyle(
                    color: Color(0xff003e6c),
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Poppins',
                    fontSize: 36),
              ),
            ))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MaxRevenueWidget(
              revenue: 1000000,
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      crossAxisCount: 2),
                  itemCount: giftItems.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          _showOverlay(giftItems[index]);
                        },
                        child: GiftItemWidget(
                          item: giftItems[index],
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
