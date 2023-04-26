import axiosRequest from '../AxiosRequest'
import { NowWeatherModel, Weather7dModel, Weather24hModel, NowAirModel } from '../model/WeatherModels'
import { AxiosResponse } from '@ohos/axios'

// 实时天气
export function getNowWeather(location: number): Promise <AxiosResponse<NowWeatherModel>> {
  return axiosRequest({
    url: 'weather/now',
    params: { location }
  })
}

// 7日天气
export function get7dWeather(location: number): Promise<AxiosResponse<Weather7dModel>> {
  return axiosRequest({
    url: 'weather/7d',
    params: { location }
  })
}

// 24小时天气预报
export function get24hWeather(location: number): Promise<AxiosResponse<Weather24hModel>> {
  return axiosRequest({
    url: 'weather/24h',
    params: { location }
  })
}

// 实时空气质量
export function getNowAir(location: number): Promise<AxiosResponse<NowAirModel>> {
  return axiosRequest({
    url: 'air/now',
    params: { location }
  })
}

