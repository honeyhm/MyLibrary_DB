create procedure AvailableBooks
as
select * from Book where Available=1


----------------*********************************

create procedure EachMemberBooks
as
select MemberCode ,ISBN_FK from Bailment


----------------*********************************

