
/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Constants from '../common/CommonConstants';
import { display } from '@kit.ArkUI';
import WindowModel from '../utils/WindowModel';
import { GlobalContext } from '../utils/GlobalContext';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { initTabData } from '../viewmodel/TabViewModel';
import { TabItem } from '../viewmodel/TabItem';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct Index{
  private windowModel: WindowModel = WindowModel.getInstance();
   aboutToAppear(): void {
     // list scroll controller.
     let windowStage: window.WindowStage = GlobalContext.getContext().getObject('windowStage') as window.WindowStage;

     this.windowModel.setWindowStage(windowStage);

     // Set Immersive Mode.
     this
       .windowModel.setMainWindowImmersive(true);
   }

  //顶部导航栏
  // @State tabArray: Array<TabItem> = initTabData();
  // @State currentIndex: number = 0;
  //
  // @Builder
  // tabBuilder(index: number, name: string) {
  //   Column() {
  //     Text(name)
  //       .fontColor(Color.Black)
  //       .fontSize(this.currentIndex === index ? $r('app.float.current_text_size') : $r('app.float.text_size'))
  //       .fontWeight(this.currentIndex === index ? Constants.FONT_WEIGHT_TAB : FontWeight.Normal)
  //       .lineHeight($r('app.float.text_line_height'))
  //       .id(index.toString())
  //   }
  //   .width(Constants.PERCENT_MAX)
  // }

  build() {
    Flex({
      direction:FlexDirection.Column,
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center
    }){
      PageTurningAnimation()
      PageTurningAnimation()
      PageTurningAnimation()
    }
    .width(Constants.PERCENT_MAX)
    .height(Constants.PERCENT_MAX)
    .backgroundColor($r('app.color.stack_background_color'))
  }

}



@Component
struct BookPage {
  @Prop pageNum: number;
  @Prop rotateAngle: number;
  @Prop positionX: string;
  @Prop positionY: string;
  private widthPx: number = display.getDefaultDisplaySync().width;

  build() {
    Text(`${this.pageNum}`)
      .fontSize($r('app.float.common_font_size'))
      .fontColor(Color.White)
      .fontWeight(FontWeight.Bold)
      .textAlign(TextAlign.Center)
      .width(`${px2vp(this.widthPx)*0.4}vp`)
      .height(`${px2vp(this.widthPx)*0.4}vp`)
      .borderRadius($r('app.float.common_border_radius'))
      .rotate({
        x: 1,
        y: 0,
        z: 0,
        angle: this.rotateAngle,
        centerX: this.positionX,
        centerY: this.positionY
      })
  }
}

@Component
export struct PageTurningAnimation {
  @State originalAngle: number = 0;
  @State rotateAngleTextA: number = 0;
  @State rotateAngleTextB: number = 0;
  @State pageNumTextA: number = 0;
  @State animatePageNumTextB: number = 1;
  @State pageNumTextC: number = 0;
  @State nextPageNumTextD: number = 0;
  @State bottomX: string = Constants.PERCENT_HALF;
  @State bottomY: string = Constants.PERCENT_HALF;
  @State centerX: string = Constants.PERCENT_HALF;
  @State centerY: string = Constants.PERCENT_HALF;
  private timer: number = 0;
  private widthPx: number = display.getDefaultDisplaySync().width;


  aboutToAppear(): void {
    this.timer = setInterval(() => {
      this.pageTurningAnimate();
    }, Constants.TIMER_DELAY)
  }

  aboutToDisappear(): void {
    clearInterval(this.timer);
  }

  private pageTurningAnimate() {
    animateTo({
      duration: Constants.ANIMATE_DURATION,
      onFinish: () => {
        this.pageNumTextA = this.animatePageNumTextB;
        this.rotateAngleTextA = Constants.ROTATE_ANGLE;
        this.rotateAngleTextB = 0;
        this.animatePageNumTextB = (this.animatePageNumTextB + 1) % Constants.MAX_SEC_NUMBER;

      }
    }, () => {
      this.rotateAngleTextB = Constants.ROTATE_ANGLE;
      this.nextPageNumTextD = (this.animatePageNumTextB + 1) % Constants.MAX_SEC_NUMBER;
    })
  }

