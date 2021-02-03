--Function to save the phone number in a way that looks good on the interface.

CREATE FUNCTION [dbo].[Format_Phone_Number](@phoneNumber VARCHAR(11))
RETURNS VARCHAR(13)
BEGIN
	IF SUBSTRING(@phoneNumber, 1, 1) = '0'
	BEGIN
		RETURN '(' + REPLACE(LEFT(@phoneNumber,4),'0','') + ')' + RIGHT(@phoneNumber,7)
	END

    RETURN '(' + LEFT(@phoneNumber,3) + ')' + RIGHT(@phoneNumber,7)
END
GO


