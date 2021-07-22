# Welcome to PolymerSearch public API instructions

You can use our API to access PolymerSearch API endpoints, that provide various functionality present at our website.

Detailed API Documentation is available [HERE](https://apidocs.polymersearch.com/).

Before
![Raw CSV](https://github.com/PolymerSearch/polymer-search-api/blob/master/assets/raw_csv.png?raw=true)

After
![Polymer App](https://github.com/PolymerSearch/polymer-search-api/blob/master/assets/polymer_app.png?raw=true)

## Authentication

PolymerSearch API uses API keys to allow access to our endpoints. You can register a new API key as a user, inside workspace settings, on the API Keys section.

![Creating an API key](https://github.com/PolymerSearch/polymer-search-api/blob/master/assets/api_key_management.png?raw=true)

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
| Success | [success.json](response/success.json)| `launch_url` is your polymer site URL
| Error | [error.json](response/error.json)|

[Javascript snippet](javascript.js) |
[Curl snippet](curl_sample.sh) |
[Short video](Dataset%20API.mp4)


## Postman collection

You can download the Postman collection directly from [here](PolymerSearch-postman.json).


## Rate Limiting
All PolymerSearch APIs have rate limiting implemented. A single API key can make up to 150 requests per hour. After reaching the rate limit, HTTP Status 429 - Too Many Requests, will be returned.

Response headers contain rate-limiting details:

-   X-RateLimit-Limit: Number of requests you can make in an hour
-   X-RateLimit-Remaining: Number of requests left for the time window
-   X-RateLimit-Reset: The remaining window before the rate limit resets in UTC epoch seconds

Currently there is no rate limiting per user, but it may be introduced in future updates.