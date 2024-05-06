--Birleþtirme tablosu oluþturma--
select * from [dbo].[Absenteeism_at_work] a
left join [dbo].[compensation] b
on a.ID = b.ID
left join [dbo].[Reasons] r on
a.[Reason_for_absence] = r.[Number]

--Bonus vermek için en saðlýklý çalýþanlarý analiz etmek--
select * from [dbo].[Absenteeism_at_work]
where Social_drinker = 0 and Social_smoker = 0
and Body_mass_index < 25 and 
[Absenteeism_time_in_hours] < (select avg([Absenteeism_time_in_hours]) from [dbo].[Absenteeism_at_work])

--Sigara içmeyenler için artýþ oranýnýn analizi-- Bütçe = 983.221 $ /saatlik zam 0.68 $/ Yýlda 1.414.4 $
select count(*) as non_smokers from [dbo].[Absenteeism_at_work]
where Social_smoker = 0


-- Sorguyu optimize edelim -- Bu kod PowerBI database baðlantýsý yapýlýrken yazýlacak.
select a.ID,r.[Reason],[Month_of_absence],[Body_mass_index],
--Vücut kitle indeksine göre vücut tipi oluþturuyoruz.
case when [Body_mass_index]<18.5 then 'Hafif Kilolu'
	 when [Body_mass_index] between 18.5 and 25 then 'Saðlýklý kilolu'
	 when [Body_mass_index] between 25 and 30 then 'Aþýrý Kilolu'
	 when [Body_mass_index] >30 then 'Obez'
	 end as BMI_Category
--Aylara göre mevsim tanýmlarý yapýp yeni bir column oluþturuyoruz.
,case when [Month_of_absence] in (12,1,2) then 'Kýþ'
	 when [Month_of_absence] in (3,4,5) then 'Ýlkbahar'
	 when [Month_of_absence] in (6,7,8) then 'Yaz'
	 when [Month_of_absence] in (9,10,11) then 'Sonbahar'
	 when [Month_of_absence] in (1,2,3,4,5,6,7,8,9,10,11,12) then 'Tüm mevsimler'
	 end as Season_Names,
Seasons,[Month_of_absence],[Day_of_the_week],[Transportation_expense],[Education],[Son],[Social_drinker],[Social_smoker],
[Pet],[Disciplinary_failure],[Age],[Work_load_Average_day],[Absenteeism_time_in_hours]


from [Proje2].[dbo].[Absenteeism_at_work] a
left join [Proje2].[dbo].[compensation] b
on a.ID = b.ID
left join [Proje2].[dbo].[Reasons] r on
a.[Reason_for_absence] = r.[Number]