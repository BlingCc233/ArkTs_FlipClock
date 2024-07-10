if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface FlipClock_Params {
    timeOne?: Array<number>;
    timeTwo?: Array<number>;
    timeThree?: Array<number>;
    timeFour?: Array<number>;
    angleOne?: Array<number>;
    angleTwo?: Array<number>;
}
interface Pomodoro_Params {
    widthPx?: number;
}
interface PageTurningAnimation_Params {
    axis?: Array<number>;
    rotaRate?: number;
    originalAngle?: number;
    timeT?: enumT;
    timeData?;
    oneSecondFromNow?;
    rotateAngleTextA?: number;
    rotateAngleTextB?: number;
    animatePageNumTextB?: number;
    nextPageNumTextD?: number;
    bottomX?: string;
    bottomY?: string;
    centerX?: string;
    centerY?: string;
    timer?: number;
    widthPx?: number;
}
interface BookPage_Params {
    pageNum?: number;
    wordAngle?: number;
    rotateAngle?: number;
    positionX?: string;
    positionY?: string;
    textColor?: string;
    axis?: Array<number>;
    widthPx?: number;
}
interface EachContent_Params {
    whichPage?: number;
    widthPx?: number;
}
interface Index_Params {
    tabArray?: Array<TabItem>;
    currentIndex?: number;
}
import Constants from "@bundle:ohos.samples.etsclock/entry/ets/common/CommonConstants";
import display from "@ohos:display";
import hilog from "@ohos:hilog";
import { initTabData } from "@bundle:ohos.samples.etsclock/entry/ets/viewmodel/TabViewModel";
import type { TabItem } from '../viewmodel/TabItem';
class Index extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__tabArray = new ObservedPropertyObjectPU(initTabData(), this, "tabArray");
        this.__currentIndex = new ObservedPropertySimplePU(0, this, "currentIndex");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: Index_Params) {
        if (params.tabArray !== undefined) {
            this.tabArray = params.tabArray;
        }
        if (params.currentIndex !== undefined) {
            this.currentIndex = params.currentIndex;
        }
    }
    updateStateVars(params: Index_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__tabArray.purgeDependencyOnElmtId(rmElmtId);
        this.__currentIndex.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__tabArray.aboutToBeDeleted();
        this.__currentIndex.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    //顶部导航栏
    private __tabArray: ObservedPropertyObjectPU<Array<TabItem>>;
    get tabArray() {
        return this.__tabArray.get();
    }
    set tabArray(newValue: Array<TabItem>) {
        this.__tabArray.set(newValue);
    }
    private __currentIndex: ObservedPropertySimplePU<number>;
    get currentIndex() {
        return this.__currentIndex.get();
    }
    set currentIndex(newValue: number) {
        this.__currentIndex.set(newValue);
    }
    tabBuilder(index: number, name: string, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/Index.ets(34:5)");
            Column.width(Constants.PERCENT_MAX);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(name);
            Text.debugLine("entry/src/main/ets/pages/Index.ets(35:7)");
            Text.fontColor(Color.White);
            Text.fontSize(this.currentIndex === index ? '18fp' : '14fp');
            Text.fontWeight(this.currentIndex === index ? Constants.FONT_WEIGHT_TAB * 2 : Constants.FONT_WEIGHT_TAB);
            Text.lineHeight('22vp');
            Text.id(index.toString());
        }, Text);
        Text.pop();
        Column.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Tabs.create({ barPosition: BarPosition.Start });
            Tabs.debugLine("entry/src/main/ets/pages/Index.ets(46:5)");
            Tabs.barWidth(Constants.PERCENT_MAX);
            Tabs.barHeight('52vp');
            Tabs.padding({
                top: '30vp'
            });
            Tabs.width(Constants.PERCENT_MAX);
            Tabs.height(Constants.PERCENT_MAX);
            Tabs.backgroundColor({ "id": 16777269, "type": 10001, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Tabs.animationDuration(Constants.ANIMATION_DURATION);
            Tabs.onAnimationStart((index: number, targetIndex: number) => {
                hilog.info(0x0000, 'index', index.toString());
                this.currentIndex = targetIndex;
            });
        }, Tabs);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    TabContent.create(() => {
                        {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                if (isInitialRender) {
                                    let componentCall = new EachContent(this, {
                                        whichPage: item.id
                                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 49 });
                                    ViewPU.create(componentCall);
                                    let paramsLambda = () => {
                                        return {
                                            whichPage: item.id
                                        };
                                    };
                                    componentCall.paramsGenerator_ = paramsLambda;
                                }
                                else {
                                    this.updateStateVarsOfChildByElmtId(elmtId, {
                                        whichPage: item.id
                                    });
                                }
                            }, { name: "EachContent" });
                        }
                    });
                    TabContent.tabBar({ builder: () => {
                            this.tabBuilder.call(this, item.id, item.name);
                        } });
                    TabContent.debugLine("entry/src/main/ets/pages/Index.ets(48:9)");
                }, TabContent);
                TabContent.pop();
            };
            this.forEachUpdateFunction(elmtId, this.tabArray.slice(0, 3), forEachItemGenFunction, (item: TabItem, index: number) => JSON.stringify(item) + index, false, true);
        }, ForEach);
        ForEach.pop();
        Tabs.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "Index";
    }
}
enum enumT {
    HOUR = 0,
    MIN = 1,
    SEC = 2
}
class EachContent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__whichPage = new SynchedPropertySimpleOneWayPU(params.whichPage, this, "whichPage");
        this.widthPx = display.getDefaultDisplaySync().width;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: EachContent_Params) {
        if (params.widthPx !== undefined) {
            this.widthPx = params.widthPx;
        }
    }
    updateStateVars(params: EachContent_Params) {
        this.__whichPage.reset(params.whichPage);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__whichPage.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__whichPage.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __whichPage: SynchedPropertySimpleOneWayPU<number>;
    get whichPage() {
        return this.__whichPage.get();
    }
    set whichPage(newValue: number) {
        this.__whichPage.set(newValue);
    }
    private widthPx: number;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/Index.ets(85:5)");
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.whichPage == 1) {
                this.ifElseBranchUpdateFunction(0, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new Pomodoro(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 87 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {};
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "Pomodoro" });
                    }
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.whichPage == 0) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Flex.create({
                            direction: FlexDirection.Column,
                            justifyContent: FlexAlign.Center,
                            alignItems: ItemAlign.Center
                        });
                        Flex.debugLine("entry/src/main/ets/pages/Index.ets(90:9)");
                        Flex.width(Constants.PERCENT_MAX);
                        Flex.height(Constants.PERCENT_MAX);
                        Flex.backgroundColor({ "id": 16777269, "type": 10001, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
                    }, Flex);
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new PageTurningAnimation(this, {
                                    axis: [0, 0, 0, 1, 0, 0],
                                    rotaRate: -90,
                                    originalAngle: 0,
                                    timeT: enumT.HOUR
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 95 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {
                                        axis: [0, 0, 0, 1, 0, 0],
                                        rotaRate: -90,
                                        originalAngle: 0,
                                        timeT: enumT.HOUR
                                    };
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {
                                    axis: [0, 0, 0, 1, 0, 0],
                                    rotaRate: -90,
                                    originalAngle: 0,
                                    timeT: enumT.HOUR
                                });
                            }
                        }, { name: "PageTurningAnimation" });
                    }
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        __Common__.create();
                        __Common__.translate({ x: 0, y: `-${px2vp(this.widthPx) * 0.2}vp` });
                    }, __Common__);
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new PageTurningAnimation(this, {
                                    axis: [0, 0, 0, 1, 0, 0],
                                    rotaRate: -90,
                                    originalAngle: 0,
                                    timeT: enumT.MIN
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 101 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {
                                        axis: [0, 0, 0, 1, 0, 0],
                                        rotaRate: -90,
                                        originalAngle: 0,
                                        timeT: enumT.MIN
                                    };
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {
                                    axis: [0, 0, 0, 1, 0, 0],
                                    rotaRate: -90,
                                    originalAngle: 0,
                                    timeT: enumT.MIN
                                });
                            }
                        }, { name: "PageTurningAnimation" });
                    }
                    __Common__.pop();
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        __Common__.create();
                        __Common__.translate({ x: 0, y: `-${px2vp(this.widthPx) * 0.4}vp` });
                    }, __Common__);
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new PageTurningAnimation(this, {
                                    axis: [0, 0, 0, 1, 0, 0],
                                    rotaRate: -90,
                                    originalAngle: 0,
                                    timeT: enumT.SEC
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 108 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {
                                        axis: [0, 0, 0, 1, 0, 0],
                                        rotaRate: -90,
                                        originalAngle: 0,
                                        timeT: enumT.SEC
                                    };
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {
                                    axis: [0, 0, 0, 1, 0, 0],
                                    rotaRate: -90,
                                    originalAngle: 0,
                                    timeT: enumT.SEC
                                });
                            }
                        }, { name: "PageTurningAnimation" });
                    }
                    __Common__.pop();
                    Flex.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.whichPage == 2) {
                this.ifElseBranchUpdateFunction(0, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new FlipClock(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 121 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {};
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "FlipClock" });
                    }
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
class BookPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__pageNum = new SynchedPropertySimpleOneWayPU(params.pageNum, this, "pageNum");
        this.__wordAngle = new SynchedPropertySimpleOneWayPU(params.wordAngle, this, "wordAngle");
        this.__rotateAngle = new SynchedPropertySimpleOneWayPU(params.rotateAngle, this, "rotateAngle");
        this.__positionX = new SynchedPropertySimpleOneWayPU(params.positionX, this, "positionX");
        this.__positionY = new SynchedPropertySimpleOneWayPU(params.positionY, this, "positionY");
        this.__textColor = new SynchedPropertySimpleOneWayPU(params.textColor, this, "textColor");
        this.__axis = new SynchedPropertyObjectOneWayPU(params.axis, this, "axis");
        this.widthPx = display.getDefaultDisplaySync().width;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: BookPage_Params) {
        if (params.widthPx !== undefined) {
            this.widthPx = params.widthPx;
        }
    }
    updateStateVars(params: BookPage_Params) {
        this.__pageNum.reset(params.pageNum);
        this.__wordAngle.reset(params.wordAngle);
        this.__rotateAngle.reset(params.rotateAngle);
        this.__positionX.reset(params.positionX);
        this.__positionY.reset(params.positionY);
        this.__textColor.reset(params.textColor);
        this.__axis.reset(params.axis);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__pageNum.purgeDependencyOnElmtId(rmElmtId);
        this.__wordAngle.purgeDependencyOnElmtId(rmElmtId);
        this.__rotateAngle.purgeDependencyOnElmtId(rmElmtId);
        this.__positionX.purgeDependencyOnElmtId(rmElmtId);
        this.__positionY.purgeDependencyOnElmtId(rmElmtId);
        this.__textColor.purgeDependencyOnElmtId(rmElmtId);
        this.__axis.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__pageNum.aboutToBeDeleted();
        this.__wordAngle.aboutToBeDeleted();
        this.__rotateAngle.aboutToBeDeleted();
        this.__positionX.aboutToBeDeleted();
        this.__positionY.aboutToBeDeleted();
        this.__textColor.aboutToBeDeleted();
        this.__axis.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __pageNum: SynchedPropertySimpleOneWayPU<number>;
    get pageNum() {
        return this.__pageNum.get();
    }
    set pageNum(newValue: number) {
        this.__pageNum.set(newValue);
    }
    private __wordAngle: SynchedPropertySimpleOneWayPU<number>;
    get wordAngle() {
        return this.__wordAngle.get();
    }
    set wordAngle(newValue: number) {
        this.__wordAngle.set(newValue);
    }
    private __rotateAngle: SynchedPropertySimpleOneWayPU<number>;
    get rotateAngle() {
        return this.__rotateAngle.get();
    }
    set rotateAngle(newValue: number) {
        this.__rotateAngle.set(newValue);
    }
    private __positionX: SynchedPropertySimpleOneWayPU<string>;
    get positionX() {
        return this.__positionX.get();
    }
    set positionX(newValue: string) {
        this.__positionX.set(newValue);
    }
    private __positionY: SynchedPropertySimpleOneWayPU<string>;
    get positionY() {
        return this.__positionY.get();
    }
    set positionY(newValue: string) {
        this.__positionY.set(newValue);
    }
    private __textColor: SynchedPropertySimpleOneWayPU<string>;
    get textColor() {
        return this.__textColor.get();
    }
    set textColor(newValue: string) {
        this.__textColor.set(newValue);
    }
    private __axis: SynchedPropertySimpleOneWayPU<Array<number>>;
    get axis() {
        return this.__axis.get();
    }
    set axis(newValue: Array<number>) {
        this.__axis.set(newValue);
    }
    private widthPx: number;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/Index.ets(140:5)");
            Column.rotate({
                x: this.axis[3],
                y: this.axis[4],
                z: this.axis[5],
                angle: this.rotateAngle,
                centerX: this.positionX,
                centerY: this.positionY
            });
            Column.backgroundColor({ "id": 16777225, "type": 10001, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Column.borderRadius({ "id": 16777341, "type": 10003, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Column.backgroundColor({ "id": 16777225, "type": 10001, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`${this.pageNum % 10 == this.pageNum ? '0' + this.pageNum.toString() : this.pageNum}`);
            Text.debugLine("entry/src/main/ets/pages/Index.ets(141:7)");
            Text.fontSize({ "id": 16777455, "type": 10002, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Text.fontColor(this.textColor);
            Text.fontWeight(FontWeight.Bold);
            Text.textAlign(TextAlign.Center);
            Text.width(`${px2vp(this.widthPx) * 0.4}vp`);
            Text.height(`${px2vp(this.widthPx) * 0.4}vp`);
            Text.borderRadius({ "id": 16777454, "type": 10002, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Text.rotate({
                x: this.axis[0],
                y: this.axis[1],
                z: this.axis[2],
                angle: this.wordAngle,
                centerX: this.positionX,
                centerY: this.positionY
            });
        }, Text);
        Text.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
export class PageTurningAnimation extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__axis = new SynchedPropertyObjectOneWayPU(params.axis, this, "axis");
        this.__rotaRate = new SynchedPropertySimpleOneWayPU(params.rotaRate, this, "rotaRate");
        this.__originalAngle = new SynchedPropertySimpleOneWayPU(params.originalAngle, this, "originalAngle");
        this.__timeT = new SynchedPropertySimpleOneWayPU(params.timeT, this, "timeT");
        this.timeData = new Date();
        this.oneSecondFromNow = new Date(this.timeData.getTime() + 1000);
        this.__rotateAngleTextA = new ObservedPropertySimplePU(0, this, "rotateAngleTextA");
        this.__rotateAngleTextB = new ObservedPropertySimplePU(0, this, "rotateAngleTextB");
        this.__animatePageNumTextB = new ObservedPropertySimplePU((this.timeT == enumT.HOUR) ? this.oneSecondFromNow.getHours() : ((this.timeT == enumT.MIN) ? this.oneSecondFromNow.getMinutes() : this.oneSecondFromNow.getSeconds()), this, "animatePageNumTextB");
        this.__nextPageNumTextD = new ObservedPropertySimplePU((this.timeT == enumT.HOUR) ? this.timeData.getHours() : ((this.timeT == enumT.MIN) ? this.timeData.getMinutes() : this.timeData.getSeconds()), this, "nextPageNumTextD");
        this.__bottomX = new ObservedPropertySimplePU(Constants.PERCENT_HALF, this, "bottomX");
        this.__bottomY = new ObservedPropertySimplePU(Constants.PERCENT_HALF, this, "bottomY");
        this.__centerX = new ObservedPropertySimplePU(Constants.PERCENT_HALF, this, "centerX");
        this.__centerY = new ObservedPropertySimplePU(Constants.PERCENT_HALF, this, "centerY");
        this.timer = 0;
        this.widthPx = display.getDefaultDisplaySync().width;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: PageTurningAnimation_Params) {
        if (params.timeData !== undefined) {
            this.timeData = params.timeData;
        }
        if (params.oneSecondFromNow !== undefined) {
            this.oneSecondFromNow = params.oneSecondFromNow;
        }
        if (params.rotateAngleTextA !== undefined) {
            this.rotateAngleTextA = params.rotateAngleTextA;
        }
        if (params.rotateAngleTextB !== undefined) {
            this.rotateAngleTextB = params.rotateAngleTextB;
        }
        if (params.animatePageNumTextB !== undefined) {
            this.animatePageNumTextB = params.animatePageNumTextB;
        }
        if (params.nextPageNumTextD !== undefined) {
            this.nextPageNumTextD = params.nextPageNumTextD;
        }
        if (params.bottomX !== undefined) {
            this.bottomX = params.bottomX;
        }
        if (params.bottomY !== undefined) {
            this.bottomY = params.bottomY;
        }
        if (params.centerX !== undefined) {
            this.centerX = params.centerX;
        }
        if (params.centerY !== undefined) {
            this.centerY = params.centerY;
        }
        if (params.timer !== undefined) {
            this.timer = params.timer;
        }
        if (params.widthPx !== undefined) {
            this.widthPx = params.widthPx;
        }
    }
    updateStateVars(params: PageTurningAnimation_Params) {
        this.__axis.reset(params.axis);
        this.__rotaRate.reset(params.rotaRate);
        this.__originalAngle.reset(params.originalAngle);
        this.__timeT.reset(params.timeT);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__axis.purgeDependencyOnElmtId(rmElmtId);
        this.__rotaRate.purgeDependencyOnElmtId(rmElmtId);
        this.__originalAngle.purgeDependencyOnElmtId(rmElmtId);
        this.__timeT.purgeDependencyOnElmtId(rmElmtId);
        this.__rotateAngleTextA.purgeDependencyOnElmtId(rmElmtId);
        this.__rotateAngleTextB.purgeDependencyOnElmtId(rmElmtId);
        this.__animatePageNumTextB.purgeDependencyOnElmtId(rmElmtId);
        this.__nextPageNumTextD.purgeDependencyOnElmtId(rmElmtId);
        this.__bottomX.purgeDependencyOnElmtId(rmElmtId);
        this.__bottomY.purgeDependencyOnElmtId(rmElmtId);
        this.__centerX.purgeDependencyOnElmtId(rmElmtId);
        this.__centerY.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__axis.aboutToBeDeleted();
        this.__rotaRate.aboutToBeDeleted();
        this.__originalAngle.aboutToBeDeleted();
        this.__timeT.aboutToBeDeleted();
        this.__rotateAngleTextA.aboutToBeDeleted();
        this.__rotateAngleTextB.aboutToBeDeleted();
        this.__animatePageNumTextB.aboutToBeDeleted();
        this.__nextPageNumTextD.aboutToBeDeleted();
        this.__bottomX.aboutToBeDeleted();
        this.__bottomY.aboutToBeDeleted();
        this.__centerX.aboutToBeDeleted();
        this.__centerY.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __axis: SynchedPropertySimpleOneWayPU<Array<number>>;
    get axis() {
        return this.__axis.get();
    }
    set axis(newValue: Array<number>) {
        this.__axis.set(newValue);
    }
    private __rotaRate: SynchedPropertySimpleOneWayPU<number>;
    get rotaRate() {
        return this.__rotaRate.get();
    }
    set rotaRate(newValue: number) {
        this.__rotaRate.set(newValue);
    }
    private __originalAngle: SynchedPropertySimpleOneWayPU<number>;
    get originalAngle() {
        return this.__originalAngle.get();
    }
    set originalAngle(newValue: number) {
        this.__originalAngle.set(newValue);
    }
    private __timeT: SynchedPropertySimpleOneWayPU<enumT>;
    get timeT() {
        return this.__timeT.get();
    }
    set timeT(newValue: enumT) {
        this.__timeT.set(newValue);
    }
    private timeData;
    private oneSecondFromNow;
    private __rotateAngleTextA: ObservedPropertySimplePU<number>;
    get rotateAngleTextA() {
        return this.__rotateAngleTextA.get();
    }
    set rotateAngleTextA(newValue: number) {
        this.__rotateAngleTextA.set(newValue);
    }
    private __rotateAngleTextB: ObservedPropertySimplePU<number>;
    get rotateAngleTextB() {
        return this.__rotateAngleTextB.get();
    }
    set rotateAngleTextB(newValue: number) {
        this.__rotateAngleTextB.set(newValue);
    }
    private __animatePageNumTextB: ObservedPropertySimplePU<number>;
    get animatePageNumTextB() {
        return this.__animatePageNumTextB.get();
    }
    set animatePageNumTextB(newValue: number) {
        this.__animatePageNumTextB.set(newValue);
    }
    private __nextPageNumTextD: ObservedPropertySimplePU<number>;
    get nextPageNumTextD() {
        return this.__nextPageNumTextD.get();
    }
    set nextPageNumTextD(newValue: number) {
        this.__nextPageNumTextD.set(newValue);
    }
    private __bottomX: ObservedPropertySimplePU<string>;
    get bottomX() {
        return this.__bottomX.get();
    }
    set bottomX(newValue: string) {
        this.__bottomX.set(newValue);
    }
    private __bottomY: ObservedPropertySimplePU<string>;
    get bottomY() {
        return this.__bottomY.get();
    }
    set bottomY(newValue: string) {
        this.__bottomY.set(newValue);
    }
    private __centerX: ObservedPropertySimplePU<string>;
    get centerX() {
        return this.__centerX.get();
    }
    set centerX(newValue: string) {
        this.__centerX.set(newValue);
    }
    private __centerY: ObservedPropertySimplePU<string>;
    get centerY() {
        return this.__centerY.get();
    }
    set centerY(newValue: string) {
        this.__centerY.set(newValue);
    }
    private timer: number;
    private widthPx: number;
    aboutToAppear(): void {
        this.timer = setInterval(() => {
            this.pageTurningAnimate();
        }, this.timeT ? Constants.TIMER_DELAY : Constants.TIMER_DELAY * 100);
    }
    aboutToDisappear(): void {
        clearInterval(this.timer);
    }
    private pageTurningAnimate() {
        Context.animateTo({
            duration: Constants.ANIMATE_DURATION,
            onFinish: () => {
                this.timeData = new Date();
                this.oneSecondFromNow = new Date(this.timeData.getTime() + 1000);
                if ((!this.oneSecondFromNow.getMinutes()) && (this.timeT == enumT.HOUR)) {
                    this.rotateAngleTextA = 0;
                    this.rotateAngleTextB = 90;
                    this.animatePageNumTextB = (this.animatePageNumTextB + 1) % Constants.MAX_HOUR_NUMBER;
                }
                if ((!this.oneSecondFromNow.getSeconds()) && (this.timeT == enumT.MIN)) {
                    this.rotateAngleTextA = 0;
                    this.rotateAngleTextB = 90;
                    this.animatePageNumTextB = (this.animatePageNumTextB + 1) % Constants.MAX_MIN_NUMBER;
                }
                if (this.timeT == enumT.SEC) {
                    this.rotateAngleTextA = 0;
                    this.rotateAngleTextB = 90;
                    this.animatePageNumTextB = (this.oneSecondFromNow.getSeconds()) % Constants.MAX_SEC_NUMBER;
                }
            }
        }, () => {
            if ((!this.oneSecondFromNow.getMinutes()) && (this.timeT == enumT.HOUR)) {
                this.rotateAngleTextA = -90;
                this.rotateAngleTextB = 0;
                this.nextPageNumTextD = this.animatePageNumTextB;
            }
            if ((!this.oneSecondFromNow.getSeconds()) && (this.timeT == enumT.MIN)) {
                this.rotateAngleTextA = -90;
                this.rotateAngleTextB = 0;
                this.nextPageNumTextD = this.animatePageNumTextB;
            }
            if (this.timeT == enumT.SEC) {
                this.rotateAngleTextA = -90;
                this.rotateAngleTextB = 0;
                this.nextPageNumTextD = this.animatePageNumTextB;
            }
        });
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/Index.ets(247:5)");
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create();
            Stack.debugLine("entry/src/main/ets/pages/Index.ets(248:7)");
            Stack.clip(true);
            Stack.clipShape(new Rect({
                width: `${px2vp(this.widthPx) * 0.8}vp`,
                height: `${px2vp(this.widthPx) * 0.2 * 0.98}vp`
            })
                .radius([[16, 16], [16, 16], [0, 0], [0, 0]])
                .offset({ x: '-50%', y: '0%' }));
            Stack.width(`${px2vp(this.widthPx) * 0.4}vp`);
            Stack.height(`${px2vp(this.widthPx) * 0.4}vp`);
            Stack.translate({ x: 0, y: `${px2vp(this.widthPx) * 0.2}vp` });
        }, Stack);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new BookPage(this, {
                        pageNum: (this.nextPageNumTextD) % 60,
                        wordAngle: this.originalAngle,
                        rotateAngle: 0,
                        positionX: this.centerX,
                        positionY: this.centerY,
                        textColor: '#fff',
                        axis: this.axis
                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 249 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            pageNum: (this.nextPageNumTextD) % 60,
                            wordAngle: this.originalAngle,
                            rotateAngle: 0,
                            positionX: this.centerX,
                            positionY: this.centerY,
                            textColor: '#fff',
                            axis: this.axis
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        pageNum: (this.nextPageNumTextD) % 60,
                        wordAngle: this.originalAngle,
                        rotateAngle: 0,
                        positionX: this.centerX,
                        positionY: this.centerY,
                        textColor: '#fff',
                        axis: this.axis
                    });
                }
            }, { name: "BookPage" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new BookPage(this, {
                        pageNum: (this.animatePageNumTextB) % 60,
                        wordAngle: this.originalAngle,
                        rotateAngle: this.rotateAngleTextA,
                        positionX: this.bottomX,
                        positionY: this.bottomY,
                        textColor: '#ffffff',
                        axis: this.axis
                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 259 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            pageNum: (this.animatePageNumTextB) % 60,
                            wordAngle: this.originalAngle,
                            rotateAngle: this.rotateAngleTextA,
                            positionX: this.bottomX,
                            positionY: this.bottomY,
                            textColor: '#ffffff',
                            axis: this.axis
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        pageNum: (this.animatePageNumTextB) % 60,
                        wordAngle: this.originalAngle,
                        rotateAngle: this.rotateAngleTextA,
                        positionX: this.bottomX,
                        positionY: this.bottomY,
                        textColor: '#ffffff',
                        axis: this.axis
                    });
                }
            }, { name: "BookPage" });
        }
        Stack.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create();
            Stack.debugLine("entry/src/main/ets/pages/Index.ets(282:7)");
            Stack.clip(true);
            Stack.clipShape(new Rect({
                width: `${px2vp(this.widthPx) * 0.8}vp`,
                height: `${px2vp(this.widthPx) * 0.2}vp`
            })
                .radius([[0, 0], [0, 0], [16, 16], [16, 16]])
                .offset({ x: '-50%', y: '51%' }));
            Stack.width(`${px2vp(this.widthPx) * 0.4}vp`);
            Stack.height(`${px2vp(this.widthPx) * 0.4}vp`);
            Stack.translate({ x: 0, y: `-${px2vp(this.widthPx) * 0.2}vp` });
        }, Stack);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new BookPage(this, {
                        pageNum: (this.animatePageNumTextB) % 60,
                        wordAngle: this.originalAngle,
                        rotateAngle: 0,
                        positionX: this.centerX,
                        positionY: this.centerY,
                        textColor: '#fff',
                        axis: this.axis
                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 283 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            pageNum: (this.animatePageNumTextB) % 60,
                            wordAngle: this.originalAngle,
                            rotateAngle: 0,
                            positionX: this.centerX,
                            positionY: this.centerY,
                            textColor: '#fff',
                            axis: this.axis
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        pageNum: (this.animatePageNumTextB) % 60,
                        wordAngle: this.originalAngle,
                        rotateAngle: 0,
                        positionX: this.centerX,
                        positionY: this.centerY,
                        textColor: '#fff',
                        axis: this.axis
                    });
                }
            }, { name: "BookPage" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new BookPage(this, {
                        pageNum: (this.nextPageNumTextD) % 60,
                        wordAngle: this.originalAngle,
                        rotateAngle: this.rotateAngleTextB,
                        positionX: this.bottomX,
                        positionY: this.bottomY,
                        textColor: '#fff',
                        axis: this.axis
                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 293 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            pageNum: (this.nextPageNumTextD) % 60,
                            wordAngle: this.originalAngle,
                            rotateAngle: this.rotateAngleTextB,
                            positionX: this.bottomX,
                            positionY: this.bottomY,
                            textColor: '#fff',
                            axis: this.axis
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        pageNum: (this.nextPageNumTextD) % 60,
                        wordAngle: this.originalAngle,
                        rotateAngle: this.rotateAngleTextB,
                        positionX: this.bottomX,
                        positionY: this.bottomY,
                        textColor: '#fff',
                        axis: this.axis
                    });
                }
            }, { name: "BookPage" });
        }
        Stack.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
