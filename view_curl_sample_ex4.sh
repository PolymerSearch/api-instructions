curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/view' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "Filtered",
    "charts": [
    {
        "type": "rich-text-insight",
        "html": "<p>This is amount received in last 30 days</p><p>&nbsp;</p><hr><p>&nbsp;</p><p><strong>This is only </strong><span style=\"background-color:hsl(6,59%,50%);\"><strong>CASH</strong></span></p>"
    },
    {
        "type": "column",
        "x_axis": "payment_mechanism",
        "y_axis": "amount",
        "operation": "COUNT",
        "filters":
        {
            "submission_date": [
            {
                "value": "last 30 days"
            }],
            "payment_mechanism": [
            {
                "value": "cash",
                "operation": "INCLUDING"
            }]
        }
    }]
}'