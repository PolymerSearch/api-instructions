curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/components' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "My Component Name",
    "description": "My Component Short Description",
    "charts": [
        {
            "type": "pie",
            "x_axis": "payment_mechanism",
            "slice": "Submission Date",
            "calculation": "sum",
            "size": "full"
        },
        {
            "type": "bar",
            "x_axis": "Fee Month",
            "y_axis": "amount",
            "slice": "Submission Date",
            "calculation": "average",
            "size": "half"
        }
    ]
}'