/*
Önce sipariş edilmiş ürünleri listeleyen bir sorgu ardından
sipariş edilMEmiş ürünleri listeleyen bir sorgu ardından
bir değişken ile verilen kategoride sipariş edilMEmiş ürünleri bulun bundan bir fonksiyon ve prosedür yazın.
*/


select * from [Sipariş Detayları]
left join Siparişler on [Sipariş Detayları].SiparişNo = Siparişler.SiparişNo

select * from
 Siparişler as s inner join [Sipariş Detayları] as sd on s.SiparişNo = sd.SiparişNo

select * from
 Siparişler as s left join [Sipariş Detayları] as sd on s.SiparişNo = sd.SiparişNo






 -- sipariş edilen ürünler
 select sd.SiparişNo, sd.ÜrünNo, u.ÜrünAd, u.KategoriNo from
 [Sipariş Detayları] as sd right join Ürünler as u on sd.ÜrünNo = u.ÜrünNo
 where sd.SiparişNo is not null


 
 -- sipariş edilMEyen ürünler
 select u.ÜrünAd as [Sipariş EdilMEyen ÜrünAdları],k.KategoriAdı, u.KategoriNo from
 [Sipariş Detayları] as sd right join Ürünler as u on sd.ÜrünNo = u.ÜrünNo
						inner join Kategoriler as k on u.KategoriNo = k.KategoriNo 
 where sd.SiparişNo is null



  
 -- sipariş edilMEyen ürünler kategori sorgulu
 select u.ÜrünAd as [Sipariş EdilMEyen ÜrünAdları],k.KategoriAdı, u.KategoriNo from
 [Sipariş Detayları] as sd right join Ürünler as u on sd.ÜrünNo = u.ÜrünNo
						inner join Kategoriler as k on u.KategoriNo = k.KategoriNo 
 where sd.SiparişNo is null and u.KategoriNo = 1
 
 
 go
 create function sip_verilmemis( @kategorino int)
 returns table
 as
  return select u.ÜrünAd as [Sipariş EdilMEyen ÜrünAdları],k.KategoriAdı, u.KategoriNo from [Sipariş Detayları] as sd right join Ürünler as u on sd.ÜrünNo = u.ÜrünNo inner join Kategoriler as k on u.KategoriNo = k.KategoriNo where sd.SiparişNo is null and u.KategoriNo = @kategorino
 go

-- fonksiyon ile kategori id ye göre sipariş edilmeyen ürünleri bulma
select * from dbo.sip_verilmemis(1)

go
create proc sip_verilmemisproc (@kategorino int)
declare @sorgu nvarchar(200)
set @sorgu = 'select u.ÜrünAd as [Sipariş EdilMEyen ÜrünAdları],k.KategoriAdı, u.KategoriNo from [Sipariş Detayları] as sd right join Ürünler as u on sd.ÜrünNo = u.ÜrünNo inner join Kategoriler as k on u.KategoriNo = k.KategoriNo where sd.SiparişNo is null and u.KategoriNo =' + @kategorino
exec print @sorgu
go
