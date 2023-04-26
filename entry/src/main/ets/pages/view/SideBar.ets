import {CityModel} from '../model/CityModel'

@Component
export default struct SideBar {
  @Link cityArr: CityModel[]
  @Link selectCity: CityModel
  @Link isShowSideBar: boolean

  build() {
    Column() {
      Text('城市选择')
        .fontSize(28)
        .width('100%')
        .fontColor('#E6000000')
        .padding({ top: 15, left: 22 })


      List({ space: 8, initialIndex: 0 }) {

        ForEach(this.cityArr, (item) => {
          ListItem() {

            if (this.selectCity.locationName == item.locationName) {
              Text(item.locationName)
                .width('100%')
                .fontSize(20)
                .fontColor('#E64F7EFD')
                .backgroundColor('#1A4F7EFD')
                .padding({ top: 10, bottom: 10, left: 22 })
            } else {
              Text(item.locationName)
                .width('100%')
                .fontSize(20)
                .borderRadius(10)
                .fontColor('#E6000000')
                .padding({ top: 10, bottom: 10, left: 22 })
            }

          }.onClick(() => {
            this.selectCity = item
            this.isShowSideBar = !this.isShowSideBar;
            console.info('点击了' + item)
          }
          )

        })
      }
      .width('100%')
      .height('80%')
      .margin({ top: 26 })

      Row() {
        Image($r('app.media.icon_plus'))
          .size({ width: 60, height: 60 })
          .margin({ left: 20 })
      }
      .align(Alignment.Start)
      .width('100%')

    }
    .width('100%')
    .height('100%')
    .align(Alignment.TopStart)
  }
}