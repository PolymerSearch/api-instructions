curl --location --request POST 'https://api.polymersearch.com/v1/dataset' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
	"url": "https://abcc.s3.amazonaws.com/FB+Ads.csv",
	"name": "FB Ad List Q2 C.csv",
	"starting_row": 10,
	"update": true
}'
