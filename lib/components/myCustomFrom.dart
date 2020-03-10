import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
// Formウィジェット内の各フォームを識別するためのキーを設定
  final _formKey = GlobalKey<FormState>();

  // フォーカス管理用のFocusNode
  final nameFocus = FocusNode();
  final ageFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // 作成したフォームキーを指定
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'テキストを入力してください。';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              // 送信ボタンクリック時の処理
              onPressed: () {
                // バリデーションチェック
                if (_formKey.currentState.validate()) {
                  // バリデーションが通ればスナックバーを表示
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('更新しました。')));
                }
              },
              child: Text('送信する'),
            ),
          )
        ],
      ),
    );
  }
}