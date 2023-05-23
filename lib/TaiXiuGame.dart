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
      _quay();

      // Kiểm tra kết quả
      if (_ketQua == 'Tài') {
        _ketQua = 'Bingo';
      } else {
        _ketQua = 'Fail';
      }
    });
  }

  void _chonXiu() {
    setState(() {
      _quay();

      // Kiểm tra kết quả
      if (_ketQua == 'Xỉu') {
        _ketQua = 'Bingo';
      } else {
        _ketQua = 'Fail';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Tài Xỉu'),
      ),
      body: Center(
          child: Container(
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
      )),
    );
  }
}
