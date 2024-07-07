import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:signing/VideoPage.dart';
import 'package:signing/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController? _controller;
  late Razorpay _razorPay;
  bool isClicked = false;
  final List<Widget> tabs = [
    Tab(
      text: '  For You  ',
    ),
    Tab(
      text: '  Premium  ',
    ),
    Tab(
      text: '  TATA IPL  ',
    ),
    Tab(
      text: '  Free Movies  ',
    ),
    Tab(
      text: '  Anime  ',
    ),
    Tab(
      text: '  NBA  ',
    ),
    Tab(
      text: '  MTV Splitsvilla X5  ',
    ),
    Tab(
      text: '  TATA IPL Final  ',
    ),
    Tab(
      text: '  Short Clips  ',
    ),
  ];

  Future<void> openPayment(amount)async{
    amount = amount*100;
    var options= {
      'key':'rzp_test_j4KJZHBzB6k7UN',
      'amount':amount,
      'name':'Bikes',
      'prefill':{
        'contact':'9786140808',
        'email':'test@gmail.com'
      },
      'external':{
        'wallets':['paytm']
      }
    };
    try{
      _razorPay.open(options);
    }catch(e){
      ScaffoldMessenger.of(context).
      showSnackBar(
          SnackBar(
            content: Text('Error : $e'),
            duration: const Duration(seconds: 2),
          ));
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response){
    ScaffoldMessenger.of(context).
    showSnackBar(
        SnackBar(
          content: Text('Paid Successfully ${response.paymentId}'),
          duration: const Duration(seconds: 2),
        ));
  }
  void handlePaymentFailure(PaymentFailureResponse resF){
    ScaffoldMessenger.of(context).
    showSnackBar(
        SnackBar(
          content: Text('Payment Error ${resF.error}'),
          duration: const Duration(seconds: 2),
        ));
  }
  void handlePaymentWallet(ExternalWalletResponse resW){
    ScaffoldMessenger.of(context).
    showSnackBar(
        SnackBar(
          content: Text('Payment Error ${resW.walletName}'),
          duration: const Duration(seconds: 2),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _razorPay.clear();
  }

  @override
  void initState() {
    _controller = TabController(length: tabs.length, vsync: this);
    super.initState();
    _razorPay=Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlePaymentWallet);
  }

  List<String> images = [
    "assets/m1.jpg",
    "assets/m2.jpg",
    "assets/m3.jpg",
    "assets/m5.jpg",
    "assets/m6.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromRGBO(7, 93, 27, 2), Colors.black])),
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 140,
                backgroundColor: Color.fromRGBO(7, 93, 27, 2),
                leading: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/jio.jpg')),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                title: Container(
                  width: 135,
                  height: 35,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(7, 93, 27, 2)),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side:
                              BorderSide(color: CupertinoColors.systemYellow)),
                      onPressed: () {
                        setState(() {
                          showModalBottomSheet(
                              context: context,
                              builder: (builder){
                                return new Container(
                                  height: MediaQuery.of(context).size.height/2.5,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    // color: Colors.blue[100],
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color.fromRGBO(7, 93, 27, 2), Colors.black]),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
                                  ),
                                  child: Center(
                                      child: Column(
                                        children: [
                                          const Text('Welcome Payment',style: TextStyle(
                                              color: Color.fromRGBO(218, 225, 10, 2),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20
                                          ),),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height:200,
                                                decoration:BoxDecoration(
                                                  color: Colors.black12,
                                                  borderRadius: BorderRadius.circular(9)
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text('With Ads',style: TextStyle(
                                                      color: Color.fromRGBO(218, 225, 10, 2),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                    ),),
                                                    SizedBox(height: 20,),
                                                    Text('100',style: TextStyle(
                                                        color:Color.fromRGBO(218, 225, 10, 2),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20
                                                    ),),
                                                    SizedBox(height: 10,),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: SizedBox(
                                                        height: 45,
                                                        width: MediaQuery.of(context).size.width/2.8,
                                                        child: ElevatedButton(onPressed:(){
                                                          setState(() {
                                                            int a=100;
                                                            openPayment(a);
                                                          });
                                                        }, child: Text('Pay',style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor: Color.fromRGBO(7, 93, 27, 2)
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 200,
                                                decoration:BoxDecoration(
                                                    color: Colors.black12,
                                                    borderRadius: BorderRadius.circular(9)
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text('Without Ads',style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromRGBO(218, 225, 10, 2),
                                                      fontSize: 20
                                                    ),),
                                                    SizedBox(height: 20,),
                                                    Text('200',style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromRGBO(218, 225, 10, 2),
                                                        fontSize: 20
                                                    ),),
                                                    SizedBox(height: 10,),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: SizedBox(
                                                        height: 45,
                                                        width: MediaQuery.of(context).size.width/2.8,
                                                        child: ElevatedButton(onPressed:(){
                                                          setState(() {
                                                            int a=200;
                                                            openPayment(a);
                                                          });
                                                        }, child: Text('Pay',style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor: Color.fromRGBO(7, 93, 27, 2)
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                  ),
                                );
                              }
                          );
                        });
                      },
                      child: Row(
                        children: [
                          Iconify(
                            Mdi.crown,
                            color: CupertinoColors.systemYellow,
                          ),
                          Text(
                            ' Go Premium',
                            style: TextStyle(
                                fontSize: 10,
                                color: CupertinoColors.systemYellow),
                          )
                        ],
                      )),
                ),
                actions: [
                  Icon(
                    CupertinoIcons.search,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()),
                      );
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/pro.jpg')),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
                bottom: TabBar(
                    tabAlignment: TabAlignment.start,
                    dragStartBehavior: DragStartBehavior.start,
                    indicator: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(40)),
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    isScrollable: true,
                    controller: _controller,
                    tabs: tabs),
                pinned: true,
              )
            ];
          },
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 400,
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                      animateToClosest: true,
                      viewportFraction: 0.89,
                      autoPlay: true,
                      height: 600.0),
                  itemCount: images.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return Container(
                      child: Stack(
                        children: [
                          Container(
                            height: 400,
                            width: 350,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white30),
                                borderRadius: BorderRadius.circular(9),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(images[index]))),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 99,
                            right: 99,
                            child: SizedBox(
                              width: 152,
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pink),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Videopage()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.play_arrow_solid,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Watch Now',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'In The Spotlight',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/m6.jpg')),
                            borderRadius: BorderRadius.circular(9)),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Icon(
                            Icons.workspace_premium,
                            color: Colors.yellow,
                          )),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/m6.jpg')),
                            borderRadius: BorderRadius.circular(9)),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Icon(
                            Icons.workspace_premium,
                            color: Colors.yellow,
                          )),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Continue Watching',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 159,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 140,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/m5.jpg')),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 140,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/m5.jpg')),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 140,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/m5.jpg')),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 140,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/m5.jpg')),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
