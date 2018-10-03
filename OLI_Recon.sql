-- Daily Qry for ETL WITH CUSTOMER NAME AND UNIT PRICE
SELECT
    o.ext_purchase_order AS order_number,
    oli.item_name AS item_name,
    oli.units_pakd AS units_pakd,
    TO_CHAR(trunc(oli.last_updated_dttm),'mm/dd/yyyy') AS last_updated_dttm,
    oni.note AS note,
    o.o_facility_alias_id AS o_facility_alias_id,
    oli.description,
    oli.UNIT_MONETARY_VALUE as Unit_Price,
    o.D_NAME as Customer_Name ,
    '0' AS dummy
FROM
    order_line_item oli,
    orders o,
    (
        SELECT
            order_id,
            line_item_id,
            note
        FROM
            order_note
        WHERE
            note_code IS NOT NULL
        GROUP BY
            order_id,
            line_item_id,
            note
    ) oni
WHERE
    o.order_id = oli.order_id
    AND   oli.order_id = oni.order_id
    AND   oli.line_item_id = oni.line_item_id
    AND 
     trunc(oli.last_updated_dttm) = DATE '2018-02-14' and  
       oli.do_dtl_status = 190;
