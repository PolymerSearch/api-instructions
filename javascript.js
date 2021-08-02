var axios = require('axios');
var qs = require('qs');
var data = qs.stringify({
 'url': 'https://abcc.s3.amazonaws.com/FB+Ads.csv',
'name': 'FB Ads.csv' 
});
var config = {
  method: 'post',
  url: 'https://dev.polymerdev.com/api/v1/dataset',
  headers: { 
    'x-api-key': 'ca224bb4-9144-4e22-8d1b-a4cd57d9eb37', 
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