import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:ontrack_backoffice/widgets/app_bar/drawer.dart';

class NotificacoesMedium extends StatefulWidget {
  const NotificacoesMedium({Key? key}) : super(key: key);

  @override
  State<NotificacoesMedium> createState() => _NotificacoesMediumState();
}

class _NotificacoesMediumState extends State<NotificacoesMedium> {
  String _selectedEstado = 'New-Old';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Notificações'),
      drawer: buildDrawer(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        color: background,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 30, 50, 20),
              child: Column(
                children: [
                  Text(
                    'Notificações',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 130,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton2(
                            isExpanded: true,
                            value: _selectedEstado,
                            items: [
                              DropdownMenuItem(child: Text('New-Old'), value: 'New-Old',),
                              DropdownMenuItem(child: Text('Old-New'), value: 'Old-New',)
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedEstado = value.toString();
                              });
                            },
                            underline: Container(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              width: 120,
                              decoration: BoxDecoration(
                                color: primary,
                              ),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    width: 800,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FutureBuilder(
                          future: getWidgetNotificacoes(_selectedEstado),
                          builder: (context, snapshot) {
                            if(snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return snapshot.data![index];
                                },
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
