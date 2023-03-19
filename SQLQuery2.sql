Select * from portfolio1..sharktank1

-- total episode

Select Count(Distinct [Ep# No#]) from portfolio1..sharktank1
Select max([ep# no#]) from portfolio1..sharktank1

--Pitches
Select count(distinct brand) Brand from portfolio1..sharktank1

--Pitches converted
Select sum(converted_not_converted) funding_recieved,count(*) total_pitches from (
 Select [Amount Invested lakhs] , case when [Amount Invested lakhs]>0 then 1 else 0 end as converted_not_converted from portfolio1..sharktank1) a

 --total male
 Select sum(male) from portfolio1..sharktank1
 Select sum(female) from portfolio1..sharktank1

 Select sum(female)/sum(male) from portfolio1..sharktank1
 --total invested amount
 Select sum([Amount Invested Lakhs]) from portfolio1..sharktank1

 --avg equity taken 
 Select * from portfolio1..sharktank1
 Select avg([Equity Taken %])from portfolio1..sharktank1

 --highest deal
 Select max([Amount Invested lakhs]) from portfolio1..sharktank1

 Select sum(b.female_count) from (
 Select *, case when female>0 then 1 else 0 end as female_count from
(Select * from portfolio1..sharktank1 where Deal!= 'No deal') a) b

--amount invested in deals
Select avg(a.[Amount Invested Lakhs]) amount_invested_per_deal from
(Select* from portfolio1..sharktank1 where Deal!= 'no deal') a

--Avaerage age group
Select * from portfolio1..sharktank1
Select [Avg age], COUNT([Avg age]) from portfolio1..sharktank1 group by [Avg age]
-- modifies
Select [Avg age], COUNT([Avg age]) cnt from portfolio1..sharktank1 group by [Avg age] order by cnt Asc

--Location

Select [Location], COUNT([Location]) cnt from portfolio1..sharktank1 group by [Location] order by cnt Asc

--Partners deals
Select Partners, COUNT(Partners) cnt from portfolio1..sharktank1 where Partners! = '-' group by Partners order by cnt Desc

--Making the matrix
Select * from portfolio1..sharktank1
Select count([Ashneer Amount Invested])from portfolio1..sharktank1 where [Ashneer Amount Invested] is not null
Select count([Ashneer Amount Invested])from portfolio1..sharktank1 where [Ashneer Amount Invested] is not null AND [Ashneer Amount Invested]!=0

Select sum(C.[Ashneer Amount Invested]), AVG(C.[Ashneer Amount Invested])
From (Select * from portfolio1..sharktank1 WHere [Ashneer Amount Invested]!=0 AND [Ashneer Amount Invested] is not null) C

--Joining all above to make a matrix
Select k.keyy,k.total_deals_present,k.total_deals,l.total_amount_invested,l.average_equity_taken from
(Select a.keyy,a.total_deals_present,b.total_deals from(
Select 'Ashneer' as keyy,count([Ashneer Amount Invested])total_deals_present from portfolio1..sharktank1 where [Ashneer Amount Invested] is not null) a
Inner join (
Select 'Ashneer' as keyy,count([Ashneer Amount Invested])total_deals from portfolio1..sharktank1 where [Ashneer Amount Invested] is not null AND [Ashneer Amount Invested]!=0) b
on a.keyy=b.keyy) k

inner join
(Select 'Ashneer' as keyy, sum(C.[Ashneer Amount Invested])total_amount_invested, AVG(C.[Ashneer Amount Invested])average_equity_taken
From (Select * from portfolio1..sharktank1 WHere [Ashneer Amount Invested]!=0 AND [Ashneer Amount Invested] is not null) C) l
on k.keyy=l.keyy

-- which is the startup in which highest amount invested
select c.* from
(Select Brand,sector, [Amount Invested lakhs],rank() over(partition by sector order by [Amount Invested lakhs] desc)rnk from portfolio1..sharktank1) c
where c.rnk=1