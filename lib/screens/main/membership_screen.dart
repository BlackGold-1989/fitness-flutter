import 'dart:async';

import 'package:fitness/generated/l10n.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:fitness/utils/constants.dart';
import 'package:fitness/widgets/appbar_widget.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberShipScreen extends StatefulWidget {
  const MemberShipScreen({Key key}) : super(key: key);

  @override
  _MemberShipScreenState createState() => _MemberShipScreenState();
}

class _MemberShipScreenState extends State<MemberShipScreen> {
  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  StreamSubscription _conectionSubscription;

  final List<String> _productLists = [
    Constants.key_iap_membership,
  ];
  List<IAPItem> _items = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    if (_conectionSubscription != null) {
      _conectionSubscription.cancel();
      _conectionSubscription = null;
    }
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    var result = await FlutterInappPurchase.instance.initConnection;
    print('result: $result');

    if (!mounted) return;

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAllItems;
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      print('purchase-updated: $productItem');
      if (productItem != null) {


      }
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });

    _getProduct();
  }

  Future _getProduct() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in items) {
      print('${item.toString()}');
      this._items.add(item);
    }

    setState(() {
      this._items = items;
    });
  }

  void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      backImage: 'assets/images/img_back_02.png',
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Upgrade Membership',
          lendingWidget: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: offsetSm, vertical: offsetBase),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/ic_crown.svg',
                color: Colors.orange,
                width: 60.0,
                height: 60.0,
              ),
              SizedBox(
                height: offsetBase,
              ),
              Text('Become a Premium Member',
                  style: GoogleFonts.montserrat(
                      fontSize: fontMd, fontWeight: weightBold)),
              SizedBox(
                height: offsetBase,
              ),
              BlurWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).premium_member,
                        style: GoogleFonts.montserrat(
                            fontSize: fontMd, fontWeight: weightSemiBold)),
                    SizedBox(
                      height: offsetBase,
                    ),
                    Text(S.of(context).purchase_detail_01,
                        style: GoogleFonts.montserrat(
                            fontSize: fontBase, fontWeight: weightLight)),
                    SizedBox(
                      height: offsetSm,
                    ),
                    Text(S.of(context).purchase_detail_02,
                        style: GoogleFonts.montserrat(
                            fontSize: fontBase, fontWeight: weightLight)),
                    SizedBox(
                      height: offsetSm,
                    ),
                    Text(S.of(context).purchase_detail_03,
                        style: GoogleFonts.montserrat(
                            fontSize: fontBase, fontWeight: weightLight)),
                    SizedBox(
                      height: offsetLg,
                    ),
                    Container(
                      width: 150.0,
                      child: OutlineEmptyButton(
                          height: 44.0,
                          title: S.of(context).upgrade_now,
                          onPress: () => _requestPurchase(_items[0])),
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
