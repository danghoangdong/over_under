import 'package:flutter/material.dart';
import 'dart:math';

class TaiXiuGame extends StatefulWidget {
  TaiXiuGame({Key? key}) : super(key: key);

  @override
  _TaiXiuGameState createState() => _TaiXiuGameState();
}

class _TaiXiuGameState extends State<TaiXiuGame> {
  int _tongDiem = 0;
  String _ketQua = '';
  int _betAmount = 0;
  bool _isBetting = false;

  void _quay() {
    // Tạo ngẫu nhiên 3 số từ 1 đến 6
    final random = new Random();
    int a = random.nextInt(6) + 1;
    int b = random.nextInt(6) + 1;
    int c = random.nextInt(6) + 1;

    _tongDiem = a + b + c;

    // Tính kết quả Tài hay Xỉu
    String ketQua = '';
    if (_tongDiem < 9) {
      ketQua = 'Xỉu';
    } else {
      ketQua = 'Tài';
    }
    _ketQua = ketQua;
  }

  void _chonTai() {
    setState(() {
      if (_isBetting) {
        _quay();

        // Kiểm tra kết quả và tính tiền thưởng hoặc mất tiền
        if (_ketQua == 'Tài') {
          _ketQua = 'Bingo';
          _betAmount *= 2;
        } else {
          _ketQua = 'Fail';
          _betAmount = 0;
        }

        _isBetting = false;
      } else {
        _isBetting = true;
      }
    });
  }

  void _chonXiu() {
    setState(() {
      if (_isBetting) {
        _quay();

        // Kiểm tra kết quả và tính tiền thưởng hoặc mất tiền
        if (_ketQua == 'Xỉu') {
          _ketQua = 'Bingo';
          _betAmount *= 2;
        } else {
          _ketQua = 'Fail';
          _betAmount = 0;
        }

        _isBetting = false;
      } else {
        _isBetting = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Game Tài Xỉu'),
        ),
        body:
            Stack(// Wrap content with a Stack widget to position the bet amount
                children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/nen.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tổng điểm: $_tongDiem',
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _chonTai,
                      child: Text('Tài'),
                    ),
                    SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: _chonXiu,
                      child: Text('Xỉu'),
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                Text(
                  'Kết quả: $_ketQua',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: _ketQua == 'Bingo' ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              // Position the bet amount element at the top left corner
              top: 0.0,
              left: 0.0,
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black,
                  child: Row(children: [
                    Text(
                      'Bet Amount: $_betAmount',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            int amountToAdd = 10;
                            return AlertDialog(
                              title: Text('Add Bet Amount'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('How much do you want to add?'),
                                  SizedBox(height: 16.0),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      amountToAdd = int.tryParse(value) ?? 0;
                                    },
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _betAmount += amountToAdd;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Add'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(Icons.add),
                    )
                  ])))
        ]));
  }
}
