function getTempData(){
	var count = $(".temp_count").attr("encount");
	var name_arr = [];
	var id_arr =[];
	var url_arr =[];
  var data = [];
	for (var i = 0; i < parseInt(count); i++) {
		var text = ".temp_data_" + i ;
    data.push({"id": $(text).attr("enid"),
              "name": $(text).attr("enname"),
              "url" : $(text).attr("enurl")});
		// name_arr.push($(text).attr("enname") );
		// id_arr.push($(text).attr("enid") );
		// url_arr.push($(text).attr("enurl") );
	};
	console.log(i);
	$("#temp").remove();

	// friend list
	console.log(url_arr);
	console.log(name_arr);
	console.log(id_arr);

  return data;
}

