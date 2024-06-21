import '../../../Constants/exports.dart';

class MyDrawer extends StatelessWidget {
  final Size size;
  const MyDrawer({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              SizedBox(
                height: 75,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildItem('Applications', Icons.widgets,
                          () => Get.to(() => const AppliedData())),
                      buildItem('Saved', Icons.beenhere,
                          () => Get.to(() => const SavedData())),
                      buildItem('Preference', Icons.tune,
                          () => Get.to(() => Preferences())),
                    ]),
              ),
              const Divider(),
              ListView.builder(
                itemCount: myProfileList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildTile(
                  onTap: myProfileList[index].onTap,
                  title: myProfileList[index].label,
                  iconData: myProfileList[index].image,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$appName\nUnit of Act T Connect (P) Ltd.',
                    textAlign: TextAlign.center,
                    style: xsmallText,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(String title, IconData iconData, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
              radius: 25,
              backgroundColor: primaryColor,
              child: Icon(
                iconData,
                color: whiteColor,
              )),
          const SizedBox(height: 3),
          Text(title, style: smallText),
        ],
      ),
    );
  }

  ListTile buildTile(
      {required void Function() onTap,
      required IconData iconData,
      required String title}) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      onTap: onTap,
      visualDensity: VisualDensity.compact,
      dense: true,
      tileColor: whiteColor,
      leading: Icon(
        iconData,
        color: primaryColor,
      ),
      title: Text(title, style: smallText),
    );
  }
}
