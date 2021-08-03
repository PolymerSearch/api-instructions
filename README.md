
# Welcome to PolymerSearch public API instructions

You can use our API to access PolymerSearch API endpoints, that provide various functionality present at our website.

Detailed API Documentation is available [HERE](https://apidocs.polymersearch.com/).

Before
![Raw CSV](https://github.com/PolymerSearch/api-instructions/blob/master/assets/raw_csv.png?raw=true)

After
![Polymer App](https://github.com/PolymerSearch/api-instructions/blob/master/assets/polymer_app.png?raw=true)

## Authentication

PolymerSearch API uses API keys to allow access to our endpoints. You can register a new API key as a user, inside workspace settings, on the API Keys section.

![Creating an API key](https://github.com/PolymerSearch/api-instructions/blob/master/assets/api_key_management.png?raw=true)

As of now you can create as many API Keys as you want and give them a name. Once you don't want to use it you can disable it from the dashboard. PolymerSearch API expects the API key to be included in all API requests to the server. There are two ways to include it in requests:

As a query parameter:  `?api_key=&your_api_key`
As a header:  `X-API-KEY: &your_api_key`

You must replace `&your_api_key` with your personal API key.

## Dataset API

The Dataset API allows creating new PolymerSearch sites from your CSV.

### Uploading a Dataset

This endpoint starts processing of provided CSV.

POST https://api.polymersearch.com/v1/dataset
|Field                |Mendatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|url|true           |URL to a valid public downloadable CSV.            |
|name          |true           |Name of the dataset/file.            |
|sharing          |false|Desired sharing status for the dataset (public, private, password-protected).
|password          |false|Required only in case of sharing: password-protected, Validation: min 6 characters.|
|import_from          |false|Copy views & user config from an existing dataset. import_from.id would be source dataset ID from which you want to copy views or user config. import_from.data is an array with possible values views, user_config (one of them or both)  |

Example 1: 
```sh
curl --location --request POST 'https://dinesh.polymerdev.com/api/v1/dataset' \
--header 'x-api-key: XXd5c7f6-XXf9-4320-XX4d-5673d8XXd5bb' \
--header 'Content-Type: application/json' \
--data-raw '{
"url": "https://abcc.s3.amazonaws.com/myfile.csv",
"name": "Payment yearly.csv"
}'
```
Example 2: 
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/dataset' \
--header 'x-api-key: XXd5c7f6-feXX-43XX-XX4d-5673d8f0d5XX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://abcc.s3.amazonaws.com/myfile.csv",
    "name": "Payment yearly2.csv",
    "import_from": {
        "id": "6107ab93fa0ec85cb863f0e1",
        "data": [
            "views"
        ]
    }
}'
```

Example 3: 
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/dataset' \
--header 'x-api-key: XXd5c7f6-feXX-43XX-XX4d-5673d8f0d5XX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://abcc.s3.amazonaws.com/myfile.csv",
    "name": "Payment yearly3.csv",
    "import_from": {
        "id": "6107ab93fa0ec85cb863f0e1",
        "data": [
            "views","user_config"
        ]
    }
}'
```

Sample Response
| Type | Link | Desc
| ------ | ------ | ------ | 
| Success | [success.json](response/success.json)| `task_id` to fetch task status
| Error | [error.json](response/error.json)|

[Javascript snippet](javascript.js) |
[Curl snippet](dataset_curl_sample.sh)

![API Invocation via curl](https://user-images.githubusercontent.com/5403700/126966334-0d409a7d-970b-4fe0-bbdb-18f8f2f77d69.mp4)

## # Task API
### Fetch Status
GET https://api.polymersearch.com/v1/tasks/:taskid
Sample Response
| Type | Link | Desc
| ------ | ------ | ------ | 
| Success | [task-success.json](response/task-success.json)|
| Error | [task-error.json](response/task-error.json)|

[Curl snippet](task_curl_sample.sh)

Response Description
| Field | Datatype | Desc
| ------ | ------ | ------ | 
| status | String|If set to 'Done' then task is executed and you can find response in data key
| data.success | Boolean| If true then dataset was processed successfully and launch URL (data.launch_url) is ready
| data.launch_url | String| launch URL (data.launch_url), only if data.success is true
| data.embed_code | String| Embed Code (data.embed_code), only if data.success is true
| errors | List| List of errors, only if data.success is false

## Postman collection

You can download the Postman collection directly from [here](PolymerSearch-postman.json).


## Rate Limiting
All PolymerSearch APIs have rate limiting implemented. A single API key can make up to 150 requests per hour. After reaching the rate limit, HTTP Status 429 - Too Many Requests, will be returned.

Response headers contain rate-limiting details:

-   X-RateLimit-Limit: Number of requests you can make in an hour
-   X-RateLimit-Remaining: Number of requests left for the time window
-   X-RateLimit-Reset: The remaining window before the rate limit resets in UTC epoch seconds