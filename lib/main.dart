import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widget/weather_data_tile.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: WeatherPage(),
    );
  }
}
class WeatherPage extends StatefulWidget {
  @override
  State<WeatherPage> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }
  //geting data form api key
  final TextEditingController _controller = TextEditingController();
  String _bgImage = 'assets/images/clear.jpg';
  String _iconsImage = 'assets/icons/Clear.png';
  String _cityName = '';
  String _temperature = '';
  String _tempMax = '';
  String _tempMin = '';
  String _sunrise = '';
  String _sunset = '';
  String _main = '';
  String _pressure = '';
  String _humidity = '';
  String _visibility = '';
  String _windSpeed = '';
  getData(String cityName) async {
    final weatherServices = WeatherServices();

    var weatherData;
    if(cityName == '')
      weatherData = await weatherServices.fetchWeather();
    else
      weatherData = await weatherServices.getWeather(cityName);
    debugPrint(weatherData.toString());
    setState(() {
      _cityName = weatherData['name'];
      _temperature = weatherData['main']['temp'].toStringAsFixed(1);
      _main = weatherData['weather'][0]['main'];
      _tempMax = weatherData['main']['temp_max'].toStringAsFixed(1);
      _tempMin = weatherData['main']['temp_min'].toStringAsFixed(1);
      _sunrise = DateFormat('hh:mm a').format(
        DateTime.fromMicrosecondsSinceEpoch(
          weatherData['sys']['sunrise'] * 1000
        )
      );
      _sunset = DateFormat('hh:mm a').format(
          DateTime.fromMicrosecondsSinceEpoch(
              weatherData['sys']['sunset'] * 1000
          )
      );
      _pressure = weatherData['main']['pressure'].toString();
      _humidity = weatherData['main']['humidity'].toString();
      _visibility = weatherData['visibility'].toString();
      _windSpeed = weatherData['wind']['speed'].toString();
      //checking state of weather to change the images and icon on main page
      if (_main == 'Clear') {
        _bgImage = 'assets/images/clear.jpg';
        _iconsImage = 'assets/icons/Clear.png';
      } else if (_main == 'Clouds') {
        _bgImage = 'assets/images/clouds.jpg';
        _iconsImage = 'assets/icons/Clouds.png';
      } else if (_main == 'Rain') {
        _bgImage = 'assets/images/rain.jpg';
        _iconsImage = 'assets/icons/Rain.png';
      } else if (_main == 'Fog') {
        _bgImage = 'assets/images/fog.jpg';
        _iconsImage = 'assets/icons/Haze.png';
      } else if (_main == 'Thunderstorm') {
        _bgImage = 'assets/images/thunderstorm.jpg';
        _iconsImage = 'assets/icons/Thunderstorm.png';
      } else {
        _bgImage = 'assets/images/haze.jpg';
        _iconsImage = 'assets/icons/Haze.png';
      }
    });
  }

  //check for location
  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
      getData('');
    }
    getData('');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            _bgImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 SizedBox(height: 45,),
                 TextField(
                   controller: _controller,
                   onChanged: (value){
                     getData(value);
                   },
                   decoration:const InputDecoration(
                       suffixIcon: Icon(Icons.search),
                       filled: true,
                       fillColor: Colors.black26,
                       hintText: 'Enter A City Name',
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(16))
                       )),
                 ),
                 SizedBox(height: 28),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_sharp),
                      Text(
                          _cityName,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500
                          )
                      )
                    ]
                ),
                 SizedBox(height: 55,),
                 Text(
                  '$_temperature℃',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 90,
                    fontWeight: FontWeight.bold
                  ),
                ),
                  Row(
                    children: [
                       Text(
                        _main,
                        style:const TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                      ),
                      Image.asset(
                        _iconsImage,
                        height: 80,
                      )
                    ],
                  ),
                   SizedBox(height: 28,),
                   Row(
                    children: [
                      const Icon(Icons.arrow_upward),
                      Text('$_tempMax℃', style:const TextStyle(
                        fontSize: 25,
                        fontStyle: FontStyle.italic
                      ),),
                       const Icon(Icons.arrow_downward),
                      Text('$_tempMin℃', style:const TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic
                      ),)
                    ],
                  ),
                   SizedBox(height: 35,),
                   Card(
                    elevation: 4,
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(children: [
                        WeatherDataTile(index1: 'Sunrise', index2: 'Sunset', value1: _sunrise, value2: _sunset,),
                        SizedBox(height: 15,),
                        WeatherDataTile(index1: 'Humidity', index2: 'Visibility', value1: _humidity, value2: _visibility,),
                        SizedBox(height: 15,),
                        WeatherDataTile(index1: 'Pressure', index2: 'Wind Speed', value1: _pressure, value2: _windSpeed,)
                      ],),
                    ),
                  )
              ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


