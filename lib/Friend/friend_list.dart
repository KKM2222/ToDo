import 'package:flutter/material.dart';

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  final List<String> friendList = []; // 친구 목록을 저장할 리스트

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
            ),
            child: Row(
              children: [
                Text(
                  'Friends',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    // 친구 추가 기능
                    _showAddFriendDialog(context);
                  },
                  backgroundColor: Colors.pinkAccent,
                  mini: true,
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
          // 친구 목록 출력
          Expanded(
            child: ListView.builder(
              itemCount: friendList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(friendList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // 친구 삭제 기능
                      _confirmRemoveFriend(context, index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 친구 추가 다이얼로그
  void _showAddFriendDialog(BuildContext context) {
    TextEditingController friendController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('친구 추가'),
          content: TextField(
            controller: friendController,
            decoration: InputDecoration(labelText: '친구 이름'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                _addFriend(friendController.text);
                Navigator.pop(context);
              },
              child: Text('추가'),
            ),
          ],
        );
      },
    );
  }

  // 친구 추가 함수
  void _addFriend(String friendName) {
    setState(() {
      friendList.add(friendName);
    });
  }

  // 친구 삭제 함수
  void _removeFriend(int index) {
    setState(() {
      friendList.removeAt(index);
    });
  }

  // 친구 삭제 전 확인 다이얼로그
  void _confirmRemoveFriend(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('친구 삭제'),
          content: Text('정말로 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                _removeFriend(index);
                Navigator.pop(context);
              },
              child: Text('삭제'),
            ),
          ],
        );
      },
    );
  }
}
