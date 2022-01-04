
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends AnimatedWidget{
  final RemoteConfig remoteConfig;

  Home({required this.remoteConfig}) : super(listenable: remoteConfig);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('A/B Testing and REmote Config'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 150.0,
              ),
              Image.network(remoteConfig.getString("Image")),
              SizedBox(
                height: 50.0,
              ),
              Text(
                remoteConfig.getString("Text"),
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(remoteConfig.lastFetchStatus.toString(),
                style: TextStyle(
                    fontSize: 17
                ),),
              SizedBox(
                height: 20.0,
              ),
              Text(remoteConfig.lastFetchTime.toString(),
                style: TextStyle(
                    fontSize: 20
                ),),
              SizedBox(
                height: 20.0,
              ),
              FloatingActionButton(
                onPressed: () async {
                  try {
                    await remoteConfig.setConfigSettings(
                        RemoteConfigSettings(
                            fetchTimeout: Duration(seconds: 2),
                            minimumFetchInterval: Duration.zero) );
                    await remoteConfig.fetchAndActivate();
                  }
                  catch (e) {
                    print(e.toString());
                  }
                },
                child: const Icon(Icons.refresh),
              )
            ],
          ),
        ),
      ),
    );
  }
}