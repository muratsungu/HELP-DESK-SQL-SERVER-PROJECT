--The function that brings all the tickets of the employee for the entered Employee ID

CREATE FUNCTION f_GET_ALL_DEMAND_FOR_EMPLOYEEID (@EMPLOYEEID AS INT)
RETURNS TABLE
AS
RETURN
(
SELECT 
	D.TEXT
FROM 
	[dbo].[DEMAND] D
WHERE D.EMPLOYEEID = @EMPLOYEEID
);