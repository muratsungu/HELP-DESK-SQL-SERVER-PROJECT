--Returns the number of requests that client companies have for years entered.

CREATE FUNCTION f_GET_DEMAND_BY_COMPANY_ANNUAL (@Start_Year INT, @End_Year INT)
RETURNS TABLE
AS
RETURN
	SELECT C.COMPANY_NAME AS COMPANY_NAME, COUNT(C.ID) AS DEMAND_COUNT FROM DEMAND D 
		INNER JOIN COMPANY_USER CU ON D.COMPANY_USERID = CU.ID
		INNER JOIN COMPANY C ON C.ID = CU.COMPANYID
		WHERE D.RECORD_STATUS = 1 AND C.RECORD_STATUS = 1
			  AND (YEAR(D.CREATE_DATE) BETWEEN @Start_Year AND @End_Year)
		GROUP BY C.COMPANY_NAME, C.ID
	
