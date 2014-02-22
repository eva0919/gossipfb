function getTempData(){
	var count = $(".temp_count").attr("encount");
	var name_arr = [];
	var id_arr =[];
	var url_arr =[];
	for (var i = 0; i < parseInt(count); i++) {
		var text = ".temp_data_" + i ;
		name_arr.push($(text).attr("enname") );
		id_arr.push($(text).attr("enid") );
		url_arr.push($(text).attr("enurl") );
	};
	$("#temp").remove();
	// friend list
	console.log(url_arr);
	console.log(name_arr);
	console.log(id_arr);
}