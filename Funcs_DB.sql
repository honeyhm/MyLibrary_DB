
create function [dbo].[MemberBooks] (@memberid int)
returns table
as
return
(
	select Book.* from Book , Bailment  where Bailment.MemberCode = @memberid
);

----------***************************************************************




create function [dbo].[WhereBookIs] (@isbn int)
returns table
as
return
(
	select Bailment.MemberCode , Bailment.EndDate from Book , Bailment  where ISBN_FK = @isbn
);

----------***************************************************************



create function [dbo].[SearchBooksByName] (@bookname nvarchar(max))
returns table
as
return
(
	select * from Book where  Title like'% @bookname %'
);

----------***************************************************************




create function [dbo].[NumberOfBooksInHand] (@code nvarchar(20))
returns Num int
WITH EXECUTE AS CALLER
as
return
(
	count(select * from Bailment where MemberCode=@code)
);



CREATE FUNCTION <schema_name, sysname, dbo>.<function_name, sysname, centigrade_to_farenheit> (<parameter1, sysname, @centigrade> <parameter1_datatype,, float>)
RETURNS <return_value_datatype,,float>
WITH EXECUTE AS CALLER
AS
-- place the body of the function here
BEGIN
     <T-SQL_statment, ,RETURN((@centigrade * 1.8) + 32.0)>
END
GO


------*********************



CREATE FUNCTION FineAmount(@id nvarchar(20))  
RETURNS int   
AS   
BEGIN      
declare @sd Date
select @sd = StartDate from Bailment
declare @ed Date
select @ed = EndDate from Bailment
declare @DiffDate    int    
select @DiffDate = DATEDIFF(day,'@sd','@ed') * 500
    
RETURN @DiffDate;  
END;  
GO 