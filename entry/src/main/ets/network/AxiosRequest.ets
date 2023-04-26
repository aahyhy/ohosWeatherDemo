import {axios} from '@ohos/axios'

export default axios

axios.defaults.baseURL = 'https://devapi.qweather.com/v7/';

// 请求拦截器
axios.interceptors.request.use(async config => {
  console.info('axios request interceptors,url:', config.url, ',params:', config.params, ',data:', config.params)

  config.method = 'get'
  config.params.key = 'a546dd6657824b6882ec461255642293'
  return config;
}, error => {
  console.info('axios request interceptors error');
  Promise.reject(error);
})

// 响应拦截器
axios.interceptors.response.use(res => {
  console.info('axios response interceptors');
  return res;
}, error => {
  console.info('axios response interceptors error:', error);
  return Promise.reject(error);
}
)