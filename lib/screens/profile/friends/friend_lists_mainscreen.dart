import 'package:chronicles/screens/profile/friends/pending_friend_lists_screen.dart';
import 'package:chronicles/services/internet_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add_friends.dart';
import 'friends_list_display.dart';

final String titleMessage = "Friends";

final String yourFriendsTabButton = "Your Friends";

final String pendingTabButton = "Pending";

final double underLineTabWidth = 3.0;

final Color underLineColor = Color(0xFF4EABCC);

final titleMessageStyle = TextStyle(
  fontSize: 22.0,
  fontFamily: 'Hind',
  fontWeight: FontWeight.w500,
  color: Color(0xFF1F1F1F),
);

final tabButtonTextStyle = TextStyle(
  fontSize: 15.0,
  fontFamily: 'Hind',
  fontWeight: FontWeight.w500,
  color: Color(0xFF1F1F1F),
);

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  late TabController tabController;
  List<String> friends = [];
  List<String> pendingRequests = [];

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InternetConnectionStatus(
      enableChild: true,
      active_child: active_internet(),
      inactive_child: inactive_internet(),
    );
  }

  Widget inactive_internet() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friends"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddFriendScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person_add_alt_1_rounded),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: "Your Friends"),
            Tab(text: "Pending"),
          ],
        ),
      ),
      body: Center(
        child: Text('No Internet'),
      ),
    );
  }

  Widget active_internet() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleMessage,
          style: titleMessageStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddFriendScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person_add_alt_1_rounded),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          indicator: UnderlineTabIndicator(
            borderSide:
                BorderSide(width: underLineTabWidth, color: underLineColor),
          ),
          tabs: [
            Tab(
              child: Text(
                yourFriendsTabButton,
                style: tabButtonTextStyle,
              ),
            ),
            Tab(
              child: Text(
                pendingTabButton,
                style: tabButtonTextStyle,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          FriendsListPage(),
          PendingRequestsPage(),
        ],
      ),
    );
  }
}
