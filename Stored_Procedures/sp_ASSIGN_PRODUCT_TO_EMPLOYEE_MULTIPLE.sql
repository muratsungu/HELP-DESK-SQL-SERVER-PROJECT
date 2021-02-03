--Stored procedure using INSERT query to adding new products to the company.

CREATE PROCEDURE [dbo].[sp_ASSIGN_PRODUCT_TO_EMPLOYEE_MULTIPLE] @RoleId INT, @Products NVARCHAR(MAX), @EmployeeId INT
AS

IF @RoleId IS NULL OR @RoleId != 1
BEGIN
	RAISERROR('��lem i�in yetkiniz bulunmamaktad�r!!',16,1);
END
ELSE IF @EmployeeId NOT IN (SELECT ID FROM EMPLOYEE)
	BEGIN
		RAISERROR('Ge�ersiz kullan�c� kodu girdiniz!',16,1);
	END

ELSE
	BEGIN
		DECLARE @ID INT;
		DECLARE CRS_PRODUCTS CURSOR FOR SELECT * FROM string_split(@Products,' ')
		OPEN CRS_PRODUCTS
		FETCH NEXT FROM CRS_PRODUCTS INTO @ID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM PRODUCT WHERE ID = @ID)
			BEGIN
				RAISERROR('Ge�ersiz �r�n kodu girdiniz!',16,1);
			END	
			ELSE
			BEGIN
				INSERT INTO [dbo].[PRODUCT_EMPLOYEE_MAPPING]
						   ([PRODUCTID]
						   ,[EMPLOYEEID]
						   ,[RECORD_STATUS])
					 VALUES
						   (@ID
						   ,@EmployeeId
						   ,1)
			END

			select @ID
			FETCH NEXT FROM CRS_PRODUCTS INTO @ID
		END
		rollback;
		CLOSE CRS_PRODUCTS
	    DEALLOCATE CRS_PRODUCTS
	END
