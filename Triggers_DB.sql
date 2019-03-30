--create trigger BailmentCheck
--before insert or update of ISBN_FK , MemberCode
--on Bailment
--for each row
--when(exists(select * from Member,Book where
--		(MemberType=2 and BookType=3 ) or (MemberType=3 and (BookType=1 or BookType=3))));






create trigger BailmentCheck
on Bailment
for  insert
as
if    (not exists (select * from Member,Book where
		(MemberType=2 and BookType=3 ) or (MemberType=3 and (BookType=1 or BookType=3)))) 
begin
raiserror ('@You are not allowed to borrow this book',15,0)
rollback
end

-------------------*****************************

go
create trigger BailmentHoldingCheck
on Bailment
for  insert
as
begin
declare @a bit
declare @b bit
select @a = Available from Book
select @b = Holding from Book
--where MemberCode = @id
if    (@a=0 or @b=0) 
begin
raiserror ('@This Book is not available by now',15,0)
rollback 
end




------------------*********************************************************************************************


Go
create trigger CheckDate
on Bailment
after insert
as
begin
declare @id int
select @id = MemberCode from Bailment
declare @endDate varchar(50)
declare @startDate varchar(50)

select @endDate = EndDate,@startDate =StartDate
from Bailment
where MemberCode = @id
if(@endDate<@startDate)
begin
raiserror('@End date is less than Start date!',15,0)
rollback
end


----------------------*********************************************


go
create trigger CheckDate11
on Bailment
after insert
as
begin
declare @id int
select @id = MemberCode from Bailment
declare @endDate varchar(50)
declare @startDate varchar(50)

select @endDate = EndDate,@startDate =StartDate
from Bailment
where MemberCode = @id
if(@endDate<@startDate)
begin
raiserror('@End date is less than Start date!',15,0)
rollback
end
end



----------------*************

create trigger BailmentCheck
before insert or update of ISBN_FK , MemberCode
on Bailment
for each row
when(exists(select * from Member,Book where
		(MemberType=2 and BookType=3 ) or (MemberType=3 and (BookType=1 or BookType=3))));



		--------------******************



go
create trigger BailmentCheck2
on Bailment
for  insert
as
declare @id nvarchar(20)
select @id = MemberCode from Bailment
declare @idd smallint
select @idd = MemberType from Member
if    (select * from Book where Code=@id and @idd=3) >= 2
begin
raiserror ('@You are not allowed to borrow more books',15,0)
rollback
end
end



---------------************



go
create trigger BailmentCheck2
on Bailment
for  insert
as
--declare @id nvarchar(20)
--select @id = MemberCode from Bailment
declare @idd smallint
select @idd = MemberType from Member
if    ( select count(*) from Bailment where EndDate IS NULL )>=2 and @idd=3
begin
raiserror ('@You are not allowed to borrow more books',15,0)
rollback
end
end



----------------


create trigger BailmentCheck3
on Bailment
for  insert
as
--declare @id nvarchar(20)
--select @id = MemberCode from Bailment
declare @idd smallint
select @idd = MemberType from Member
if    ( select count(*) from Bailment where EndDate IS NULL )>=4 and @idd=2
begin
raiserror ('@You are not allowed to borrow more books',15,0)
rollback
end




--------------------



create trigger BailmentCheck4
on Bailment
for  insert
as
--declare @id nvarchar(20)
--select @id = MemberCode from Bailment
declare @idd smallint
select @idd = MemberType from Member
if    ( select count(*) from Bailment where EndDate IS NULL )>=10 and @idd=1
begin
raiserror ('@You are not allowed to borrow more books',15,0)
rollback
end



--select count(*) from Bailment 
--where EndDate IS NULL

---**********************************************************************



create trigger Fine
on Bailment
for  insert
as
declare @sd Date
select @sd = StartDate from Bailment
declare @ed Date
select @ed = EndDate from Bailment
declare @idd smallint
select @idd = MemberType from Member
if    ( SELECT DATEDIFF(day,'@sd','@ed') AS DiffDate )>=30 and @idd=1
begin
raiserror ('@Delay discovered !!!',15,0)
rollback
end


----------******************************



create trigger Fine2
on Bailment
for  insert
as
declare @sd Date
select @sd = StartDate from Bailment
declare @ed Date
select @ed = EndDate from Bailment
declare @idd smallint
select @idd = MemberType from Member
if    ( SELECT DATEDIFF(day,'@sd','@ed') AS DiffDate )>=14 and (@idd=2 or @idd=3)
begin
raiserror ('@Delay discovered !!!',15,0)
rollback
end


create procedure Held
@code nvarchar(20)
As 
select ISBN,Code,Title,Genre,Publisher,Edition 
from Bailment,Book
where ISBN=ISBN_FK and MemberCode=@code



create procedure holding 
@code nvarchar(20)
AS
select ISBN,Code,Title,Genre,Publisher,Edition from Book,bailment
where ISBN=ISBN_FK and MemberCode=@code;
