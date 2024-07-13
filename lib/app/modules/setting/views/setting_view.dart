import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_unwahas_mobile/app/modules/setting/views/change_password_view.dart';
import 'package:perpus_unwahas_mobile/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingController controller = Get.find<SettingController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   width: double.infinity,
          //   height: MediaQuery.of(context).size.height * 0.2,
          //   color: AppColors.primaryColor,
          //   padding: const EdgeInsets.only(left: 24),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       const SizedBox(height: 8),
          //       Text(
          //         'Perpustakaan Digital\nManajemen Unwahas'.toUpperCase(),
          //         style: const TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 16,
          //         ),
          //       ),
          //       const Text(
          //         'Fakultas Ekonomi dan Manajemen Unwahas',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 12,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.account_circle, size: 72),
                const SizedBox(width: 8),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.studentData['user']['name'],
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        controller.studentData['user']['NIM'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildSettingTile(
                title: 'About Us',
                icon: Icons.info_outline,
                onTap: () {},
              ),
              _buildSettingTile(
                title: 'Change Password',
                icon: Icons.lock,
                onTap: () {
                  Get.to(() => const ChangePasswordView());
                },
              ),
              _buildSettingTile(
                  title: 'Contact Admin',
                  icon: Icons.contact_support_outlined,
                  onTap: () async {
                    String url = 'https://wa.me/628112892827';
                    launchUrl(Uri.parse(url));
                  }),
              _buildSettingTile(
                title: 'Logout',
                icon: Icons.logout,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Konfirmasi Logout'),
                        content: const Text('Apakah Anda yakin ingin logout?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              controller.logoutStudent();
                            },
                            child: const Text('Ya'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
