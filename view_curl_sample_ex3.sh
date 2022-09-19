curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/view' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "AI View",
    "charts": [
        {   
            "type": "heatmap",
            "x_axis": "Fee Month",
            "y_axis": "amount",
            "calculation": "max"
        },
        {
            "type": "ai"
        },
        {
            "type": "ai"
        },
        {
            "type": "ai"
        }
    ]
}'