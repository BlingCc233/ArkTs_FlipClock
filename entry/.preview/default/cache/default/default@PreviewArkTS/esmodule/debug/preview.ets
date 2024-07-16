struct preview{build(){Text(`${day.date}`)
              .height(50)
              .width(50)
              .textAlign(TextAlign.Center)
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              // .borderRadius(8)
              .fontColor(day.isToday ? '#ffffff' : '#eaeaea')
              .margin(3)
              .backgroundColor(day.isToday ?
                (this.feelings.has(this.todayDate) ? this.feelings.get(this.todayDate) : '#666') : day.thisDayColor)
              .opacity(day.isCurrentMonth ? 0.8 : 0.2)}}