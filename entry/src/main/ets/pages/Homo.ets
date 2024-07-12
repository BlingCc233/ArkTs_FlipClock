import homer from './homo.json'

@Component
export default struct TextGradientView {
  @State message: ResourceStr = '';

  build() {
    Row() {
      Text(this.message)
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .blendMode(BlendMode.DST_IN, BlendApplyType.OFFSCREEN)
    }
    .linearGradient({
      angle: 23+180,
      colors: [['#ff544203', 0.0], ['#DC9B00', 0.3], ['#ffffd25d', 1.0]]
    })
    .blendMode(BlendMode.SRC_OVER, BlendApplyType.OFFSCREEN)
  }
}

@Preview
@Component
export struct Homo {
  @State resNum: string = '';
  @State inpNum: string = '';

  build() {
    Column() {
      Flex({
        direction: FlexDirection.Column,
        justifyContent: FlexAlign.SpaceAround,
        alignItems: ItemAlign.Center
      }) {
        TextGradientView({message: '哼！啊～啊啊'})
          .rotate({
            x: 0,
            y: 0,
            z: 1,
            angle: 15
          })
          .opacity(0.6)
          .translate({ x: 20, y: -10 })

        Column(){
          Text(`${this.resNum == '' ? '快点' :
            this.inpNum + ' = '}`)
            .fontColor('#DC9B00')
            .fontSize(20)
            .fontWeight(FontWeight.Normal)
            .width("80%")


          Text(`${this.resNum == '' ? '端上来罢' : this.resNum}`)
            .fontColor('#DC9B00')
            .fontSize(30)
            .fontWeight(FontWeight.Normal)
            .width("80%")

        }


        TextInput({ placeholder: "输入你要论证的数字" })
          .textAlign(TextAlign.Center)
          .width('80%')
          .fontSize(20)
          .inputFilter(`[-.0-9]`)
          .placeholderColor('#77412300')
          .height(50)
          .maxLength(10)
          .linearGradient({
            angle: 23,
            colors: [['#ff544203', 0.0], ['#DC9B00', 0.5], ['#ffffd25d', 1.0]]
          })
          .onChange((value: string) => {
            this.inpNum = value;
            this.resNum = homoFunction(parseFloat(value))
          })

        TextGradientView({ message: '恶臭论证器' })


      }
      .height('80%')

    }
    .height('100%')
    .width('100%')
    .backgroundColor('#232323')
  }
}


function homoFunction(homoNum: number): string {
  const numsReversed = Object.keys(homer).map(x => (parseInt(x))).filter(x => x > 0);
  const getMinDiv = (num: number): number => {
    for (let i = numsReversed.length; i >= 0; i--) {
      if (num >= numsReversed[i]) {
        return numsReversed[i];
      }
    }
    return numsReversed[numsReversed.length];
  };
  const isDotRegex = /\.(\d+?)0{0,}$/;
  const demolish = (num: number): string => {
    if (typeof num !== "number") {
      return "";
    }

    if (num === Infinity || Number.isNaN(num)) {
      return ``;
    }

    if (num < 0) {
      return `(⑨)*(${demolish(num * -1)})`.replace(/\*\(1\)/g, "");
    }

    if (!Number.isInteger(num)) {
      // abs(num) is definitely smaller than 2**51
      // rescale
      const n = num.toFixed(16).match(isDotRegex)![1].length;
      return `(${demolish(num * Math.pow(10, n))})/(10)^(${n})`;
    }

    if (homer[num]) {
      return String(num);
    }

    const div = getMinDiv(num);
    return (`${div}*(${demolish(Math.floor(num / div))})+` +
      `(${demolish(num % div)})`).replace(/\*\(1\)|\+\(0\)$/g, "");
  };

  const finisher = (expr: string): string => {
    let result = expr;

    result = result.replace(/\d+|⑨/g, (n): string => n == '⑨' ? homer[-1] : homer[n]).replace("^", "**");

    // As long as it matches ([*|/])(([^+-()]+)), replace it with $1$2
    let match: RegExpMatchArray | null;
    while ((match = result.match(/[\*|\/]\([^\+\-\(\)]+\)/)) !== null) {
      if (match.index != undefined) {
        result =
          result.substring(0, match.index) + match[1] + match[2] + result.substring(match.index + match[0].length);
      }
    }

    // As long as it matches ([+|-])(([^()]+))([+|-|)]), replace it with $1$2$3
    while ((match = result.match(/[\+|\-]\([^\(\)]+\)[\+|\-|\)]/)) !== null) {
      if (match.index != undefined) {
        result = result.substring(0, match.index) + match[1] + match[2] + match[3] +
        result.substring(match.index + match[0].length);
      }
    }

    // As long as it matches ([+|-])(([^()]+))$, replace it with $1$2
    while ((match = result.match(/[\+|\-]\(([^\(\)]+)\)$/)) !== null) {
      if (match.index != undefined) {
        result =
          result.substring(0, match.index) + match[1] + match[2] + result.substring(match.index + match[0].length);
      }
    }

    // If there is a bracket in the outermost part, remove it
    if (result.match(/^\([^\(\)]+?\)$/)) {
      result = result.substring(1, result.length - 1);
    }

    // Replace +- with -
    result = result.replace(/\+-/g, '-');
    result = result.toString().replace(/undefined/g, '');

    return result;
  }

  return finisher(demolish(homoNum));
}

