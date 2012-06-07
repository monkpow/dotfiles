chop = function(int, array){
  var safe = array instanceof Array;
  var result = -1;
  for(var i=0; array[i]; i++){
    if(array[i] == int){
      result = i; 
    }
  }
  return result;
}
