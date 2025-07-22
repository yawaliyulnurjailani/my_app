import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:intl/intl.dart';
import '../../components/hover_scale_wrap_comp.dart';
import '../../components/slide_fade_on_visible_comp.dart';
import '../../components/snackbar_comp.dart';
import '../../controllers/theme_controller.dart';

class MainContactView extends StatefulWidget {
  const MainContactView({super.key});

  @override
  State<MainContactView> createState() => _MainContactViewState();
}

class _MainContactViewState extends State<MainContactView> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  DateTime now = DateTime.now();

  final ThemeController _theme = Get.find();

  void sendEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await emailjs.send(
          "YOUR_SERVICE_KEY",
          "YOUR_TEMPLATE_KEY",
          {
            "title": "Portofolio Notification",
            "name": _nameController.text,
            "time":
                DateFormat('d MMM y, HH.mm', 'id_ID').format(now).toString(),
            "message": _messageController.text,
            "email": _emailController.text,
          },
          const emailjs.Options(
            publicKey: "YOUR_PUBLIC_KEY",
            privateKey: "YOUR_PRIVATE_KEY",
            limitRate: emailjs.LimitRate(
              id: 'app',
              throttle: 10000,
            ),
          ),
        );
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        SnackbarComp.snackDefault(
          title: "Berhasil!",
          message: "Email berhasil terkirim",
          backgroundColor: _theme.getButtonHoverColor,
          titleColor: _theme.getSoftFontColor,
          messageColor: _theme.getSoftFontColor,
          snackPosition: SnackPosition.TOP,
          icon: Icon(
            Icons.check_circle,
            color: _theme.getSoftFontColor,
            size: 40,
          ),
        );
      } catch (error) {
        if (error is emailjs.EmailJSResponseStatus) {
          SnackbarComp.snackDefault(
            title: "Gagal!",
            message: "Email Error : $error",
            backgroundColor: Colors.red.shade100,
            titleColor: Colors.red,
            messageColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(
              Icons.error,
              color: Colors.red,
              size: 40,
            ),
          );
        } else {
          SnackbarComp.snackDefault(
            title: "Gagal!",
            message: "Error : $error",
            backgroundColor: Colors.red.shade100,
            titleColor: Colors.red,
            messageColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(
              Icons.error,
              color: Colors.red,
              size: 40,
            ),
          );
        }
      }
    } else {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email wajib diisi';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Format email tidak valid';
    return null;
  }

  InputDecoration buildInputDecoration(String label, {bool isMessage = false}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        fontSize: 16,
        color: _theme.getSoftFontColor,
      ),
      alignLabelWithHint: isMessage,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: _theme.getSoftFontColor, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: _theme.getHighFontColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 0.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      filled: true,
      fillColor: _theme.getSoftContainerColor,
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType inputType = TextInputType.text,
    TextInputAction inputAction = TextInputAction.next,
    int maxLines = 1,
    int maxLength = 100,
    bool isMessage = false,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: inputType,
      textInputAction: inputAction,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 16),
      inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
      decoration: buildInputDecoration(label, isMessage: isMessage),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final double maxWidth =
    //     CustomStyle.conditionDevice(context) ? double.infinity : 1000;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 100),
      child: SlideFadeOnVisibleComp(
        offsetX: 0,
        duration: const Duration(seconds: 2),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HoverScaleWrapper(
                scale: 1.2,
                child: Column(
                  children: [
                    Text(
                      "KONTAK",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: _theme.getHighFontColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 50,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _theme.getSoftFontColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              HoverScaleWrapper(
                scale: 1.03,
                child: Text(
                  "Silakan isi formulir di bawah ini untuk menghubungi saya. Pesan Anda akan langsung dikirim ke email saya dan akan saya balas secepat mungkin.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: _theme.getHighFontColor,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 1000),
                        child: buildTextField(
                          label: "Nama",
                          controller: _nameController,
                          validator: (v) => v == null || v.isEmpty
                              ? 'Nama wajib diisi'
                              : null,
                          maxLength: 50,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 1000),
                        child: buildTextField(
                          label: "Email",
                          controller: _emailController,
                          validator: validateEmail,
                          inputType: TextInputType.emailAddress,
                          maxLength: 50,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 1000),
                        child: buildTextField(
                          label: "Pesan",
                          controller: _messageController,
                          validator: (v) => v == null || v.isEmpty
                              ? 'Pesan wajib diisi'
                              : null,
                          inputType: TextInputType.multiline,
                          inputAction: TextInputAction.newline,
                          maxLines: 10,
                          maxLength: 2000,
                          isMessage: true,
                        ),
                      ),
                      const SizedBox(height: 25),
                      HoverScaleWrapper(
                        onTap: sendEmail,
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                            color: _theme.getButtonHoverColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Kirim",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _theme.getSoftFontColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.send,
                                color: _theme.getSoftFontColor,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
