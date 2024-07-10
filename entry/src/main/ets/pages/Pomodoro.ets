import { display, RectShape } from '@kit.ArkUI';

@Component
export struct Pomodoro {
  private widthPx: number = display.getDefaultDisplaySync().width;


  @Builder descriptionBuilderImage() {
    Image($r('sys.media.ohos_ic_public_clock')).width(36).height(36)
      .translate({x:0,y:40})
      .fillColor(Color.White)
  }

  build() {
    Column() {
      Gauge({ value: 50, min: 1, max: 100 }) {
        Column() {
          Text('50')
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
      .colors('#cca5d61d')
      .width('80%')
      .height('80%')
      .strokeWidth(18)
      .description(this.descriptionBuilderImage)
      .padding(18)
      Button('Start')
        .width(`${px2vp(this.widthPx) * 0.3}vp`)
        .height(`${px2vp(this.widthPx) * 0.06}vp`)
        .fontColor(Color.White)
        .backgroundColor('#cca5d61d')
        .borderRadius('30vp')

    }.margin({ top: 40 }).width('100%').height('100%')
  }
}
