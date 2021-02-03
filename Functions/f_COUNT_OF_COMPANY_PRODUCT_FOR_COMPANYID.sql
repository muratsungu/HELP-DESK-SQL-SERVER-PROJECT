--The function that brings the number of products it has when the company ID is entered

CREATE FUNCTION f_COUNT_OF_COMPANY_PRODUCT_FOR_COMPANYID (@CompanyId int)
RETURNS INT 
AS
BEGIN 
DECLARE @count int 
SELECT @count = COUNT(*) FROM COMPANY_PRODUCT_MAPPING 
WHERE COMPANYID = @CompanyId

RETURN @count 
END 

