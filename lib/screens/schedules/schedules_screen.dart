import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/model/proposal.dart';
import 'package:trocatalentos_app/model/schedule.dart';
import 'package:trocatalentos_app/services/proposal_api_service.dart';
import 'package:trocatalentos_app/services/schedule_api_service.dart';
import 'package:trocatalentos_app/widgets/tiles/invitetile.dart';
import 'package:trocatalentos_app/widgets/tiles/scheduleexpansiontile.dart';

class SchedulesScreen extends StatefulWidget {
  @override
  _SchedulesScreenState createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  ProposalApiService proposalApi;
  ScheduleApiService scheduleApi;
  List<Proposal> proposalList;
  List<Schedule> scheduleList;

  @override
  void initState() {
    proposalApi = ProposalApiService();
    scheduleApi = ScheduleApiService();
     proposalList = [];
     scheduleList = [];
     for(int i = 0; i<11 ; i++){
       proposalList.add(
           Proposal(
               tcoin: i
           ));
     }
    for(int i = 0; i<11 ; i++){
      scheduleList.add(
          Schedule(
            tcoin: i
          ));
    }
    super.initState();
  }

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
          _buildListInvite('Propostas recebidas',
              proposalList: proposalList, isSended: false),
            /*FutureBuilder(
                future: proposalApi.getProposalData(),
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
                        final ProposalResponse response = snapshot.data;
                        if (response.error.isNotEmpty) {
                          return Center(
                            child: Text(response.error),
                          );
                        } else {
                          if (response.result.isNotEmpty) {
                            return _buildListInvite('Propostas recebidas',
                                proposalList: response.result, isSended: false);
                          }else{
                            return Center(
                              child: Text('Você não possui solicitações no momento'),
                            );
                          }
                        }
                      }
                      return Container();
                      break;
                  }
                  return Container();
                }),*/
            /*SizedBox(
              height: 40,
            ),
            _buildListInvite('Propostas enviadas', isSended: true),*/
            SizedBox(
              height: 40,
            ),
          _buildListSchedule('Agendamentos confirmados', scheduleList),
            /*FutureBuilder(
                future: scheduleApi.getScheduleData(),
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
                        final ScheduleResponse response = snapshot.data;
                        if (response.error.isNotEmpty) {
                          return Center(
                            child: Text(response.error),
                          );
                        } else {
                          if (response.result.isNotEmpty) {
                            return _buildListSchedule('Agendamentos confirmados', response.result);
                          }else{
                            return Center(
                              child: Text('Você não possui agendamentos no momento'),
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
    );
  }

  _buildListInvite(String title, {List<Proposal> proposalList, bool isSended}) {
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
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              itemCount: proposalList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Proposal proposal = proposalList[index];
                return InviteTile(proposal, isSended);
              }),
        ),
      ],
    );
  }

  _buildListSchedule(String title, List<Schedule> scheduleList) {
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
            padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            physics: NeverScrollableScrollPhysics(),
            itemCount: scheduleList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Schedule schedule = scheduleList[index];
              return CustomExpansionTile(schedule);
            }),
      ],
    );
  }
}
