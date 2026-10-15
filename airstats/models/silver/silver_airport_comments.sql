{{
    config(
        materialized = 'incremental',
        unique_key = 'comment_id',
        incremental_strategy = 'append'
    )
}}
select
    comment_id,
	airport_ident,
	comment_timestamp,
	nvl(member_nickname, '__UNKNOWN__') as member_nickname,
	comment_subject,
	comment_body,
    current_timestamp() as loaded_at
from {{ref('src_airport_comments')}}
where (comment_body is not null or comment_body != '')
{% if is_incremental() %}
    and comment_id > (select max(comment_id) from {{this}})
{% endif %}