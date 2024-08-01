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
  CompanyType? _selectedCategory;
  String? searchText;
  final _controller = TextEditingController();
  List<_CategoryButtonData> get _categories {
    final l = AppLocalizations.of(context)!;

    return [
      _CategoryButtonData(
          title: l.invoices,
          icon: Image.asset(
            'assets/images/icons/payments/Light.png',
            width: 40,
          ),
          type: CompanyType.invoice),
      _CategoryButtonData(
          title: l.restoration,
          icon: Image.asset(
            'assets/images/icons/payments/Hamburger.png',
            width: 40,
          ),
          type: CompanyType.food),
      _CategoryButtonData(
          title: l.shopping,
          icon: Image.asset(
            'assets/images/icons/payments/Shopping.png',
            width: 40,
          ),
          type: CompanyType.shopping),
      _CategoryButtonData(
          title: l.tourism,
          icon: Image.asset(
            'assets/images/icons/payments/Tourism.png',
            width: 40,
          ),
          type: CompanyType.tourism)
    ];
  }

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

  String _category2String(CompanyType category) {
    final l = AppLocalizations.of(context)!;

    switch (category) {
      case CompanyType.invoice:
        return l.invoices;
      case CompanyType.food:
        return l.restoration;
      case CompanyType.shopping:
        return l.shopping;
      case CompanyType.tourism:
        return l.tourism;
    }
  }

  Widget _categorySelected(CompanyType category) {
    String name = _category2String(category);

    return Container(
      padding: const EdgeInsets.all(3),
      height: 28,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            width: 32,
            child: IconButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                padding: EdgeInsets.zero,
                onPressed: () => setState(() {
                      _selectedCategory = null;
                    }),
                icon: const Icon(
                  Icons.close,
                  size: 20,
                )),
          )
        ],
      ),
    );
  }

  void _filterCompaniesByTextSearch() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    context.loaderOverlay.show();
    _controller.addListener(_filterCompaniesByTextSearch);
    _fetchCompanies().then((_) {
      context.loaderOverlay.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Flexible(
                      child: _PrefixSearchField(
                          controller: _controller,
                          hintText: l.search_by_name,
                          prefix: _selectedCategory != null
                              ? _categorySelected(_selectedCategory!)
                              : null)),
                  Visibility(
                      visible: _selectedCategory != null ||
                          _controller.text.isNotEmpty,
                      child: TextButton(
                        onPressed: () => setState(() {
                          _selectedCategory = null;
                          _controller.value = TextEditingValue.empty;
                        }),
                        child: Text(
                          l.cancel,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ))
                ],
              ),
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
              children: _categories
                  .map((data) => TextButton(
                        onPressed: () =>
                            setState(() => _selectedCategory = data.type),
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
          if (_controller.text.isNotEmpty)
            ..._listItems(_companies
                .where((item) =>
                    item.name
                        .toLowerCase()
                        .contains(_controller.text.trim().toLowerCase()) &&
                    (_selectedCategory == null ||
                        _selectedCategory == item.type))
                .toList()),
          if (_controller.text.isEmpty) ...[
            if (_selectedCategory == null) ...[
              _categoryTitle(l.favorites),
              ..._listItems(_favorites)
            ],
            if (_selectedCategory == null ||
                _selectedCategory == CompanyType.invoice) ...[
              _categoryTitle(l.invoices),
              ..._listItems(
                  _filterCompanies(CompanyType.invoice, favorite: false))
            ],
            if (_selectedCategory == null ||
                _selectedCategory == CompanyType.food) ...[
              _categoryTitle(l.food),
              ..._listItems(_filterCompanies(CompanyType.food, favorite: false))
            ],
            if (_selectedCategory == null ||
                _selectedCategory == CompanyType.shopping) ...[
              _categoryTitle(l.shopping),
              ..._listItems(
                  _filterCompanies(CompanyType.shopping, favorite: false))
            ],
            if (_selectedCategory == null ||
                _selectedCategory == CompanyType.tourism) ...[
              _categoryTitle(l.tourism),
              ..._listItems(
                  _filterCompanies(CompanyType.tourism, favorite: false))
            ]
          ]
        ],
      ),
    ));
  }

  @override
  void dispose() {
    _controller.removeListener(_filterCompaniesByTextSearch);
    _controller.dispose();
    super.dispose();
  }
}

class _CategoryButtonData {
  final String title;
  final Widget icon;
  final CompanyType type;

  const _CategoryButtonData(
      {required this.title, required this.icon, required this.type});
}

class _PrefixSearchField extends StatefulWidget {
  final Widget? prefix;
  final String? hintText;
  final TextEditingController? controller;

  const _PrefixSearchField(
      {required this.prefix, this.hintText, this.controller});

  @override
  State<_PrefixSearchField> createState() => _PrefixSearchFieldState();
}

class _PrefixSearchFieldState extends State<_PrefixSearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black.withOpacity(0.25)),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Icon(Icons.search, size: 32),
          if (widget.prefix != null) widget.prefix!,
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  border: InputBorder.none,
                  isDense: true,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4))),
            ),
          )
        ],
      ),
    );
  }
}
