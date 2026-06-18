import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_product/core/utils/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),

      body: Column(
        children: [
          App_bar(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      _buildProfileCard(),

                      const SizedBox(height: 16),

                      _buildMenuCard([
                        ProfileMenuItem(
                          icon: Icons.inventory_2_outlined,
                          title: "My Orders",
                          subtitle: "View past & current orders",
                        ),
                        ProfileMenuItem(
                          icon: Icons.edit_location_alt_outlined,
                          title: "Manage Addresses",
                          subtitle: "Add/edit delivery addresses",
                        ),
                        ProfileMenuItem(
                          icon: Icons.credit_card_outlined,
                          title: "Payment Methods",
                          subtitle: "Saved cards, UPI, wallets",
                        ),
                        ProfileMenuItem(
                          icon: Icons.favorite_border,
                          title: "Wishlist",
                          subtitle: "Saved favorite items",
                        ),
                      ]),

                      const SizedBox(height: 16),

                      _buildSingleTile(
                        icon: Icons.local_offer_outlined,
                        title: "Coupons & Offers",
                        subtitle: "View available promo codes",
                      ),

                      const SizedBox(height: 12),

                      _buildSingleTile(
                        icon: Icons.support_agent,
                        title: "Support / Help",
                        subtitle: "FAQs, Contact Us, Chat Support",
                      ),

                      const SizedBox(height: 12),

                      _buildSingleTile(
                        icon: Icons.settings_outlined,
                        title: "Settings",
                        subtitle: "Notification preferences, privacy",
                      ),

                      const SizedBox(height: 12),

                      _buildSingleTile(
                        icon: Icons.logout,
                        title: "Logout",
                        subtitle: "Sign out securely",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pronoy Sarkar',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Welcome to EasyShop',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(List<ProfileMenuItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: items
            .map((item) => _menuTile(item.icon, item.title, item.subtitle))
            .toList(),
      ),
    );
  }

  Widget _buildSingleTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: _menuTile(icon, title, subtitle),
    );
  }

  Widget _menuTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle, style: GoogleFonts.montserrat(fontSize: 11)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class App_bar extends StatelessWidget {
  const App_bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profile',
            style: GoogleFonts.montserrat(
              color: AppColors.textPrimary,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: AppColors.textPrimary,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem {
  final IconData icon;
  final String title;
  final String subtitle;

  ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
