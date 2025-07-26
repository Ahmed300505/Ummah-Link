  import 'package:flutter/material.dart';
import 'package:islamicinstapp/screens/ChangePassword.dart';
  import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

  class SecurityPrivacyScreen extends StatefulWidget {
    const SecurityPrivacyScreen({super.key});

    @override
    State<SecurityPrivacyScreen> createState() => _SecurityPrivacyScreenState();
  }

  class _SecurityPrivacyScreenState extends State<SecurityPrivacyScreen> {
    bool isPrivate = false;
    bool isLocationEnabled = false;
    bool isLoginInfoSaved = true;

    void _showPopup(String type) {
      showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFFFEFDEB),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (BuildContext context) {
          final width = MediaQuery.of(context).size.width;
          final isSmall = width < 400;
          final padding = isSmall ? 16.0 : 24.0;
          final fontSize = isSmall ? 14.0 : 16.0;

          if (type == 'private') {
            return Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPopupHeader("Make Your Account Private?"),
                  const SizedBox(height: 16),
                  Text(
                    "This confirms that you are making your account private.\n\n• Only followers you approve can see your posts, likes, and activities.\n• New follow requests must be manually approved.\n• New follow requests will also be able to view your content.",
                    style: TextStyle(fontSize: fontSize, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF03B9C2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      minimumSize: const Size(double.infinity, 44),
                    ),
                    child: const Text("Confirm",style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPopupHeader("Allow Location Access?"),
                  const SizedBox(height: 16),
                  Text(
                    "We use your location to personalize your experience and show relevant content near you.\n\n✅ Your location will never be shared without your permission.\n❗You can always change this setting at any time in your phone settings.",
                    style: TextStyle(fontSize: fontSize, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE6E6E6),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            minimumSize: const Size(double.infinity, 44),
                          ),
                          child: const Text("Allow",style: TextStyle(color: Colors.black),),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            minimumSize: const Size(double.infinity, 44),
                          ),
                          child: const Text("Don’t Allow",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        },
      );
    }

    Widget _buildPopupHeader(String title) {
      return Row(
        children: [
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close, size: 20))
        ],
      );
    }

    @override
    Widget build(BuildContext context) {
      final width = MediaQuery.of(context).size.width;
      final isSmall = width < 400;
      final padding = isSmall ? 16.0 : 20.0;
      final fontSize = isSmall ? 14.0 : 16.0;

      return Scaffold(
        backgroundColor: const Color(0xFFFEFDEB),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFEFDEB),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Privacy/Security",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 12),
          child: Column(
            children: [
              _buildToggleTile(
                "Private Account",
                "Save your credentials on this device for faster logins.",
                isPrivate,
                    (val) {
                  setState(() => isPrivate = val);
                  if (val) _showPopup('private');
                },
              ),
              _buildToggleTile(
                "Location",
                "CHANGE LOC",
                isLocationEnabled,
                    (val) {
                  setState(() => isLocationEnabled = val);
                  if (val) _showPopup('location');
                },
              ),
              _buildToggleTile(
                "Save Login Info",
                "Save your credentials on this device for faster logins.",
                isLoginInfoSaved,
                    (val) => setState(() => isLoginInfoSaved = val),
              ),
              const SizedBox(height: 20),
              _buildTile("Report an Issue",
                  "Let us know if you're being harassed or there's something wrong.",
                  onTap: () {}),
              _buildTile("Manage Linked Devices",
                  "Manage & sign out of any devices you've used your account on.",
                  onTap: () {}),
              _buildTile("Change Password",
                  "Update your password at any time to keep your account safe.",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChangePasswordScreen())),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar()
      );
    }

    Widget _buildToggleTile(String title, String subtitle, bool value, Function(bool) onChanged) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: SwitchListTile(
          contentPadding: EdgeInsets.zero, // Align with ListTile
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF033941),
        ),
      );
    }
    Widget _buildTile(String title, String subtitle, {VoidCallback? onTap}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0), // Match SwitchListTile spacing
        child: ListTile(
          contentPadding: EdgeInsets.zero, // Remove default horizontal padding
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          onTap: onTap,
        ),
      );
    }
  }
