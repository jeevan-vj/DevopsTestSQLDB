--EXEC tSQLt.NewTestClass 'testCalcApp';

CREATE PROCEDURE testCalcApp.[test that Add function adds two numbers]
AS
BEGIN
	
	DECLARE @ExpectedTotal INT = 10
	DECLARE @ActualTotal INT = 20

    EXEC tSQLt.AssertEquals @ExpectedTotal , @ActualTotal;

END;