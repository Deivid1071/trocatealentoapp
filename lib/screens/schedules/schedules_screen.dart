import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/widgets/tiles/invitetile.dart';
import 'package:trocatalentos_app/widgets/tiles/scheduleexpansiontile.dart';

class SchedulesScreen extends StatefulWidget {
  @override
  _SchedulesScreenState createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            _buildListInvite('Solicitações recebidas'),
            SizedBox(
              height: 40,
            ),
            _buildListInvite('Solicitações enviadas'),
            _buildListSchedule('Agendamentos confirmados'),
          ],
        ),
      ),
    );
  }

  _buildListInvite(String title) {
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
          height: 160,
          child: ListView.builder(
              itemCount: 8,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InviteTile();
              }),
        ),
      ],
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
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            itemCount: 8,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CustomExpansionTile();
            }),
      ],
    );
  }
}
