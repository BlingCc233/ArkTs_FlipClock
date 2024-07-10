

@Component
export struct FlipClock {
  @State timeOne: Array<number> = []
  @State timeTwo: Array<number> = []
  @State timeThree: Array<number> = []
  @State timeFour: Array<number> = []
  @State angleOne: Array<number> = [0, 0, 0, 0, 0, 0]
  @State angleTwo: Array<number> = [-90, -90, -90, -90, -90, -90]

  aboutToAppear() {
    const arr = this.changeTime()
    this.timeOne = [...arr]
    this.timeTwo = [...arr]
    this.timeThree = [...arr]
    this.timeFour = [...arr]
    setInterval(() => {
      const time = new Date()
      if (this.timeOne[5] != time.getSeconds() % 10) {
        const arr = this.changeTime()
        for (let i = 0; i < 6; i++) {
          if (arr[i] != this.timeFour[i]) {
            this.timeFour[i] = arr[i]
            this.animationOne(i)
            setTimeout(() => {
              this.timeTwo[i] = arr[i]
            }, 100)
            setTimeout(() => {
              this.timeThree[i] = arr[i]
            }, 150)
            setTimeout(() => {
              this.timeOne[i] = arr[i]
            }, 240)
          }
        }
      }
    }, 1000)
  }

  //修改时间
  changeTime(): Array<number> {
    const time = new Date()
    const hour = time.getHours()
    const hourOne = Math.floor(hour / 10)
    const hourTwo = hour % 10
    const minutesOne = Math.floor(time.getMinutes() / 10)
    const minutesTwo = time.getMinutes() % 10
    const secondsOne = Math.floor(time.getSeconds() / 10)
    const secondsTwo = time.getSeconds() % 10
    return [hourOne, hourTwo, minutesOne, minutesTwo, secondsOne, secondsTwo]
  }

  animationOne(i: number): void {
    animateTo({
      duration: 250,
      delay: 0,
      iterations: 1,
      onFinish: () => {
        this.animationTwo(i)
        this.angleOne[i] = 0
      }
    }, () => this.angleOne[i] = 90)
  }

  animationTwo(i: number): void {
    animateTo({
      duration: 250,
      delay: 0,
      iterations: 1,
      onFinish: () => {
        this.angleTwo[i] = -90
      }
    }, () => this.angleTwo[i] = 0)
  }

  @Builder
  box(num: number) {
    Column() {
      Divider()
        .zIndex(5)
        .strokeWidth(3)
        .color(0x3c3c3c)
        .position({ x: 0, y: '50%' })

      Text(`${this.timeOne[num]}`)
        .zIndex(1)
        .height(108)
        .width('100%')
        .borderRadius(8)
        .fontWeight(700)
        .padding({ top: 0 })
        .fontSize(90)
        .position({ x: 0, y: 0 })
        .fontColor(Color.White)
        .fontFamily('Monospace')
        .backgroundColor($r('app.color.text_bg'))
        .textAlign(TextAlign.Center)

      Text(`${this.timeTwo[num]}`)
        .zIndex(2)
        .height(64)
        .width('100%')
        .fontWeight(700)
        .borderRadius(8)
        .padding({ top: 3 })
        .fontSize(90)
        .position({ x: 0, y: 0 })
        .fontColor(Color.White)
        .fontFamily('Monospace')
        .backgroundColor($r('app.color.text_bg'))
        .textAlign(TextAlign.Center)

      Text(`${this.timeThree[num]}`)
        .zIndex(4)
        .height(64)
        .width('100%')
        .fontWeight(700)
        .borderRadius(8)
        .padding({ top: 3 })
        .fontSize(90)
        .position({ x: 0, y: 0 })
        .fontColor(Color.White)
        .fontFamily('Monospace')
        .textAlign(TextAlign.Center)
        .backgroundColor($r('app.color.text_bg'))
        .rotate({
          x: 1,
          y: 0,
          z: 0,
          centerX: '50%',
          centerY: '100%',
          angle: this.angleOne[num]
        })

      Text(`${this.timeFour[num]}`)
        .zIndex(3)
        .height(108)
        .width('100%')
        .fontWeight(700)
        .borderRadius(8)
        .padding({ top: 0 })
        .fontSize(90)
        .position({ x: 0, y: 0 })
        .fontColor(Color.White)
        .fontFamily('Monospace')
        .backgroundColor($r('app.color.text_bg'))
        .textAlign(TextAlign.Center)
        .rotate({
          x: 1,
          y: 0,
          z: 0,
          centerX: '50%',
          centerY: '50%',
          angle: this.angleTwo[num]
        })
    }
    .height(108)
    .width('50%')
  }

  build() {
    Column() {
      Row() {
        Row({ space: 2 }) {
          this.box(0)
          this.box(1)
        }
        .width('40%')
        .height('40%')

        Image($r('app.media.dot'))
          .width(20)
          .height(50)

        Row({ space: 2 }) {
          this.box(2)
          this.box(3)
        }
        .width('40%')
        .height('40%')

        Image($r('app.media.dot'))
          .width(20)
          .height(50)

        Row({ space: 2 }) {
          this.box(4)
          this.box(5)
        }
        .width('40%')
        .height('40%')
      }
      .id('currentTimeBox')
      .width('120%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .rotate({
      x:0,y:0,z:1,
      centerX:'50%',
      centerY:'50%',
      angle:90
    })
    .translate({x:0,y:'-10%'})
  }
}
