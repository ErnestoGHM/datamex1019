#Challenge 1
#Step 1
select title.title_id, authors.au_id,	title.royalty*title.price*sales.qty/100*titaut.royaltyper/100 as sales_royalty
from publications.authors authors
right join publications.titleauthor titaut
on authors.au_id=titaut.au_id
left join publications.titles as title
on titaut.title_id=title.title_id
left join publications.sales as sales
on title.title_id=sales.title_id
;

#Step 2
select roy.title_id, roy.au_id,COALESCE(sum(sales_royalty),0)as sumroy
from
(select title.title_id, authors.au_id,	title.royalty*title.price*sales.qty/100*titaut.royaltyper/100 as sales_royalty
from publications.authors authors
right join publications.titleauthor titaut
on authors.au_id=titaut.au_id
left join publications.titles as title
on titaut.title_id=title.title_id
left join publications.sales as sales
on title.title_id=sales.title_id) as roy
group by roy.au_id,roy.title_id
;

#Step 3
select unqroy.au_id,(unqroy.advance+sumroy) as totprof
from
(select roy.title_id,roy.advance,roy.au_id,COALESCE(sum(sales_royalty),0)as sumroy
from
(select title.title_id, authors.au_id,title.advance,title.royalty*title.price*sales.qty/100*titaut.royaltyper/100 as sales_royalty
from publications.authors authors
right join publications.titleauthor titaut
on authors.au_id=titaut.au_id
left join publications.titles as title
on titaut.title_id=title.title_id
left join publications.sales as sales
on title.title_id=sales.title_id) as roy
group by roy.au_id,roy.title_id) as unqroy
order by totprof desc
limit 3
;

#Challenge 2
create temporary table publications.sales_royalty
select title.title_id, authors.au_id,title.advance,title.royalty*title.price*sales.qty/100*titaut.royaltyper/100 as sales_royalty
from publications.authors authors
right join publications.titleauthor titaut
on authors.au_id=titaut.au_id
left join publications.titles as title
on titaut.title_id=title.title_id
left join publications.sales as sales
on title.title_id=sales.title_id
;

create temporary table publications.sumroytemp
select temp.title_id,temp.au_id,tit.advance,COALESCE(sum(sales_royalty),0)as sumroy
from publications.sales_royalty as temp
left join publications.titles as tit
on temp.title_id=tit.title_id
group by temp.title_id,temp.au_id
;

select tem.au_id,(tem.advance+tem.sumroy) as totprof
from publications.sumroytemp as tem
order by totprof desc
limit 3
;

#Challenge 3
-- -----------------------------------------------------
-- Table `lab_mysql_Ernesto`.`most_profiting_authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_mysql_Ernesto`.`most_profiting_authors` (
  `au_id` INT NOT NULL,
  `profits` VARCHAR(45) NULL,
  PRIMARY KEY (`au_id`))
ENGINE = InnoDB;

