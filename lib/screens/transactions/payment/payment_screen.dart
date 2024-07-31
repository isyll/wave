import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:waveapp/screens/transactions/payment/payment_form_screen.dart';
import 'package:waveapp/services/data_service.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const routeName = '/payment';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<Company> _companies = [];

  Future<void> _fetchCompanies() async {
    final data = await DataService.loadCompanies();
    setState(() {
      _companies = data;
    });
  }

  List<Company> _filterCompanies(CompanyType type, {bool? favorite}) =>
      favorite != null
          ? _companies
              .where((item) => item.type == type && item.isFavorite == favorite)
              .toList()
          : _companies.where((item) => item.type == type).toList();

  List<Company> get _favorites =>
      _companies.where((item) => item.isFavorite).toList();

  Widget _categoryTitle(String title) => Padding(
        padding: const EdgeInsets.only(top: 28, bottom: 5, left: 16, right: 16),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      );

  Widget _companyItem(Company company) => Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: company.bgColor,
            ),
            width: 50,
            height: 50,
            child: Image.asset(
              company.imgAsset,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            company.name,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.normal),
          )
        ],
      );

  dynamic _listItems(List<Company> items) => List.generate(
      items.length,
      (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PaymentFormScreen(company: items[index])));
                },
                style: ButtonStyle(
                    shape: const WidgetStatePropertyAll(LinearBorder()),
                    overlayColor:
                        WidgetStatePropertyAll(Colors.black.withOpacity(0.08))),
                child: _companyItem(items[index])),
          ));

  @override
  void initState() {
    super.initState();
    context.loaderOverlay.show();
    _fetchCompanies().then((_) {
      context.loaderOverlay.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final favorites = _favorites;
    final invoices = _filterCompanies(CompanyType.invoice, favorite: false);
    final foods = _filterCompanies(CompanyType.food, favorite: false);
    final shoppings = _filterCompanies(CompanyType.shopping, favorite: false);
    final tourisms = _filterCompanies(CompanyType.tourism, favorite: false);

    return Scaffold(
        body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          pinned: true,
          snap: true,
          floating: true,
          title: Text(l.payment),
          bottom: AppBar(
            surfaceTintColor: Theme.of(context).colorScheme.surface,
            automaticallyImplyLeading: false,
            title: TextField(
              decoration: InputDecoration(
                  hintText: l.search_by_name,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 32,
                  ),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.25)),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black26)),
                  enabledBorder: const OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(width: 1, color: Colors.black26))),
            ),
          ),
        ),
      ],
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              spacing: 10,
              children: [
                _CategoryButtonData(
                    title: l.invoices,
                    icon: Image.asset(
                      'assets/images/icons/payments/Light.png',
                      width: 40,
                    )),
                _CategoryButtonData(
                    title: l.restoration,
                    icon: Image.asset(
                      'assets/images/icons/payments/Hamburger.png',
                      width: 40,
                    )),
                _CategoryButtonData(
                    title: l.shopping,
                    icon: Image.asset(
                      'assets/images/icons/payments/Shopping.png',
                      width: 40,
                    )),
                _CategoryButtonData(
                    title: l.tourism,
                    icon: Image.asset(
                      'assets/images/icons/payments/Tourism.png',
                      width: 40,
                    ))
              ]
                  .map((data) => TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                            shape: WidgetStatePropertyAll(LinearBorder.none),
                            padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                        child: Column(
                          children: [
                            data.icon,
                            Text(data.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    color: Colors.black))
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          _categoryTitle(l.favorites),
          ..._listItems(favorites),
          _categoryTitle(l.invoices),
          ..._listItems(invoices),
          _categoryTitle(l.food),
          ..._listItems(foods),
          _categoryTitle(l.shopping),
          ..._listItems(shoppings),
          _categoryTitle(l.tourism),
          ..._listItems(tourisms)
        ],
      ),
    ));
  }
}

class _CategoryButtonData {
  final String title;
  final Widget icon;

  const _CategoryButtonData({required this.title, required this.icon});
}
