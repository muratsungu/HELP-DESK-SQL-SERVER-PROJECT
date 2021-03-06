--Stored procedure using UPDATE query to company user record.

CREATE PROCEDURE [dbo].[sp_DELETE_COMPANY_USER] @RoleId INT, @Company_UserId INT
AS

IF @RoleId IS NULL OR @RoleId != 1
BEGIN
	RAISERROR('��lem i�in yetkiniz bulunmamaktad�r!',16,1);
END

ELSE IF NOT EXISTS(SELECT 1 FROM COMPANY_USER WHERE ID = @Company_UserId AND RECORD_STATUS = 1)
BEGIN
	RAISERROR('�lgili kullan�c� sistemde mevcut de�ildir!',16,1);
END

ELSE IF EXISTS(SELECT 1 FROM COMPANY_USER CU INNER JOIN DEMAND D ON CU.ID = D.COMPANY_USERID
			   WHERE D.RECORD_STATUS = 1 AND (DEMAND_STATEID = 1 OR DEMAND_STATEID = 2) AND COMPANY_USERID = @Company_UserId)
BEGIN
	RAISERROR('�lgili kullan�c�n�n i�lemde olan talepleri bulunmaktad�r!',16,1);
END

ELSE
BEGIN
	UPDATE [dbo].[COMPANY_USER]  SET [RECORD_STATUS] = 0, MODIFICATION_DATE = GETDATE() WHERE ID = @Company_UserId
	UPDATE [dbo].[DEMAND] SET [RECORD_STATUS] = 0, MODIFICATION_DATE = GETDATE() WHERE COMPANY_USERID = @Company_UserId
	PRINT 'Silme i�lemi ba�ar�yla ger�ekle�tirildi.';

END