import CommonConstants from '../common/CommonConstants';

export default class DrawClock {
  drawClock(context: CanvasRenderingContext2D, radius: number, canvasWidth: number, hour: number, minute: number,
    second: number, time: string) {
    this.drawBackGround(context, radius, canvasWidth);
    this.drawHour(context, radius, hour, minute);
    this.drawMinute(context, radius, minute);
    this.drawSecond(context, radius, second);
    this.drawDot(context);
    this.drawTime(context, radius, time);
  }

  drawBackGround(context: CanvasRenderingContext2D, radius: number, canvasWidth: number) {
    context.save();
    // 绘制背景
    let grad = context.createRadialGradient(radius, radius, radius - 32, radius, radius, radius);
    grad.addColorStop(0.0, 'white');
    grad.addColorStop(0.9, '#eee');
    grad.addColorStop(1.0, 'white');
    context.fillStyle = grad;
    context.fillRect(0, 0, canvasWidth, canvasWidth);

    // 绘制外圈圆
    context.translate(radius, radius);
    context.lineWidth = 6;
    context.beginPath();
    context.strokeStyle = '#fff';
    context.arc(0, 0, radius - 5, 0, 2 * Math.PI, false);
    context.stroke();

    // 绘制时间文字
    context.font = '30px';
    context.textAlign = "center";
    context.textBaseline = "middle";
    context.fillStyle = '#000';
    CommonConstants.HOURS.forEach((num, index) => {
      context.save();
      let rad = 2 * Math.PI / 12 * index;
      let x = Math.cos(rad) * (radius - 38);
      let y = Math.sin(rad) * (radius - 38);
      context.fillText(num, x, y);
    })

    // 绘制刻度
    for (let i = 0; i < 60; i++) {
      let rad = 2 * Math.PI / 60 * i;
      let x = Math.cos(rad) * (radius - 12);
      let y = Math.sin(rad) * (radius - 12);
      context.beginPath();
      context.moveTo(x, y);
      if (i % 5 == 0) {
        let x1 = Math.cos(rad) * (radius - 20);
        let y1 = Math.sin(rad) * (radius - 20);
        context.strokeStyle = '#000';
        context.lineWidth = 2;
        context.lineTo(x1, y1);
      } else {
        let x1 = Math.cos(rad) * (radius - 18);
        let y1 = Math.sin(rad) * (radius - 18);
        context.strokeStyle = '#ccc';
        context.lineWidth = 1;
        context.lineTo(x1, y1);
      }
      context.stroke();
    }
  }

  // 绘制时针
  drawHour(context: CanvasRenderingContext2D, radius: number, hour: number, minute: number) {
    context.save();
    context.beginPath();
    context.lineWidth = 8;
    context.lineCap = 'round';
    let rad = 2 * Math.PI / 12 * hour;
    let mrad = 2 * Math.PI / 12 / 60 * minute;
    context.rotate(rad + mrad);
    context.moveTo(0, 10);
    context.strokeStyle = '#000';
    context.lineTo(0, -radius / 2);
    context.stroke();
    context.restore();
  }

  // 绘制分针
  drawMinute(context: CanvasRenderingContext2D, radius: number, minute: number) {
    context.save();
    context.beginPath();
    context.lineWidth = 5;
    context.lineCap = 'round';
    let rad = 2 * Math.PI / 60 * minute;
    context.rotate(rad);
    context.moveTo(0, 10);
    context.strokeStyle = '#000';
    context.lineTo(0, -radius + 40);
    context.stroke();
    context.restore();
  }

  // 绘制秒针
  drawSecond(context: CanvasRenderingContext2D, radius: number, second: number) {
    context.save();
    context.beginPath();
    context.lineWidth = 2;
    context.lineCap = 'round';
    let rad = 2 * Math.PI / 60 * second;
    context.rotate(rad);
    context.moveTo(0, 10);
    context.strokeStyle = '#05f';
    context.lineTo(0, -radius + 21);
    context.stroke();
    context.restore();
  }

  // 绘制中心点
  drawDot(context: CanvasRenderingContext2D) {
    context.save();
    context.beginPath();
    context.fillStyle = '#05f';
    context.arc(0, 0, 4, 0, 2 * Math.PI, false);
    context.fill();
    context.restore();
  }

  // 绘制表盘下面时间文本
  drawTime(context: CanvasRenderingContext2D, radius: number, time: string) {
    context.save();
    context.beginPath();
    context.font = '90px';
    context.textAlign = "center";
    context.textBaseline = "middle";
    context.fillStyle = '#000';
    context.fillText(time, 0, radius + 80);
    context.restore();
  }
}