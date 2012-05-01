messages = ()->
	$("#lift__noticesContainer___notice li").addClass "alert-message sucess"
	$("#lift__noticesContainer___error li").addClass "alert-message error"
	$("#lift__noticesContainer___warning li").addClass "alert-message warning"