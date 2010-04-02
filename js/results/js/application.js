init=function(){
  var c=flightTemplate(flight);
  console.log(c);
  d=new HTMLTEXT();
  d.add("div",{style:"height:200px;width:200px;background:blue"})
  d.inject(); 
}



HTMLTEXT=Class.create();
HTMLTEXT.prototype={  
  parent:document.createElement("DIV"),
  initialize:function(){
  //this.parent:document.createElement("DIV"),

  },
  
  add:function(/* Element type */ elem,/* Hash of attributes to set */ rbhash){
    t=document.createElement(elem);
    if(arguments[1] /*typeof Object */){
      var properties=arguments[1];
      for (p in properties){
        t.setAttribute(p,properties[p]);
      }
    }
  },
  inject:function(){
    document.body.appendChild(this.parent);
  }
}

//var a=new HTMLTEXT(' \
var a=' \
<div class="${foo}"> \
<div class="${foro}"> \
<a href="booHoo">hey</a> \
</div> \
</div> \
';

console.log(a);
foo="success";
var amatch=(function(){
  var re=/\${([^}]*?)}/g; // extracts the pattern ${var_name}, and returns var_name
  d=re.exec(a);
  try{
    console.log(eval(d[1]));
    }catch(e){
    console.log('boo');
  }
  console.log(d); 
})();


function flightTemplate(obj){
  // pass in a conforming object, and this will return an html template
  //<div class="flightTemplate">
  //<a href="booHoo">hey</a>
  //</div>
  var t=document.createElement("DIV") //.createAttribute("style","border:1px solid black");
  x=document.createTextNode(obj.alive);
  y=document.createElement("A");
  y.setAttribute("href","a");
  y.appendChild(x);
  t.appendChild(y);//.createAttribute("href",obj.alive);
  document.body.appendChild(t);

  return obj;


}

var flight={
  alive:"answer"
}




