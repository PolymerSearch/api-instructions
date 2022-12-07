curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/view' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "My View Name",
    "charts": [
        {
            "type": "pie",
            "x_axis_multiple": [
                {
                    "name": "payment_mechanism"
                }
            ]
            "slice": "Submission Date"
        },
        {
            "type": "bar",
            "x_axis": "Fee Month",
            "y_axis": "amount",
            "slice": "Submission Date",
            "operation": "AVERAGE"
        }
    ]
}'