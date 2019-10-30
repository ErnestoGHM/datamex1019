#Challenge 1
select autid.au_id, autid.au_lname, autid.au_fname,title.title,pubs.pub_name
from
(select authors.au_id, authors.au_lname, authors.au_fname, titaut.title_id
from publications.authors authors
right join publications.titleauthor titaut
on authors.au_id=titaut.au_id
) as autid
left join publications.titles as title
on autid.title_id=title.title_id
left join publications.publishers as pubs
on title.pub_id = pubs.pub_id
;

#Challenge 2
select authors.au_id, authors.au_lname, authors.au_fname,pubs.pub_name,count(title.title)
from publications.authors authors
right join publications.titleauthor titaut
on authors.au_id=titaut.au_id
left join publications.titles as title
on titaut.title_id=title.title_id
left join publications.publishers as pubs
on title.pub_id = pubs.pub_id
group by authors.au_id,pubs.pub_name
;

#Challenge 3
select authors.au_id, authors.au_lname, authors.au_fname,sum(sales.qty) as sale
from publications.authors authors
right join publications.titleauthor titaut
on authors.au_id=titaut.au_id
left join publications.titles as title
on titaut.title_id=title.title_id
left join publications.sales as sales
on title.title_id=sales.title_id
group by authors.au_id
order by sale desc
limit 3
;

#Challenge 4
select authors.au_id, authors.au_lname, authors.au_fname,coalesce(sum(sales.qty),0) as sale
from publications.authors authors
left join publications.titleauthor titaut
on authors.au_id=titaut.au_id
left join publications.titles as title
on titaut.title_id=title.title_id
left join publications.sales as sales
on title.title_id=sales.title_id
group by authors.au_id
order by sale desc
;

#Challenge Bonus
select prof.au_lname,prof.profit
from
(select authors.au_id, authors.au_lname, authors.au_fname,title.advance,title.advance+(title.royalty*sales.qty*title.price/100*titaut.royaltyper/100) as profit
from publications.authors authors
left join publications.titleauthor titaut
on authors.au_id=titaut.au_id
left join publications.titles as title
on titaut.title_id=title.title_id
left join publications.sales as sales
on title.title_id=sales.title_id
order by profit desc) as prof
group by prof.au_lname,prof.profit
order by profit desc
limit 5
;