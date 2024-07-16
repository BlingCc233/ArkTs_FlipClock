import { display, RectShape } from '@kit.ArkUI';
import { curves } from '@kit.ArkUI';
import router from '@ohos.router'
import { vibrator } from '@kit.SensorServiceKit';
import { audioHaptic } from '@kit.AudioKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { uri } from '@kit.ArkTS';
import { fileIo } from '@kit.CoreFileKit';
import { audio } from '@kit.AudioKit';
import { media } from '@kit.MediaKit';
import { hilog } from '@kit.PerformanceAnalysisKit';



export enum Stage {
  FOCUS,
  BREAK,
  LONGBREAK
}

PersistentStorage.persistProp('focusTime', 25);
PersistentStorage.persistProp('breakTime', 5);
PersistentStorage.persistProp('longBreak', 10);
PersistentStorage.persistProp('isRemind', true);
PersistentStorage.persistProp('isVibration', true);

let  soundPool: media.SoundPool;
let  audioRendererInfo: audio.AudioRendererInfo = {
  usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
  rendererFlags: 1
}

@Preview
@Component
export struct Pomodoro {
  private widthPx: number = display.getDefaultDisplaySync().width;
  private timeData = new Date();
  @StorageLink('focusTime') focusTime: number = 25;
  @StorageLink('breakTime') breakTime: number = 5;
  @StorageLink('longBreak') longBreak: number = 10;
  @StorageLink('isRemind') isRemind: boolean = true;
  @StorageLink('isVibration') isVibration: boolean = true;
  @State defaultTime: number = this.focusTime;
  private breakInterval: number = 3;
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
  @State remainSec: number = this.remainTime * 60;
  @State clockOff: number = 0;
  @State clockColor: string = '#fff';
  @State btnAngle: number = 0;



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

