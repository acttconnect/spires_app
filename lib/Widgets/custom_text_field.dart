import 'package:intl/intl.dart';
import '../Constants/exports.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword,
    this.isEmail,
    this.isPhone,
    required this.iconData,
    this.isDate,
    this.isStartDate,
    this.keyboardType,
    this.isNumeric,
  });
  final TextEditingController controller;
  final IconData iconData;
  final String hintText;
  final bool? isPassword;
  final bool? isEmail;
  final bool? isNumeric;
  final bool? isPhone;
  final bool? isDate;
  final bool? isStartDate;
  final TextInputType? keyboardType;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;
  bool isPasswordVisible = false;
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          readOnly: widget.isDate ?? false ? true : false,
          onTap: () async {
            if (widget.isDate ?? false) {
              if (widget.isStartDate ?? false) {
                final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now());
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd-MMM-yyyy').format(pickedDate);
                  setState(() {
                    c.startDate.value = pickedDate;
                    widget.controller.text = formattedDate;
                  });
                }
              } else if (c.startDate.value.year != 1999) {
                final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(
                      c.startDate.value.year,
                      c.startDate.value.month,
                      c.startDate.value.day,
                    ),
                    firstDate: DateTime(
                      c.startDate.value.year,
                      c.startDate.value.month,
                      c.startDate.value.day,
                    ),
                    lastDate: DateTime.now());
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd-MMM-yyyy').format(pickedDate);
                  setState(() {
                    widget.controller.text = formattedDate;
                  });
                }
              } else {
                Fluttertoast.showToast(msg: 'Please select start date first');
              }
            } else {
              null;
            }
          },
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ?? false ? showPassword : false,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword ?? false
                ? IconButton(
                    onPressed: () {
                      showPassword = !showPassword;
                      isPasswordVisible = !isPasswordVisible;
                      setState(() {});
                    },
                    icon: showPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: smallLightText,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Icon(widget.iconData),
            ),
          ),
          validator: (value) {
            const pattern =
                r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
            const stringPattern = (r'^[a-zA-Z.\s]+$');
            final regExp = RegExp(pattern);
            final regStrExp = RegExp(stringPattern);
            if (widget.isPassword ?? false) {
              if (value!.isEmpty) {
                return 'Enter password';
              } else if (value.length < 6) {
                return 'Enter atleast 6 letter password';
              }
            } else if (widget.isEmail ?? false) {
              if (value!.isEmpty) {
                return 'Enter an E-mail';
              } else if (!regExp.hasMatch(value.trim())) {
                return 'Enter an valid E-mail address';
              }
            } else if (widget.isPhone ?? false) {
              if (value!.isEmpty) {
                return 'Enter your Mobile number';
              } else if (value.length != 10) {
                return 'Enter an valid 10 digit Mobile number';
              }
            } else if (widget.isDate ?? false) {
              if (value!.isEmpty) {
                return 'Date is required';
              }
            } else if (widget.isNumeric ?? false) {
              if (value!.isEmpty) {
                return 'This is required';
              }
            } else {
              if (value!.isEmpty) {
                return 'This is required';
              } else if (!regStrExp.hasMatch(value.trim())) {
                return 'Enter an valid name with alphabets characters';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