class Pomodoro extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.widthPx = display.getDefaultDisplaySync().width;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: Pomodoro_Params) {
        if (params.widthPx !== undefined) {
            this.widthPx = params.widthPx;
        }
    }
    updateStateVars(params: Pomodoro_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private widthPx: number;
    descriptionBuilderImage(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 125830169, "type": 20000, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Image.debugLine("entry/src/main/ets/pages/Index.ets(325:5)");
            Image.width(36);
            Image.height(36);
            Image.translate({ x: 0, y: 40 });
            Image.fillColor(Color.White);
        }, Image);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/Index.ets(331:5)");
            Column.margin({ top: 40 });
            Column.width('100%');
            Column.height('100%');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Gauge.create({ value: 50, min: 1, max: 100 });
            Gauge.debugLine("entry/src/main/ets/pages/Index.ets(332:7)");
            Gauge.startAngle(210);
            Gauge.endAngle(150);
            Gauge.colors('#cca5d61d');
            Gauge.width('80%');
            Gauge.height('80%');
            Gauge.strokeWidth(18);
            Gauge.description({ builder: this.descriptionBuilderImage.bind(this) });
            Gauge.padding(18);
        }, Gauge);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/Index.ets(333:9)");
            Column.width('100%');
            Column.height('100%');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('50');
            Text.debugLine("entry/src/main/ets/pages/Index.ets(334:11)");
            Text.fontWeight(FontWeight.Medium);
            Text.width('62%');
            Text.fontColor("#fff");
            Text.maxFontSize("60.0vp");
            Text.minFontSize("30.0vp");
            Text.textAlign(TextAlign.Center);
            Text.margin({ top: '35%' });
            Text.textOverflow({ overflow: TextOverflow.Ellipsis });
            Text.maxLines(1);
        }, Text);
        Text.pop();
        Column.pop();
        Gauge.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel('Start');
            Button.debugLine("entry/src/main/ets/pages/Index.ets(354:7)");
            Button.width(`${px2vp(this.widthPx) * 0.3}vp`);
            Button.height(`${px2vp(this.widthPx) * 0.06}vp`);
            Button.fontColor(Color.White);
            Button.backgroundColor('#cca5d61d');
            Button.borderRadius('30vp');
        }, Button);
        Button.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
