import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(40);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.grey),
        onPressed: null,
      ),
      title: Text(
        'Explore',
        style: GoogleFonts.lexendDeca(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.info_outline,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/second");
          },
        ),
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}

class CardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CardAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(40);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Demo',
        style: GoogleFonts.lexendDeca(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.info_outline,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                    title: Text("Memnix Alpha"),
                    content: Text(
                        "Memnix alpha version testing !\nversion: 0.1.0-alpha171121-3")));
          },
        ),
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
