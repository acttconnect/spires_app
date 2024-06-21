import '../../../../Constants/exports.dart';

class ViewCV extends StatelessWidget {
  final String pdfUrl;
  const ViewCV({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV'),
      ),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
