import 'package:flutter/material.dart';
import 'dart:math';

class TaiXiuGame extends StatefulWidget {
  const TaiXiuGame({Key? key}) : super(key: key);

  @override
  _TaiXiuGameState createState() => _TaiXiuGameState();
}

class _TaiXiuGameState extends State<TaiXiuGame> {
  int _tongDiem = 0;
  String _ketQua = '';
  int _money = 50000;
  bool _isBetting = false;
  int betAmount = 0;
  int a = 1;
  int b = 1;
  int c = 1;

  void _quay() {
    // Tạo ngẫu nhiên 3 số từ 1 đến 6
    var random = Random();
    int a = random.nextInt(6) + 1;
    int b = random.nextInt(6) + 1;
    int c = random.nextInt(6) + 1;

    setState(() {
      this.a = a;
      this.b = b;
      this.c = c;

      _tongDiem = a + b + c;

      // Tính kết quả Tài hay Xỉu
      if (_tongDiem < 9) {
        _ketQua = 'Xỉu';
      } else {
        _ketQua = 'Tài';
      }
    });
  }

  void _chonTai() async {
    if (!_isBetting) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Nhập tiền cược'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Cược bao nhiêu tiền'),
                const SizedBox(height: 16.0),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    betAmount = int.tryParse(value) ?? 0;
                  },
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _money -= betAmount;
                    _isBetting = true;
                  });
                  _quay();

                  Navigator.of(context).pop();
                },
                child: const Text('Cược'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Hủy'),
              ),
            ],
          );
        },
      );
    } else {
      // Kiểm tra kết quả và tính tiền thưởng hoặc mất tiền
      if (_ketQua == 'Tài') {
        _ketQua = 'Bingo';
        _money += 2 * betAmount;
      } else {
        _ketQua = 'Fail';
        betAmount = 0;
      }

      _isBetting = false;
    }
  }

  void _chonXiu() async {
    if (!_isBetting) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Nhập tiền cược'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Cược bao nhiêu tiền'),
                const SizedBox(height: 16.0),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    betAmount = int.tryParse(value) ?? 0;
                  },
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _money -= betAmount;
                    _isBetting = true;
                  });
                  _quay();

                  Navigator.of(context).pop();
                },
                child: const Text('Cược'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Hủy'),
              ),
            ],
          );
        },
      );
    } else {
      // Kiểm tra kết quả và tính tiền thưởng hoặc mất tiền
      if (_ketQua == 'Xỉu') {
        _ketQua = 'Bingo';
        _money += 2 * betAmount;
      } else {
        _ketQua = 'Fail';
        betAmount = 0;
      }

      _isBetting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Game Tài Xỉu'),
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
                image: AssetImage('assets/imges/nen.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Text('Tổng điểm: $_tongDiem',
                    style: const TextStyle(fontSize: 24.0)),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/imges/$a.png',
                      width: 80.0,
                      height: 80.0,
                    ),
                    const SizedBox(width: 16.0),
                    Image.asset(
                      'assets/imges/$b.png',
                      width: 80.0,
                      height: 80.0,
                    ),
                    const SizedBox(width: 16.0),
                    Image.asset(
                      'assets/imges/$c.png',
                      width: 80.0,
                      height: 80.0,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _chonTai,
                      child: const Text('Tài'),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: _chonXiu,
                      child: const Text('Xỉu'),
                    ),
                  ],
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
                      'Money: $_money',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            int amountToAdd = 10;
                            return AlertDialog(
                              title: const Text('Nạp Tiền'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Số tiền nạp'),
                                  const SizedBox(height: 16.0),
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
                                      _money += amountToAdd;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Nạp'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Hủy'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Icon(Icons.add),
                    )
                  ])))
        ]));
  }
}
