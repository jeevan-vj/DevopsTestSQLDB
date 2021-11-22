CREATE TABLE [tSQLt].[Private_NullCellTable] (
    [I] INT NULL,
    CONSTRAINT [U:tSQLt.Private_NullCellTable] UNIQUE CLUSTERED ([I] ASC)
);


GO

CREATE TRIGGER tSQLt.Private_NullCellTable_StopModifications ON tSQLt.Private_NullCellTable INSTEAD OF DELETE, INSERT, UPDATE
AS
BEGIN
  IF EXISTS (SELECT 1 FROM tSQLt.Private_NullCellTable) RETURN;
  INSERT INTO tSQLt.Private_NullCellTable VALUES (NULL);
END;
