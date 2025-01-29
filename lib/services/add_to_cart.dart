Set<Map<String,dynamic>> cartList= {};


void addToCart({required Map<String,dynamic> values}) {
   if(cartList.isEmpty){
     cartList.add(values);
   }else{
     for(int i = 0 ; i<cartList.length;i++){
       if(cartList.elementAt(i)['id'] == values['id']){
         cartList.elementAt(i)['quantity']++;

         // cartList.add(values);
       }
       else{
         print('ggggg');
         cartList.add(values);
       }
     }
   }

}

