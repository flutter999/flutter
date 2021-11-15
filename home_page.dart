import 'package:auto_route/auto_route.dart' as route;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_carousel/carousel.dart';
import 'package:go_watch_this/application/auth/auth_bloc.dart';
import 'package:go_watch_this/domain/push_notifications/i_notifications_facade.dart';
import 'package:go_watch_this/infrastructure/push_notifications/firebase_notifications_facade.dart';
import 'package:go_watch_this/injection.dart';
import 'package:go_watch_this/presentation/pages/home/notifications/notifications_page.dart';
import 'package:go_watch_this/presentation/routes/router.gr.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    CarouselExample(),
    FullscreenSliderDemo(),
    NotesOverviewPage(),
    TestPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _setupPushNotificationsListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: const Text('GoWatchThis'),
//      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Discover'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  void _setupPushNotificationsListener() {
    getIt<INotificationsFacade>().listen(
      onMessage: (message) {
        print("onMessage $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title'] ?? message['title']),
              subtitle:
                  Text(message['notification']['body'] ?? message['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (message) {
        print("onResume $message");
      },
      onLaunch: (message) {
        print("onLaunch $message");
      },
    );
  }
}
class FullscreenSliderDemo extends StatelessWidget {
  static const List<String> imgList = [
    'https://go-watch-this-images.s3.amazonaws.com/poster/w500/588817.jpg',
    'https://go-watch-this-images.s3.amazonaws.com/poster/w500/588806.jpg',
    'https://go-watch-this-images.s3.amazonaws.com/poster/w500/170618.jpg',
    'https://image.tmdb.org/t/p/w500//3O1lB4ZhTMZ0Q3VsU7SHtFBDYI1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              scrollDirection: Axis.vertical,
              // autoPlay: false,
            ),
            items: imgList.map((item) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                child: Center(
                    child: Image.network(item, fit: BoxFit.cover, height: height,)
                ),
              ),
            )).toList(),
          );
        },
      ),
    );
  }
}
class VerticalSliderDemo extends StatelessWidget {
  static const List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
    'https://go-watch-this-images.s3.amazonaws.com/poster/w500/170618.jpg'
  ];

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vertical sliding carousel demo')),
      body: Center(
        child: Container(
            child: CarouselSlider(
          options: CarouselOptions(
//            aspectRatio: 2.0,
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
            autoPlay: true,
          ),
          items: imageSliders,
        )),
      ),
    );
  }
}

class CarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Carousel(
            height: 350.0,
            width: 350,
            initialPage: 3,
            allowWrap: false,
            type: Types.yRotating,
            onCarouselTap: (i) {
              print("onTap $i");
            },
//            indicatorType: IndicatorTypes.dot,
//            arrowColor: Colors.black,
            axis: Axis.vertical,
//            showArrow: true,
            children: List.generate(
                7,
                (i) => Center(
                      child:
                          Container(color: Colors.red.withOpacity((i + 1) / 7)),
                    ))),
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Text('I am initial! 2'),
          authenticated: (_) => SafeArea(
            child: Center(
                child: Column(
              children: [
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(AuthEvent.signedOut());
                  },
                  color: Colors.lightBlue,
                  child: const Text(
                    'DEV SIGN OUT...',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    getIt<INotificationsFacade>().requestPushNotifications();
                  },
                  color: Colors.lightBlue,
                  child: const Text(
                    'request push notifications... ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                    'I am authenticated in T2! ${BlocProvider.of<AuthBloc>(context).state}'),
              ],
            )),
          ),
          unauthenticated: (_) => const PromptSignInPage(),
        );
      },
    );
  }
}

class PromptSignInPage extends StatelessWidget {
  const PromptSignInPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Sign in to continue!"),
          RaisedButton(
            onPressed: () {
              route.ExtendedNavigator.of(context).push(Routes.signInPage);
            },
            color: Colors.lightBlue,
            child: const Text(
              'SIGN IN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
