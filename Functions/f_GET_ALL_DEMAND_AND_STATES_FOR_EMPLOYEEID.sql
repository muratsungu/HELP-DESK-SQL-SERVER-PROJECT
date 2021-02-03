--The function that brings all the demands registered to a employee and the type of these demands.

CREATE FUNCTION f_GET_ALL_DEMAND_AND_STATES_FOR_EMPLOYEEID (@EMPLOYEEID AS INT)
RETURNS TABLE
AS
RETURN
(
	SELECT 
		D.TEXT, 
		DS.STATE
	FROM 
		[dbo].[DEMAND_STATE] DS
	INNER JOIN [dbo].[DEMAND] D 
		ON DS.ID = D.DEMAND_STATEID
	WHERE D.EMPLOYEEID = @EMPLOYEEID
);