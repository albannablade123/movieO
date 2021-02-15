
class Media{
  int id;
  bool netflix;
  bool googlePlay;

  Media({this.id, this.netflix, this.googlePlay});
  factory Media.fromJson(int id, Map<String, dynamic> json) {

    var netflixCheck = false;
    var googlePlayCheck = false;
    var resultFlatRate;
    try{
      if(json['TR']['flatrate']!= null){
        resultFlatRate = json['TR']['flatrate'];
        for(Map i in resultFlatRate){
          if(i['provider_id'] == 8) {
            print('netflix found');
            netflixCheck = true;
          }
        }
      }
      else{
        netflixCheck = false;
      }

      if(json['TR']['buy'] != null){
        var resultBuy = json['TR']['buy'];
        if(resultBuy != null){
          for(Map i in resultBuy){
            if(i['provider_id'] == 3){
              googlePlayCheck = true;
              print('google paycheck found');
            }
          }
        }
      }
      else{
        googlePlayCheck = false;
        print('google paycheck not found');
      }
    }
    catch(e){
    }


    return Media(
      id: id,
      netflix: netflixCheck,
      googlePlay: googlePlayCheck,
    );
  }
  Map<String, dynamic> mediatoMap() {
    return {
      "id": this.id,
      "netflix": this.netflix,
      "googleplay": this.googlePlay,

    };
  }
}