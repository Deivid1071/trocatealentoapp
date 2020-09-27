

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/model/talent.dart';
import 'package:trocatalentos_app/services/talent_api_service.dart';
import 'package:trocatalentos_app/widgets/tiles/talent_tile.dart';

class SearchTalentScreen extends StatefulWidget {
  @override
  _SearchTalentScreenState createState() => _SearchTalentScreenState();
}

class _SearchTalentScreenState extends State<SearchTalentScreen> {
  TextEditingController _searchController;
  TalentApiService api;
  String search = "";
  List<Talent> talentList;

  @override
  void initState() {
    _searchController = TextEditingController();
    api = TalentApiService();
    talentList = [];
    talentList.add(Talent(
      userName: 'Jose',
      talentTitle: 'Programador',
      tcoin: 2,
    ));
    talentList.add(Talent(
      userName: 'Paula',
      talentTitle: 'Programador',
      tcoin: 6,
    ));
    talentList.add(Talent(
      userName: 'Ricardo',
      talentTitle: 'Programador',
      tcoin: 1,
    ));
    talentList.add(Talent(
      userName: 'Alessandra',
      talentTitle: 'Programador',
      tcoin: 5,
    ));
    talentList.add(Talent(
      userName: 'Paola',
      talentTitle: 'Programador',
      tcoin: 3,
    ));
    super.initState();
  }

  Future<dynamic> futureBuilder;

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
                    hintText: 'Digite a palavra Programador e clique na busca',
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
              search == 'Programador'
                  ? _buildListTalent('Resultado', talentList: talentList)
                  : Container(child: Text("Por favor busque pela palavra 'Programador' para testar a aplicação"),),
              /*FutureBuilder(
                  future: search.isNotEmpty && search != null ? api.getTalentBySearch(search) : null,
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
                            if (response.result.isNotEmpty && response.result != null) {
                              print(response.result);
                              return _buildListTalent('Resultado da busca', talentList: response.result);
                            }else{
                              return Center(
                                child: Text('Talento não encontrado.'),
                              );
                            }
                          }
                        }
                        return Container();
                        break;
                    }
                    return Container();
                  }),*/
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
