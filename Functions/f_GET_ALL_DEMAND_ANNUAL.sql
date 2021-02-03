--Function bringing tickets opened between the entered years

CREATE FUNCTION f_GET_ALL_DEMAND_ANNUAL (@Start_Year INT, @End_Year INT)
RETURNS TABLE
AS
RETURN
	SELECT * FROM DEMAND WHERE RECORD_STATUS = 1 AND (YEAR(CREATE_DATE) BETWEEN @Start_Year AND @End_Year)