  private countDownAnime() {
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

  soundpollPlay(){
    media.createSoundPool(5, audioRendererInfo, (error: BusinessError, soundPool_: media.SoundPool) => {
      if (error) {
        console.error(`Failed to createSoundPool`)
        return;
      } else {
        soundPool = soundPool_;
        console.info(`Succeeded in createSoundPool`)
        let file: fileIo.File;
        let soundID: number = 0;
        let streamID: number = 0;

        let fileSize: number = 1; //通过fs.stat()获取size值
        let uri: string = "";
        //获取fd的描述信息
        fileIo.open('..//remind.mp3', fileIo.OpenMode.READ_ONLY).then((file_: fileIo.File) => {

          file = file_;
          console.info("file fd: " + file.fd);
          uri = 'fd://' + (file.fd).toString()
          AlertDialog.show({message:uri})
          soundPool.load(file.fd, 0, fileSize).then((soundId: number) => {
            console.info('Succeeded in loading soundpool');
            soundID = soundId;
          }, (err: BusinessError) => {
            console.error('Failed to load soundpool and catch error is ' + err.message);
          });
        });

        soundPool.play(soundID,  (error: BusinessError, streamId: number) => {
          if (error) {
            console.error(`Failed to play soundpool: errCode is ${error.code}, errMessage is ${error.message}`)
          } else {
            streamID = streamId;
            console.info('Succeeded in playing soundpool, streamId:' + streamId);
          }
        });
      }
    });
  }

  private countDown() {
    let lastStage = this.curStage;
    let totalSec = (this.curStage == Stage.FOCUS ? this.focusTime * 60 :
      (this.curStage == Stage.BREAK ? this.breakTime * 60 : this.longBreak * 60));
    this.defaultTime = (totalSec / 60);
    this.progress = this.defaultTime;
    this.timer = setInterval(() => {
      this.countDownAnime()
      if (this.remainSec > 0) {
        this.remainSec--;
        this.remainTime = Math.floor(this.remainSec / 60) + 1;
      }
      if (this.remainSec == 0) {
        if(this.isVibration) {
          vibrator.startVibration({
            type: 'time',
            duration: 2000
          }, {
            usage: 'notification'
          });
        }
        if(this.isRemind){
          this.soundpollPlay();
        }
        if (lastStage == Stage.FOCUS && this.breakInterval > 0) {
          this.curStage = Stage.BREAK;
          this.breakInterval--;
          totalSec = this.breakTime * 60;
        }
        if (lastStage == Stage.FOCUS && this.breakInterval == 0) {
          this.curStage = Stage.LONGBREAK;
          this.breakInterval = 4;
          totalSec = this.longBreak * 60;
        }
        if (lastStage == Stage.BREAK || lastStage == Stage.LONGBREAK) {
          this.curStage = Stage.FOCUS;
          totalSec = this.focusTime * 60;
        }
        lastStage = this.curStage;
        this.defaultTime = Math.floor(totalSec / 60);
        this.remainSec = totalSec;
        this.progress = this.defaultTime;
      }
    }, 1000)
  }




  @Builder
  descriptionBuilderImage() {
    Image($r('sys.media.ohos_ic_public_clock'))
      .width(40)
      .height(44)
      .padding({ bottom: 4 })
      .translate({ x: 0, y: 40 + this.clockOff })
      .fillColor(Color.White)
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#232323')
      Column() {
        Gauge({ value: !this.isPause ? this.remainSec : this.progress * 60, min: 0, max: this.defaultTime * 60 }) {
          Column() {
            Text(Math.floor((!this.isPause ? this.remainTime : this.progress) >= 0 ?
            Math.floor(!this.isPause ? this.remainTime : this.progress) : 0)
              .toString())// Text(this.remainSec.toString())
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
            .clickEffect({ level: ClickEffectLevel.MIDDLE, scale: 0.8 })
            .linearGradient({
              angle: this.btnGrad,
              colors: [[this.buttonColor1, 0.0], [this.buttonColor2, 0.5], [this.buttonColor3, 1.0]]
            })// .backgroundColor(this.buttonColor)
            .borderRadius('30vp')
            .onClick(() => {
              this.isPause = !this.isPause;
              this.buttonAnime();
              if (!this.isPause) {
                this.countDown();
              } else {
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
                    if (this.dialogController != null) {
                      this.dialogController.open()
                    }
                  }
                })
            )


          Button('Setting')
            .fontSize('20vp')
            .width(`${px2vp(this.widthPx) * 0.3}vp`)
            .height(`${px2vp(this.widthPx) * 0.15}vp`)
            .fontColor('#e1e2e5')
            .clickEffect({ level: ClickEffectLevel.MIDDLE, scale: 0.8 })
            .linearGradient({
              angle: this.btnGrad,
              colors: [[this.buttonColor1, 0.0], [this.buttonColor2, 0.5], [this.buttonColor3, 1.0]]
            })
            .rotate({
              x: 0,
              y: 0,
              z: 1,
              angle: this.btnAngle
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
            .gesture(
              LongPressGesture({ repeat: true, duration: 200 })
                .onAction((event: GestureEvent | undefined) => {
                  if (event) {
                    if (event.repeat) {
                      animateTo({
                        duration: 100,
                        curve: Curve.Friction,
                        delay: 0,
                        iterations: 1,
                        onFinish: () => {
                          animateTo({
                            duration: 100,
                            curve: Curve.Friction,
                            delay: 0,
                            iterations: 1,
                            onFinish: () => {
                              this.btnAngle = 0;
                            }
                          }, () => {
                            this.btnAngle = -7;
                          })
                        }
                      }, () => {
                        this.btnAngle = 7;
                      })
                    }
                  }
                })
                .onActionEnd(() => {
                  this.btnAngle = 0;
                  router.pushUrl({ url: 'pages/Homo' });
                })
            )
        }
        .width('70%')
      }
      .backgroundColor('#232323')
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
              SettingList({
                hereTime: this.focusTime,
                hereStage: Stage.FOCUS
              });
            }
            .onClick(() => {
              this.TimePick(Stage.FOCUS, 50);
            })

            ListItem() {
              SettingList({
                hereTime: this.breakTime,
                hereStage: Stage.BREAK
              });
            }
            .onClick(() => {
              this.TimePick(Stage.BREAK, 10);
            })

            ListItem() {
              SettingList({
                hereTime: this.longBreak,
                hereStage: Stage.LONGBREAK
              });
            }
            .onClick(() => {
              this.TimePick(Stage.LONGBREAK, 20);

            })

          }
          .width('80%')
          .margin({ top: 60, left: px2fp(this.widthPx * 0.1) })
          .backgroundColor('#444')
          .borderRadius('20vp')

          Blank()
            .layoutWeight(1)

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

    }.margin({ top: 20 }).width('100%').height('100%').backgroundColor(0x232323)

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

  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: AfterFocusDialog({
      cancel: () => {
        this.onCancel()
      },
      confirm: () => {
        this.onAccept()
      },
    }),
    cancel: this.exitApp,
    autoCancel: true,
    onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
      console.info("reason=" + JSON.stringify(dismissDialogAction.reason))
      console.log("dialog onWillDismiss")
      if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
        dismissDialogAction.dismiss()
      }
      if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
        dismissDialogAction.dismiss()
      }
    },
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: 20 },
    gridCount: 4,
    customStyle: false,
    cornerRadius: 20,
  })

  aboutToDisappear() {
    this.dialogController = null;
  }

  onCancel() {
    this.defaultTime = this.focusTime;
    this.remainTime = this.focusTime;
    this.remainSec = this.remainTime*60;
    this.progress = this.focusTime;
    this.curStage = Stage.FOCUS;
    this.breakInterval = 3;
    clearInterval(this.timer);
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    this.defaultTime = this.focusTime;
    this.remainTime = this.focusTime;
    this.remainSec = this.remainTime*60;
    this.progress = this.focusTime;
    this.curStage = Stage.FOCUS;
    this.breakInterval = 3;
    clearInterval(this.timer);
    console.info('Callback when the second button is clicked')
  }

  exitApp() {
    this.defaultTime = this.focusTime;
    this.remainTime = this.focusTime;
    this.remainSec = this.remainTime*60;
    this.progress = this.focusTime;
    this.curStage = Stage.FOCUS;
    this.breakInterval = 3;
    clearInterval(this.timer);
    console.info('Click the callback in the blank area')
  }

  TimePick(thisStage: Stage, thisRange: number): void {

    TextPickerDialog.show({
      range: this.generateStringArray(thisRange),
      selected: (thisStage == Stage.FOCUS ? this.focusTime - 10 :
        (thisStage == Stage.BREAK ? this.breakTime : this.longBreak)),
      onAccept: (value: TextPickerResult) => {
        // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
        console.log(String(value.index));
        if (thisStage == Stage.FOCUS) {
          this.focusTime = parseInt(String(value.value));
          if (this.curStage == Stage.FOCUS) {
            this.defaultTime = this.focusTime;
          }
        }
        if (thisStage == Stage.BREAK) {
          this.breakTime = parseInt(String(value.value));
          if (this.curStage == Stage.BREAK) {
            this.defaultTime = this.breakTime;
          }
        }
        if (thisStage == Stage.LONGBREAK) {
          this.longBreak = parseInt(String(value.value));
          if (this.curStage == Stage.LONGBREAK) {
            this.defaultTime = this.longBreak;
          }
        }
        this.progress = this.defaultTime;
        this.remainTime = this.defaultTime;
        this.remainSec = this.defaultTime * 60;


      },
      onCancel: () => {
        console.log('cancle');
      },
      onChange: (value: TextPickerResult) => {
        vibrator.startVibration(
          { type: 'preset', effectId: 'haptic.clock.timer', count: 1 },
          { usage: 'unknown' });
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
  }



}


@CustomDialog
@Component
struct AfterFocusDialog {
  private widthPx: number = display.getDefaultDisplaySync().width;
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }

  build() {

    Flex({
      justifyContent: FlexAlign.SpaceBetween,
      direction: FlexDirection.Column,
      alignItems: ItemAlign.Center
    }) {
      Text(`Ciallo～(∠・ω< )⌒★`).fontSize(20).margin({ top: 10, bottom: 10 }).fontColor('#eaeaea')

      Text('辛苦啦，番茄钟结束啦！').fontSize(20).margin({ top: 10, bottom: 10 }).fontColor('#eaeaea')


      Button() {
        TextGradient({ message: 'Reset' })
      }
      .onClick(() => {
        if (this.controller != undefined) {
          this.controller.close();
          this.confirm()
        }
      })
      .fontSize(30)
      .width(`${px2vp(this.widthPx) * 0.3}vp`)
      .height(`${px2vp(this.widthPx) * 0.15}vp`)
      .borderWidth(3)
      .borderColor('#ffb0003d')
      .clickEffect({ level: ClickEffectLevel.MIDDLE, scale: 0.9 })
      .margin({ bottom: 20 })
      .backgroundColor('#444')

    }
    .borderRadius(20)
    .width('100%')
    .height('50%')
    .backgroundColor('#444')
  }
}

@Component
export default struct TextGradient {
  @State message: ResourceStr = '';

  build() {
    Row() {
      Text(this.message)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .blendMode(BlendMode.DST_IN, BlendApplyType.OFFSCREEN)
    }
    .linearGradient({
      angle: 30,
      colors: [['#ff7c012c', 0.0], ['#ffb0003d', 0.3], ['#D4004A', 1.0]]
    })
    .blendMode(BlendMode.SRC_OVER, BlendApplyType.OFFSCREEN)
  }
}

@Component
struct SettingList {
  @Prop hereTime : number;
  @Prop hereStage : Stage;
  build() {
    Row() {
      Text((this.hereStage == Stage.FOCUS ? 'Focus time' : (this.hereStage == Stage.BREAK ? 'Break time' : 'Long break')))
        .height(48)
        .fontSize(20)
        .fontColor('#eaeaea')
        .textAlign(TextAlign.Start)
        .fontFamily('HarmonyHeiTi-Medium')
        .padding({ bottom: 4, top: 4, left: 24 })

      Blank()
      Text(this.hereTime.toString() + 'min')
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
}
