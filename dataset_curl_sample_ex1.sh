curl --location --request POST 'https://app.polymersearch.com/api/v1/dataset' \
--header 'x-api-key: b58aab30-17f1-4bc7-83df-4c8301fea504' \
--header 'Content-Type: application/json' \
--data-raw '{
"url": "https://abcc.s3.amazonaws.com/FB+Ads.csv",
"name": "FB Ad List Q2.csv"
}'