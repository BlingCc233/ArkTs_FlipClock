import { display, RectShape } from '@kit.ArkUI';
import { curves } from '@kit.ArkUI';
import measure from '@ohos.measure'
import Constants from '../common/CommonConstants';
import font from '@ohos.font'
import setting from './setting.json'

export enum Stage{
  FOCUS,
  BREAK,
  LONGBREAK
}

@Preview
@Component
export struct Pomodoro {
  private widthPx: number = display.getDefaultDisplaySync().width;
  private timeData = new Date();
  @State focusTime: number = setting.defaultTime;
  @State defaultTime: number = this.focusTime;
  @State breakTime: number = setting.breakTime;
  @State longBreak: number = setting.longBreak;
  @State isRemind: boolean = setting.isRemind;
  @State isVibration: boolean = setting.isVibration;
  private breakInterval: number = 4;
  @State remainTime: number = this.defaultTime;
  @State select: number = 2;
  private positionY: number = 0;
  @State isPause: boolean = true;
  @State translateY: string | number = '120%';
  @State progress: number = this.defaultTime;
  @State buttonPos: number = 0;
  @State buttonOpacity: number = 1;
  @State buttonColor1: string = '#ff7c012c';
  @State buttonColor2: string = '#ffb0003d';
  @State buttonColor3: string = '#D4004A';
  @State btnGrad: number = 30;
  @State visible: Visibility = Visibility.Visible;
  private curStage: Stage = Stage.FOCUS;
  private timer: number = 0;
  @State remainSec : number = this.remainTime*60;
  @State clockOff:number = 0;
  @State clockColor:string = '#fff';




  private buttonAnime() {
    animateTo({
      duration: 200,
      curve: Curve.Friction,
      delay: 0,
      iterations: 1,
      onFinish: () => {
        if (!this.isPause) {
          this.visible = Visibility.None;
        }
      }
    }, () => {
      if (!this.isPause) {
        this.buttonPos = 65;
        this.buttonOpacity = 0;
        this.buttonColor1 = '#D4004A';
        this.btnGrad = 210;
      } else {
        this.visible = Visibility.Visible;
        this.buttonPos = 0;
        this.buttonOpacity = 1;
        this.buttonColor1 = '#ff7c012c';
        this.buttonColor2 = '#ffb0003d';
        this.buttonColor3 = '#D4004A';
        this.btnGrad = 30;
      }
    })
  }

  private countDownAnime(){
    animateTo({
      duration: 200,
      curve: Curve.FastOutSlowIn,
      delay: 0,
      iterations: 1,
      onFinish: () => {
      }
    }, () => {
      this.clockOff = this.remainSec % 2 ? 0 : -10;
      this.clockColor = this.remainSec % 2 ? '#fff' : '#aaa';
    })
  }

  private countDown() {
    let lastStage = this.curStage;
    let totalSec = (this.curStage == Stage.FOCUS ? this.focusTime * 60 : (this.curStage == Stage.BREAK ? this.breakTime * 60 : this.longBreak * 60));
    this.defaultTime = (totalSec/60);
    this.progress = this.defaultTime;
    this.timer = setInterval(() => {
      this.countDownAnime()
      if(this.remainSec>0) {
        this.remainSec--;
        this.remainTime = Math.floor(this.remainSec/60)+1;
      }
      if(this.remainSec == 0){
        if(lastStage == Stage.FOCUS && this.breakInterval > 0){
          this.curStage = Stage.BREAK;
          this.breakInterval --;
          totalSec = this.breakTime*60;
        }
        if(lastStage == Stage.FOCUS && this.breakInterval == 0){
          this.curStage = Stage.LONGBREAK;
          this.breakInterval = 4;
          totalSec = this.longBreak*60;
        }
        if(lastStage == Stage.BREAK || lastStage == Stage.LONGBREAK){
          this.curStage = Stage.FOCUS;
          totalSec = this.focusTime*60;
        }
        lastStage = this.curStage;
        this.defaultTime = Math.floor(totalSec/60);
        this.remainSec = totalSec;
        this.progress = this.defaultTime;
      }
    }, 1000)
  }



