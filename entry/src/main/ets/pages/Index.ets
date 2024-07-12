
import {FlipClock} from './FlipClock'
import Constants from '../common/CommonConstants';
import { display, RectShape } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { initTabData } from '../viewmodel/TabViewModel';
import { TabItem } from '../viewmodel/TabItem';
import {Pomodoro} from './Pomodoro';
import {PageTurningAnimation, enumT} from './PageTurningAnimation';
import {Cofeeling} from './Cofeeling'




@Entry
@Component
struct Index {
  //顶部导航栏
  @State tabArray: Array<TabItem> = initTabData();
  @State currentIndex: number = 0;

  @Builder
  tabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(Color.White)
        .fontSize(this.currentIndex === index ? '18fp' : '14fp')
        .fontWeight(this.currentIndex === index ? Constants.FONT_WEIGHT_TAB * 2 : Constants.FONT_WEIGHT_TAB)
        .lineHeight('22vp')
        .id(index.toString())
    }
    .width(Constants.PERCENT_MAX)
  }

  build() {
    Tabs({ barPosition: BarPosition.Start }) {
      ForEach(this.tabArray.slice(0, 3), (item: TabItem) => {
        TabContent() {
          EachContent({
            whichPage: item.id
          })
        }.tabBar(this.tabBuilder(item.id, item.name))
      }, (item: TabItem, index: number) => JSON.stringify(item) + index)
    }
    .barWidth(Constants.PERCENT_MAX)
    .barHeight('52vp')
    .padding({
      top: '30vp'
    })
    .width(Constants.PERCENT_MAX)
    .height(Constants.PERCENT_MAX)
    .backgroundColor($r('app.color.stack_background_color'))
    .animationDuration(Constants.ANIMATION_DURATION)
    .onAnimationStart((index: number, targetIndex: number) => {
      hilog.info(0x0000, 'index', index.toString());
      this.currentIndex = targetIndex;
    })

  }
}


@Component
struct EachContent {
  @Prop whichPage: number;
  private widthPx: number = display.getDefaultDisplaySync().width;
  @State isRotate : boolean = false;
  private time = new Date();
  @State rotaAngle: number = 0;
  @State offsetPos: string = '0';
  @State textOpacity : number = 1;

  private clockAnime(){
    animateTo({
      duration: 600,
      curve: Curve.FastOutSlowIn,
      delay: 0,
      iterations: 1,
      onFinish: () => {
      }
    }, () => {
      this.rotaAngle = this.isRotate ? 90 : 0;
      this.textOpacity = this.isRotate ? 0 : 1;
      this.offsetPos = this.isRotate ? `${px2vp(this.widthPx) * 0.085}vp` : '0';
    })
  }

  build() {
    Column() {
      if (this.whichPage == 1) {
        Pomodoro()
      }
      if (this.whichPage == 0) {
        Flex({
          direction: FlexDirection.Column,
          justifyContent: FlexAlign.Center,
          alignItems: ItemAlign.Center
        }) {
          Row() {
            Text(`${this.time.getFullYear().toString()} - ${this.time.getMonth() % 10 == this.time.getMonth() ? '0' :
              ''}${this.time.getMonth().toString()} - ${this.time.getDate() % 10 == this.time.getDate() ? '0' :
              ''}${this.time.getDate().toString()}`)
              .fontColor('#aaa')
              .fontSize('23vp')
              .opacity(this.textOpacity)
            Image($r('app.media.rotate'))
              .fillColor('#aaa')
              .width('28vp')
              .height('27vp')
              .padding({top:4,left:6})
              .onClick(()=>{
                this.isRotate = !this.isRotate;
                this.clockAnime();
              })
          }
          .translate({ x: 0, y: `${px2vp(this.widthPx) * 0.1}vp` })


          PageTurningAnimation({
            axis: [0, 0, 0, 1, 0, 0],
            rotaRate: -90,
            originalAngle: 0,
            timeT: enumT.HOUR
          })
            .rotate({x:0,y:0,z:1,centerX:'50%',centerY:'50%',angle: this.rotaAngle})
          PageTurningAnimation({
            axis: [0, 0, 0, 1, 0, 0],
            rotaRate: -90,
            originalAngle: 0,
            timeT: enumT.MIN

          }).translate({x:0,y:`-${px2vp(this.widthPx) * 0.2}vp`})
            .rotate({x:0,y:0,z:1,angle: this.rotaAngle})
          PageTurningAnimation({
            axis: [0, 0, 0, 1, 0, 0],
            rotaRate: -90,
            originalAngle: 0,
            timeT: enumT.SEC

          }).translate({x:0,y:`-${px2vp(this.widthPx) * 0.4}vp`})
            .rotate({x:0,y:0,z:1,angle: this.rotaAngle})

        }
        .offset({
          x:this.offsetPos,
          y:this.offsetPos})
        .width(Constants.PERCENT_MAX)
        .height(Constants.PERCENT_MAX)
        .backgroundColor($r('app.color.stack_background_color'))
      }
      if (this.whichPage == 2) {
        FlipClock();
      }
    }

  }
}

