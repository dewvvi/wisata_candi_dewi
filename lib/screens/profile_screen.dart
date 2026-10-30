
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/profile_info_item.dart';
import 'package:wisata_candi_dewi/providers/favorite_provider.dart';
import 'package:wisata_candi_dewi/providers/auth_provider.dart';
import 'sign_in_screen.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCount =
        context.watch<FavoriteProvider>().count;

    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 200 - 50,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            'images/placeholder_image.png',
                          ),
                        ),
                      ),
                      if (auth.isSignedIn)
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.deepPurple[50],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    ProfileInfoItem(
                      icon: Icons.lock,
                      label: 'Pengguna',
                      value: auth.username,
                      iconColor: Colors.amber,
                    ),
                    const SizedBox(height: 4),
                    Divider(
                      color: Colors.deepPurple[100],
                    ),
                    ProfileInfoItem(
                      icon: Icons.person,
                      label: 'Nama',
                      value: '',
                      showEditIcon: auth.isSignedIn,
                      onEditPressed: () {
                        debugPrint('Icon edit ditekan');
                      },
                      iconColor: Colors.blue,
                    ),
                    const SizedBox(height: 4),
                    Divider(
                      color: Colors.deepPurple[100],
                    ),
                    ProfileInfoItem(
                      icon: Icons.favorite,
                      label: 'Favorit',
                      value: favoriteCount > 0
                          ? '$favoriteCount'
                          : '',
                      iconColor: Colors.red,
                    ),
                    const SizedBox(height: 4),
                    Divider(
                      color: Colors.deepPurple[100],
                    ),
                    const SizedBox(height: 20),
                    auth.isSignedIn
                        ? TextButton(
                            onPressed: () {
                              context
                                  .read<AuthProvider>()
                                  .signOut();
                            },
                            child: const Text('Sign Out'),
                          )
                        : TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SignInScreen(),
                                ),
                              );
                            },
                            child: const Text('Sign In'),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
