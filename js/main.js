$(function(){

	//Hide the error message for ISBN.
	$('.error_message').hide();

	//Hide success message div
	$(".successMessage").hide();

	//Function to hide success message div
	function hideSuccessMessage(){
		$(".successMessage").hide();
	}

	function registerAuthor(deliveryInfo) {
		//ajax for register delivery (authors)(first_name, last_name)
		//to db/authors
		$.ajax({
			url:"libs/sql-ajax-json.php",

			dataType:"json",

			data:{
				sql:"sql/sql-queries.sql",
				run:"register authors",
				//data to send
				firstname: JSON.stringify(deliveryInfo["firstname"]),
				lastname: JSON.stringify(deliveryInfo["lastname"])

			},

			success: function(data){
				console.log("register authors success: ", data);
				selectAuthors(deliveryInfo);
			},

			error: function(data){
				console.log("register authors error: ", data);
			}

		});
	}

	function registerDelivery(deliveryInfo) {
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
				delivery_date: JSON.stringify(deliveryInfo["delivery_date"]),
				quantity: JSON.stringify(deliveryInfo["quantity"])

			},

			success: function(data){
				console.log("register delivery success: ", data);
			},

			error: function(data){
				console.log("register delivery error: ", data);
			}

		});
	}
	function registerBooks(deliveryInfo) {
		//ajax for register delivery (isbn, title, description)
		//to db/book
		$.ajax({
			url:"libs/sql-ajax-json.php",

			dataType:"json",

			data:{
				sql:"sql/sql-queries.sql",
				run:"register books",
				//data to send
				isbn: JSON.stringify(deliveryInfo["isbn"]),
				title: JSON.stringify(deliveryInfo["title"]),
				quantity: JSON.stringify(deliveryInfo["quantity"]),
				delivery_date: JSON.stringify(deliveryInfo["delivery_date"]),
				f_price: JSON.stringify(deliveryInfo["f_price"]),
				shelf_id: JSON.stringify(deliveryInfo["shelfData"]["shelf_id"]),
				book_author_id: JSON.stringify(deliveryInfo["authorData"]["book_author_id"])
			},

			success: function(data){
				console.log("register books success: ", data);
				selectIsbn(deliveryInfo);
			},

			error: function(data){
				console.log("register books error: ", data);
			}

		});

	}

	function selectAuthors(deliveryInfo) {
		//ajax for register delivery (isbn, title, description)
		//to db/book
		$.ajax({
			url:"libs/sql-ajax-json.php",

			dataType:"json",

			data:{
				sql:"sql/sql-queries.sql",
				run:"select authors",
				firstname: JSON.stringify(deliveryInfo["firstname"]),
				lastname: JSON.stringify(deliveryInfo["lastname"])
			},

			success: function(data){
				console.log("select authors: ", data);
				if (data.length > 0) {
					deliveryInfo["authorData"] = data[0];
					selectShelf(deliveryInfo);
				} else {
					registerAuthor(deliveryInfo);
				}
			},

			error: function(data){
				console.log("select authors error: ", data);
			}

		});

	}

	function selectIsbn(deliveryInfo) {
		//ajax for register delivery (isbn, title, description)
		//to db/book
		$.ajax({
			url:"libs/sql-ajax-json.php",

			dataType:"json",

			data:{
				sql:"sql/sql-queries.sql",
				run:"select isbn",
				isbn: JSON.stringify(deliveryInfo["isbn"])
			},

			success: function(data){
				console.log("select isbn: ", data);
				if (data.length > 0) {
					//deliveryInfo["bookData"] = data[0] ????
					//maybe run registerDelivery(data, deliveryInfo) here?
					printDeliveryResult(data);
				} else {
					selectAuthors(deliveryInfo);
				}
			},

			error: function(data){
				console.log("select isbn error: ", data);
			}

		});

	}

	function selectShelf(deliveryInfo) {
		//ajax for register delivery (isbn, title, description)
		//to db/book
		console.log("selectShelf deliveryInfo: ", deliveryInfo);
		$.ajax({
			url:"libs/sql-ajax-json.php",

			dataType:"json",

			data:{
				sql:"sql/sql-queries.sql",
				run:"select shelf",
				shelf_id: JSON.stringify(deliveryInfo["shelf_id"])
			},

			success: function(data){
				console.log("select shelf: ", data);
				if (data.length > 0) {
					deliveryInfo["shelfData"] = data[0];
					registerBooks(deliveryInfo);
				} else {
					registerShelf(deliveryInfo);
				}
			},

			error: function(data){
				console.log("select shelf error: ", data);
			}

		});

	}

	function registerShelf(deliveryInfo) {
		//ajax for register delivery (isbn, title, description)
		//to db/book
		$.ajax({
			url:"libs/sql-ajax-json.php",

			dataType:"json",

			data:{
				sql:"sql/sql-queries.sql",
				run:"register shelf",
				shelf_id: JSON.stringify(deliveryInfo["shelf_id"])
			},

			success: function(data){
				console.log("register shelf: ", data);
				selectShelf(deliveryInfo);
			},

			error: function(data){
				console.log("register shelf error: ", data);
			}

		});

	}


    function printDeliveryResult(data) {
    	//maybe run registerDelivery(data, deliveryInfo) here?
    	console.log("delivery result: ", data);
    }

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
			
			

			selectIsbn(deliveryInfo);
			

			//Show success message div
			$(".successMessage").show();

			//Hide success message(div) when click ok
			$('.successMessageButton').click(hideSuccessMessage);

		}

		//Clean up input after submit
        $('.deliveryForm').find('input').not("input[type='submit'], input[type='reset']").val('');




		return false;
	});



	//US2
	function selectF_price(deliveryInfo) {
		
		$.ajax({
			url:"libs/sql-ajax-json.php",

			dataType:"json",

			data:{
				sql:"sql/sql-queries.sql",
				run:"select f_price",
				f_price: JSON.stringify(deliveryInfo["f_price"])
			},

			success: function(data){
				console.log("select f_price: ", data);
			},

			error: function(data){
				console.log("select f_price error: ", data);
			}

		});
	}

	function setSale_price(){

		$.ajax({
			url:"libs/sql-ajax-json.php",

			dataType:"json",

			data:{
				sql:"sql/sql-queries.sql",
				run:"select f_price and set to sale_price",
			},

			success: function(data){
				console.log("select f_price: ", data);
			},

			error: function(data){
				console.log("select f_price error: ", data);
			}

		});
	}

	function registerSale_price(deliveryInfo){

		$.ajax({
			url:"libs/sql-ajax-json.php",

			dataType:"json",

			data:{
				sql:"sql/sql-queries.sql",
				run:"register sale_price",
				sale_price: JSON.stringify(deliveryInfo["sale_price"])
			},

			success: function(data){
				console.log("register sale_price: ", data);
			},

			error: function(data){
				console.log("register sale_price error: ", data);
			}

		});
	}

});






