$(function(){
	//Hide the error message for ISBN.
	$('.error_message').hide();
	//Add submit handler for the deliveryInfo(form)
	$('.insertDelivery .deliveryForm').submit(function(){
		var deliveryInfo = {};
		//Here 'this' is the <form>
		//ask HUGO about .not input type=reset
		$(this).find('input').not("input[type='submit'], input[type='reset']").each(function(){
			//Here 'this' is the each input on <form>
			deliveryInfo[this.name] = $(this).val();
		});
		//Just to controll it is working
		console.log('deliveryInfo: ', deliveryInfo);

		// Controll to have ISBN value 13
		var isbn = $(this).find('#isbn').val();
		var isbnGood = true;
        if(isbn.length != 13){
        	isbnGood = false;
        }
        if(!isbnGood){
        	//show the error message for ISBN.
        	$('.error_message').show();
    	}
    	else {
    		//if you got the right ISBN after you got the error message, it will hide
    		//and send the data to DB
    		$('.error_message').hide();
			//ajax for register delivery (isbn, f_price, date, quantity)
			//to db/deliveries
			$.ajax({
				url:"libs/sql-ajax-json.php",

				dataType:"json",

				data:{
					sql:"sql/sql-queries.sql",
					run:"register delivery",
					//data to send
					isbn: JSON.stringify(deliveryInfo["isbn"]),
					f_price: JSON.stringify(deliveryInfo["f_price"]),
					date: JSON.stringify(deliveryInfo["date"]),
					quantity: JSON.stringify(deliveryInfo["quantity"])

				},

				success: function(data){
					//console.log("success: ", data);
				},

				error: function(data){
					//console.log("error: ", data);
				}

			});

			//ajax for register delivery (isbn, title, description)
			//to db/book
			$.ajax({
				url:"libs/sql-ajax-json.php",

				dataType:"json",

				data:{
					sql:"sql/sql-queries.sql",
					run:"register book",
					//data to send
					isbn: JSON.stringify(deliveryInfo["isbn"]),
					title: JSON.stringify(deliveryInfo["title"]),
					description: JSON.stringify(deliveryInfo["description"])

				},

				success: function(data){
					//console.log("success: ", data);
				},

				error: function(data){
					//console.log("error: ", data);
				}

			});

			//ajax for register delivery (authors)(first_name, last_name)
			//to db/authors
			$.ajax({
				url:"libs/sql-ajax-json.php",

				dataType:"json",

				data:{
					sql:"sql/sql-queries.sql",
					run:"add author",
					//data to send
					first_name: JSON.stringify(deliveryInfo["first_name"]),
					last_name: JSON.stringify(deliveryInfo["last_name"])

				},

				success: function(data){
					//console.log("success: ", data);
				},

				error: function(data){
					//console.log("error: ", data);
				}

			});


			//ajax for register (isbn, shelfs_id) to db/book_shelfs
			$.ajax({
				url:"libs/sql-ajax-json.php",
				dataType:"json",

				data:{
					sql:"sql/sql-queries.sql",
					run:"register shelfs",
					//data to send
					code: JSON.stringify(deliveryInfo["code"])
			},

				success: function(data){},

				error: function(data){}

			});

		}

      $('.deliveryForm').find('input').not("input[type='submit'], input[type='reset']").val('');


		return false;
	});

});