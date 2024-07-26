import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/screens/home/home_screen.dart';
import 'package:waveapp/screens/transactions/transfer/transfer_screen_arguments.dart';
import 'package:waveapp/utils/number.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  static const routeName = '/transfer';

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final amountSentController = TextEditingController();
  final amountReceivedController = TextEditingController();
  int? amountSent;
  int? amountReceived;

  bool disabled = true;

  AppLocalizations get l => AppLocalizations.of(context)!;

  void checkDisabled() {
    setState(() {
      disabled = amountSent == null || amountReceived == null;
    });
  }

  void caclculateAmountSent() {
    amountSentController.removeListener(caclculateAmountReceived);
    amountReceived = int.tryParse(amountReceivedController.text);
    amountSent = int.tryParse(amountSentController.text);
    if (amountReceived != null) {
      final result = roundToNearest5Or10(amountReceived!, 1);
      amountSentController.text = result.toString();
    } else {
      amountSentController.text = '';
    }
    checkDisabled();
    amountSentController.addListener(caclculateAmountReceived);
  }

  void caclculateAmountReceived() {
    amountReceivedController.removeListener(caclculateAmountSent);
    amountSent = int.tryParse(amountSentController.text);
    amountReceived = int.tryParse(amountReceivedController.text);
    if (amountSent != null) {
      final result = roundToNearest5Or10(amountSent!, -1);
      amountReceivedController.text = result.toString();
    } else {
      amountReceivedController.text = '';
    }
    checkDisabled();
    amountReceivedController.addListener(caclculateAmountSent);
  }

  @override
  void initState() {
    super.initState();

    amountSentController.addListener(caclculateAmountReceived);
    amountReceivedController.addListener(caclculateAmountSent);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TransferScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.transfer_money),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.transfer_to,
                    style: const TextStyle(color: Color(0xff6f6f6f)),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    args.name,
                    style: const TextStyle(
                        color: Color(0xff2e2858), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    args.phoneNumber,
                    style: const TextStyle(color: Color(0xff6f6f6f)),
                  ),
                  const SizedBox(height: 3),
                  TextField(
                    controller: amountSentController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l.amount_sent),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: amountReceivedController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l.amount_received),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            width: double.infinity,
            child: TextButton(
                onPressed: disabled
                    ? null
                    : () {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routeName);
                      },
                style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor: WidgetStateProperty.resolveWith(
                        (Set<WidgetState> states) =>
                            states.contains(WidgetState.disabled)
                                ? const Color(0xffa1e7ff)
                                : Theme.of(context).colorScheme.secondary)),
                child: Text(
                  l.transfer_send,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 24),
                )),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    amountSentController.dispose();
    amountReceivedController.dispose();
  }
}
