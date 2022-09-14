curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/view' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "AI view",
    "description": "AI Driven Charts",
    "charts": [
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