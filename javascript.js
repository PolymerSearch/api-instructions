var axios = require('axios');
var qs = require('qs');
var data = qs.stringify({
 'url': 'https://abcc.s3.amazonaws.com/FB+Ads.csv',
'name': 'FB Ads.csv' 
});
var config = {
  method: 'post',
  url: 'https://api.polymersearch.com/v1/dataset',
  headers: { 
    'x-api-key': 'XXeca66c-21f3-XX39-b407-64e00c62XXXX', 
    'Content-Type': 'application/x-www-form-urlencoded'
  },
  data : data
};

axios(config)
.then(function (response) {
  console.log(JSON.stringify(response.data));
})
.catch(function (error) {
  console.log(error);
});