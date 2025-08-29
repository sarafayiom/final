import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/settings_controller.dart';
class Settingspage extends StatelessWidget {
  final SettingsController controller = Get.find<SettingsController>();
  Settingspage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }

        if (controller.wallet.value == null) {
          return const Center(child: Text("No value"));
        }

        
        return ListView(
          padding: const EdgeInsets.all(10),
          children: [ Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              controller.wallet.value!.username,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.purple
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '👛 Balance: \$${controller.wallet.value!.balance}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
            const Text("Edit Profile",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Card(
              //color: Colors.white,
              child: ListTile(tileColor:  Theme.of(context).brightness == Brightness.light ? Colors.white :Colors.grey[850],
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text("Edit Profile"),
                onTap: controller.editProfile,
              ),
            ),
            const SizedBox(height: 16),
            const Text("Theme Mode",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Card(
             // color: Colors.white,
              child: ListTile(tileColor:  Theme.of(context).brightness == Brightness.light ? Colors.white :Colors.grey[850],
                leading: Icon(
                  controller.isDarkMode.value
                      ? Icons.nightlight_round
                      : Icons.wb_sunny,
                  color:
                      controller.isDarkMode.value ? Colors.grey : Colors.orange,
                ),
                title: Text(
                    controller.isDarkMode.value ? "Dark Mode" : "Light Mode"),
                trailing: Switch(
                  value: controller.isDarkMode.value,
                  onChanged: (value) => controller.toggleTheme(),
                ),
                onTap: controller.toggleTheme,
              ),
            ),
            const SizedBox(height: 16),
            const Text("Music Player",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Card(
           //   color: Colors.white,
              child: ListTile(tileColor:  Theme.of(context).brightness == Brightness.light ? Colors.white :Colors.grey[850],
                leading: const Icon(Icons.music_note, color: Colors.green),
                title: const Text("Sports Music"),
                trailing: Switch(
                  value: controller.isMusicPlaying.value,
                  onChanged: controller.toggleMusic,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Logout",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Card(
           //   color: Colors.white,
              child: ListTile(tileColor:  Theme.of(context).brightness == Brightness.light ? Colors.white :Colors.grey[850],
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout"),
                onTap: controller.logout,
              ),
            ),
          ],
        );
      }),
    );
  }
}
