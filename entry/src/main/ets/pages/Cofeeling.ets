import { i18n } from '@kit.LocalizationKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

const WEEK_TITLE = [$r('app.string.monday'), $r('app.string.tuesday'), $r('app.string.wednesday'),
  $r('app.string.thursday'), $r('app.string.friday'), $r('app.string.saturday'),
  $r('app.string.sunday')];

interface Day {
  thisDayColor: FEELING | undefined,
  isCurrentMonth: boolean,
  isToday: boolean,
  date: number
};

enum FEELING {
  UNDEFINE = '#232323',
  EXTREMELY_BAD = '#913a4a',
  SAD = '#a7535a',
  NORMAL = '#92b3a5',
  HAPPY = '#63bbd0',
  ULTRA_HAPPY = '#1772b4'
}

interface TodayFeeling{
  lever:string,
  color:FEELING
}


PersistentStorage.persistProp("feelings", new Map<number, FEELING>([]));


@Entry
@Component
export struct Cofeeling {
  @StorageLink("feelings") feelings: Map<number, FEELING> = new Map<number, FEELING>([]);
  initialMap() {

    //找最早的一天
    // 如果第一天存在就设为那一天
    // this.feelings.set(20240530, FEELING.EXTREMELY_BAD);
    const keysOfMap = Array.from(this.feelings.keys());
    keysOfMap.sort();
    this.firstDay = keysOfMap[0];
    if(this.firstDay == undefined){
      this.firstDay = this.todayDate;
    }

  }


  @State viewingMonthIndex: number = 0;
  private calendar = i18n.getCalendar('zh-Hans');
  private toDayY: number = this.calendar.get('year');
  private toDayM: number = this.calendar.get('month'); //start from 0
  private toDayD: number = this.calendar.get('date');

  @State todayDate:number = ((this.toDayY*100)+this.toDayM+1)*100+this.toDayD;

  private totMonth: number = 0;
  @State currentMonth: number = 0;
  // private firstDay : number = (this.toDayY*100 + this.toDayM)*100 + 1; //本月第一天
  private firstDay: number = this.todayDate;
  private monthWithFirstDay: number = Math.floor(this.firstDay / 100);

  private toDayFeeling : TodayFeeling[] = [
    {lever:'BAD', color:FEELING.EXTREMELY_BAD},
    {lever:'bad', color:FEELING.SAD},
    {lever:'normal', color:FEELING.NORMAL},
    {lever:'good', color:FEELING.HAPPY},
    {lever:'GOOD', color:FEELING.ULTRA_HAPPY}
  ]


  refreshData(listIndex: number): Day[] {
    let monthIndex = this.monthWithFirstDay - 1;
    let algFornextyear = (monthIndex % 100 + listIndex);

    while (algFornextyear / 12 >= 1) //满12进一年
    {
      monthIndex = (Math.floor(monthIndex / 100) + 1) * 100 + algFornextyear % 12;
      algFornextyear = algFornextyear - 12;
    }
    if (algFornextyear / 12 < 1) {
      monthIndex = (Math.floor(monthIndex / 100)) * 100 + algFornextyear;
    }

    const currentYear = Math.floor(monthIndex / 100);
    const currentMonth = monthIndex % 100;
    // AlertDialog.show({ message:`${currentYear}  ${currentMonth}` });
    let daysData: Day[] = [];
    this.calendar.set(currentYear, currentMonth, 1);
    let currentMonthStartWeek = this.calendar.get('day_of_week');
    let currentMonthJulianDay = this.calendar.get('julian_day');
    let preYear = currentMonth - 1 >= 0 ? currentYear : currentYear - 1;
    let preMonth = currentMonth - 1 >= 0 ? currentMonth - 1 : 11;
    this.calendar.set(preYear, preMonth, 1);
    let preMonthJulianDay = this.calendar.get('julian_day');
    let nextYear = currentMonth + 1 < 12 ? currentYear : currentYear + 1;
    let nextMonth = currentMonth + 1 < 12 ? currentMonth + 1 : 0;
    this.calendar.set(nextYear, nextMonth, 1);
    let nextMonthJulianDay = this.calendar.get('julian_day');
    let preMonthDays = currentMonthJulianDay - preMonthJulianDay;
    let currentMonthDays = nextMonthJulianDay - currentMonthJulianDay;
    this.calendar.set(currentYear, currentMonth, currentMonthDays);
    let currentMonthEndWeek = this.calendar.get('day_of_week');
    for (let index = preMonthDays - ((currentMonthStartWeek + 5) % 7) + 1; index <= preMonthDays; index++) {
      daysData.push({
        thisDayColor: FEELING.UNDEFINE,
        isCurrentMonth: false,
        isToday: false,
        date: index
      })
    }
    for (let index = 1; index <= currentMonthDays; index++) {
      daysData.push({
        thisDayColor: this.feelings.has((currentYear * 100 + currentMonth + 1) * 100 + index) ?
        this.feelings.get((currentYear * 100 + currentMonth + 1) * 100 + index) : FEELING.UNDEFINE,
        isCurrentMonth: true,
        isToday: this.toDayY === currentYear && this.toDayM === currentMonth && index === this.toDayD,
        date: index
      })
    }
    for (let index = 1; index <= (8 - currentMonthEndWeek) % 7; index++) {
      daysData.push({
        thisDayColor: FEELING.UNDEFINE,
        isCurrentMonth: false,
        isToday: false,
        date: index
      })
    }

    return daysData;
  }

