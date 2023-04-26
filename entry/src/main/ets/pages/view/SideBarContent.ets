import { CityModel } from '../model/CityModel'
import { WeatherUiModel } from '../model/WeatherUiModel'

@Component
export default struct SideBarContent {

  private lineHeight: number = 40
  private pointArr: number[] = [1, 2, 3, 4, 5]

  @State selectDay: string = '今天'
  @Link isShowSideBar: boolean
  @Link selectCity: CityModel
  @Link @Watch('calculatePoint') weatherUiModel: WeatherUiModel

  build() {
    Column() {

      //head
      Row() {
        Image($r('app.media.icon_city'))
          .width(28)
          .height(28)
          .onClick(() => {
            this.isShowSideBar = !this.isShowSideBar;
          })
        Blank()
        Image($r('app.media.icon_more'))
          .width(28)
          .height(28)
      }
      .width('100%')

      //temp_city
      Row() {
        Text(this.weatherUiModel.nowTemp)
          .fontSize(120)
          .fontColor('#E6000000')
          .fontWeight(FontWeight.Bold)
        Column() {
          Text('°')
            .fontSize(48)
            .fontColor('#E6000000')
            .fontWeight(FontWeight.Bold)
          Text(this.weatherUiModel.nowWeatherText)
            .fontSize(38)
        }

        Blank()
        Text(this.selectCity.locationName)
          .fontSize(38)
          .margin({ top: 50 })
      }
      .margin({ top: 130 })
      .width('100%')

      Text(this.weatherUiModel.date + '  ' + this.weatherUiModel.day + '  ' +
      this.weatherUiModel.tempMin + '℃' + '/' + this.weatherUiModel.tempMax + '℃')
        .fontSize(16)
        .margin({ left: 4 })
        .textAlign(TextAlign.Start)
        .width('100%')

      //precip_category
      Row() {

        Column() {
          Text('未来两小时')
            .fontSize(14)
          Blank()
          if (this.weatherUiModel.precip > 0) {
            Text('有雨')
              .fontSize(32)
              .fontColor('#FFF7B500')
          } else {
            Text('无雨')
              .fontSize(32)
              .fontColor('#FF6DD400')
          }
        }
        .backgroundColor('#05000000')
        .padding({ top: 12, bottom: 15 })
        .border({ radius: 14 })
        .size({ width: 140, height: 100 })

        Column() {
          Text('空气质量')
            .fontSize(14)
          Blank()
          if (this.weatherUiModel.category == '优') {
            Text('优')
              .fontSize(32)
              .fontColor('#FF6DD400')
          } else if (this.weatherUiModel.category == '良') {
            Text('良')
              .fontSize(32)
              .fontColor('#F7B500')
          } else if (this.weatherUiModel.category == '轻度污染') {
            Text('轻度污染')
              .fontSize(32)
              .fontColor('#FF7F40')
          } else if (this.weatherUiModel.category == '中度污染') {
            Text('中度污染')
              .fontSize(32)
              .fontColor('#FFE25555')
          } else if (this.weatherUiModel.category == '重度污染') {
            Text('重度污染')
              .fontSize(32)
              .fontColor('#7F017E')
          } else if (this.weatherUiModel.category == '严重污染') {
            Text('严重污染')
              .fontSize(32)
              .fontColor('#7F3E2E')
          }
        }
        .backgroundColor('#05000000')
        .padding({ top: 12, bottom: 15 })
        .margin({ left: 14 })
        .border({ radius: 14 })
        .size({ width: 140, height: 100 })

      }
      .margin({ top: 24 })
      .width('100%')

      //hoursArr_Polyline_hourlyTemp
      Column() {
        //hoursArr
        Row() {
          ForEach(this.weatherUiModel.hoursArr, (item) => {
            Text(item)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
          })
        }
        .margin({ bottom: 10 })

        //Polyline_hourlyTemp
        if (this.weatherUiModel.hourlyTemp.length > 0) {
          Polyline({ width: '100%', height: this.lineHeight })
            .points([['5%', this.pointArr[0]],
              ['25%', this.pointArr[1]], ['50%', this.pointArr[2]],
              ['75%', this.pointArr[3]], ['95%', this.pointArr[4]]])
            .fillOpacity(0)
            .stroke('#AAB8CA')
            .strokeWidth(1)

          Row() {
            ForEach(this.weatherUiModel.hourlyTemp, (item) => {
              Text(item.temp + '℃')
                .textAlign(TextAlign.Center)
                .layoutWeight(1)
            })
          }
          .margin({ top: 35 })
        }

      }
      .margin({ top: 39 })
      .width('100%')

      //iconDays_dayArr
      Column() {

        //iconDays
        Row() {
          ForEach(this.weatherUiModel.iconDays, (item) => {
            Column() {

              Image($rawfile(item.iconDay))
                .size({ width: 24, height: 24 })
            }
            .align(Alignment.Center)
            .layoutWeight(1)
          })
        }

        //dayArr
        Row() {
          ForEach(this.weatherUiModel.dayArr, (item) => {
            Column() {
              if (item == this.selectDay) {
                Text(item)
                  .fontColor(Color.White)
                  .textAlign(TextAlign.Center)
                  .height(40)
                  .width(40)
                  .border({ radius: 40 })
                  .fontSize(14)
                  .backgroundColor(Color.Black)
              } else {
                Text(item)
                  .textAlign(TextAlign.Center)
                  .height(40)
                  .width(40)
                  .fontSize(14)
              }
            }
            .layoutWeight(1)
            .align(Alignment.Center)
            .onClick(() => {
              //天气切换功能
              //              this.selectDay = item
            })
          })
        }
        .margin({ top: 18 })

      }
      .margin({ top: 30 })
      .width('100%')

    }
    .padding({ left: 38, right: 24, top: 20 })
    .height('100%')
    .width('100%')
    .backgroundColor(Color.White)
  }

  //点位置计算
  calculatePoint() {
    if (this.weatherUiModel.hourlyTemp.length > 0) {
      for (var i = 0; i < 5; i++) {
        let tempArg = parseInt(this.weatherUiModel.hourlyTemp[0].temp)
        if (i == 0) {
          this.pointArr[i] = this.lineHeight - tempArg
        } else {
          this.pointArr[i] = this.lineHeight -
          (((parseInt(this.weatherUiModel.hourlyTemp[i].temp) - tempArg) * 3) +
          parseInt(this.weatherUiModel.hourlyTemp[i].temp))
        }
      }
    }
  }

}