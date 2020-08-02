use BankProject
go

 
create table Trn_Src_Des_PROC(
	 VoucherId varchar(10),
	 TrnDate date,
	 TrnTime varchar(6),
     Amount BIGINT,
     SourceDep INT,
     DesDep INT,
     Branch_ID INT,
     Trn_Desc VARCHAR(150),
);

select * from Trn_Src_Des

CREATE PROCEDURE TrnGraph
	 @vID int
AS
BEGIN
	SET NOCOUNT ON;
	delete from Trn_Src_Des_PROC;
	create table temp(
	 VoucherId varchar(10),
	 TrnDate date,
	 TrnTime varchar(6),
     Amount BIGINT,
     SourceDep INT,
     DesDep INT,
     Branch_ID INT,
     Trn_Desc VARCHAR(150)
	 );
	 create table stack(
	 VoucherId varchar(10),
	 TrnDate date,
	 TrnTime varchar(6),
     Amount BIGINT,
     SourceDep INT,
     DesDep INT,
     Branch_ID INT,
     Trn_Desc VARCHAR(150)
	 );
	declare @A date;
	declare @M int;
	declare @des int;
	declare @Maxvochertemp int;
	declare @Minvochertemp int;
	declare @counter int;
	declare @sumtemp int;
	declare @mainsum int;
	set @des= (select DesDep from Trn_Src_Des where VoucherId=@vID);
	set @A= (select top 1 TrnDate from Trn_Src_Des where SourceDep=@des and VoucherId>@vID);
	set @M= (select Amount from Trn_Src_Des where VoucherId=@vID);
	insert into Trn_Src_Des_PROC select * from Trn_Src_Des where  VoucherId=@vID;
	insert into Trn_Src_Des_PROC select * from Trn_Src_Des where  TrnDate=@A and Amount=@M and VoucherId<>@vID;
	insert into Trn_Src_Des_PROC select * from Trn_Src_Des where  TrnDate=@A and SourceDep=@des and Amount<>@M and VoucherId<>@vID;
	set @sumtemp=(select sum(Amount) from Trn_Src_Des where  TrnDate=@A and SourceDep=@des and Amount<>@M and VoucherId<>@vID);
	insert into temp select * from Trn_Src_Des where SourceDep=@des and TrnDate>@A order by TrnDate,TrnTime,Amount;
	insert into stack select * from Trn_Src_Des where  TrnDate=@A and Amount=@M and VoucherId<>@vID;
	insert into stack select * from Trn_Src_Des where  TrnDate=@A and SourceDep=@des and Amount<>@M and VoucherId<>@vID;
	set @Maxvochertemp= (select MAX(VoucherId) from temp)
	set @Minvochertemp= (select Min(VoucherId) from temp)
	set @counter=@Minvochertemp;
	set @mainsum=(select Amount*1.1 from Trn_Src_Des where VoucherId=@vID);
	--set @sumtemp=0;
	while (@counter<=@Maxvochertemp)
	begin
		--print @counter;
		if(@counter IN (select VoucherId from temp))
		begin
			set @sumtemp= @sumtemp+(select Amount from temp where VoucherId=@counter)
			--print @sumtemp;
			if ( @sumtemp<=@mainsum)
			begin
				insert into Trn_Src_Des_PROC select * from Trn_Src_Des where VoucherId=@counter;
				insert into stack select * from Trn_Src_Des where VoucherId=@counter;
				--print @counter;
			end
			if ( @sumtemp>@mainsum) break;
		set @counter=@counter+1;
		end
		else
			set @counter=@counter+1;
	end
	--select * from stack
	--*********************************************************************************
	declare @topstack int;
	while((select count(*) from stack)>0)
	begin
		delete from temp;
		--select * from stack
		set @topstack=(select top 1 VoucherId from stack order by VoucherId)
		set @des= (select DesDep from Trn_Src_Des where VoucherId=@topstack);
		if (@des>199)
		begin
			delete from stack where VoucherId=@topstack;
		end
		else
		begin
			set @A= (select top 1 TrnDate from Trn_Src_Des where SourceDep=@des order by TrnDate,TrnTime);
			set @M= (select Amount from Trn_Src_Des where VoucherId=@topstack);
			insert into Trn_Src_Des_PROC select * from Trn_Src_Des where  TrnDate=@A and Amount=@M and VoucherId<>@topstack;
			insert into Trn_Src_Des_PROC select * from Trn_Src_Des where  (TrnDate=@A and Amount<>@M) and SourceDep=@des  and VoucherId<>@topstack;
			set @sumtemp=(select sum(Amount) from Trn_Src_Des where (TrnDate=@A and Amount<>@M) and SourceDep=@des  and VoucherId<>@topstack);
			insert into temp select * from Trn_Src_Des where SourceDep=@des and TrnDate>@A order by TrnDate,TrnTime;
			insert into stack select * from Trn_Src_Des where  TrnDate=@A and Amount=@M and VoucherId<>@topstack;
			insert into stack select * from Trn_Src_Des where  (TrnDate=@A and Amount<>@M) and SourceDep=@des  and VoucherId<>@topstack;
			set @Maxvochertemp= (select MAX(VoucherId) from temp)
			set @Minvochertemp= (select Min(VoucherId) from temp)
			set @counter=@Minvochertemp;
			set @mainsum=(select Amount*1.1 from Trn_Src_Des where VoucherId=@topstack);
			while (@counter<=@Maxvochertemp)
			begin
				if(@counter IN (select VoucherId from temp) )
				begin
					set @sumtemp= @sumtemp+(select Amount from temp where VoucherId=@counter)
					if ( @sumtemp<=@mainsum  )
					begin
						insert into Trn_Src_Des_PROC select * from Trn_Src_Des where VoucherId=@counter;
						insert into stack select * from Trn_Src_Des where VoucherId=@counter;
					end
					if ( @sumtemp>@mainsum) break;
				set @counter=@counter+1;
				end
				else
					set @counter=@counter+1;
			end
			delete from stack where VoucherId=@topstack;
		end
	end