  // 获取第一天到现在的所有月份的索引
  allMonthIndexes(): number[] {
    let numOfIndex: number = (this.toDayY - Math.floor(this.monthWithFirstDay / 100)) * 12 -
      (this.monthWithFirstDay % 100 - (this.toDayM + 1));
    let indexes: number[] = [];

    for (let i = 0; i <= numOfIndex; i++) {
      indexes.push(i);
    }
    return indexes;
  }

  private arrForList: number[] = this.allMonthIndexes(); // 把这些索引构建成List的内容
  private listScroll: Scroller = new Scroller();

  // private temp : Day[] = this.refreshData(0);
  aboutToAppear(): void {
    this.initialMap();


    this.monthWithFirstDay = Math.floor(this.firstDay / 100);
    this.arrForList = this.allMonthIndexes();
    this.viewingMonthIndex = this.allMonthIndexes().length - 1;
    this.totMonth = this.allMonthIndexes().length - 1;

    let monthIndex = (this.monthWithFirstDay - 1) % 100;
    this.currentMonth = (monthIndex + this.viewingMonthIndex) % 12;
  }

  build() {
    Flex({
      direction:FlexDirection.Column,
      justifyContent:FlexAlign.SpaceAround,
      alignItems: ItemAlign.Center
    }) {

      Text('How are you?')
        .fontColor('#eaeaea')
        .textAlign(TextAlign.Center)
        .width('100%')
        .fontSize(30)
        .fontWeight(FontWeight.Lighter)

      Blank()



      Row() {
        Text(`${this.currentMonth + 1 >= 10 ? '' : '0'}${this.currentMonth + 1}`)
          .fontSize(20)
          .margin({ left: 24 })
          .padding(8)
          .fontColor(Color.White)
          .backgroundColor('#8fb2c9')
          .opacity(0.6)

        Blank()
        Row() {
          Text($r('app.string.today'))
            .id('today')
            .fontColor('#8fb2c9')
            .fontSize(20)
            .margin({ right: 24 })
        }
        .height('100%')
        .aspectRatio(1)
        .onClick(() => {
          this.listScroll.scrollToIndex(this.totMonth, true);
        })
      }
      .width('100%')
      .height(56)


      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        ForEach(WEEK_TITLE, (str: Resource) => {
          Text(str)
            .fontSize(20)
            .fontColor(Color.White)
            .opacity(0.6)
            .height(24)
            .width(24)
            .textAlign(TextAlign.Center)
        })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .margin({ top: 10, bottom: 20 })

      Divider().strokeWidth(0.6).color(Color.White).opacity(0.4).width('90%')


      List({ space: 40, scroller: this.listScroll, initialIndex: this.arrForList.length - 1 }) {
        ForEach(this.arrForList, (item: number) => {
          ListItem() {
            eachMonth({
              daysData: this.refreshData(item),
              todayDate: this.todayDate,
              feelings: $feelings
            })
          }
        })
      }
      .width('100%')
      .height(300)
      .friction(0.9)
      .scrollSnapAlign(ScrollSnapAlign.CENTER)
      .onScrollIndex((firstIndex: number, lastIndex: number, centerIndex: number) => {
        this.viewingMonthIndex = centerIndex;
        let monthIndex = (this.monthWithFirstDay - 1) % 100;
        this.currentMonth = (monthIndex + this.viewingMonthIndex) % 12;
      })

      Blank()


      Flex({
        direction:FlexDirection.Row,
        justifyContent:FlexAlign.SpaceAround
      }) {
        ForEach(this.toDayFeeling, (option:TodayFeeling)=>{
          Button(option.lever)
            .backgroundColor(option.color)
            .width('18%')
            .clickEffect({ level: ClickEffectLevel.MIDDLE, scale: 0.8 })
            .opacity(0.8)
            .onClick(()=>{
              this.listScroll.scrollToIndex(this.totMonth, true);
              this.feelings.set(this.todayDate, option.color);
            })

        })
      }
      .width('90%')

    }
    .height('80%')
  }
}


@Component
struct eachMonth {
  @Prop daysData: Day[];
  @Prop todayDate:number;
  @Link feelings: Map<number, FEELING>;

  build() {
    Flex({ wrap: FlexWrap.Wrap }) {
      ForEach(WEEK_TITLE, (item: Resource, index) => {
        Flex({ justifyContent: FlexAlign.SpaceAround }) {
          ForEach(this.daysData.slice(index * WEEK_TITLE.length, (index + 1) * WEEK_TITLE.length), (day: Day) => {
            Text(`${day.date}`)
              .height(50)
              .width(50)
              .textAlign(TextAlign.Center)
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .borderRadius(8)
              .fontColor(day.isToday ? '#ffffff' : '#eaeaea')
              .backgroundColor(day.isToday ? (this.feelings.has(this.todayDate)?this.feelings.get(this.todayDate) : '#666') : day.thisDayColor)
              .opacity(day.isCurrentMonth ? 0.9 : 0.2)
          })
        }
        .width('100%')
      })
    }
    .padding({ left: 24, right: 24 })
    .width('100%')
  }
}