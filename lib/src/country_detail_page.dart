import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CountryDetailPage extends StatefulWidget {
  final String countryName;

  CountryDetailPage({required this.countryName});

  @override
  _CountryDetailPageState createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  Map<String, dynamic>? countryData;

  @override
  void initState() {
    super.initState();
    fetchCountryDetails();
  }

  Future<void> fetchCountryDetails() async {
    try {
      print('пуе  https://restcountries.com/v3.1/name/${widget.countryName}');
      var response = await Dio()
          .get('https://restcountries.com/v3.1/name/${widget.countryName}');
      setState(() {
        countryData = response.data[0];
      });
    } catch (e) {
      print('Error fetching country details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.countryName)),
      body: countryData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    countryData!['flags']['png'],
                    height: 150,
                  ),
                  const SizedBox(height: 16),
                  Text('Country: ${countryData!['name']['common']}',
                      style: TextStyle(fontSize: 20)),
                  Text(
                      'Capital: ${countryData!['capital']?.join(", ") ?? "N/A"}'),
                  Text('Population: ${countryData!['population']}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Back'),
                  ),
                ],
              ),
            ),
    );
  }
}
