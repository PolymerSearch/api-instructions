





# **Welcome to the Polymer Search API**

The Polymer Search API  is the fastest way to convert any dataset into a fully interactive web application, allowing anyone to access AI-recommended insights, make lightning quick visualizations or reports, and more.

The API endpoints provide a simple interface that can be integrated quickly.

Detailed API Documentation is available [HERE](https://apidocs.polymersearch.com/).

**Get in touch**: Contact emir@polymersearch.com for questions about integrating the API with your business platform or other project.

### Before - Raw file in spreadsheet editor:
<img src="https://github.com/PolymerSearch/api-instructions/blob/master/assets/raw_csv.png" width="800">

### After - A fully interactive web app:
![Polymer App](https://github.com/PolymerSearch/api-instructions/blob/master/assets/polymer_app.png?raw=true&s=400)

Check out some live examples: https://flixgem.com, https://sheethacks.com 

## What is Polymer Search?

[Polymer Search](https://polymersearch.com) is the world's fastest path to data-empowerment for everyone. Just upload or connect a CSV/spreadsheet, and create an interactive web application that allows individuals of all backgrounds to understand and share data like never before.


## First step: Getting your API key and authentication

The Polymer Search API uses API keys to regulate endpoint access. You can register a new API key as a user within ‘Workspace Settings’ and the ‘API Keys’ tab.

![Creating an API key](https://github.com/PolymerSearch/api-instructions/blob/master/assets/api_key_management.png?raw=true)

You can create as many API Keys as you want. If you no longer want to use a key, you may disable it from the dashboard. The Polymer Search API expects an API key to be included in all API requests to the server. There are two ways to include a key in requests:

As a query parameter:  `?api_key=&your_api_key`
As a header:  `X-API-KEY: &your_api_key`

You must replace `&your_api_key` with your API key.

## Creating a Polymer app from a raw file/dataset

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
    
-   if **'views'** included in '**fields'** list, views[] will be returned for datasets wherever present with [id, userid, name, visibility, createdat, uid] attributes

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

## Views API

With views API you can create beautiful charts without creating the full Polymer app. Embed in your site a manually selected chart for your data, or let our powerful AI determine what are the best charts for your data.


### Create View
---

POST https://api.polymersearch.com/v1/datasets/:dataset_id/views

    URL Params

|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|dataset_id|true           |Type: String<br />Dataset ID             |



    Body Params

|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|name|true           |Type: String<br />Name of the view            |
|charts          |true           |Type: List [Chart Object] <br /> |
|sharing          |false|Desired sharing status for the dataset (public, private, password-protected). Default: private|
|password          |false|Required only in case of sharing: password-protected, Validation: min 6 characters.|

**Chart Object**
<br >
**AI Chart**
```
{
    "type": "ai"
}
```

| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |ai
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full

<br >

**Bar Chart**

```
{
    "type": "bar",
    "x_axis": [
        "spend",
        "Clicks (all)"
    ],
    "y_axis": "campaign_status",
    "operation": "SUM",
    "y_axis_log": true,
    "show_annotations": true,
    "show_stacked": false
}
```


| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |bar
| x_axis |List |No |list of valid column name. Min length: 1, Max length: 3
| y_axis | String| Yes| valid column name
| operation | String| Yes| Any value from COUNT, SUM, AVERAGE, STDDEV, VARIANCE, MAX, MIN
| slice | String| No| valid column name
| show_annotations | Boolean| No | Annotate each segment by its value
| show_stacked | Boolean| No | Show as stack. Default: true
| is_percentage | Boolean| No | Show as percentage
| y_axis_log | Boolean| No | Use logarithmic scale for Y-Axis
| exclude_empty_string | Boolean| No | Exclude [EMPTY] strings. Default: true
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full
| filters | Object| No | Filter Object

<br >

**Column Chart**
```
{
    "type": "column",
    "x_axis": "campaign_status",
    "y_axis": [
        "spend",
        "Clicks (all)"
    ],
    "operation": "SUM",
    "show_annotations": true,
    "show_stacked": false
}
```


| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |column
| x_axis | String| Yes| valid column name
| y_axis |List |No |list of valid column name. Min length: 1, Max length: 3
| operation | String| Yes| Any value from COUNT, SUM, AVERAGE, STDDEV, VARIANCE, MAX, MIN
| slice | String| No| valid column name
| show_annotations | Boolean| No | Annotate each segment by its value
| show_stacked | Boolean| No | Show as stack. Default: true
| is_percentage | Boolean| No | Show as percentage
| x_axis_log | Boolean| No | Use logarithmic scale for X-Axis
| exclude_empty_string | Boolean| No | Exclude [EMPTY] strings. Default: true
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full
| filters | Object| No | Filter Object

<br >

**SCATTER PLOT Chart**
```
{
    "type": "scatter",
    "x_axis": "spend",
    "y_axis": "cost_per_initiate_checkout",
    "operation": "SUM",
    "x_axis_log": true
}
```


| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |scatter
| x_axis | String| Yes| valid column name
| y_axis |String |Yes |valid column name
| operation | String| Yes| Any value from COUNT, SUM, AVERAGE, STDDEV, VARIANCE, MAX, MIN
| slice | String| No| valid column name
| x_axis_log | Boolean| No | Use logarithmic scale for X-Axis
| y_axis_log | Boolean| No | Use logarithmic scale for Y-Axis
| exclude_empty_string | Boolean| No | Exclude [EMPTY] strings. Default: true
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full
| filters | Object| No | Filter Object

<br >

**TIMESERIES Chart**
```
{
    "type": "timeseries",
    "x_axis": "date",
    "operation": "SUM",
    "y_axis_log": true,
    "exclude_empty_string": false,
    "group_by": "quarter",
    "is_area": true
}
```


| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |timeseries
| x_axis | String| Yes| valid column name
| y_axis |String |No |valid column name
| operation | String| Yes| Any value from COUNT, SUM, AVERAGE, STDDEV, VARIANCE, MAX, MIN
| slice | String| No| valid column name
| is_area | Boolean| No | Use area chart
| y_axis_log | Boolean| No | Use logarithmic scale for Y-Axis
| exclude_empty_string | Boolean| No | Exclude [EMPTY] strings. Default: true
| group_by | String| No | Any value from day, week, month, quarter, year
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full
| filters | Object| No | Filter Object

<br >

**HEATMAP Chart**
```
{
    "type": "heatmap",
    "y_axis": "account_currency",
    "operation": "SUM",
    "exclude_empty_string": false,
    "show_annotations": true
}
```

| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |heatmap
| y_axis |String |Yes |valid column name
| x_axis | String| No| valid column name
| operation | String| Yes| Any value from COUNT, SUM, AVERAGE, STDDEV, VARIANCE, MAX, MIN
| slice | String| No| valid column name
| show_annotations | Boolean| No | Annotate each segment by its value
| exclude_empty_string | Boolean| No | Exclude [EMPTY] strings. Default: true
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full
| filters | Object| No | Filter Object

<br >

**LINEPLOT Chart**
```
{
    "type": "lineplot",
    "x_axis": "spend",
    "y_axis": "link_click",
    "operation": "SUM"
}
```

| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |lineplot
| y_axis |String |Yes |valid column name
| x_axis | String| Yes| valid column name
| operation | String| Yes| Any value from COUNT, SUM, AVERAGE, STDDEV, VARIANCE, MAX, MIN
| slice | String| No| valid column name
| y_axis_log | Boolean| No | Use logarithmic scale for Y-Axis
| exclude_empty_string | Boolean| No | Exclude [EMPTY] strings. Default: true
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full
| filters | Object| No | Filter Object

<br >

**PIE Chart**
```
{
    "type": "pie",
    "columns": [
        "date"
    ],
    "exclude_empty_string": false,
    "show_annotations": true
}
```

| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |pie
| columns |List |Yes |list of valid column name. Min length: 1, Max length: 2
| show_annotations | Boolean| No | Annotate each segment by its value
| exclude_empty_string | Boolean| No | Exclude [EMPTY] strings. Default: true
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full
| filters | Object| No | Filter Object

<br >

**OUTLIERS**
```
{
    "type": "outliers",
    "metric": "spend",
    "operation": "COUNT",
    "exclude_empty_string": false,
    "influencing_columns": [
        "ad_name"
    ]
}
```

| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |outliers
| metric |String |Yes |valid column name
| operation | String| Yes| Any value from COUNT, SUM, AVERAGE, STDDEV, VARIANCE, MAX, MIN
| influencing_columns |List |Yes |Influencing Columns - list of valid column names. Min length: 1, Max length: 6
| results_type |String |No |Show results - Any value from count, below_average_only, above_average_only, top_and_bottom_outliers, above_and_below_average
| show_results_column | Boolean| No | Show Results Column
| exclude_empty_string | Boolean| No | Exclude [EMPTY] strings
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full
| filters | Object| No | Filter Object

<br >

**ROI CALCULATOR**
```
{
    "type": "roi",
    "max_metric": "impressions",
    "max_operation": "AVERAGE",
    "min_metric": "spend",
    "min_operation": "MAX",
    "influencing_columns": [
        "ad_name",
        "campaign_name"
    ],
    "show_results_column": false
}
```

| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |roi
| max_metric |String |Yes |Metric to Maximize (Return) - valid column name
| max_operation | String| Yes| Any value from COUNT, SUM, AVERAGE, STDDEV, VARIANCE, MAX, MIN
| min_metric |String |Yes |Metric to Minimize (Investment) - valid column name
| min_metric | String| Yes| Any value from COUNT, SUM, AVERAGE, STDDEV, VARIANCE, MAX, MIN
| influencing_columns |List |Yes |Influencing Columns - list of valid column names. Min length: 1, Max length: 6
| show_results_column | Boolean| No | Show Results Column
| show_percentage | Boolean| No | Show ROI as Percentage
| exclude_empty_string | Boolean| No | Exclude [EMPTY] strings
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full
| filters | Object| No | Filter Object

<br >

**PIVOT TABLE**
```
{
    "type": "pivot",
    "metrics": [
    {
        "metric": "spend",
        "operation": "SUM"
    }],
    "rows": [
        "account_currency"
    ],
    "columns": ["ad_name"]
}
```

| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |pivot
| metrics |List |Yes |Object, Min length: 1, Max length: 10. <br > **metric**: valid column <br > **operation**: Any value from COUNT, SUM, AVERAGE, STDDEV, VARIANCE, MAX, MIN
| rows |List |Yes |Rows - list of valid column names. Min length: 1, Max length: 1
| columns |List |Yes |Columns - list of valid column names. Min length: 1, Max length: 1
| show_row_totals | Boolean| No | Show Row Totals
| show_column_totals | Boolean| No | Show Column Totals
| show_percentage | Boolean| No | Show Percentage, Default: True
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full
| filters | Object| No | Filter Object

<br >

**KPI BLOCK**
```
{
    "type": "kpi",
    "metric": "impressions",
    "operation": "SUM",
    "date": "date",
    "date_range": "last 90 days",
    "goal": 4000000
}
```


| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |kpi
| metric |List |Yes |valid column name
| operation | String| Yes| Any value from COUNT, SUM, AVERAGE, STDDEV, VARIANCE, MAX, MIN
| date | String| No| valid date column name
| date_range | String| No| Any value from 'last day', 'last 7 days', 'last 30 days', 'last 90 days', 'last 6 months', 'last 12 months, custom
| date_range_custom | List| No| If date_range is selected as custom. [START_DATE_EPOCH_SECONDS, END_DATE_EPOCH_SECONDS]
| comp_date_range | String| No| Any value from 'previous period', 'custom'
| comp_date_range_custom | List| No| If comp_date_range is selected as custom. [START_DATE_EPOCH_SECONDS, END_DATE_EPOCH_SECONDS]
| goal |Number |No |
| exclude_empty_string | Boolean| No | Exclude [EMPTY] strings
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full
| filters | Object| No | Filter Object


<br >

**RICH TEXT**
```
{
    "type": "rich-text-insight",
    "html": "<p><strong>This is just a header</strong></p><p><i>Add blocks of <u>your choice</u></i></p>"
}
```

| Field | Datatype | Mandatory | Desc
| ------ | ------ | ------ | --------
| type |String |Yes |rich-text-insight
| html |String |Yes |HTML text
| width | Boolean| No | Any value from one-third , two-thirds, full. Default: full

<br >



**Filters**
**Allowed values**: object
Following filters can be applied
 - Filter date columns with dynamic date range like last 30 days, last year etc
 - Filter numerical columns with ranges like amount between 25 to 45.
 - Text search in categorical columns like payment mechanism including cash and demand draft.
 -   Text search in categorical columns like payment mechanism excluding cash
Example payload

    {
        "Submission Date": [
        {
            "value": "last 30 days"
        }],
        "amount": [
        {
            "value": [
                10,
                20
            ]
        }],
        "Payment Mechanism": [
        {
            "value": "cash",
            "operation": "INCLUDING"
        }]
    }
Following filter will be read as 

> Submission Date within last 30 days 
> AND 
> amount between range 10 to 20 
> AND
> Payment Mechanism INCLUDING cash

Possible dynamic date ranges
 - last day
 - last 7 days
 - last 30 days
 - last 90 days
 - last 6 months
 - last 12 months

Possible operations
 - INCLUDING
 - EXCLUDING
<br>


### Example 1: Create basic view with all non AI charts ([see curl](view_curl_sample_ex1.sh)): 
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/view' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "My View Name",
    "charts": [
        {
            "type": "pie",
            "x_axis": "payment_mechanism",
            "slice": "Submission Date",
            "operation": "SUM"
        },
        {
            "type": "bar",
            "x_axis": "Fee Month",
            "y_axis": "amount",
            "slice": "Submission Date",
            "operation": "AVERAGE"
        }
    ]
}'
```
### Example 2: Create basic view with all AI charts ([see curl](view_curl_sample_ex2.sh)): 
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/view' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "AI view",
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
```

### Example 3: Create basic view with all AI and non AI charts ([see curl](view_curl_sample_ex3.sh)): 
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/view' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "AI View",
    "charts": [
        {   
            "type": "heatmap",
            "x_axis": "Fee Month",
            "y_axis": "amount",
            "operation": "MAX"
        },
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
```

### Example 4: Create view with a rich text block and column chart with filters([see curl](view_curl_sample_ex4.sh)): 
```sh
curl --location --request POST 'https://api.polymersearch.com/v1/datasets/6278c1c221fb918ae401c228/view' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "Filtered",
    "charts": [
    {
        "type": "rich-text-insight",
        "html": "<p>This is amount received in last 30 days</p><p>&nbsp;</p><hr><p>&nbsp;</p><p><strong>This is only </strong><span style=\"background-color:hsl(6,59%,50%);\"><strong>CASH</strong></span></p>"
    },
    {
        "type": "column",
        "x_axis": "payment_mechanism",
        "y_axis": "amount",
        "operation": "COUNT",
        "filters":
        {
            "submission_date": [
            {
                "value": "last 30 days"
            }],
            "payment_mechanism": [
            {
                "value": "cash",
                "operation": "INCLUDING"
            }]
        }
    }]
}'
```

### Response
```sh
{
    "launch_url": "https://app.polymersearch.com/views/e793422c-71bf-4043-8363-5e5a4f551fc1",
    "uid": "e793422c-71bf-4043-8363-5e5a4f551fc1"
}
```


Sample Response
| Type | Link | Desc
| ------ | ------ | ------ | 
| Success | [get_success.json](response/create_view_success.json)| Launch URL
| Error | [get_error.json](response/create_view_error.json)|

### Edit View
---
PUT https://api.polymersearch.com/v1/datasets/views/:view_uid

    URL Params

|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|view_id|true           |Type: String<br />View UID             |


    Body Params

|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|name|true           |Type: String<br />Name of the view            |
|charts          |false           |Type: List <br /> |
|sharing          |false|Desired sharing status for the dataset (public, private, password-protected).|
|password          |false|Required only in case of sharing: password-protected, Validation: min 6 characters.|

**Charts Object**
Same as described on Create View request
Note: Make sure you pass all the charts inside `charts` key
### Example 1: Edit view with all non AI charts ([see curl](view_edit_curl_sample_ex1.sh)): 
```sh
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
            "operation": "SUM"
        },
        {
            "type": "bar",
            "x_axis": "Fee Month",
            "y_axis": "amount",
            "slice": "Submission Date",
            "operation": "MIN"
        }
    ]
}'
```

### Example 2: Edit view with all non AI charts and name ([see curl](view_edit_curl_sample_ex2.sh)): 
```sh
curl --location --request PUT 'https://api.polymersearch.com/v1/datasets/views/dc2507ac-5e5d-456f-897f-e8ae23544b59' \
--header 'x-api-key: XXeca66c-21f3-XX39-b407-64e00c62XXXX' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "Edited View Name",
    "charts": [
        {
            "type": "bar",
            "x_axis": "payment_mechanism",
            "y_axis": "Submission Date",
            "slice": "amount",
            "operation": "SUM"
        },
        {
            "type": "bar",
            "x_axis": "Fee Month",
            "y_axis": "amount",
            "slice": "Submission Date",
            "operation": "MIN"
        }
    ]
}'
```

### Response
```sh
{
    "launch_url": "https://app.polymersearch.com/views/dc2507ac-5e5d-456f-897f-e8ae23544b59",
    "uid": "dc2507ac-5e5d-456f-897f-e8ae23544b59"
}
```

### GET Views
---
GET https://api.polymersearch.com/v1/datasets/views

    Query Params

|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|name|false           |Type: String<br />             |
|file_id|false           |Type: String<br />Dataset ID             |
|limit|false           |Type: Number<br />Max number of returned results           |
|page|false           |Type: Number<br />Page Number             |
|sort_order|false           |Type: String<br />`desc`, `asc`             |
|sort_key|false           |Type: String<br />Sorting is allowed on `name`, `created_at`              |
|fields|false           |Type: []String<br />Following Fields are allowed: `name`, `sharing`, `file_id`, `user_id`, `uid`, `created_at`, `updated_at`             |

### Response
```sh
{
    "data": [
    {
        "uid": "40d4b950-78bb-4d6c-8b06-9fd20dbdf704",
        "name": "component test Group view 1 4",
        "sharing": "password-protected",
        "launch_url": "https://dinesh.polymerdev.com/views/6278c1c221fb918ae401c228/40d4b950-78bb-4d6c-8b06-9fd20dbdf704",
        "file_id": "6278c1c221fb918ae401c228",
        "user_id": "61ee36cf2ac79ae07f539bcf",
        "created_at": "2022-09-13T10:35:28.349Z",
        "updated_at": "2022-09-13T10:54:02.214Z"
    },
    {
        "uid": "d85a90ec-ed66-432f-bdfa-488bf298ad7e",
        "name": "component test Group view 1 3",
        "sharing": "password-protected",
        "launch_url": "https://dinesh.polymerdev.com/views/6278c1c221fb918ae401c228/d85a90ec-ed66-432f-bdfa-488bf298ad7e",
        "file_id": "6278c1c221fb918ae401c228",
        "user_id": "61ee36cf2ac79ae07f539bcf",
        "created_at": "2022-09-13T10:33:30.863Z",
        "updated_at": "2022-09-13T10:33:30.863Z"
    }],
    "limit": 10,
    "page": 1,
    "sort_key": "created_at",
    "sort_order": "desc"
}
```

### DELETE View
---
DELETE https://api.polymersearch.com/v1/datasets/views/:view_uid

    URL Params

|Field                |Mandatory                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|view_uid|true           |Type: String<br />View UID             |

### Response
```sh
{
   "success": true
}
```


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