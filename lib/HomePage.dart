import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _modalController = TextEditingController();
  final TextEditingController _hargaPertamaController = TextEditingController();
  final TextEditingController _hargaKeduaController = TextEditingController();
  final TextEditingController _hargaStopLossController =
      TextEditingController();
  String _selectedPersentaseKerugian = '1%';
  int _maksimalLot = 0;

  @override
  void dispose() {
    _modalController.dispose();
    _hargaPertamaController.dispose();
    _hargaKeduaController.dispose();
    _hargaStopLossController.dispose();
    super.dispose();
  }

  void _hitungMaksimalLot() {
    if (_formKey.currentState!.validate()) {
      final modal = int.parse(_modalController.text);
      final hargaPertama = int.parse(_hargaPertamaController.text);
      final hargaKedua = _hargaKeduaController.text.isNotEmpty
          ? int.parse(_hargaKeduaController.text)
          : 0;
      final hargaStopLoss = int.parse(_hargaStopLossController.text);
      final persentaseKerugian =
          double.parse(_selectedPersentaseKerugian.replaceAll('%', '')) / 100;

      final hargaRataRata =
          (hargaPertama + hargaKedua) / (hargaKedua != 0 ? 2 : 1);
      final kerugian = modal * persentaseKerugian;
      final maksimalLot = ((modal) ~/ (hargaRataRata * 100)).toInt();

      setState(() {
        _maksimalLot = maksimalLot.toInt() ~/ 100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hitung Maksimal Lot'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _modalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Modal'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi modal';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _hargaPertamaController,
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(labelText: 'Harga Pembelian Pertama'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi harga pembelian pertama';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _hargaKeduaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Harga Pembelian Kedua (opsional)'),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _hargaStopLossController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Harga Stop Loss'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi harga stop loss';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedPersentaseKerugian,
                    items: ['1%', '1.5%', '2%']
                        .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    decoration:
                        InputDecoration(labelText: 'Persentase Kerugian'),
                    onChanged: (value) {
                      setState(() {
                        _selectedPersentaseKerugian = value.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Mohon pilih persentase kerugian';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _hitungMaksimalLot,
                    child: Text('Hitung'),
                  ),
                  SizedBox(height: 16),
                  if (_maksimalLot > 0)
                    Text(
                      'Maksimal lot saham yang dapat dibeli adalah $_maksimalLot lot',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
