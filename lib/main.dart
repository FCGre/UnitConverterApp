import 'package:flutter/material.dart';

void main() {
  runApp(const UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مبدل واحد',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Vazir', // اگر فونت فارسی داری اضافه کن
      ),
      debugShowCheckedModeBanner: false,
      home: const UnitConverterPage(),
    );
  }
}

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedCategory = 'طول';
  String _result = '';

  /// تبدیل اعداد انگلیسی به فارسی
  String _toPersianNumber(String input) {
    const english = ['0','1','2','3','4','5','6','7','8','9'];
    const persian  = ['۰','۱','۲','۳','۴','۵','۶','۷','۸','۹'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], persian[i]);
    }
    return input;
  }

  void _convert() {
    double value = double.tryParse(_controller.text) ?? 0;
    double converted = 0;
    String unit = '';

    switch (_selectedCategory) {
      case 'طول':
        converted = value / 1000; // متر به کیلومتر
        unit = ' کیلومتر';
        break;
      case 'وزن':
        converted = value / 1000; // گرم به کیلوگرم
        unit = ' کیلوگرم';
        break;
      case 'دما':
        converted = (value * 9 / 5) + 32; // سلسیوس به فارنهایت
        unit = ' درجه فارنهایت';
        break;
      case 'زمان':
        converted = value / 60; // ثانیه به دقیقه
        unit = ' دقیقه';
        break;
    }

    setState(() {
      _result = _toPersianNumber(converted.toStringAsFixed(2)) + unit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('🌀 مبدل واحد ساده'),
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'دسته‌بندی',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: ['طول', 'وزن', 'دما', 'زمان']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedCategory = val!;
                  _result = '';
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'مقدار ورودی',
                hintText: 'مثال: ۲۵۰۰',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: _convert,
              child: const Text('🔄 تبدیل کن'),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                _result,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
