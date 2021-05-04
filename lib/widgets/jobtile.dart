import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oldies/providerr/jobs.dart';

class JobTile extends StatelessWidget {
  final String jid;
  JobTile(this.jid);
  @override
  Widget build(BuildContext context) {
    final itemslist = Provider.of<Jobs>(context, listen: false).jitem;
    final jobData = itemslist.firstWhere((i) => i.jid == jid);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        height: 70,
                        width: 80,
                        child: FadeInImage(
                          placeholder: AssetImage(
                            "assets/l2.jpg",
                          ),
                          image: (jobData.imageurl != null)?NetworkImage(jobData.imageurl):AssetImage(
                            "assets/l2.jpg",
                          ),
                          fit: BoxFit.cover,
                        )
                      // Image.network(
                      // data.imageurl,
                      // fit: BoxFit.cover,

                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Name :",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        jobData.name,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Service :",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        jobData.service,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
