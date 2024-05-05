import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:smart_car_park/utils/formatters/formatter.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smart_car_park/common/widgets/simple_button.dart';
import 'package:smart_car_park/common/widgets/custom_drawer_primary.dart';
import 'package:smart_car_park/featuers/app/screens/payment/add_card.dart';
import 'package:smart_car_park/featuers/app/controllers/card_controller.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sH = KDeviceUtils.getScreenHeight();
    final controller = CardController.instance;

    return Scaffold(
      drawer: CustomDrawerPrimary(
        sH: sH,
      ),
      appBar: AppBar(),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.allCards.length,
                itemBuilder: (context, index) => InkWell(
                  onLongPress: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text('Confirmation'),
                            content: const Text('Do you want to proceed?'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(foregroundColor: Colors.red),
                                onPressed: () async {
                                  // Add your action when "Yes" is pressed
                                  Navigator.of(context).pop();
                                  await CardController.instance
                                      .deleteCard(controller.allCards[index].id);
                                  // Add your code here
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(foregroundColor: Colors.green),
                                onPressed: () {
                                  // Add your action when "No" is pressed
                                  Navigator.of(context).pop();
                                  // Add your code here
                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        });
                  },
                  child: CreditCardWidget(
                    cardNumber: KFormatter.formatCardNumber(controller.allCards[index].cardNumber),
                    expiryDate: controller.allCards[index].expireDate,
                    cardHolderName: controller.allCards[index].cardNameHolder,
                    cvvCode: controller.allCards[index].cardCvv,
                    showBackView: false,
                    onCreditCardWidgetChange: (CreditCardBrand brand) {},
                    bankName: controller.allCards[index].cardBrand,
                    cardBgColor: Colors.black87,
                    enableFloatingCard: false,
                    labelValidThru: 'DATE',
                    obscureCardNumber: true,
                    obscureInitialCardNumber: true,
                    obscureCardCvv: true,
                    labelCardHolder: 'CARD HOLDER',
                    cardType: CardType.mastercard,
                    isHolderNameVisible: true,
                    height: 190,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                    width: MediaQuery.of(context).size.width,
                    isChipVisible: true,
                    isSwipeGestureEnabled: false,
                    animationDuration: const Duration(milliseconds: 1000),
                    frontCardBorder: Border.all(color: Colors.grey),
                    backCardBorder: Border.all(color: Colors.grey),
                    chipColor: Colors.red,
                    padding: 16,
                  ),
                ),
              ),
            ),
          ),
          SimpleButton(
            onPressed: () {
              Get.to(() => const AddCard());
            },
            text: "Add Card",
            width: 0.50,
            backgroundColor: Colors.deepPurpleAccent.shade100,
          )
        ],
      ),
    );
  }
}
