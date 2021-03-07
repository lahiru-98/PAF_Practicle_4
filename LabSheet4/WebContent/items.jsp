<%@page import="com.Item"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%

session.setAttribute("statusMsg", "");


	if(request.getParameter("itemCode") != null){
		
	 if(request.getParameter("itemCode").length() != 0){
		 
		 
		 Item item = new Item();
			String messsage="";
			
			if(!("null").equals(request.getParameter("Id"))){
				int iid = Integer.parseInt(request.getParameter("Id"));
			
				 messsage = item.updateItem(iid,request.getParameter("itemCode"), request.getParameter("itemName"), 
						Double.parseDouble(request.getParameter("itemPrice")), request.getParameter("itemDesc"));
				
			}else{
				
				 messsage = item.insertItem(request.getParameter("itemCode"), request.getParameter("itemName"), 
						request.getParameter("itemPrice"), request.getParameter("itemDesc"));			
				
			}
			
			session.setAttribute("statusMsg", messsage);
	 }
	
	}

//check for remove button Clicked
	if(request.getParameter("itemId") != null){
			
		String id = request.getParameter("itemId");
		String status="";
		
		Item item = new Item();
		status = item.removeItem(id);
		
		session.setAttribute("statusMsg", status);
	}

//check for update buttn clicked
	if(request.getParameter("updateId") != null){
				
		String id = request.getParameter("updateId");		
		Item item = new Item();
		Item retrievedItem = item.readOneItem(id);	
		
		//setting the values to the session object
		session.setAttribute("itemID",retrievedItem.getItemID());
		session.setAttribute("itemCode",retrievedItem.getItemCode());
		session.setAttribute("itemName",retrievedItem.getItemName());
		session.setAttribute("itemPrice",retrievedItem.getItemPrice());
		session.setAttribute("itemDesc",retrievedItem.getItemDescription());
		
		System.out.println(""+retrievedItem.toString());
	}else{
		session.setAttribute("itemID", "null");
		session.setAttribute("itemCode","");
		session.setAttribute("itemName","");
		session.setAttribute("itemPrice","");
		session.setAttribute("itemDesc","");
	
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Items Management</title>
</head>
<body>

	<h1>Items Management</h1>
	<form method="post" action="items.jsp">
		Item code: <input name="itemCode" type="text"  value='<%= session.getAttribute("itemCode") %>'><br> 
		Item name: <input name="itemName" type="text"  value='<%= session.getAttribute("itemName") %>'><br> 
		Item price:<input name="itemPrice" type="text" value='<%= session.getAttribute("itemPrice") %>'><br>
		Item description: <input name="itemDesc" type="text" value='<%= session.getAttribute("itemDesc") %>'><br>
		
		<input name='Id' value='<%= session.getAttribute("itemID") %>'>
		<input name="btnSubmit" type="submit" value="Save">
	</form>

	<%
	
		out.print(session.getAttribute("statusMsg"));	
	
	%>

	<br>

	<%
		Item itemObj = new Item();
	    out.print(itemObj.readItems());
	%>
	
	<br>
	
	
	


</body>
</html>