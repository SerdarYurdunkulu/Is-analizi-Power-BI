--Birle�tirme tablosu olu�turma--
select * from [dbo].[Absenteeism_at_work] a
left join [dbo].[compensation] b
on a.ID = b.ID
left join [dbo].[Reasons] r on
a.[Reason_for_absence] = r.[Number]

--Bonus vermek i�in en sa�l�kl� �al��anlar� analiz etmek--
select * from [dbo].[Absenteeism_at_work]
where Social_drinker = 0 and Social_smoker = 0
and Body_mass_index < 25 and 
[Absenteeism_time_in_hours] < (select avg([Absenteeism_time_in_hours]) from [dbo].[Absenteeism_at_work])

--Sigara i�meyenler i�in art�� oran�n�n analizi-- B�t�e = 983.221 $ /saatlik zam 0.68 $/ Y�lda 1.414.4 $
select count(*) as non_smokers from [dbo].[Absenteeism_at_work]
where Social_smoker = 0


-- Sorguyu optimize edelim -- Bu kod PowerBI database ba�lant�s� yap�l�rken yaz�lacak.
select a.ID,r.[Reason],[Month_of_absence],[Body_mass_index],
--V�cut kitle indeksine g�re v�cut tipi olu�turuyoruz.
case when [Body_mass_index]<18.5 then 'Hafif Kilolu'
	 when [Body_mass_index] between 18.5 and 25 then 'Sa�l�kl� kilolu'
	 when [Body_mass_index] between 25 and 30 then 'A��r� Kilolu'
	 when [Body_mass_index] >30 then 'Obez'
	 end as BMI_Category
--Aylara g�re mevsim tan�mlar� yap�p yeni bir column olu�turuyoruz.
,case when [Month_of_absence] in (12,1,2) then 'K��'
	 when [Month_of_absence] in (3,4,5) then '�lkbahar'
	 when [Month_of_absence] in (6,7,8) then 'Yaz'
	 when [Month_of_absence] in (9,10,11) then 'Sonbahar'
	 when [Month_of_absence] in (1,2,3,4,5,6,7,8,9,10,11,12) then 'T�m mevsimler'
	 end as Season_Names,
Seasons,[Month_of_absence],[Day_of_the_week],[Transportation_expense],[Education],[Son],[Social_drinker],[Social_smoker],
[Pet],[Disciplinary_failure],[Age],[Work_load_Average_day],[Absenteeism_time_in_hours]


from [Proje2].[dbo].[Absenteeism_at_work] a
left join [Proje2].[dbo].[compensation] b
on a.ID = b.ID
left join [Proje2].[dbo].[Reasons] r on
a.[Reason_for_absence] = r.[Number]