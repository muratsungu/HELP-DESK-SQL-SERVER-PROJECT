--Stored procedure using INSERT query to adding new employee and product to employee.

CREATE PROCEDURE [dbo].[sp_CREATE_EMPLOYEE] @RoleIdForCreator INT, @Employee_Name NVARCHAR(50), @Employee_Surname NVARCHAR(50), 
									@Mobile_Number NVARCHAR(15), @Employee_Email NVARCHAR(50),
									@ProfessionId NVARCHAR(50), @DepartmentId NVARCHAR(50), 
									@RoleId int, @ProductId INT
AS

IF @RoleIdForCreator IS NULL OR @RoleIdForCreator != 1
BEGIN
	RAISERROR('Ýþlem için yetkiniz bulunmamaktadýr!!',16,1);
END
ELSE IF @RoleId IS NULL OR (@RoleId != 1 AND @RoleId != 2)
BEGIN
	RAISERROR('Girdiðiniz rol çalýþan türü için geçerli deðildir!',16,1);	
END
ELSE IF NOT EXISTS(SELECT 1 FROM PROFESSION WHERE ID = @ProfessionId)
BEGIN
	RAISERROR('Geçersiz bir meslek girdiniz!',16,1);	
END
ELSE IF NOT EXISTS(SELECT 1 FROM DEPARTMENT WHERE ID = @DepartmentId)
BEGIN
	RAISERROR('Geçersiz bir departman girdiniz!',16,1);
END
ELSE IF NOT EXISTS(SELECT 1 FROM PRODUCT WHERE ID = @ProductId)
BEGIN
	RAISERROR('Geçersiz ürün kodu girdiniz!',16,1);
END
ELSE
BEGIN
	INSERT INTO [dbo].[EMPLOYEE]
			   ([EMPLOYEE_NAME]
			   ,[EMPLOYEE_SURNAME]
			   ,[MOBILE_NUMBER]
			   ,[EMPLOYEE_EMAIL]
			   ,[PROFESSIONID]
			   ,[DEPARTMENTID]
			   ,[CREATE_DATE]
			   ,[MODIFICATION_DATE]
			   ,[RECORD_STATUS])
		 VALUES
			   (@Employee_Name
			   ,@Employee_Surname
			   ,@Mobile_Number
			   ,@Employee_Email
			   ,@ProfessionId
			   ,@DepartmentId
			   ,GETDATE()
			   ,GETDATE()
			   ,1)

	DECLARE @EmployeeId INT = (SELECT IDENT_CURRENT('EMPLOYEE'))

	INSERT INTO [dbo].[PRODUCT_EMPLOYEE_MAPPING]
			   ([PRODUCTID]
			   ,[EMPLOYEEID]
			   ,[RECORD_STATUS])
		 VALUES
			   (@ProductId
			   ,@EmployeeId
			   ,1)

	PRINT 'Kayýt baþarýyla gerçekleþtirildi.'
END