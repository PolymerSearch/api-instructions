curl --location --request POST 'https://api.polymersearch.com/v1/dataset' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://abcc.s3.amazonaws.com/FB+Ads.csv",
    "name": "FB Ad List Q5.csv",
    "import_from": {
        "id": "610b9b87263134f034b5dd73",
        "data": [
            "views", "user_config"
        ]
    }
}'