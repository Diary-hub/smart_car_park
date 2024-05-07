import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_park/featuers/app/controllers/history_controller.dart';

class ParkHistory extends StatelessWidget {
  const ParkHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HistoryController.instance;
    print(controller.allHistory2.length);
    print("--------------------------");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextButton(
          onPressed: () {
            controller.fetchHistory();
          },
          child: Text(
            "Refresh",
            style: TextStyle(fontSize: 20, color: Colors.deepPurpleAccent[400]),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.allHistory2.length,
          itemBuilder: (context, index) {
            if (controller.allHistory2.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                trailing: IconButton(
                    onPressed: () {
                      controller.deleteHistory(controller.allHistory2[index]!.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                leading: const Icon(
                  Icons.payments_outlined,
                  color: Colors.deepPurpleAccent,
                ),
                title: Text(
                  controller.allHistory2[index]!.location,
                  style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Oxygen"),
                ),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(), borderRadius: BorderRadius.circular(10)),
                subtitle: Text(
                  "Slot ${controller.allHistory2[index]!.slot}\nPrice:${controller.allHistory2[index]!.price}IQD/Hr\nDate: ${controller.allHistory2[index]!.date.substring(0, controller.allHistory2[index]!.date.lastIndexOf(':'))}",
                  style: const TextStyle(color: Colors.black87, fontFamily: "Oxygen"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
