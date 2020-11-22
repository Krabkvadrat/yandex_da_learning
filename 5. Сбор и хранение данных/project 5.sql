select
       extract(week from flights.departure_time) as week_number
       ,count(ticket_flights.ticket_no) as ticket_amount
       ,subq.festival_week as festival_week
       ,subq.festival_name as festival_name
from 
    flights
inner join airports 
    on airports.airport_code = flights.arrival_airport
inner join ticket_flights
    on ticket_flights.flight_id = flights.flight_id
left join (
        select
            extract(week from festivals.festival_date) as festival_week
            ,festivals.festival_name
        from 
            festivals
        where festivals.festival_city='Москва'
        order by 1 asc
       ) as subq on extract(week from flights.departure_time) = festival_week
where 
    cast(flights.departure_time as date) >= '2018-07-23'
    and cast(flights.departure_time as date) <= '2018-09-30'
    and airports.city = 'Москва'
group by 1,3,4
order by 1