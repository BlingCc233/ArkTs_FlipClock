
import {FlipClock} from './FlipClock'
import Constants from '../common/CommonConstants';
import { display, RectShape } from '@kit.ArkUI';
import WindowModel from '../utils/WindowModel';
import { GlobalContext } from '../utils/GlobalContext';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { initTabData } from '../viewmodel/TabViewModel';
import { TabItem } from '../viewmodel/TabItem';
import { window } from '@kit.ArkUI';
import {Pomodoro} from './Pomodoro'
import {PageTurningAnimation, enumT} from './PageTurningAnimation'



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

  build() {
    Column() {
      if (this.whichPage == 1) {
        Pomodoro();
      }
      if (this.whichPage == 0) {
        Flex({
          direction: FlexDirection.Column,
          justifyContent: FlexAlign.Center,
          alignItems: ItemAlign.Center
        }) {
          PageTurningAnimation({
            axis: [0, 0, 0, 1, 0, 0],
            rotaRate: -90,
            originalAngle: 0,
            timeT: enumT.HOUR
          })
          PageTurningAnimation({
            axis: [0, 0, 0, 1, 0, 0],
            rotaRate: -90,
            originalAngle: 0,
            timeT: enumT.MIN

          }).translate({x:0,y:`-${px2vp(this.widthPx) * 0.2}vp`})
          PageTurningAnimation({
            axis: [0, 0, 0, 1, 0, 0],
            rotaRate: -90,
            originalAngle: 0,
            timeT: enumT.SEC

          }).translate({x:0,y:`-${px2vp(this.widthPx) * 0.4}vp`})
        }
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

