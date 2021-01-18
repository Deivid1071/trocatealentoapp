

import 'package:trocatalentos_app/model/talent.dart';
import 'package:trocatalentos_app/model/user.dart';
import 'package:trocatalentos_app/services/notification_api_service.dart';
import 'package:trocatalentos_app/services/talent_api_service.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/widgets/notification/notification_dialog.dart';
import 'package:trocatalentos_app/widgets/tiles/talent_tile.dart';

import 'detail_talent_screen.dart';

class SearchTalentScreen extends StatefulWidget {
  @override
  _SearchTalentScreenState createState() => _SearchTalentScreenState();
}

class _SearchTalentScreenState extends State<SearchTalentScreen> {
  TextEditingController _searchController;
  TalentApiService api;
  NotificationApiService apiNotification;
  String search='';
  TalentResponse initialTalentsResponse;

  @override
  void initState() {
    apiNotification = NotificationApiService();
    api = TalentApiService();
    _searchController = TextEditingController();
    _verifyNotifications();
   // getInitialData();
    super.initState();
  }

  getInitialData()async {
    TalentResponse initialTalentsResponse = await api.getTalentBySearch();
  }

  _verifyNotifications()async{
    await apiNotification.getMyNotifications();
    if(User.canceled || User.lastSchedulefinished != null || User.qtsNewProposals > 0 ){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return NotificationAlertDialog();
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: 55,
                child: TextField(
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Nunito',
                  ),
                  controller: _searchController,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        setState(() {
                          search = _searchController.text;
                        });
                      },
                      child: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                    ),
                    hintText: 'Busque um talento',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontStyle: FontStyle.italic,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onSubmitted: (value) async {
                    setState(() {
                      search = _searchController.text;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FutureBuilder(
                  future: api.getTalentBySearch(search: search),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        break;
                      case ConnectionState.waiting:
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Color(0xFF2F9C7F)),
                        );
                        break;
                      case ConnectionState.active:
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          final TalentResponse response = snapshot.data;
                          if (response.error.isNotEmpty) {
                            return Center(
                              child: Text(response.error),
                            );
                          } else {
                            if (response.resultListTalents.isNotEmpty && response.resultListTalents != null) {
                              return _buildListTalent(search.isNotEmpty ? 'Resultado da busca' : '', talentList: response.resultListTalents);
                            }else{
                              return Center(
                                child: Text('Nenhum talento a exibir.', style: TextStyle(fontFamily: 'Nunito'),),
                              );
                            }
                          }
                        }
                        return Container();
                        break;
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _buildListTalent(String title, {List<Talent> talentList}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              color: Color(0xFF365950),
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        Container(
          height: MediaQuery.of(context).size.height - 220,
          child: ListView.builder(
              //physics: NeverScrollableScrollPhysics(),
              itemCount: talentList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Talent talent = talentList[index];
                return TalentTile(talent);
              }),
        ),
      ],
    );
  }
}
