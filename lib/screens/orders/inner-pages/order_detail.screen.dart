import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:sieves_courier/constants.dart';
import 'package:sieves_courier/models/order.model.dart';
import 'package:sieves_courier/models/order_item.model.dart';
import 'package:sieves_courier/providers/order.provider.dart';
import 'package:sieves_courier/screens/orders/inner-pages/order_item.dart';
import 'package:sieves_courier/widgets/time_difference.widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({required this.order});
  final Order order;
  
  String getAddress(Map<String, dynamic> address) {
    if (address['address_2'] == null) {
      final district = address['district'];
      final decodedAddress = json.decode(address['address']);
      return district + ', ' + decodedAddress['street'] + ', ' + decodedAddress['house'];
    } else {
      final address_2 = address['address_2'].toString().split(',');
      return address_2[0] + ', ' + address_2[1] + ', ' + address_2[2];
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final address = order.address;
    final _pageViewController = PageController(
        initialPage: 0
    );
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height / 2,
                child: address['lat'] == null ?
                Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_off_outlined,
                        ),
                        Text('Локация отсуствует')
                      ],
                    ),
                  ),
                ) :
                FlutterMap(
                  options: MapOptions(
                    center: latLng.LatLng(double.parse(order.address['lat']), double.parse(order.address['lng'])),
                    zoom: 15.0,
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate: "https://api.mapbox.com/styles/v1/eesah/cktcj5ag80fa518phvaaxcsnd/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZWVzYWgiLCJhIjoiY2twcDNubGJsMHM3aDJvbnU3eXdodTd1aCJ9.K9HqdRWszVvMLWJhwhE2Bw",
                        additionalOptions: {
                          "accessToken": "pk.eyJ1IjoiZWVzYWgiLCJhIjoiY2t0YmhxMnkxMXcxMTJvcGVldm1rdmdxZiJ9.v254ZybHLtEtILePGjLZYQ",
                          "id": "mapbox.mapbox-streets-v8"
                        }
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 20.0,
                          height: 20.0,
                          point: latLng.LatLng(double.parse(order.address['lat']), double.parse(order.address['lng'])),
                          builder: (ctx) =>
                              Container(
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                      Icons.arrow_back
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimeDifference(from: order.created_at, fontSize: 24, fontColor: Color(0xFF448BFF),),
              ],
            ),
          ),
          Container(
            width: size.width,
            height: 230,
            padding: const EdgeInsets.only(
                left: 20,
                right: 20,
            ),
            child: PageView(
              controller: _pageViewController,
              children: [
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Счет:',
                          style: TextStyle(
                              color: primaryGreyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                          ),
                        ),
                        Text(
                          ' № ' + order.receipt_number.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Дата: ',
                          style: TextStyle(
                              color: primaryGreyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                          ),
                        ),
                        Text(
                          order.created_at.substring(0, 10),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Тел: ',
                          style: TextStyle(
                              color: primaryGreyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                          ),
                        ),
                        Text(
                          order.customer['contacts'][0]['phone'],
                          // TODO display all phone numbers
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Адрес: ',
                          style: TextStyle(
                              color: primaryGreyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                          ),
                        ),
                        Expanded(
                          child: Text(
                            getAddress(order.address),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Тип платежа: ',
                          style: TextStyle(
                              color: primaryGreyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                          ),
                        ),
                        Text(
                          order.transactions[0]['paymentType']['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Комментарии: ',
                          style: TextStyle(
                              color: primaryGreyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                          ),
                        ),
                        Text(
                          order.note != null ? order.note.toString() : 'нет',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: order.orderItems.length,
                          itemBuilder: (context, i) =>
                              OrderItemComponent(item: order.orderItems[i]),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20
                      ),
                      width: size.width,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                  'ИТОГО:',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(order.value!.toInt().toString())
                            ],
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                  'Цена доставки: ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Expanded(child: Divider()),
                              Text(
                                  ' 12.000',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageViewController,
                count: 2,
                effect: WormEffect(
                  dotColor: Color(0xFFC4C4C4),
                  activeDotColor: Color(0xFF6D6D6D),
                  dotHeight: 10,
                  dotWidth: 10
                ),
                onDotClicked: (index) => _pageViewController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.bounceInOut),
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text(
                'Доставлен',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18
                ),
              ),
              onPressed: () {
                Provider.of<OrderProvider>(context, listen: false).closeOrder(order);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Provider.of<OrderProvider>(context).checkTimeout(order.created_at) ? primaryBlueColor : primaryRedColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 60,
                  right: 60
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
