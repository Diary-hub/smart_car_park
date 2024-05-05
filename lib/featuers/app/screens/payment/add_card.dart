import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:smart_car_park/common/widgets/custom_input_feild.dart';
import 'package:smart_car_park/common/widgets/simple_button.dart';
import 'package:smart_car_park/featuers/app/controllers/card_controller.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smart_car_park/utils/formatters/formatter.dart';
import 'package:smart_car_park/utils/validators/validation.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CardController.instance;
    final sW = KDeviceUtils.getScreenWidht(context);
    final sH = KDeviceUtils.getScreenHeight();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => CreditCardWidget(
                cardNumber: KFormatter.formatCardNumber(""),
                expiryDate: "",
                cardHolderName: controller.cardNameHolder.value.text,
                cvvCode: "012",
                showBackView: false,
                onCreditCardWidgetChange: (CreditCardBrand brand) {},
                bankName: 'BANK NAME',
                cardBgColor: Colors.black87,
                enableFloatingCard: false,
                labelValidThru: 'DATE',
                obscureCardNumber: false,
                obscureInitialCardNumber: false,
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
            CreditCardForm(
              formKey: controller.key, // Required
              cardNumber: "",
              expiryDate: "",
              cardHolderName: "",
              cvvCode: "",

              cardNumberKey: controller.cardNumberKey,
              cvvCodeKey: controller.cvvCodeKey,
              expiryDateKey: controller.expiryDateKey,
              cardHolderKey: controller.cardHolderKey,
              onCreditCardModelChange: (CreditCardModel data) {}, // Required
              obscureCvv: false,
              obscureNumber: false,
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              enableCvv: true,
              cardNumberValidator: (String? cardNumber) {
                String result = cardNumber!.replaceAll(' ', '');

                if (result.length < 16) {
                  return "Fill Out Number";
                }
                controller.cardNumber.value = result;
                return null;
              },
              expiryDateValidator: (String? expiryDate) {
                if (expiryDate!.length < 3) {
                  return "Fill Out Date";
                }
                controller.expireDate.value = expiryDate;
                return null;
              },
              cvvValidator: (String? cvv) {
                if (cvv!.length < 3) {
                  return "Fill Out CVV";
                }
                controller.cardCvv.value = cvv;
                return null;
              },
              cardHolderValidator: (String? cardHolderName) {
                if (cardHolderName! == "") {
                  return "Fill Out Card Holder Name";
                }
                controller.cardNameHolder.value.text = cardHolderName;
                return null;
              },
              onFormComplete: () {
                // callback to execute at the end of filling card data
              },
              autovalidateMode: AutovalidateMode.always,
              disableCardNumberAutoFillHints: false,
              inputConfiguration: const InputConfiguration(
                cardNumberDecoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  labelText: 'Number',
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
                expiryDateDecoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                ),
                cvvCodeDecoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                  border: OutlineInputBorder(),
                  labelText: 'Card Holder',
                ),
                cardNumberTextStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                cardHolderTextStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                expiryDateTextStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                cvvCodeTextStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: sW * 0.92,
              child: CustomInputField(
                  validator: (value) => KValidator.validateField("Bank Name", value),
                  controller: controller.cardBankName,
                  labelText: "Bank Name",
                  prefixIcon: null,
                  obscureText: false),
            ),
            SizedBox(height: sH * 0.02),
            SimpleButton(
              onPressed: () {
                controller.saveCard();
              },
              text: "Save Card",
              backgroundColor: Colors.deepPurpleAccent.shade100,
            )
          ],
        ),
      ),
    );
  }
}
