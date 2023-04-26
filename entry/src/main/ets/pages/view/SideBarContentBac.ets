import { CityModel } from '../model/CityModel'
@Component
export default struct SideBarContentBac {
  @Link isShowSideBar: boolean
  @Link selectCity: CityModel
  private cacheCity: CityModel
  build() {
    //灰底
    Column()
      .size({ width: '100%', height: '100%' })
      .backgroundColor('#FF818385')
      .onClick(() => {
        this.isShowSideBar = !this.isShowSideBar
        this.cacheCity = this.selectCity
        this.selectCity = null
        this.selectCity =  this.cacheCity
      })
  }
}