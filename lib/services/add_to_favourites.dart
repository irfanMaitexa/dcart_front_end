

List<Map<String,dynamic>> favList=[];


void addToFav({required Map<String,dynamic> values}){
  if(favList.isEmpty){
    favList.add(values);
  }else{
    for(int i = 0; i < favList.length; i++){
      if(favList[i]['id']==values['id']){

        break;

      }else{
        favList.add(values);
      }
    }
  }
}

void deleteFromFav({required Map<String,dynamic> values}){
  print(values);
  favList.remove(values);

  print(favList);
}

bool checkFav({required Map value}){

   return  favList.contains(value);


}

