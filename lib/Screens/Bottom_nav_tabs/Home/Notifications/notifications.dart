import '../../../../Constants/exports.dart';
import '../../../../Model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notification'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: FutureBuilder<NotificationModel>(
            future: HomeUtils.showNotifications(),
            builder: (context, snapshot) => snapshot.hasData
                ? snapshot.data!.data!.isEmpty
                    ? noNotification(size)
                    : notificationCard(size, snapshot)
                : loading,
          ),
        ),
      ),
    );
  }

  Center noNotification(Size size) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.2),
          const Icon(Icons.circle_notifications,
              size: 170, color: primaryColor),
          Text('No Notifications Yet', style: xLargeLightText)
        ],
      ),
    );
  }

  Widget notificationCard(
      Size size, AsyncSnapshot<NotificationModel> snapshot) {
    final item = snapshot.data!.data!;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data!.data!.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: RoundedContainer(
          color: whiteColor,
          width: size.width,
          padding: const EdgeInsets.all(defaultPadding),
          isImage: false,
          child: IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item[index].date!.split(' ').first,
                        textAlign: TextAlign.center,
                        style: largeLightText,
                      ),
                      Text(
                        item[index].date!.split(' ')[1],
                        textAlign: TextAlign.center,
                        style: mediumLightText,
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item[index].type!,
                      style: mediumBoldText,
                    ),
                    SizedBox(
                      width: size.width - 125,
                      child: Text(
                        item[index].message!,
                        style: smallLightText,
                      ),
                    ),
                    Text(
                      item[index].time!,
                      style: smallLightText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
