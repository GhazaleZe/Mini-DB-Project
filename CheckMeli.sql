use BankProject
go

create view Customer_validation as
	select CID,[Name],NatCod,Birthdate,[Add],Tel,
	case
		when len(NatCod )>10 OR len(NatCod)<8 then 'Invalid NatCode'
		When len(NatCod)=8 then  (case 
									when (((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8))%11)<2  and
										 (((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8))%11)=((cast(NatCod as bigint)%10)) 
										 then 'Valid NatCode'
									when (((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8))%11)>1  and
										 (11-(((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8))%11))=((cast(NatCod as bigint)%10)) 
										 then 'Valid NatCode'
									else 'Invalid NatCode'
									end)
		when len(NatCod)=9 then  (
									case 
									when (((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8)+(((cast(NatCod as bigint)/100000000)%10)*9))%11)<2  and
										 (((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8)+(((cast(NatCod as bigint)/100000000)%10)*9))%11)=((cast(NatCod as bigint)%10)) 
										 then 'Valid NatCode'
									when (((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8)+(((cast(NatCod as bigint)/100000000)%10)*9))%11)>1  and
										 (11-(((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8)+(((cast(NatCod as bigint)/100000000)%10)*9))%11))=((cast(NatCod as bigint)%10)) 
										 then 'Valid NatCode'
									else 'Invalid NatCode'
									end)
		when len(NatCod)=10 then (
									case 
									when (((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8)+(((cast(NatCod as bigint)/100000000)%10)*9)+
										 (((cast(NatCod as bigint)/1000000000)%10)*10))%11)<2  and
										 (((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8)+(((cast(NatCod as bigint)/100000000)%10)*9)+
										 (((cast(NatCod as bigint)/1000000000)%10)*10))%11)=((cast(NatCod as bigint)%10)) 
										 then 'Valid NatCode'
									when (((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8)+(((cast(NatCod as bigint)/100000000)%10)*9)+
										 (((cast(NatCod as bigint)/1000000000)%10)*10))%11)>1  and
										 (11-(((((cast(NatCod as bigint)/10)%10)*2)+(((cast(NatCod as bigint)/100)%10)*3)+
									     (((cast(NatCod as bigint)/1000)%10)*4)+ (((cast(NatCod as bigint)/10000)%10)*5)+
									     (((cast(NatCod as bigint)/100000)%10)*6)+ (((cast(NatCod as bigint)/1000000)%10)*7)+
									     (((cast(NatCod as bigint)/10000000)%10)*8)+(((cast(NatCod as bigint)/100000000)%10)*9)+
										 (((cast(NatCod as bigint)/1000000000)%10)*10))%11))=((cast(NatCod as bigint)%10)) 
										 then 'Valid NatCode'
									else 'Invalid NatCode'
									end)
	end as [Validation]
	from Customer


select * from Customer_validation