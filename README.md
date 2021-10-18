
# Welcome to PolymerSearch public API instructions

You can use our API to access PolymerSearch API endpoints, that provide various functionality present on our website.

Detailed API Documentation is available [HERE](https://apidocs.polymersearch.com/).

Before
![Raw CSV](https://github.com/PolymerSearch/api-instructions/blob/master/assets/raw_csv.png?raw=true)

After
![Polymer App](https://github.com/PolymerSearch/api-instructions/blob/master/assets/polymer_app.png?raw=true)

## What is PolymerSearch

[Polymer Search](https://polymersearch.com) is the world's fastest path to a data-driven team, regardless of background. It lets you upload or sync a CSV/spreadsheet and creates an interactive web app that you can share easily with others.


## Authentication

PolymerSearch API uses API keys to allow access to our endpoints. You can register a new API key as a user, inside workspace settings, on the API Keys section.

![Creating an API key](https://github.com/PolymerSearch/api-instructions/blob/master/assets/api_key_management.png?raw=true)

As of now you can create as many API Keys as you want and give them a name. Once you don't want to use it you can disable it from the dashboard. PolymerSearch API expects the API key to be included in all API requests to the server. There are two ways to include it in requests:

As a query parameter:  `?api_key=&your_api_key`
As a header:  `X-API-KEY: &your_api_key`

You must replace `&your_api_key` with your API key.

## Uploading a Dataset

The Dataset API allows creating new PolymerSearch sites from your CSV.

POST https://api.polymersearch.com/v1/dataset
|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|url|true           |URL to a valid public downloadable CSV.            |
|name          |true           |Name of the dataset/file.            |
|sharing          |false|Desired sharing status for the dataset (public, private, password-protected). Defaults to private.
|password          |false|Required only in case of sharing: password-protected, Validation: min 6 characters.|
|starting_row           |false|Desired row count where Polymer should start processing your file.|
|update           |false|Boolean. Force update dataset in case a dataset already exists with the given name.|
|import_from          |false|Object for copy views & user config from an existing dataset (see below).|
|import_from.id           |true|source dataset ID from which you want to copy views or user-config. You can copy ID from Polymer app UI.|
|import_from.data           |true|Array containing views, user_config (one of them or both).|

### Example 1 ([see curl](dataset_curl_sample_ex1.sh)): Create a dataset just with a name and dataset URL.
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/dataset' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://abcc.s3.amazonaws.com/FB+Ads.csv",
    "name": "FB Ad List Q2.csv"
}'
```
### Example 2 ([see curl](dataset_curl_sample_ex2.sh)): Update content of an existing dataset.
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/dataset' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://abcc.s3.amazonaws.com/FB+Ads.csv",
    "name": "FB Ad List Q2 C.csv",
    "update": true
}'
```

### Example 3 ([see curl](dataset_curl_sample_ex3.sh)): Create a dataset with a name, dataset URL and import all the views from an existing dataset.
Note: Copy import_from.id from Polymer UI.
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/dataset' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://abcc.s3.amazonaws.com/FB+Ads.csv",
    "name": "FB Ad List Q3.csv",
    "import_from": {
        "id": "610b9b87263134f034b5dd73",
        "data": [
            "views"
        ]
    }
}'
```

### Example 4: ([see curl](dataset_curl_sample_ex4.sh)): Create a dataset with a name, dataset URL and import all the views, user config from an existing dataset.
```sh
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
```
### Response
```sh
{
    "task_id": "60f7bdd7c07d897637ac60f5"
}
```
You can use this task ID to poll status of dataset processing. [Check Task -> Fetch Status API](#task-api) for more details.

| Type | Link | Desc
| ------ | ------ | ------ | 
| Success | [success.json](response/success.json)| `task_id` to fetch task status
| Error | [error.json](response/error.json)|

[Javascript snippet](javascript.js) |

![API Invocation via curl](https://user-images.githubusercontent.com/5403700/126966334-0d409a7d-970b-4fe0-bbdb-18f8f2f77d69.mp4)

## Updating a Dataset
This endpoint update content, name of the existing dataset.

PUT https://api.polymersearch.com/v1/dataset/:id

URL Params
|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|id|true           |Dataset ID.|

Body Params
|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|url|true           |URL to a valid public downloadable CSV.            |
|name          |false           |Name of the dataset/file.|

### Example 1 ([see curl](dataset_update_curl_sample_ex1.sh)): 
```sh
curl --location --request PUT 'https://api.polymersearch.com/v1/dataset/6151754dfad3627deeb8f84b' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "FB Ad List Q2 C-uploaded.csv",
    "url": "https://test-csv-datasets.s3.us-east-2.amazonaws.com/Test+-+Bank+Loans.csv"
}'
```
### Response
```sh
{
    "task_id": "60f7bdd7c07d897637ac60f5"
}
```
You can use this task ID to poll status of dataset processing. [Check Task -> Fetch Status API](#task-api) for more details.
Sample Response
| Type | Link | Desc
| ------ | ------ | ------ | 
| Success | [success.json](response/success.json)| `task_id` to fetch task status
| Error | [error.json](response/error.json)|


## Task API
### Fetch Status
GET https://api.polymersearch.com/v1/tasks/:taskid
### Response
```sh
{
    "id": "60f139c67168e50baf7c0d00",
    "user_id": "60990e185b2895737aa8841c",
    "status": "Done",
    "type": "dataset_upload",
    "created_at": "2021-07-16T07:48:22.435Z",
    "updated_at": "2021-07-16T07:51:32.692Z",
    "data":
    {
        "message": "file processing done",
        "launch_url": "https://app.polymersearch.com/polymer/data/60f7bdd7c07d8900b5ac60f8",
        "embed_code": "<iframe height=\"1200\" scrolling=\"no\" src=\"https://app.polymersearch.com/polymer/data/60f7bdd7c07d8900b5ac60f8\" style=\"overflow:hidden;height:100%;width:100%;position:absolute;top:0;left:0;right:0;bottom:0\" width=\"100%\"></iframe>",
        "success": true
    }
}
```
| Type | Link | Desc
| ------ | ------ | ------ | 
| Success | [task-success.json](response/task-success.json)|
| In Progress | [task-in-progress.json](response/task-in-progress.json)|
| Error | [task-error.json](response/task-error.json)|

[Curl snippet](task_curl_sample.sh)
Response Description
| Field | Datatype | Desc
| ------ | ------ | ------ | 
| status | String|If set to 'Done' then task is executed and you can find response in data key
| data.success | Boolean| If true then dataset was processed successfully and launch URL (data.launch_url) is ready
| data.launch_url | String| launch URL (data.launch_url), only if data.success is true
| data.embed_code | String| Embed Code (data.embed_code), only if data.success is true
| data.errors | List| List of errors, only if data.success is false


## Copying views and config

You can copy all views and config from a different dataset by adding `import_from` object in the request, and including `id` of the dataset and `data` that you want to copy (either `views`, `user_config`, or both).

```
{
    "import_from":{
        "id": "6107ab93fa0ec85cb863f0e1",
        "data": [
            "views","user_config"
        ]
    }
}
```

## Postman collection

You can download the Postman collection directly from [here](PolymerSearch-postman.json).


## Rate Limiting
All PolymerSearch APIs have rate limiting implemented. A single API key can make up to 150 requests per hour. After reaching the rate limit, HTTP Status 429 - Too Many Requests, will be returned.

Response headers contain rate-limiting details:

-   X-RateLimit-Limit: Number of requests you can make in an hour
-   X-RateLimit-Remaining: Number of requests left for the time window
-   X-RateLimit-Reset: The remaining window before the rate limit resets in UTC epoch seconds

# Frequently Asked Questions
- [How to make generated site public?](#how-to-make-generated-site-public)
- [What formats are supported by Dataset API?](#what-formats-are-supported-by-dataset-api)
- [Can the Datasets uploaded via Dataset API be seen in PolymerSearch Dashboard?](#can-the-datasets-uploaded-via-dataset-api-be-seen-in-polymersearch-dashboard)
- [What input sources Dataset API supports?](#what-input-sources-dataset-api-supports)
- [I received task_id from Dataset API, what are the next steps to get dataset URL?](#i-received-task_id-from-dataset-api-what-are-the-next-steps-to-get-dataset-url)

### How to make generated site public?
Set `sharing:public` when invoking the Dataset API to make a site publically accessible.

### What formats are supported by Dataset API?
As of now, PolymerSearch API supports 'CSV' format only. We're planning to add support for xlsx soon.

### Can the Datasets uploaded via Dataset API be seen in PolymerSearch Dashboard?
Yes, all the datasets uploaded API will be visible in PolymerSearch Dashboard.

### What input sources Dataset API supports?
Currently, it supports publically downloadable CSV URLs only. We’re planning to add support for other sources soon (starting with form-data upload).

### I received task_id from Dataset API, what are the next steps to get dataset URL?
You need to invoke Task -> Fetch Status API to fetch dataset launch URL.