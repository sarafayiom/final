import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Models/wallet_model.dart';
import 'package:homeworkout_flutter/Services/api_wallet.dart';
import 'package:homeworkout_flutter/View/edit_profile.dart';
import 'package:homeworkout_flutter/View/signup..dart';

class SettingsController extends GetxController {
  final box = GetStorage();
  var isDarkMode = false.obs;
  var isMusicPlaying = false.obs;
  final player = AudioPlayer();
 final apiWallet = Get.find<ApiWallet>();

var wallet = Rxn<Wallet>();
  var isLoading = false.obs;
  var error = ''.obs;
  @override
  void onInit() {
    super.onInit();
     isDarkMode.value = box.read('isDarkMode') ?? false;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    fetchWalletData();
  }

  void fetchWalletData() async {
    try {
      isLoading.value = true;
      error.value = '';
      Wallet? data = await apiWallet.fetchWallet();
      if (data != null) {
        wallet.value = data;
      } else {
        error.value = 'Failed to load wallet';
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  void editProfile() {
   Get.off(() => EditProfile());
  }
  void toggleMusic(bool value) async {
  isMusicPlaying.value = value;
  if (value) {
    await player.setReleaseMode(ReleaseMode.loop);
    await player.play(AssetSource('audio/sport_music.mp3'));
  } else {
    await player.pause();
  }
}
void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    box.write('isDarkMode', isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
  void logout() {
    box.remove('access_token'); 
    box.remove('refresh_token'); 
    Get.offAll(() => SignUp()); 
  }
}