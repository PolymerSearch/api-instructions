curl --location --request PUT 'https://api.polymersearch.com/v1/datasets/views/dc2507ac-5e5d-456f-897f-e8ae23544b59' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "charts": [
        {
            "type": "timeseries",
            "x_axis": "payment_mechanism",
            "y_axis": "Submission Date",
            "slice": "amount",
            "calculation": "sum"
        },
        {
            "type": "bar",
            "x_axis": "Fee Month",
            "y_axis": "amount",
            "slice": "Submission Date",
            "calculation": "min"
        }
    ]
}'