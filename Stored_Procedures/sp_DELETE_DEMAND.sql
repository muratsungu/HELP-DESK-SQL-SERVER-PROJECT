--Stored procedure using UPDATE query to delete demand record.

CREATE PROCEDURE [dbo].[sp_DELETE_DEMAND] @DemandCreatorId INT, @DemandId INT
AS

IF NOT EXISTS(SELECT COMPANY_USERID FROM DEMAND WHERE ID = @DemandId AND COMPANY_USERID = @DemandCreatorId)
BEGIN
	RAISERROR('��lem i�in yetkiniz bulunmamaktad�r!',16,1);
END

ELSE IF NOT EXISTS(SELECT 1 FROM DEMAND WHERE ID = @DemandId AND RECORD_STATUS = 1)
BEGIN
	RAISERROR('�lgili talep sistemde mevcut de�ildir!',16,1);
END

ELSE IF EXISTS(SELECT ID FROM DEMAND WHERE ID = @DemandId AND (DEMAND_STATEID = 1 OR DEMAND_STATEID = 2) AND RECORD_STATUS = 1)
BEGIN
	RAISERROR('�lgili talep i�leme al�nm��t�r!',16,1);
END

ELSE
BEGIN

	UPDATE [dbo].[DEMAND]  SET [RECORD_STATUS] = 0, MODIFICATION_DATE = GETDATE() WHERE ID = @DemandId

	PRINT 'Silme i�lemi ba�ar�yla ger�ekle�tirildi.';

END