  @Builder
  descriptionBuilderImage() {
    Image($r('sys.media.ohos_ic_public_clock'))
      .width(40).height(44)
      .padding({bottom:4})
      .translate({ x: 0, y: 40+this.clockOff })
      .fillColor(Color.White)
  }

  build() {
    Stack() {
      Column() {
        Gauge({ value: !this.isPause ? this.remainSec : this.progress*60, min: 0, max: this.defaultTime*60 }) {
          Column() {
            Text(Math.floor((!this.isPause ? this.remainTime : this.progress) >= 0 ? Math.floor(!this.isPause ? this.remainTime : this.progress) : 0).toString())
            // Text(this.remainSec.toString())
              .fontWeight(FontWeight.Bolder)
              .width('75%')
              .fontColor(this.clockColor)
              .maxFontSize("100.0vp")
              .minFontSize(`70vp`)
              .textAlign(TextAlign.Center)
              .margin({ top: '28%' })
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
        .height('50%')
        .strokeWidth(30)
        .description(this.descriptionBuilderImage)
        .padding(18)


        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.SpaceBetween
        }) {
          Button(this.isPause ? 'Start' : 'Pause')
            .fontSize('20vp')
            .width(`${px2vp(this.widthPx) * 0.3}vp`)
            .height(`${px2vp(this.widthPx) * 0.15}vp`)
            .fontColor('#e1e2e5')
            .translate({ x: `${this.buttonPos}%` })
            .clickEffect({ level: ClickEffectLevel.MIDDLE, scale: 0.5 })
            .linearGradient({
              angle: this.btnGrad,
              colors: [[this.buttonColor1, 0.0], [this.buttonColor2, 0.5], [this.buttonColor3, 1.0]]
            })// .backgroundColor(this.buttonColor)
            .borderRadius('30vp')
            .onClick(() => {
              this.isPause = !this.isPause;
              this.buttonAnime();
              if(!this.isPause){
                this.countDown();
              }
              else {
                clearInterval(this.timer);
              }

            })
            .gesture(
              LongPressGesture({ repeat: true })
                .onAction((event: GestureEvent | undefined) => {
                  if (event) {
                    if (event.repeat && this.isPause) {
                      // this.anime()
                      this.progress -= (this.defaultTime / 5)
                      //长按期间动画
                    }
                  }
                })
                .onActionEnd(() => {
                  if (this.isPause && this.progress > 0) {
                    this.progress = this.defaultTime
                    //长按结束番茄钟
                  }
                  if (this.progress <= 0) {
                    AlertDialog.show(
                      {
                        title: `Ciallo～(∠・ω< )⌒★`,
                        backgroundColor: '#aaa',
                        backgroundBlurStyle: BlurStyle.BACKGROUND_ULTRA_THICK,
                        message: '\t\t\t番茄钟结束啦！',
                        alignment: DialogAlignment.Center,
                        autoCancel: true,
                        height: '40%',
                        confirm: {
                          value: 'Reset',
                          backgroundColor: '#4e4e4e',
                          fontColor: '#eaeaea',
                          action: () => {
                            this.defaultTime = this.focusTime;
                            this.progress = this.focusTime;
                            this.curStage = Stage.FOCUS;
                          }
                        },
                        cancel: () => {
                          this.defaultTime = this.focusTime;
                          this.progress = this.focusTime;
                          this.curStage = Stage.FOCUS;
                        }
                      }
                    )
                  }
                })
            )


          Button('Setting')
            .fontSize('20vp')
            .width(`${px2vp(this.widthPx) * 0.3}vp`)
            .height(`${px2vp(this.widthPx) * 0.15}vp`)
            .fontColor('#e1e2e5')
            .clickEffect({ level: ClickEffectLevel.MIDDLE, scale: 0.5 })
            .linearGradient({
              angle: this.btnGrad,
              colors: [[this.buttonColor1, 0.0], [this.buttonColor2, 0.5], [this.buttonColor3, 1.0]]
            })
            .borderRadius('30vp')
            .id('text_pickerButton')
            .visibility(this.visible)
            .opacity(this.buttonOpacity)
            .onClick(() => {
              animateTo({
                duration: 600,
                curve: Curve.Friction
              }, () => {
                this.translateY = '0%';
              });

            })
        }
        .width('70%')
      }
      .margin({ top: '-30%' })


      RelativeContainer() {
        Row() {
        }
        .width('80vp')
        .height('7vp')
        .backgroundColor('#acacac')
        .borderRadius('5vp')
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .offset({ x: '-40vp', y: '7vp' })
        .id('slider')
        .onClick(() => {
          this.closeSelf();
        })

        // Image($r('sys.media.ohos_ic_public_arrow_down'))
        //   .fillColor('#ededed')
        //   .width('40vp')
        //   .height('50vp')
        //   .alignRules({
        //     top: { anchor: "__container__", align: VerticalAlign.Top },
        //     left: { anchor: '__container__', align: HorizontalAlign.Start }
        //   })
        //   .margin({
        //     top: '10vp',
        //     left: '20vp'
        //   })
        //   .id('button')


        Column() {
          Text(`Ciallo～(∠・ω< )⌒★`)
            .fontColor("#ededed")
            .fontSize('30vp')
            .alignSelf(ItemAlign.Start)
            .fontWeight(FontWeight.Bolder)
            .padding({ bottom: '20vp', left: 24 })

          Text(`Keep focus!`)
            .fontColor("#ededed")
            .fontSize('15vp')
            .alignSelf(ItemAlign.Start)
            .fontWeight(FontWeight.Bold)
            .padding({ left: 24 })

          List() {
            ListItem() {
              Row() {
                Text('Remind sound')
                  .height(48)
                  .fontSize(20)
                  .fontColor('#eaeaea')
                  .textAlign(TextAlign.Start)
                  .fontFamily('HarmonyHeiTi-Medium')
                  .padding({ bottom: 4, top: 4, left: 24 })

                Blank()

                Toggle({ type: ToggleType.Switch, isOn: this.isRemind })
                  .selectedColor('#ffd40050')
                  .switchPointColor('#FFFFFF')
                  .alignSelf(ItemAlign.End)
                  .width(56)
                  .height(32)
                  .offset({ x: -24, y: -3 })
                  .onChange((isOn: boolean) => {
                    this.isRemind = isOn;
                    console.info('Component status:' + isOn)
                  })
              }
              .width('100%')

            }

            ListItem() {
              Row() {
                Text('Vibration')
                  .height(48)
                  .fontSize(20)
                  .fontColor('#eaeaea')
                  .textAlign(TextAlign.Start)
                  .fontFamily('HarmonyHeiTi-Medium')
                  .padding({ bottom: 4, top: 4, left: 24 })

                Blank()

                Toggle({ type: ToggleType.Switch, isOn: this.isVibration })
                  .selectedColor('#ffd40050')
                  .switchPointColor('#FFFFFF')
                  .alignSelf(ItemAlign.End)
                  .width(56)
                  .height(32)
                  .offset({ x: -24, y: -3 })
                  .onChange((isOn: boolean) => {
                    this.isVibration = isOn;
                    console.info('Component status:' + isOn);
                  })
              }
              .width('100%')
            }

            ListItem() {
              Row() {
                Text('Focus time')
                  .height(48)
                  .fontSize(20)
                  .fontColor('#eaeaea')
                  .textAlign(TextAlign.Start)
                  .fontFamily('HarmonyHeiTi-Medium')
                  .padding({ bottom: 4, top: 4, left: 24 })

                Blank()
                Text(this.focusTime.toString() + 'min')
                  .height(48)
                  .fontSize(16)
                  .fontColor('#aaa')
                  .textAlign(TextAlign.Start)
                  .fontFamily('HarmonyHeiTi-Medium')
                  .padding({ bottom: 4, top: 4, right: 8 })

                Image($r('sys.media.ohos_ic_public_arrow_right'))
                  .fillColor('#2a2a2a')
                  .width('25vp')
                  .height(48)
                  .padding({ right: 12 })
              }
              .width('100%')
            }
            .onClick(() => {
              TextPickerDialog.show({
                range: this.generateStringArray(50),
                selected: this.defaultTime - 10,
                onAccept: (value: TextPickerResult) => {
                  // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
                  console.log(String(value.index));
                  this.focusTime = parseInt(String(value.value));
                  if(this.curStage == Stage.FOCUS){
                    this.defaultTime = this.focusTime;
                    this.progress = this.defaultTime;
                    this.remainTime = this.defaultTime;
                    this.remainSec = this.defaultTime*60;
                  }

                },
                onCancel: () => {
                  console.log('cancle');
                },
                onChange: (value: TextPickerResult) => {
                  console.log(value.value.toString());
                },
                defaultPickerItemHeight: 50,
                backgroundColor: '#444',
                acceptButtonStyle: { fontColor: '#eaeaea' },
                cancelButtonStyle: { fontColor: '#aaaaaa' },
                disappearTextStyle: { color: '#aaa', font: { size: '20vp', weight: FontWeight.Lighter } },
                backgroundBlurStyle: BlurStyle.BACKGROUND_ULTRA_THICK,
                textStyle: { color: '#eaeaea', font: { size: '20vp', weight: FontWeight.Lighter } },
                selectedTextStyle: { color: '#ffd40050', font: { size: '25vp', weight: FontWeight.Normal } },

              });
            })

            ListItem() {
              Row() {
                Text('Break time')
                  .height(48)
                  .fontSize(20)
                  .fontColor('#eaeaea')
                  .textAlign(TextAlign.Start)
                  .fontFamily('HarmonyHeiTi-Medium')
                  .padding({ bottom: 4, top: 4, left: 24 })

                Blank()
                Text(this.breakTime.toString() + 'min')
                  .height(48)
                  .fontSize(16)
                  .fontColor('#aaa')
                  .textAlign(TextAlign.Start)
                  .fontFamily('HarmonyHeiTi-Medium')
                  .padding({ bottom: 4, top: 4, right: 8 })

                Image($r('sys.media.ohos_ic_public_arrow_right'))
                  .fillColor('#2a2a2a')
                  .width('25vp')
                  .height(48)
                  .padding({ right: 12 })
              }
              .width('100%')
            }
            .onClick(() => {
              TextPickerDialog.show({
                range: this.generateStringArray(10),
                selected: this.breakTime,
                onAccept: (value: TextPickerResult) => {
                  // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
                  console.log(String(value.index));
                  this.breakTime = parseInt(String(value.value));

                  if(this.curStage == Stage.BREAK){
                    this.defaultTime = this.breakTime;
                    this.progress = this.defaultTime;
                    this.remainTime = this.defaultTime;
                    this.remainSec = this.defaultTime*60;
                  }

                },
                onCancel: () => {
                  console.log('cancle');
                },
                onChange: (value: TextPickerResult) => {
                  console.log(value.value.toString());
                },
                defaultPickerItemHeight: 50,
                backgroundColor: '#444',
                acceptButtonStyle: { fontColor: '#eaeaea' },
                cancelButtonStyle: { fontColor: '#aaaaaa' },
                disappearTextStyle: { color: '#aaa', font: { size: '20vp', weight: FontWeight.Lighter } },
                backgroundBlurStyle: BlurStyle.BACKGROUND_ULTRA_THICK,
                textStyle: { color: '#eaeaea', font: { size: '20vp', weight: FontWeight.Lighter } },
                selectedTextStyle: { color: '#ffd40050', font: { size: '25vp', weight: FontWeight.Normal } },

              });
            })

            ListItem() {
              Row() {
                Text('Long break')
                  .height(48)
                  .fontSize(20)
                  .fontColor('#eaeaea')
                  .textAlign(TextAlign.Start)
                  .fontFamily('HarmonyHeiTi-Medium')
                  .padding({ bottom: 4, top: 4, left: 24 })

                Blank()
                Text(this.longBreak.toString() + 'min')
                  .height(48)
                  .fontSize(16)
                  .fontColor('#aaa')
                  .textAlign(TextAlign.Start)
                  .fontFamily('HarmonyHeiTi-Medium')
                  .padding({ bottom: 4, top: 4, right: 8 })

                Image($r('sys.media.ohos_ic_public_arrow_right'))
                  .fillColor('#2a2a2a')
                  .width('25vp')
                  .height(48)
                  .padding({ right: 12 })
              }
              .width('100%')
            }
            .onClick(() => {
              TextPickerDialog.show({
                range: this.generateStringArray(20),
                selected: this.longBreak,
                onAccept: (value: TextPickerResult) => {
                  // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
                  console.log(String(value.index));
                  this.longBreak = parseInt(String(value.value));
                  setting.longBreak = this.longBreak;

                  if(this.curStage == Stage.LONGBREAK){
                    this.defaultTime = this.longBreak;
                    this.progress = this.defaultTime;
                    this.remainTime = this.defaultTime;
                    this.remainSec = this.defaultTime*60;

                  }
                },
                onCancel: () => {
                  console.log('cancle');
                },
                onChange: (value: TextPickerResult) => {
                  console.log(value.value.toString());
                },
                defaultPickerItemHeight: 50,
                backgroundColor: '#444',
                acceptButtonStyle: { fontColor: '#eaeaea' },
                cancelButtonStyle: { fontColor: '#aaaaaa' },
                disappearTextStyle: { color: '#aaa', font: { size: '20vp', weight: FontWeight.Lighter } },
                backgroundBlurStyle: BlurStyle.BACKGROUND_ULTRA_THICK,
                textStyle: { color: '#eaeaea', font: { size: '20vp', weight: FontWeight.Lighter } },
                selectedTextStyle: { color: '#ffd40050', font: { size: '25vp', weight: FontWeight.Normal } },

              });
            })

          }
          .width('80%')
          .layoutWeight(1)
          .margin({ top: '40vp', left: px2fp(this.widthPx * 0.1) })
          .backgroundColor('#444')
          .borderRadius('20vp')

        }
        .margin({ top: '100vp', bottom: '140vp' })

      }
      .linearGradient({
        colors: [
          ['#484848', 0],
          ['#3c3c3c', 0.3],
          ['#232323', 1]
        ]
      })
      .borderRadius({
        topLeft: '18vp',
        topRight: '18vp'
      })
      .width('100%')
      .height('80%')
      .translate({ x: 0, y: this.translateY })
      .gesture(
        PanGesture({ direction: PanDirection.Vertical, distance: 1 })
          .onActionUpdate((event?: GestureEvent) => {
            this.handlePanGestureUpdate(event?.offsetY);
          })
          .onActionEnd((event?: GestureEvent) => {
            this.handlePanGestureEnd(event?.offsetY);
          })
      )
      .zIndex(2)

    }.margin({ top: 40 }).width('100%').height('100%').backgroundColor(0x232323)

  }

  private closeSelf() {
    animateTo({
      duration: 600,
      curve: Curve.Friction,
    }, () => {
      this.translateY = '120%';
    });
  }

  private reset() {
    animateTo({
      curve: curves.responsiveSpringMotion()
    }, () => {
      this.translateY = '0%';
      this.positionY = 0;
    });
  }

  handlePanGestureUpdate(offsetY?: number): void {
    if (!offsetY || offsetY < 0) {
      return;
    }
    animateTo({
      curve: curves.responsiveSpringMotion()
    }, () => {
      this.translateY = this.positionY + offsetY;
    });
  }

  handlePanGestureEnd(offsetY?: number): void {
    if (!offsetY) {
      return;
    }
    if (offsetY > 300) {
      this.closeSelf();
    } else {
      this.reset();
    }
  }

  generateStringArray(num: number): Array<string> {
    let result: Array<string> = [];
    if (num <= 20) {
      for (let i = 0; i <= num; i++) {
        result.push(i.toString());
      }
    } else {
      for (let i = 10; i <= num; i++) {
        result.push(i.toString());
      }
    }
    return result;
  }
}
