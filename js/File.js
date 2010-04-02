File=function(fileName){
	 file=readFile(fileName);
	 lineCount=0;
	 return {
			removeJSPComments:function(){
				 return file.replace(/<%--[\s\S]*?--%>/g,"");
			} ,
			toString:function(){
				 return (file);
			},
			split:function(){ 
				 return file.split("\n");
			}
	 }
}

Rules=[]