--****************************************************
	delete stack;
	delete temp;
	declare @src int;
	declare @timeA varchar(10);
	set @src= (select SourceDep from Trn_Src_Des where VoucherId=@vID);
	set @A= (select top 1 TrnDate from Trn_Src_Des where DesDep=@src and VoucherId<@vID order by VoucherId desc);
	set @timeA=(select top 1 TrnTime from Trn_Src_Des where DesDep=@src and VoucherId<@vID order by VoucherId desc)
	set @M= (select Amount from Trn_Src_Des where VoucherId=@vID);
	--insert into Trn_Src_Des_PROC select * from Trn_Src_Des where  VoucherId=@vID;
	insert into Trn_Src_Des_PROC select * from Trn_Src_Des where  TrnDate=@A and Amount=@M and VoucherId<>@vID;
	insert into Trn_Src_Des_PROC select * from Trn_Src_Des where  TrnDate=@A and DesDep=@src and Amount<>@M and VoucherId<>@vID;
	set @sumtemp=(select sum(Amount) from Trn_Src_Des where  TrnDate=@A and DesDep=@src and Amount<>@M and VoucherId<>@vID);
	insert into temp select * from Trn_Src_Des where DesDep=@src and ((TrnDate=@A and TrnTime<@timeA) OR (TrnDate<@A));
	insert into stack select * from Trn_Src_Des where  TrnDate=@A and Amount=@M and VoucherId<>@vID;
	insert into stack select * from Trn_Src_Des where  TrnDate=@A and DesDep=@src and Amount<>@M and VoucherId<>@vID;
	set @Maxvochertemp= (select MAX(VoucherId) from temp)
	set @Minvochertemp= (select Min(VoucherId) from temp)
	set @counter=@Minvochertemp;
	set @mainsum=(select Amount*1.1 from Trn_Src_Des where VoucherId=@vID);
	while (@counter<=@Maxvochertemp)
	begin
		--print @counter;
		if(@counter IN (select VoucherId from temp))
		begin
			set @sumtemp= @sumtemp+(select Amount from temp where VoucherId=@counter)
			if ( @sumtemp<=@mainsum)
			begin
				insert into Trn_Src_Des_PROC select * from Trn_Src_Des where VoucherId=@counter;
				insert into stack select * from Trn_Src_Des where VoucherId=@counter;
				--print @counter;
			end
			if ( @sumtemp>@mainsum) break;
		set @counter=@counter+1;
		end
		else
			set @counter=@counter+1;
	end
--*************************************************************************	
	while((select count(*) from stack)>0)
	begin
		delete from temp;
		--select * from stack
		set @topstack=(select top 1 VoucherId from stack order by VoucherId)
		set @src= (select SourceDep from Trn_Src_Des where VoucherId=@topstack);
		if (@src>199)
		begin
			delete from stack where VoucherId=@topstack;
		end
		else
		begin
			set @A= (select top 1 TrnDate from Trn_Src_Des where DesDep=@src and VoucherId<@topstack order by VoucherId desc);
			set @timeA=(select top 1 TrnTime from Trn_Src_Des where DesDep=@src and VoucherId<@topstack order by VoucherId desc)
			set @M= (select Amount from Trn_Src_Des where VoucherId=@topstack);
			insert into Trn_Src_Des_PROC select * from Trn_Src_Des where  TrnDate=@A and Amount=@M and VoucherId<>@topstack;
			insert into Trn_Src_Des_PROC select * from Trn_Src_Des where  TrnDate=@A and DesDep=@src and Amount<>@M and VoucherId<>@topstack;
			set @sumtemp=(select sum(Amount) from Trn_Src_Des where  TrnDate=@A and DesDep=@src and Amount<>@M and VoucherId<>@topstack)
			insert into temp select * from Trn_Src_Des where DesDep=@src and ((TrnDate=@A and TrnTime<@timeA) OR (TrnDate<@A));
			insert into stack select * from Trn_Src_Des where  TrnDate=@A and Amount=@M and VoucherId<>@topstack;
			insert into stack select * from Trn_Src_Des where  TrnDate=@A and DesDep=@src and Amount<>@M and VoucherId<>@topstack;
			set @Maxvochertemp= (select MAX(VoucherId) from temp)
			set @Minvochertemp= (select Min(VoucherId) from temp)
			--(select sum(Amount) from temp)<=(select Amount*1.1 from Trn_Src_Des where VoucherId=@vID)
			set @counter=@Minvochertemp;
			set @mainsum=(select Amount*1.1 from Trn_Src_Des where VoucherId=@topstack);
			while (@counter<=@Maxvochertemp)
			begin
				if(@counter IN (select VoucherId from temp) )
				begin
					set @sumtemp= @sumtemp+(select Amount from temp where VoucherId=@counter)
					if ( @sumtemp<=@mainsum  )
					begin
						insert into Trn_Src_Des_PROC select * from Trn_Src_Des where VoucherId=@counter;
						insert into stack select * from Trn_Src_Des where VoucherId=@counter;
					end
					if ( @sumtemp>@mainsum) break;
				set @counter=@counter+1;
				end
				else
					set @counter=@counter+1;
			end
			delete from stack where VoucherId=@topstack;
		end
	end
--****************************************************************************************
select * from Trn_Src_Des_PROC order by VoucherId;
--select * from stack
--select * from temp
drop table temp;
drop table stack; 
END
GO

exec TrnGraph 1005