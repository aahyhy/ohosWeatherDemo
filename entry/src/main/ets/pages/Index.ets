import SideBar from './view/SideBar'
import SideBarContent from './view/SideBarContent'
import SideBarContentBac from './view/SideBarContentBac'
import { getNowWeather, get7dWeather, get24hWeather, getNowAir } from '../network/api/WeatherApi'
import { CityModel } from './model/CityModel'
import { WeatherUiModel } from './model/WeatherUiModel'

@Entry
@Component
struct Index {
  @State isShowSideBar: boolean = false
  @State @Watch("initData") selectCity: CityModel = { locationId: 101280601, locationName: '深圳' }
  @State cityArr: CityModel[] = [
    { locationId: 101010100, locationName: '北京' }, { locationId: 101280601, locationName: '深圳' },
    { locationId: 101020100, locationName: '上海' }, { locationId: 101250101, locationName: '长沙' },
    { locationId: 101310101, locationName: '海口' }, { locationId: 101070201, locationName: '大连' }]
  @State weatherUiModel: WeatherUiModel = {
    nowTemp: 0,
    nowWeatherText: 0,
    tempMax: 0,
    tempMin: 0,
    category: 0,
    precip: 0,
    hourlyTemp: [],
    iconDays: [],
    date: '2月6日',
    day: '周一',
    dayArr: [],
    hoursArr: [],
  }
  private weeks = new Array('周日', '周一', '周二', '周三', '周四', '周五', '周六');
  private TAG: string = 'NET_WORK_'

  //绘制界面
  build() {
    SideBarContainer(SideBarContainerType.Embed) {

      //侧边栏
      SideBar({ cityArr: $cityArr, selectCity: $selectCity, isShowSideBar: $isShowSideBar })

      if (this.isShowSideBar) {
        //灰底
        SideBarContentBac({ selectCity: $selectCity, isShowSideBar: $isShowSideBar })
      } else {
        SideBarContent({ isShowSideBar: $isShowSideBar, selectCity: $selectCity, weatherUiModel: $weatherUiModel })
      }

    }
    .showControlButton(false)
    .showSideBar(this.isShowSideBar)
    .autoHide(false)
    .sideBarWidth(160)

  }

  async aboutToAppear() {
    this.initData()
  }

  async initData() {
    let locationId = this.selectCity.locationId;

    let myDate = new Date;
    let mon = myDate.getMonth() + 1;
    let date = myDate.getDate();
    let hours = myDate.getHours();
    let day = myDate.getDay();

    this.weatherUiModel.date = mon + '月' + date + '日'
    this.weatherUiModel.day = this.weeks[day]
    this.weatherUiModel.dayArr = []
    this.weatherUiModel.dayArr.push('今天', '明天', this.weeks[day <= 4 ? day + 2 : day - 5],
    this.weeks[day <= 3 ? day + 3 : day - 4], this.weeks[day <= 2 ? day + 4 : day - 3])
    this.weatherUiModel.hoursArr = []
    for (var i = 0; i < 5; i++) {
      this.weatherUiModel.hoursArr.push(hours + i + ':00')
    }

    let nowWeatherModel = (await getNowWeather(locationId)).data
    let weather7dModel = (await get7dWeather(locationId)).data
    let weather24hModel = (await get24hWeather(locationId)).data
    let nowAirModel = (await getNowAir(locationId)).data

    this.weatherUiModel.nowTemp = nowWeatherModel.now.temp
    this.weatherUiModel.precip = nowWeatherModel.now.precip
    this.weatherUiModel.nowWeatherText = nowWeatherModel.now.text
    this.weatherUiModel.tempMax = weather7dModel.daily[0].tempMax
    this.weatherUiModel.tempMin = weather7dModel.daily[0].tempMin
    this.weatherUiModel.category = nowAirModel.now.category

    this.weatherUiModel.hourlyTemp = []
    for (var index = 0; index < 5; index++) {
      this.weatherUiModel.hourlyTemp.push({ temp: weather24hModel.hourly[index].temp })

    }

    this.weatherUiModel.iconDays = []
    for (var i = 0; i < 5; i++) {
      this.weatherUiModel.iconDays.push({ iconDay: weather7dModel.daily[i].iconDay + '.svg' })
    }
  }

  conLog(string) {
    console.info(this.TAG + string)
  }
}