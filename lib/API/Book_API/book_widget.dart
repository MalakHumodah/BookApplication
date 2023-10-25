import 'package:flutter/material.dart';
import 'package:myapp/API/Book_API/book_model_API.dart';

class BookItemView extends StatelessWidget {
  const BookItemView({Key? key, required this.model, required this.onTab})
      : super(key: key);

  final BookModel model;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Hero(
                tag: 'category${model.totalItems}',
                child: SizedBox(
                  height: 100,
                  child: Image.asset('assets/Imgs/img1.png')
                )),
            SizedBox(
              height: 3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(model.kind!.length>10?model.kind!.substring(0,10):model.kind!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(
                  /*model.volumeInfo?.description!.length > 30
                      ? model.volumeInfo?.description?.substring(0, 15)
                      : model.volumeInfo.description!,*/
                  '${model.items?[0]}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${model.items?[0]}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.pink,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
