



# **Welcome to the Polymer Search API**

The Polymer Search API  is the fastest way to convert any dataset into a fully interactive web application, allowing anyone to access AI-recommended insights, make lightning quick visualizations or reports, and more.

The API endpoints provide a simple interface that can be integrated quickly.

Detailed API Documentation is available [HERE](https://apidocs.polymersearch.com/).

**Get in touch**: Contact emir@polymersearch.com for questions about integrating the API with your business platform or other project.

### Before: Any raw dataset
<img src="https://github.com/PolymerSearch/api-instructions/blob/master/assets/raw_csv.png" width="800">

### After: A fully interactive site
Check out some live examples: https://flixgem.com, https://sheethacks.com 
![Polymer App](https://github.com/PolymerSearch/api-instructions/blob/master/assets/polymer_app.png?raw=true&s=400)


## What is Polymer Search?

[Polymer Search](https://polymersearch.com) is the world's fastest path to data-empowerment for everyone. Just upload or connect a CSV/spreadsheet, and create an interactive web application that allows individuals of all backgrounds to understand and share data like never before.


## First step: Getting your API key and authentication

The Polymer Search API uses API keys to regulate endpoint access. You can register a new API key as a user within ‘Workspace Settings’ and the ‘API Keys’ tab.

![Creating an API key](https://github.com/PolymerSearch/api-instructions/blob/master/assets/api_key_management.png?raw=true)

You can create as many API Keys as you want. If you no longer want to use a key, you may disable it from the dashboard. The Polymer Search API expects an API key to be included in all API requests to the server. There are two ways to include a key in requests:

As a query parameter:  `?api_key=&your_api_key`
As a header:  `X-API-KEY: &your_api_key`

You must replace `&your_api_key` with your API key.

## Creating a Polymer app from a raw dataset

The Dataset API allows creating new PolymerSearch sites from your CSV.

POST https://api.polymersearch.com/v1/dataset

|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|url|false           |URL to a valid public downloadable CSV.            |
|file          |false           |Type: file. The file to upload.         |
|name          |true           |Name of the dataset/file.            |
|sharing          |false|Desired sharing status for the dataset (public, private, password-protected). Defaults to private.
|password          |false|Required only in case of sharing: password-protected, Validation: min 6 characters.|
|starting_row           |false|Desired row number where Polymer should start processing your file.|
|update           |false|Boolean. Force update dataset in case a dataset already exists with the given name.|
|import_from          |false|Object for copy views & user config from an existing dataset (see below).|
|import_from.id           |true|source dataset ID from which you want to copy views or user-config. You can copy ID from Polymer app UI.|
|import_from.data           |true|Array containing views, user_config (one of them or both).|

Note: One of 'url' or 'file' parameter is required.

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

### Example 5 ([see curl](dataset_curl_sample_ex5.sh)): Create a dataset with file upload.
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/dataset' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--form 'name="Payment yearly 2022 920.csv"' \
--form 'file=@"/local_file_path/file_name.csv"'
```

### Intermediate response

Polymer returns an intermediate response until the task is completed. You can use this to poll the status of the task.

```sh
{
    "task_id": "60f7bdd7c07d897637ac60f5"
}
```

### Final success response

Once the task is completed, Polymer returns the final app information that is ready to be used!
* **launch_url** indicates the unlisted web url at which the app is available.
* **embed_code** indicates the embed code to embed within your own app

```json
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

See [Check Task -> Fetch Status API](#task-api) for more details.

### Types of responses

| Type | Link | Desc
| ------ | ------ | ------ | 
| Intermediate Success | [success.json](response/success.json)| `task_id` to fetch task status
| Final Success |  [task-success.json](response/task-success.json) | 
| Error | [error.json](response/error.json)|

### Example code to get started quickly
[Javascript API snippet](javascript.js) 

See detailed documentation [HERE](https://apidocs.polymersearch.com/).

#### Postman collection
You can download the Postman collection directly from [here](PolymerSearch-postman.json).


### Short video (1 minute) that demonstrates the process
[Dataset conversion via Polymer API + curl](https://user-images.githubusercontent.com/5403700/126966334-0d409a7d-970b-4fe0-bbdb-18f8f2f77d69.mp4)

## Updating the data for an existing Polymer app
This endpoint updates the content and the name of the existing dataset.

PUT https://api.polymersearch.com/v1/dataset/:id

URL Params
|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|id|true           |Dataset ID.|

Body Params
|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|url|false           |URL to a valid public downloadable CSV.            |
|name          |false           |Name of the dataset/file.|
|file          |false           |Type: file. The file to upload.|
|sharing          |false|Desired sharing status for the dataset (public, private, password-protected).|
|password          |false|Required only in case of sharing: password-protected, Validation: min 6 characters.|

Note: One of 'url' or 'file' parameter is required.

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
### Example 2 ([see curl](dataset_update_curl_sample_ex2.sh)): 
```sh
curl --location --request PUT 'https://api.polymersearch.com/v1/dataset/6151754dfad4622deeb8f84b' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--form 'name="FB Ad List Q2 D-uploaded.csv"' \
--form 'file=@"/local_file_path/file_name.csv"'
```
### Response
```sh
{
    "task_id": "60f7bdd7c07d897637ac60f5"
}
```
**Intermediate response:** Polymer returns an **intermediate response** which you can use to poll the task status.  
**Final success response:** You can use this task ID to poll status of dataset processing. [Check Task -> Fetch Status API](#task-api) for more details.


Sample Response
| Type | Link | Desc
| ------ | ------ | ------ | 
| Success | [success.json](response/success.json)| `task_id` to fetch task status
| Error | [error.json](response/error.json)|

## Fetch existing Polymer apps
This endpoint fetches the details of existing Polymers apps

GET https://api.polymersearch.com/v1/dataset

Query Params
|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|source_type|false           |Type: String<br />Filter by remote source name<br />Supported values: [Airtable, GoogleDrive, Dropbox, Upload, Example, Kloudless, API]            |
|name          |false           |Type: String<br />Filter by name of the datasets. Name of the dataset/file.|
|limit          |false           |Type: Number. <br />Default value: 10 |
|page          |false           |Type: Number. <br />Default value: 1<br /> |
|sort_key          |false|Type: String. <br />Supported values: [desc, asc], Default value: created_at |
|sort_order          |false|Type: String. <br />Supported values: [name, created_at, num_rows], Default value: desc<br /> |
|fields          |false|Type: List. <br />Required: True, <br />Supported values: [name, user, user_email, mime_type, source_type, sharing, workspace_id, created_at, num_rows, status, views, sheets, sheet]<br />Default value: [name, user, user_email, mime_type, source_type, sharing, workspace_id, created_at, num_rows, status, sheet]|

Note: 

 - 'name'** field will search on the 'name' attribute of the parent sheets only. It'll not search on 'name' attribute of the child sheets
    
-   'name' ignore case while searching and it works on the principle of a like operator with regex **%${given_value}%**
    
-   if **'sheets'** included in '**fields'** list, sheets for each parent will be returned with the same fields list
    
-   if **'views'** included in '**fields'** list, views[] will be returned for datasets wherever present with [id, userid, name, description, visibility, createdat, uid] attributes

### Example 1 ([see curl](dataset_get_curl_sample_ex1.sh)): 
```sh
curl --location --request GET 'https://api.polymersearch.com/v1/dataset' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX'
```
### Example 2 ([see curl](dataset_get_curl_sample_ex2.sh)): 
```sh
curl --location -g --request GET 'https://api.polymersearch.com/v1/dataset?name=N18&fields=[%22name%22,%22user%22,%22num_rows%22]' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX'
```
### Response
```sh
{
    "data": [
    {
        "_id": "61f8100fb04dff5a38b4e0ad",
        "name": "Manual N18 1.xlsx",
        "user": "61ee36cf2ac79ae07f539bcf",
        "id": "61f8100fb04dff5a38b4e0ad"
    },
    {
        "_id": "61f8100fb04dff83d9b4e0ae",
        "name": "MN18 2nd file Nov - Multisheet.xlsx",
        "user": "61ee36cf2ac79ae07f539bcf",
        "id": "61f8100fb04dff83d9b4e0ae"
    }],
    "pagination":
    {
        "page_size": 10,
        "page_num": 1
    }
}
```

Sample Response
| Type | Link | Desc
| ------ | ------ | ------ | 
| Success | [get_success.json](response/get_success.json)| List of datasets maching query
| Error | [get_error.json](response/get_error.json)|

## Delete Polymer app
This endpoint deletes existing Polymers app

DELETE https://api.polymersearch.com/v1/dataset/:id

Body Params
|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|delete|false           |Type: String<br />Supported values: [trash]<br /> Pass this flag to move dataset to trash           


### Example 1 ([see curl](dataset_delete_curl_sample_ex1.sh)): 
```sh
curl --location --request DELETE 'https://api.polymersearch.com/v1/dataset/6203c33cc83f04b0ed605c9c' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json'
```
### Example 2 ([see curl](dataset_delete_curl_sample_ex2.sh)): 
```sh
curl --location --request DELETE 'https://api.polymersearch.com/v1/dataset/6203c33cc83f04b0ed605c9c' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "delete": "trash"
}'
```
### Response
```sh
{
    "success": true
}
```

Sample Response
| Type | Link | Desc
| ------ | ------ | ------ | 
| Success | [delete_success.json](response/get_success.json)|


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


## Copying views and customization from another manually created Polymer app

Let's say you want to have certain views and customization pre-available when you create a Polymer app using the API. To do this, first create an app on the Polymer platform using a similar/same dataset and make all of the views and customizations that you want.

You can then copy all views and customizations from a different dataset by adding import_from object in the request, and including id of the dataset and data that you want to copy (either views, user_config, or both).

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

## Components API
TBD short description
![Creating an API key](https://github.com/PolymerSearch/api-instructions/blob/components_api/assets/component.png?raw=true)

### Create Component
---

POST https://api.polymersearch.com/v1/datasets/:dataset_id/components

URL Params

|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|dataset_id|true           |Type: String<br />Dataset ID             |



Body Params
|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|name|true           |Type: String<br />Name of the component            |
|description          |false           |Type: String<br />Short description of the component|
|charts          |true           |Type: List <br /> |

**Charts Object**

**Field**: type
**Mandatory**: true
**Allowed values**
- bar 
- scatter 
- timeseries
- heatmap
- lineplot
- pie
- dependencywheel
- ai 
<br >

**Field**: x_axis
**Mandatory**

> if type is **ai** then **not allowed** 
> if type is **dependencywheel**
> then **not required** for **other types** it is **required**

**Allowed values**: valid column name
<br >

**Field**: y_axis
**Mandatory**:

> if type is **ai** then **not allowed** 
> if type is **pie** then **not required** 
> for **other types** it is **required**

**Allowed values**: valid column name
<br >

**Field**: slice
**Mandatory**

> if type is **ai** then **not allowed** 
> for **other types** it is **not required**
> 
**Allowed values**: valid column name
<br >

**Field**: size
**Mandatory**: true
**Allowed values**
- half 
- full 
<br >

**Field**: calculation
**Mandatory**

> if type is **ai** then **not allowed** 
> for **other types** it is **required**

**Allowed values**
- count 
- sum
- average
- stddev
- variance
- max
- min 

### Example 1: Create basic compont with all non AI charts ([see curl](component_curl_sample_ex1.sh)): 
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/components' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "My Component Name",
    "description": "My Component Short Description",
    "charts": [
        {
            "type": "pie",
            "x_axis": "payment_mechanism",
            "slice": "Submission Date",
            "calculation": "sum",
            "size": "full"
        },
        {
            "type": "bar",
            "x_axis": "Fee Month",
            "y_axis": "amount",
            "slice": "Submission Date",
            "calculation": "average",
            "size": "half"
        }
    ]
}'
```
### Example 2: Create basic compont with all AI charts ([see curl](component_curl_sample_ex2.sh)): 
```sh
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
```

### Example 3: Create basic compont with all AI and non AI charts ([see curl](component_curl_sample_ex3.sh)): 
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/components' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "AI Component",
    "description": "AI Driven Charts",
    "charts": [
        {   
            "type": "heatmap",
            "x_axis": "Fee Month",
            "y_axis": "amount",
            "calculation": "max",
            "size": "full"
        },
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
```

### Response
```sh
{
    "launch_url": "https://api.polymersearch.com/components/e793422c-71bf-4043-8363-5e5a4f551fc1",
    "uid": "e793422c-71bf-4043-8363-5e5a4f551fc1"
}
```


Sample Response
| Type | Link | Desc
| ------ | ------ | ------ | 
| Success | [get_success.json](response/create_component_success.json)| Launch URL
| Error | [get_error.json](response/create_component_error.json)|


## Rate Limiting
All PolymerSearch APIs have rate limiting implemented. A single API key can make up to 150 requests per hour. After reaching the rate limit, HTTP Status 429 - Too Many Requests, will be returned.

Response headers contain rate-limiting details:

-   X-RateLimit-Limit: Number of requests you can make in an hour
-   X-RateLimit-Remaining: Number of requests left for the time window
-   X-RateLimit-Reset: The remaining window before the rate limit resets in UTC epoch seconds

# Frequently Asked Questions
- [How do I make the generated site public?](#how-do-i-make-the-generated-site-public)
- [What formats are supported by Dataset API?](#what-formats-are-supported-by-dataset-api)
- [Can the Datasets uploaded via Dataset API be seen in my Polymer Search dashboard?](#can-the-datasets-uploaded-via-dataset-api-be-seen-in-my-polymer-search-dashboard)
- [I received task_id from Dataset API, what are the next steps to get the dataset URL?](#i-received-task_id-from-dataset-api-what-are-the-next-steps-to-get-the-dataset-url)

### How do I make the generated site public?
Set sharing:public when invoking the Dataset API to make a site publicly accessible.

### What formats are supported by Dataset API?
The Polymer Search API supports 'CSV' format only.

### Can the datasets uploaded via Dataset API be seen in my Polymer Search dashboard?
Yes, all the datasets uploaded by the API will be visible in your Polymer Search dashboard.

### I received task_id from Dataset API, what are the next steps to get the dataset URL?
You need to invoke Task -> Fetch Status API to fetch the dataset launch URL.
