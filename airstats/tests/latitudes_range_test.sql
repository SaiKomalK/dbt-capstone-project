select
    airport_ident,
    airport_lat
from {{ ref('silver_airports') }}
where airport_lat < -90 or airport_lat > 90