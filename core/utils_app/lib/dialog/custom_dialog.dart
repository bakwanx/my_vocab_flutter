import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static chooseCameraGallery(BuildContext context, Function fnc) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          margin: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              FractionallySizedBox(
                widthFactor: 0.25,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Container(
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(2.5),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        fnc(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 48,
                            color: primaryColor,
                          ),
                          Text(
                            'Kamera',
                            style: Typo.small.copyWith(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        fnc(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo,
                            size: 48,
                            color: primaryColor,
                          ),
                          Text(
                            'Galeri',
                            style: Typo.small.copyWith(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static dialogPop(BuildContext context, String message) async {
    Widget noButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop(false);
      },
      child: Text(
        'TIDAK',
        style: Typo.small.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
    Widget yesButton = TextButton(
      onPressed: () async {
        Navigator.of(context).pop(true);
        Navigator.of(context).pop(true);
      },
      child: Text(
        'YA',
        style: Typo.small.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        'KELUAR',
        style: Typo.small.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      content: Text(message, style: Typo.small.copyWith(fontSize: 16)),
      actions: [noButton, yesButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static dialogExit(BuildContext context, Function yesFunc) async {
    Widget noButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop(false);
      },
      child: Text(
        'TIDAK',
        style: Typo.small.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
    Widget yesButton = TextButton(
      onPressed: () {
        yesFunc();
      },
      child: Text(
        'YA',
        style: Typo.small.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        'KELUAR',
        style: Typo.small.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      content: Text(
        "Keluar dari akun Anda?",
        style: Typo.small.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      actions: [noButton, yesButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static snackbar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      action: SnackBarAction(
        label: "Tutup",
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}