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

POST http://api.polymersearch.com/dataset
|Field                |Mendatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|url|true           |URL to a valid public downloadable CSV.            |
|name          |true           |Name of the dataset/file.            |
|sharing          |false|Desired sharing status for the dataset (public, private, password-protected)
|password          |false|Required only in case of sharing: password-protected, Validation: min 6 characters.|

Example: 
```sh
curl --location --request POST 'http://api.polymersearch.com/dataset' \
--header 'x-api-key: XXXc8ef-Xdd9-4XX6-X72d-X119377fXXX' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'url=https://abcc.s3.amazonaws.com/myfile.csv' \
--data-urlencode 'name=Payments 11 July 1a'
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
GET http://api.polymersearch.com/tasks/:taskid
Sample Response
| Type | Link | Desc
| ------ | ------ | ------ | 
| Success | [task-success.json](response/task-success.json)|
| Error | [task-error.json](response/task-error.json)|

[Curl snippet](task_curl_sample.sh)

Response Description
| Type | Datatype | Desc
| ------ | ------ | ------ | 
| data.status | String|If set to 'Done' then task is executed and you can find response in data.data key
| data.data.success | Boolean| If true then dataset was processed successfully and launch URL (data.data.launch_url) is ready
| data.data.launch_url | Boolean| launch URL (data.data.launch_url), only if data.data.success is true
| data.data.embed_code | Boolean| Embed Code (data.data.embed_code), only if data.data.success is true
| data.errors | List| List of errors, only if data.data.success is false

## Postman collection

You can download the Postman collection directly from [here](PolymerSearch-postman.json).


## Rate Limiting
All PolymerSearch APIs have rate limiting implemented. A single API key can make up to 150 requests per hour. After reaching the rate limit, HTTP Status 429 - Too Many Requests, will be returned.

Response headers contain rate-limiting details:

-   X-RateLimit-Limit: Number of requests you can make in an hour
-   X-RateLimit-Remaining: Number of requests left for the time window
-   X-RateLimit-Reset: The remaining window before the rate limit resets in UTC epoch seconds

Currently there is no rate limiting per user, but it may be introduced in future updates.
