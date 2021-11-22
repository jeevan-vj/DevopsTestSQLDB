
CREATE PROCEDURE tSQLt.Private_CreateFakeOfTable
  @SchemaName NVARCHAR(MAX),
  @TableName NVARCHAR(MAX),
  @OrigTableFullName NVARCHAR(MAX),
  @Identity BIT,
  @ComputedColumns BIT,
  @Defaults BIT
AS
BEGIN
   DECLARE @cmd NVARCHAR(MAX) =
     (SELECT CreateTableStatement 
        FROM tSQLt.Private_CreateFakeTableStatement(OBJECT_ID(@OrigTableFullName), @SchemaName+'.'+@TableName,@Identity,@ComputedColumns,@Defaults,0));
   EXEC (@cmd);
END;