export class FlipClock extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__timeOne = new ObservedPropertyObjectPU([], this, "timeOne");
        this.__timeTwo = new ObservedPropertyObjectPU([], this, "timeTwo");
        this.__timeThree = new ObservedPropertyObjectPU([], this, "timeThree");
        this.__timeFour = new ObservedPropertyObjectPU([], this, "timeFour");
        this.__angleOne = new ObservedPropertyObjectPU([0, 0, 0, 0, 0, 0], this, "angleOne");
        this.__angleTwo = new ObservedPropertyObjectPU([-90, -90, -90, -90, -90, -90], this, "angleTwo");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: FlipClock_Params) {
        if (params.timeOne !== undefined) {
            this.timeOne = params.timeOne;
        }
        if (params.timeTwo !== undefined) {
            this.timeTwo = params.timeTwo;
        }
        if (params.timeThree !== undefined) {
            this.timeThree = params.timeThree;
        }
        if (params.timeFour !== undefined) {
            this.timeFour = params.timeFour;
        }
        if (params.angleOne !== undefined) {
            this.angleOne = params.angleOne;
        }
        if (params.angleTwo !== undefined) {
            this.angleTwo = params.angleTwo;
        }
    }
    updateStateVars(params: FlipClock_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__timeOne.purgeDependencyOnElmtId(rmElmtId);
        this.__timeTwo.purgeDependencyOnElmtId(rmElmtId);
        this.__timeThree.purgeDependencyOnElmtId(rmElmtId);
        this.__timeFour.purgeDependencyOnElmtId(rmElmtId);
        this.__angleOne.purgeDependencyOnElmtId(rmElmtId);
        this.__angleTwo.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__timeOne.aboutToBeDeleted();
        this.__timeTwo.aboutToBeDeleted();
        this.__timeThree.aboutToBeDeleted();
        this.__timeFour.aboutToBeDeleted();
        this.__angleOne.aboutToBeDeleted();
        this.__angleTwo.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __timeOne: ObservedPropertyObjectPU<Array<number>>;
    get timeOne() {
        return this.__timeOne.get();
    }
    set timeOne(newValue: Array<number>) {
        this.__timeOne.set(newValue);
    }
    private __timeTwo: ObservedPropertyObjectPU<Array<number>>;
    get timeTwo() {
        return this.__timeTwo.get();
    }
    set timeTwo(newValue: Array<number>) {
        this.__timeTwo.set(newValue);
    }
    private __timeThree: ObservedPropertyObjectPU<Array<number>>;
    get timeThree() {
        return this.__timeThree.get();
    }
    set timeThree(newValue: Array<number>) {
        this.__timeThree.set(newValue);
    }
    private __timeFour: ObservedPropertyObjectPU<Array<number>>;
    get timeFour() {
        return this.__timeFour.get();
    }
    set timeFour(newValue: Array<number>) {
        this.__timeFour.set(newValue);
    }
    private __angleOne: ObservedPropertyObjectPU<Array<number>>;
    get angleOne() {
        return this.__angleOne.get();
    }
    set angleOne(newValue: Array<number>) {
        this.__angleOne.set(newValue);
    }
    private __angleTwo: ObservedPropertyObjectPU<Array<number>>;
    get angleTwo() {
        return this.__angleTwo.get();
    }
    set angleTwo(newValue: Array<number>) {
        this.__angleTwo.set(newValue);
    }
    aboutToAppear() {
        const arr = this.changeTime();
        this.timeOne = [...arr];
        this.timeTwo = [...arr];
        this.timeThree = [...arr];
        this.timeFour = [...arr];
        setInterval(() => {
            const time = new Date();
            if (this.timeOne[5] != time.getSeconds() % 10) {
                const arr = this.changeTime();
                for (let i = 0; i < 6; i++) {
                    if (arr[i] != this.timeFour[i]) {
                        this.timeFour[i] = arr[i];
                        this.animationOne(i);
                        setTimeout(() => {
                            this.timeTwo[i] = arr[i];
                        }, 100);
                        setTimeout(() => {
                            this.timeThree[i] = arr[i];
                        }, 150);
                        setTimeout(() => {
                            this.timeOne[i] = arr[i];
                        }, 240);
                    }
                }
            }
        }, 1000);
    }
    //修改时间
    changeTime(): Array<number> {
        const time = new Date();
        const hour = time.getHours();
        const hourOne = Math.floor(hour / 10);
        const hourTwo = hour % 10;
        const minutesOne = Math.floor(time.getMinutes() / 10);
        const minutesTwo = time.getMinutes() % 10;
        const secondsOne = Math.floor(time.getSeconds() / 10);
        const secondsTwo = time.getSeconds() % 10;
        return [hourOne, hourTwo, minutesOne, minutesTwo, secondsOne, secondsTwo];
    }
    animationOne(i: number): void {
        Context.animateTo({
            duration: 250,
            delay: 0,
            iterations: 1,
            onFinish: () => {
                this.animationTwo(i);
                this.angleOne[i] = 0;
            }
        }, () => this.angleOne[i] = 90);
    }
    animationTwo(i: number): void {
        Context.animateTo({
            duration: 250,
            delay: 0,
            iterations: 1,
            onFinish: () => {
                this.angleTwo[i] = -90;
            }
        }, () => this.angleTwo[i] = 0);
    }
    box(num: number, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/Index.ets(442:5)");
            Column.height(108);
            Column.width('50%');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Divider.create();
            Divider.debugLine("entry/src/main/ets/pages/Index.ets(443:7)");
            Divider.zIndex(5);
            Divider.strokeWidth(2);
            Divider.color(0x3c3c3c);
            Divider.position({ x: 0, y: '50%' });
        }, Divider);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`${this.timeOne[num]}`);
            Text.debugLine("entry/src/main/ets/pages/Index.ets(449:7)");
            Text.zIndex(1);
            Text.height(108);
            Text.width('100%');
            Text.borderRadius(8);
            Text.fontWeight(700);
            Text.padding({ top: 0 });
            Text.fontSize(90);
            Text.position({ x: 0, y: 0 });
            Text.fontColor(Color.White);
            Text.fontFamily('Monospace');
            Text.backgroundColor({ "id": 16777524, "type": 10001, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Text.textAlign(TextAlign.Center);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`${this.timeTwo[num]}`);
            Text.debugLine("entry/src/main/ets/pages/Index.ets(463:7)");
            Text.zIndex(2);
            Text.height(64);
            Text.width('100%');
            Text.fontWeight(700);
            Text.borderRadius(8);
            Text.padding({ top: 3 });
            Text.fontSize(90);
            Text.position({ x: 0, y: 0 });
            Text.fontColor(Color.White);
            Text.fontFamily('Monospace');
            Text.backgroundColor({ "id": 16777524, "type": 10001, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Text.textAlign(TextAlign.Center);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`${this.timeThree[num]}`);
            Text.debugLine("entry/src/main/ets/pages/Index.ets(477:7)");
            Text.zIndex(4);
            Text.height(64);
            Text.width('100%');
            Text.fontWeight(700);
            Text.borderRadius(8);
            Text.padding({ top: 3 });
            Text.fontSize(90);
            Text.position({ x: 0, y: 0 });
            Text.fontColor(Color.White);
            Text.fontFamily('Monospace');
            Text.textAlign(TextAlign.Center);
            Text.backgroundColor({ "id": 16777524, "type": 10001, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Text.rotate({
                x: 1,
                y: 0,
                z: 0,
                centerX: '50%',
                centerY: '100%',
                angle: this.angleOne[num]
            });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`${this.timeFour[num]}`);
            Text.debugLine("entry/src/main/ets/pages/Index.ets(499:7)");
            Text.zIndex(3);
            Text.height(108);
            Text.width('100%');
            Text.fontWeight(700);
            Text.borderRadius(8);
            Text.padding({ top: 0 });
            Text.fontSize(90);
            Text.position({ x: 0, y: 0 });
            Text.fontColor(Color.White);
            Text.fontFamily('Monospace');
            Text.backgroundColor({ "id": 16777524, "type": 10001, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Text.textAlign(TextAlign.Center);
            Text.rotate({
                x: 1,
                y: 0,
                z: 0,
                centerX: '50%',
                centerY: '50%',
                angle: this.angleTwo[num]
            });
        }, Text);
        Text.pop();
        Column.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/Index.ets(526:5)");
            Column.width('100%');
            Column.height('100%');
            Column.justifyContent(FlexAlign.Center);
            Column.rotate({
                x: 0, y: 0, z: 1,
                centerX: '50%',
                centerY: '50%',
                angle: 90
            });
            Column.translate({ x: 0, y: '-10%' });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.debugLine("entry/src/main/ets/pages/Index.ets(527:7)");
            Row.id('currentTimeBox');
            Row.width('120%');
            Row.height('100%');
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 2 });
            Row.debugLine("entry/src/main/ets/pages/Index.ets(528:9)");
            Row.width('40%');
            Row.height('40%');
        }, Row);
        this.box.bind(this)(0, this);
        this.box.bind(this)(1, this);
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 16777533, "type": 20000, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Image.debugLine("entry/src/main/ets/pages/Index.ets(535:9)");
            Image.width(20);
            Image.height(50);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 2 });
            Row.debugLine("entry/src/main/ets/pages/Index.ets(539:9)");
            Row.width('40%');
            Row.height('40%');
        }, Row);
        this.box.bind(this)(2, this);
        this.box.bind(this)(3, this);
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 16777533, "type": 20000, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
            Image.debugLine("entry/src/main/ets/pages/Index.ets(546:9)");
            Image.width(20);
            Image.height(50);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 2 });
            Row.debugLine("entry/src/main/ets/pages/Index.ets(550:9)");
            Row.width('40%');
            Row.height('40%');
        }, Row);
        this.box.bind(this)(4, this);
        this.box.bind(this)(5, this);
        Row.pop();
        Row.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
registerNamedRoute(() => new Index(undefined, {}), "", { bundleName: "ohos.samples.etsclock", moduleName: "entry", pagePath: "pages/Index", pageFullPath: "entry/src/main/ets/pages/Index", integratedHsp: "false" });
