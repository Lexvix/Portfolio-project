select * from portfolio.nashvillehousing;

ALTER table portfolio.nashvillehousing
add saledateconverted Date;

update portfolio.nashvillehousing
set saledateconverted=convert(saledate,DATE);

select PropertyAddress from portfolio.nashvillehousing
where PropertyAddress <>'';

SELECT * FROM portfolio.nashvillehousing
order by ParcelID;

select a.ParcelID,a.PropertyAddress, b.ParcelID, b.PropertyAddress, if(a.propertyaddress,'',b.propertyaddress)
 from portfolio.nashvillehousing a
join portfolio.nashvillehousing b
  on a.parcelid =b.ParcelID
  and a.UniqueID <>b.UniqueID
  where a.PropertyAddress = '';

Update portfolio.nashvillehousing a
join portfolio.nashvillehousing b
    on a.parcelid =b.ParcelID
     and a.UniqueID <>b.UniqueID
     set a.propertyaddress = if(a.propertyaddress,'',b.propertyaddress)
      where a.PropertyAddress = '';


ALTER table portfolio.nashvillehousing
add propertyaddress1 text;
update portfolio.nashvillehousing
set 
propertyaddress1= 
substring_index(propertyaddress,',',1);

ALTER table portfolio.nashvillehousing
add propertycityaddress text;
update portfolio.nashvillehousing
set 
propertycityaddress=
substring_index(propertyaddress,',',-1);

select OwnerAddress from portfolio.nashvillehousing;

ALTER table portfolio.nashvillehousing
add owneraddress1 text;
ALTER table portfolio.nashvillehousing
add ownercityaddress text;
ALTER table portfolio.nashvillehousing
add owneraddresscode text;

update portfolio.nashvillehousing
set owneraddress1=substring_index(owneraddress,',',1);
update portfolio.nashvillehousing
set ownercityaddress=substring_index(substring_index(owneraddress,',' ,2),',',-1);
update portfolio.nashvillehousing
set owneraddresscode=substring_index(owneraddress,',',-1);
    
select distinct(soldasvacant), count(soldasvacant)
from portfolio.nashvillehousing
group by soldasvacant
order by 2;
    
update portfolio.nashvillehousing
set soldasvacant=  
case when soldasvacant = 'Y' then 'Yes'  
      when  soldasvacant = 'N' then 'No'
      else soldasvacant
      end;
    
with rownumcte as(
select *,
  row_number() 
  over (partition by parcelid, propertyaddress, saleprice, saledate, legalreference
  order by uniqueid) as row_num
  from portfolio.nashvillehousing)
 #select * from rownumcte where row_num>1 order by propertyaddress; 
DELETE portfolio.nashvillehousing 
FROM portfolio.nashvillehousing 
INNER JOIN rownumcte  
ON portfolio.nashvillehousing.ParcelID = rownumcte.ParcelID
WHERE rownumcte.row_num > 1;   

alter table portfolio.nashvillehousing
drop column owneraddress,
drop column TaxDistrict,
drop column PropertyAddress,
drop column saledate;
  
  
  
  
  
  
    
    
    
    


