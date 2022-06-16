curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/components' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "AI Component",
    "description": "AI Driven Charts",
    "charts": [
        {
            "type": "ai",
            "size": "half"
        },
        {
            "type": "ai",
            "size": "half"
        },
        {
            "type": "ai",
            "size": "full"
        }
    ]
}'