  build() {
    //这里是变化后的数字
    // Column() {
    //   BookPage({
    //     pageNum: this.pageNumTextC,
    //     rotateAngle: this.originalAngle,
    //     positionX: this.bottomX,
    //     positionY: this.bottomY
    //   })
    //   BookPage({
    //     pageNum: this.nextPageNumTextD,
    //     rotateAngle: this.originalAngle,
    //     positionX: this.bottomX,
    //     positionY: this.bottomY
    //   })
    // }
    Stack() {

        BookPage({
          pageNum: this.nextPageNumTextD,
          rotateAngle: this.originalAngle,
          positionX: this.centerX,
          positionY: this.centerY
        })
        BookPage({
          pageNum: this.animatePageNumTextB,
          rotateAngle: this.rotateAngleTextB,
          positionX: this.bottomX,
          positionY: this.bottomY
        })

    }
    .width(`${px2vp(this.widthPx)*0.4}vp`)
    .height(`${px2vp(this.widthPx)*0.4}vp`)
    .borderRadius($r('app.string.ohos_id_corner_radius_default_l'))
    .backgroundColor($r('app.color.common_color_dark_blue'))
    .margin(
      {
        bottom: `${px2vp(this.widthPx)*0.04}vp`
      }
    )
  }
}



// /*
//  * Copyright (c) 2022 Huawei Device Co., Ltd.
//  * Licensed under the Apache License, Version 2.0 (the "License");
//  * you may not use this file except in compliance with the License.
//  * You may obtain a copy of the License at
//  *
//  *     http://www.apache.org/licenses/LICENSE-2.0
//  *
//  * Unless required by applicable law or agreed to in writing, software
//  * distributed under the License is distributed on an "AS IS" BASIS,
//  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  * See the License for the specific language governing permissions and
//  * limitations under the License.
//  */
// import { display } from '@kit.ArkUI';
// import Logger from '../utils/Logger';
// import DrawClock from '../utils/DrawClock';
// import CommonConstants from '../common/CommonConstants';
//
// const HEIGHT_ADD: number = CommonConstants.HEIGHT_ADD; // 表盘下面需要绘制时间，canvas高度是宽度加150
// const TAG: string = 'Index';
//
// @Entry
// @Component
// struct Clock {
//   @State canvasWidth: number = CommonConstants.DEFAULT_WATCH_SIZE; // 300是表盘默认大小
//   private settings: RenderingContextSettings = new RenderingContextSettings(true);
//   private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
//   private radius: number = CommonConstants.DEFAULT_WATCH_RADIUS; // 默认表盘半径
//   private intervalId: number = 0;
//   private drawClock: DrawClock = new DrawClock();
//   updateTime = () => {
//     this.context.clearRect(0, 0, this.canvasWidth, this.canvasWidth + HEIGHT_ADD);
//     let nowTime = new Date();
//     let hour = nowTime.getHours();
//     let minute = nowTime.getMinutes();
//     let second = nowTime.getSeconds();
//     let time = `${this.fillTime(hour)}:${this.fillTime(minute)}:${this.fillTime(second)}`;
//     this.drawClock.drawClock(this.context, this.radius, this.canvasWidth, hour, minute, second, time)
//     this.context.translate(-this.radius, -this.radius);
//   }
//
//   fillTime(time: number) {
//     return time < CommonConstants.NUMBER_TEN ? `0${time}` : `${time}`;
//   }
//
//   onPageShow(): void {
//     this.updateTime();
//     this.intervalId = setInterval(this.updateTime, CommonConstants.INTERVAL_TIME)
//   }
//
//   onPageHide() {
//     clearInterval(this.intervalId);
//   }
//
//   aboutToAppear() {
//     this.getSize();
//   }
//
//   // 获取设备宽高计算表盘大小
//   async getSize() {
//     let mDisplay = display.getDefaultDisplaySync();
//     Logger.info(TAG, `getDefaultDisplay mDisplay = ${JSON.stringify(mDisplay)}`);
//     this.canvasWidth = px2vp(mDisplay.width > mDisplay.height ? mDisplay.height * CommonConstants.CONVERSION_RATE :
//       mDisplay.width * CommonConstants.CONVERSION_RATE);
//     this.radius = this.canvasWidth / CommonConstants.NUMBER_TWO;
//   }
//
//   build() {
//     Stack({ alignContent: Alignment.Center }) {
//       Canvas(this.context)
//         .padding({ top: $r('app.float.canvas_padding_top') })
//         .width(this.canvasWidth)
//         .height(this.canvasWidth + HEIGHT_ADD)
//         .onReady(() => {
//           this.updateTime();
//           this.intervalId = setInterval(this.updateTime, CommonConstants.INTERVAL_TIME);
//         })
//     }
//     .width(CommonConstants.FULL_PERCENTAGE)
//     .height(CommonConstants.FULL_PERCENTAGE)
//   }
// }