--select * into [Person].[EmailAddress_bkp] select * from [Person].[EmailAddress]
--select a.BusinessEntityID, * from [Person].[EmailAddress] a where a.EmailAddress is null
--update [Person].[EmailAddress] set EmailAddress = null where BusinessEntityID between 189 and 210

--update [Person].[EmailAddress] set EmailAddress = 'sinvalfelisberto@gmail.com' where BusinessEntityID  = 201
declare @email varchar(max), @id int 

declare cursorAtualizaEmail cursor
for select  BusinessEntityID, EmailAddress from person.[EmailAddress_bkp] a where BusinessEntityID between 189 and 210
open cursorAtualizaEmail

fetch next from cursorAtualizaEmail
into @id, @email

while @@FETCH_STATUS = 0
	begin
		if (select EmailAddress from [Person].[EmailAddress] where BusinessEntityID = @id) is null
			begin
				update [Person].[EmailAddress]
				set EmailAddress = @email
				where BusinessEntityID = @id
		
				select EmailAddress from [Person].[EmailAddress] where BusinessEntityID = @id

				fetch next from cursorAtualizaEmail
				into @id, @email
			end
		else 
			begin
				fetch next from cursorAtualizaEmail
				into @id, @email
			end
	end
close cursorAtualizaEmail
deallocate cursorAtualizaEmail

--select * from [Person].[EmailAddress] where BusinessEntityID between 189 and 210

update [Person].[EmailAddress]
set EmailAddress = (select EmailAddress from [Person].[EmailAddress_bkp] where BusinessEntityID = 201)
where BusinessEntityID = 201