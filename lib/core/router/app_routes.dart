
/// Route class to access route name and path effectively
library;

class Route {
  String path;
  String name;
  Route({
    required this.path,
    required this.name,
  });
}

class AppRoutes {
  AppRoutes._();
  static Route launch = Route(path: '/launch', name: 'launch');
  static Route welcome = Route(path: '/welcome', name: 'welcome');
  static Route signUp = Route(path: '/signUp', name: 'signUp');
  static Route signIn = Route(path: '/signIn', name: 'signIn');
  static Route home = Route(path: '/home', name: 'home');
  static Route chatRoom = Route(path: '/chatRoom', name: 'chatRoom');
  static Route about = Route(path: '/about', name: 'about');

  // static Route productDetails = Route(path: '/productDetails', name: 'productDetails');
}
