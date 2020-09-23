import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/widgets/tiles/talent_tile.dart';

class SearchTalentScreen extends StatefulWidget {
  @override
  _SearchTalentScreenState createState() => _SearchTalentScreenState();
}

class _SearchTalentScreenState extends State<SearchTalentScreen> {
  TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito',
                ),
                controller: _searchController,
                decoration: InputDecoration(
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
              ),
              SizedBox(
                height: 15,
              ),
              _buildListSchedule('Resultado'),
            ],
          ),
        ),
      ),
    );
  }

  _buildListSchedule(String title) {
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
          height: MediaQuery.of(context).size.height-220,
          child: ListView.builder(
            //physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TalentTile();
              }),
        ),
      ],
    );
  }
}
