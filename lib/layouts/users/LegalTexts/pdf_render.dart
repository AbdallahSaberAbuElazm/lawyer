import 'package:flutter/material.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ignore: must_be_immutable
class PdfRender extends StatelessWidget {
  String fileName;
  String url;
  PdfRender({Key? key, required this.fileName, required this.url})
      : super(key: key);

  final PdfViewerController _pdfViewerController = PdfViewerController();
  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text(
            fileName,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.jumpToPage(3);
              },
            ),
          ],
        ),
        body: SfPdfViewer.network(
          url,
          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
            //print(details.document.pages.count);
          },
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
            AlertDialog(
              title: Text(details.error),
              content: Text(details.description),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('تمام'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ));
  }
}
