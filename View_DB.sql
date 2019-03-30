create view BorrowInf
as
select * from Bailment 


create view BooksInf
as
select Book.* ,Author.FirstName+' '+Author.LastName as Author,
Translator.FirstName+' '+Translator.LastName as Translator 
from Book ,Author , Translator 
where( Author.ISBN_FK=ISBN or Translator.ISBN_FK=ISBN)