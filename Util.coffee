#DecimalAsString
das = (n) ->
	if(n <10 ) then "0"+n else n
	
getHourBr = (d) ->
	das(d.getHours())+ ":" + das(d.getMinutes())

getDateBr = (d) ->
	das(d.getDate())+"/"+das(d.getMonth())+"/"+d.getFullYear()	

gup = ( name ) ->
	name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]")
	regex = new RegExp "[\\?&]"+name+"=([^&#]*)" 
	results = regex.exec( window.location.href );
	if( results?) then decodeURIComponent(results[1]) else "";

