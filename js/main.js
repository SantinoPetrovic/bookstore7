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
				isbn: deliveryInfo.isbn,
				f_price: deliveryInfo.f_price,
				delivery_date: JSON.stringify(deliveryInfo["delivery_date"]),
				quantity: deliveryInfo.quantity

			},

			success: function(data){
				console.log("register delivery success: ", data);
				addPrice(deliveryInfo);
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
				//({isbn}, {title}, {description}, {shelf_id}, {book_author_id})
				isbn: deliveryInfo.isbn,
				title: JSON.stringify(deliveryInfo["title"]),
				description: JSON.stringify(deliveryInfo["description"]),
				//fråga hugo
				shelf_id: JSON.stringify(deliveryInfo["shelfData"]["shelf_id"]),
				book_author_id: deliveryInfo["authorData"]["author_id"]
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
				isbn: deliveryInfo.isbn
			},

			success: function(data){
				console.log("select isbn: ", data);
				if (data.length > 0) {
					//deliveryInfo["bookData"] = data[0] ????
					//maybe run registerDelivery(data, deliveryInfo) here?
					 if (deliveryInfo.newDelivery) {
           				 registerDelivery(deliveryInfo);
           				 return;
         			 }
					printDeliveryResult(data);
				} 
				else {
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

    //multiplying f_price with 1.8 to price
	function addPrice(deliveryInfo){
		 console.log("addPrice: ", deliveryInfo);
		if(!deliveryInfo.price){
			deliveryInfo.price = Math.round(deliveryInfo.f_price * 1.8);
		}
		//ajax call for register the price in price_history
		$.ajax({
			url:"libs/sql-ajax-json.php",

			dataType:"json",

			data:{
				sql:"sql/sql-queries.sql",
				run:"register price",
				isbn: deliveryInfo.isbn,
				price: deliveryInfo.price
			},

			success: function(data){
				console.log("register price: ", data);
				deliveryInfo.newDelivery = false;
				selectIsbn(deliveryInfo);
			},

			error: function(data){
				console.log("register price error: ", data);
			}

		});
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
			
			//Show success message div
			$(".successMessage").show();

			deliveryInfo.newDelivery = true;

			selectIsbn(deliveryInfo);

			//Hide success message(div) when click ok
			$('.successMessageButton').click(hideSuccessMessage);


		}

		//Clean up input after submit
        $('.deliveryForm').find('input').not("input[type='submit'], input[type='reset']").val('');
    	  console.log("deliveryInfo: ", deliveryInfo);
		return false;
	});

});






