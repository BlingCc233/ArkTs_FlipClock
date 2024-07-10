import { display, RectShape } from '@kit.ArkUI';
import Constants from '../common/CommonConstants';

export enum enumT {
  HOUR,
  MIN,
  SEC
}

@Component
export struct BookPage {
  @Prop pageNum: number;
  @Prop wordAngle: number;
  @Prop rotateAngle: number;
  @Prop positionX: string;
  @Prop positionY: string;
  @Prop textColor: string;
  @Prop axis: Array<number>;
  private widthPx: number = display.getDefaultDisplaySync().width;

  build() {
    Column() {
      Text(`${this.pageNum%10==this.pageNum? '0'+this.pageNum.toString() : this.pageNum}`)
        .fontSize($r('app.float.common_font_size'))
        .fontColor(this.textColor)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .width(`${px2vp(this.widthPx) * 0.4}vp`)
        .height(`${px2vp(this.widthPx) * 0.4}vp`)
        .borderRadius($r('app.float.common_border_radius'))
        .rotate({
          x: this.axis[0],
          y: this.axis[1],
          z: this.axis[2],
          angle: this.wordAngle,
          centerX: this.positionX,
          centerY: this.positionY
        })
    }
    .rotate({
      x: this.axis[3],
      y: this.axis[4],
      z: this.axis[5],
      angle: this.rotateAngle,
      centerX: this.positionX,
      centerY: this.positionY
    })
    .backgroundColor($r('app.color.common_color_dark_blue'))
    .borderRadius($r('app.string.ohos_id_corner_radius_default_l'))
    .backgroundColor($r('app.color.common_color_dark_blue'))
  }
}


@Component
export struct PageTurningAnimation {
  @Prop axis: Array<number>;
  @Prop rotaRate: number;
  @Prop originalAngle: number;
  @Prop timeT: enumT;
  private timeData  = new Date();
  private  oneSecondFromNow = new Date(this.timeData.getTime() + 1000);
  @State rotateAngleTextA: number = 0;
  @State rotateAngleTextB: number = 0;
  @State animatePageNumTextB: number = (this.timeT == enumT.HOUR)? this.oneSecondFromNow.getHours() : ((this.timeT == enumT.MIN)? this.oneSecondFromNow.getMinutes() : this.oneSecondFromNow.getSeconds());
  @State nextPageNumTextD: number = (this.timeT == enumT.HOUR)? this.timeData.getHours() : ((this.timeT == enumT.MIN)? this.timeData.getMinutes() : this.timeData.getSeconds());
  @State bottomX: string = Constants.PERCENT_HALF;
  @State bottomY: string = Constants.PERCENT_HALF;
  @State centerX: string = Constants.PERCENT_HALF;
  @State centerY: string = Constants.PERCENT_HALF;
  private timer: number = 0;
  private widthPx: number = display.getDefaultDisplaySync().width;

  aboutToAppear(): void {
    this.timer = setInterval(() => {
      this.pageTurningAnimate();
    }, this.timeT ? Constants.TIMER_DELAY : Constants.TIMER_DELAY * 100)
  }

  aboutToDisappear(): void {
    clearInterval(this.timer);
  }

  private pageTurningAnimate() {
    animateTo({
      duration: Constants.ANIMATE_DURATION,
      onFinish: () => {
        this.timeData  = new Date();
        this.oneSecondFromNow = new Date(this.timeData.getTime() + 1000);
        if((!this.oneSecondFromNow.getMinutes())&&(this.timeT == enumT.HOUR)){
          this.rotateAngleTextA = 0;
          this.rotateAngleTextB = 90;
          this.animatePageNumTextB = (this.animatePageNumTextB+1) % Constants.MAX_HOUR_NUMBER;
        }
        if((!this.oneSecondFromNow.getSeconds())&&(this.timeT == enumT.MIN)){
          this.rotateAngleTextA = 0;
          this.rotateAngleTextB = 90;
          this.animatePageNumTextB = (this.animatePageNumTextB+1) % Constants.MAX_MIN_NUMBER;

        }
        if(this.timeT == enumT.SEC){
          this.rotateAngleTextA = 0;
          this.rotateAngleTextB = 90;
          this.animatePageNumTextB = (this.oneSecondFromNow.getSeconds()) % Constants.MAX_SEC_NUMBER;

        }
      }
    }, () => {
      if((!this.oneSecondFromNow.getMinutes())&&(this.timeT == enumT.HOUR)) {
        this.rotateAngleTextA = -90;
        this.rotateAngleTextB = 0;
        this.nextPageNumTextD = this.animatePageNumTextB;
      }
      if((!this.oneSecondFromNow.getSeconds())&&(this.timeT == enumT.MIN)){
        this.rotateAngleTextA = -90;
        this.rotateAngleTextB = 0;
        this.nextPageNumTextD = this.animatePageNumTextB;
      }
      if(this.timeT == enumT.SEC){
        this.rotateAngleTextA = -90;
        this.rotateAngleTextB = 0;
        this.nextPageNumTextD = this.animatePageNumTextB;
      }

    })
  }

  build() {
    Column() {
      Stack() {
        BookPage({
          pageNum: (this.nextPageNumTextD) % 60,
          wordAngle: this.originalAngle,
          rotateAngle: 0,
          positionX: this.centerX,
          positionY: this.centerY,
          textColor: '#fff',
          axis: this.axis
        })

        BookPage({
          pageNum: (this.animatePageNumTextB) % 60,
          wordAngle: this.originalAngle,
          rotateAngle: this.rotateAngleTextA,
          positionX: this.bottomX,
          positionY: this.bottomY,
          textColor: '#ffffff',
          axis: this.axis
        })
      }
      .clip(true)
      .clipShape(new Rect({
        width: `${px2vp(this.widthPx) * 0.8}vp`,
        height:`${px2vp(this.widthPx) * 0.2 * 0.98}vp`
      })
        .radius([[16,16],[16,16],[0,0],[0,0]])
        .offset({x:'-50%',y:'0%'})

      )
      .width(`${px2vp(this.widthPx) * 0.4}vp`)
      .height(`${px2vp(this.widthPx) * 0.4}vp`)
      .translate({x:0,y:`${px2vp(this.widthPx) * 0.2}vp`})

      Stack() {
        BookPage({
          pageNum: (this.animatePageNumTextB) % 60,
          wordAngle: this.originalAngle,
          rotateAngle: 0,
          positionX: this.centerX,
          positionY: this.centerY,
          textColor: '#fff',
          axis: this.axis
        })

        BookPage({
          pageNum: (this.nextPageNumTextD) % 60,
          wordAngle: this.originalAngle,
          rotateAngle: this.rotateAngleTextB,
          positionX: this.bottomX,
          positionY: this.bottomY,
          textColor: '#fff',
          axis: this.axis
        })
      }
      .clip(true)
      .clipShape(new Rect({
        width: `${px2vp(this.widthPx) * 0.8}vp`,
        height:`${px2vp(this.widthPx) * 0.2}vp`
      })
        .radius([[0,0],[0,0],[16,16],[16,16]])
        .offset({x:'-50%',y:'51%'})
      )
      .width(`${px2vp(this.widthPx) * 0.4}vp`)
      .height(`${px2vp(this.widthPx) * 0.4}vp`)
      .translate({x:0,y:`-${px2vp(this.widthPx) * 0.2}vp`})
    }
  }
}
