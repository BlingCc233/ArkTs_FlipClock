import { display, RectShape } from '@kit.ArkUI';


import Constants from '../common/CommonConstants';

@Component
struct SideTab {
  @State navList: Array<number> = [0, 1, 2, 3, 4, 5];
  @State active: number = 0;
  @State show: boolean = false;
  private one: number = 1;

  build() {
    SideBarContainer(SideBarContainerType.Overlay) {
      Column() {
        Column() {
          ForEach(this.navList, (item: number, index: number) => {
            Column() {
              Row() {
                Text('LIST')
                  .fontSize('16fp')
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Medium)
                  .margin({ left: '17vp'})
              }
              .height(Constants.LIST_HEIGHT)
              .width(Constants.FULL_WIDTH)

              if (this.navList.length - this.one !== index) {
                Row()
                  .height(Constants.DIVIDER_HEIGHT)
                  .backgroundColor('#0D000000')
                  .width(Constants.DIVIDER_DRAWER_WIDTH)
              }
            }
            .onClick(() => {
              this.active = item;
            })
            .margin('4vp')
            .justifyContent(FlexAlign.Center)
            .width(Constants.DRAWER_WIDTH)
            .height(Constants.LIST_HEIGHT)
            .padding({ left: '13vp'})
            .borderRadius(Constants.BORDER_RADIUS_DRAWER)
            .backgroundColor(this.active === item ? '#1a0a59f7' : '')
          }, (item: number, index: number) => JSON.stringify(item) + index)

        }
        .width(Constants.LIST_CARD_WIDTH)
        .height(Constants.LIST_CARD_HEIGHT)
        .backgroundColor(Color.White)
        .borderRadius(Constants.BORDER_RADIUS_DRAWER_CONTENT)
      }
      .height(Constants.FULL_HEIGHT)
      .padding({ top: '104vp'})
      .backgroundColor('#e9eaec')

      Column() {
        Pomodoro()
      }
      .onClick(() => {
        animateTo({
          duration: Constants.ANIMATION_DURATION,
          curve: Curve.EaseOut,
          playMode: PlayMode.Normal,
        }, () => {
          this.show = false;
        })
      })
      .width(Constants.FULL_WIDTH)
      .height(Constants.LIST_CONTENT_HEIGHT)
      .backgroundColor(this.show ? '#c1c2c4' : '')
    }
    .showSideBar(this.show)
    .controlButton({
      left: Constants.MARGIN_SIXTEEN,
      top: Constants.MARGIN_BUTTON_TOP,
      height: Constants.LIST_IMAGE_HEIGHT_WIDTH,
      width: Constants.LIST_IMAGE_HEIGHT_WIDTH,
      icons: {
        shown: $r('app.media.changeBack'),
        hidden: $r('app.media.change'),
        switching: $r('app.media.change')
      }
    })
    .onChange((value: boolean) => {
      this.show = value;
    })
    .sideBarWidth(Constants.SUB_LIST_WIDTH)
    .minSideBarWidth(Constants.SUB_LIST_WIDTH)
    .width(Constants.FULL_WIDTH)
    .height(Constants.LIST_CONTENT_HEIGHT)
    .translate({ y: Constants.TRANSLATE_TOP })
  }
}

@Preview
@Component
export struct Pomodoro {
  private widthPx: number = display.getDefaultDisplaySync().width;
  private timeData  = new Date();
  @State defaultTime : number = 25;
  @State remainTime : number = this.defaultTime/2;

  @Builder descriptionBuilderImage() {
    Image($r('sys.media.ohos_ic_public_clock')).width(36).height(36)
      .translate({x:0,y:40})
      .fillColor(Color.White)
  }
  build() {
    Column() {
      Gauge({ value: this.remainTime, min: 0, max: this.defaultTime }) {
        Column() {
          Text(parseInt(this.remainTime.toString()).toString())
            .fontWeight(FontWeight.Medium)
            .width('62%')
            .fontColor("#fff")
            .maxFontSize("60.0vp")
            .minFontSize("30.0vp")
            .textAlign(TextAlign.Center)
            .margin({ top: '35%' })
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
        }.width('100%').height('100%')
      }
      .startAngle(210)
      .endAngle(150)
      .indicator(null)
      .trackShadow({ radius: 20, offsetX: 7, offsetY: 7 })
      .colors('#ccd61d51')
      .width(`${px2vp(this.widthPx) * 0.8}vp`)
      .height('60%')
      .strokeWidth(18)
      .description(this.descriptionBuilderImage)
      .padding(18)
      .margin({top:`10%`})
      Button('Start')
        .width(`${px2vp(this.widthPx) * 0.3}vp`)
        .height(`${px2vp(this.widthPx) * 0.1}vp`)
        .fontColor(Color.White)
        .clickEffect({level:ClickEffectLevel.MIDDLE, scale: 0.5})
        .backgroundColor('#bfd61d51')
        .borderRadius('30vp')
        .shadow({ radius: 40, offsetX: 0, offsetY: 0 , color: '#46d66787'})

    }.margin({ top: 40 }).width('100%').height('100%').backgroundColor(0x232323)
  }
}
