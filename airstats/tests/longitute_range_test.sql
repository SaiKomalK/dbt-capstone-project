select
    airport_ident,
    airport_long
from {{ ref('silver_airports') }}
where airport_long < -180 or airport_long > 180