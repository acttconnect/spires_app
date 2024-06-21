import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Model/show_plan_model.dart';

class UpgradeNow extends StatefulWidget {
  const UpgradeNow({super.key});

  @override
  State<UpgradeNow> createState() => _UpgradeNowState();
}

class _UpgradeNowState extends State<UpgradeNow> {
  int planId = 0;
  final _razorpay = Razorpay();
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    HomeUtils.purchasePlan(planId);
    Fluttertoast.showToast(msg: response.paymentId!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: response.walletName.toString());
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade Now'),
      ),
      body: FutureBuilder<ShowPlanModel>(
        future: HomeUtils.showPlan(),
        builder: (context, snapshot) => snapshot.hasData
            ? Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) =>
                      planCard(snapshot, index, size),
                ),
              )
            : loading,
      ),
    );
  }

  MyContainer planCard(
      AsyncSnapshot<ShowPlanModel> snapshot, int index, Size size) {
    final item = snapshot.data!.data![index];
    return MyContainer(
      padding: const EdgeInsets.all(defaultPadding),
      margin: const EdgeInsets.only(bottom: defaultPadding),
      child: Column(
        children: [
          Text(item.planName!, style: normalColorText),
          Text(item.planTitle ?? 'Interview Guide', style: smallText),
          const SizedBox(height: 12),
          Text(
            '₹${item.price!}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w100,
            ),
          ),
          Text(item.planSubTitle ?? 'Key Benefits', style: smallText),
          const SizedBox(height: 16),
          ListView.builder(
            itemCount: snapshot.data!.data![index].list!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, ind) =>
                featuresRow(snapshot.data!.data![index].list![ind], size),
          ),
          const SizedBox(height: 12),
          myButton(
            onPressed: () {
              planId = item.id!.toInt();
              var options = {
                'key': 'rzp_test_Xnvv8oiApC5dMT',
                'amount': double.parse(item.price!) * 100,
                'name': 'Spires Recruit',
                'description': 'Apply for latest Jobs and Internships',
                'theme': {'color': '#F38E27'},
                'prefill': {
                  'contact': MyController.userPhone,
                  'email': MyController.userEmail,
                }
              };
              _razorpay.open(options);
            },
            label: 'Buy Now',
            color: primaryColor,
            style: normalWhiteText,
          ),
          const Divider(),
          Align(
            alignment: Alignment.centerRight,
            child:
                Text('Validity : ${item.duration!} Months', style: smallText),
          ),
        ],
      ),
    );
  }

  Padding featuresRow(String feature, Size size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: size.width - 85,
            child: Text(feature, style: normalBoldText),
          )
        ],
      ),
    );
  }
}
