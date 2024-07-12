if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface EachContent_Params {
    whichPage?: number;
    widthPx?: number;
    isRotate?: boolean;
    time?;
    rotaAngle?: number;
    offsetPos?: string;
    textOpacity?: number;
}
interface Index_Params {
    tabArray?: Array<TabItem>;
    currentIndex?: number;
}
import { FlipClock } from "@bundle:com.blingcc.flipclock/entry/ets/pages/FlipClock";
import Constants from "@bundle:com.blingcc.flipclock/entry/ets/common/CommonConstants";
import display from "@ohos:display";
import hilog from "@ohos:hilog";
import { initTabData } from "@bundle:com.blingcc.flipclock/entry/ets/viewmodel/TabViewModel";
import type { TabItem } from '../viewmodel/TabItem';
import { Pomodoro } from "@bundle:com.blingcc.flipclock/entry/ets/pages/Pomodoro";
import { PageTurningAnimation, enumT } from "@bundle:com.blingcc.flipclock/entry/ets/pages/PageTurningAnimation";
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
            Column.debugLine("entry/src/main/ets/pages/Index.ets(24:5)");
            Column.width(Constants.PERCENT_MAX);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(name);
            Text.debugLine("entry/src/main/ets/pages/Index.ets(25:7)");
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
            Tabs.debugLine("entry/src/main/ets/pages/Index.ets(36:5)");
            Tabs.barWidth(Constants.PERCENT_MAX);
            Tabs.barHeight('52vp');
            Tabs.padding({
                top: '30vp'
            });
            Tabs.width(Constants.PERCENT_MAX);
            Tabs.height(Constants.PERCENT_MAX);
            Tabs.backgroundColor({ "id": 16777269, "type": 10001, params: [], "bundleName": "com.blingcc.flipclock", "moduleName": "entry" });
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
                                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 39 });
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
                    TabContent.debugLine("entry/src/main/ets/pages/Index.ets(38:9)");
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
class EachContent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__whichPage = new SynchedPropertySimpleOneWayPU(params.whichPage, this, "whichPage");
        this.widthPx = display.getDefaultDisplaySync().width;
        this.__isRotate = new ObservedPropertySimplePU(false, this, "isRotate");
        this.time = new Date();
        this.__rotaAngle = new ObservedPropertySimplePU(0, this, "rotaAngle");
        this.__offsetPos = new ObservedPropertySimplePU('0', this, "offsetPos");
        this.__textOpacity = new ObservedPropertySimplePU(1, this, "textOpacity");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: EachContent_Params) {
        if (params.widthPx !== undefined) {
            this.widthPx = params.widthPx;
        }
        if (params.isRotate !== undefined) {
            this.isRotate = params.isRotate;
        }
        if (params.time !== undefined) {
            this.time = params.time;
        }
        if (params.rotaAngle !== undefined) {
            this.rotaAngle = params.rotaAngle;
        }
        if (params.offsetPos !== undefined) {
            this.offsetPos = params.offsetPos;
        }
        if (params.textOpacity !== undefined) {
            this.textOpacity = params.textOpacity;
        }
    }
    updateStateVars(params: EachContent_Params) {
        this.__whichPage.reset(params.whichPage);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__whichPage.purgeDependencyOnElmtId(rmElmtId);
        this.__isRotate.purgeDependencyOnElmtId(rmElmtId);
        this.__rotaAngle.purgeDependencyOnElmtId(rmElmtId);
        this.__offsetPos.purgeDependencyOnElmtId(rmElmtId);
        this.__textOpacity.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__whichPage.aboutToBeDeleted();
        this.__isRotate.aboutToBeDeleted();
        this.__rotaAngle.aboutToBeDeleted();
        this.__offsetPos.aboutToBeDeleted();
        this.__textOpacity.aboutToBeDeleted();
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
    private __isRotate: ObservedPropertySimplePU<boolean>;
    get isRotate() {
        return this.__isRotate.get();
    }
    set isRotate(newValue: boolean) {
        this.__isRotate.set(newValue);
    }
    private time;
    private __rotaAngle: ObservedPropertySimplePU<number>;
    get rotaAngle() {
        return this.__rotaAngle.get();
    }
    set rotaAngle(newValue: number) {
        this.__rotaAngle.set(newValue);
    }
    private __offsetPos: ObservedPropertySimplePU<string>;
    get offsetPos() {
        return this.__offsetPos.get();
    }
    set offsetPos(newValue: string) {
        this.__offsetPos.set(newValue);
    }
    private __textOpacity: ObservedPropertySimplePU<number>;
    get textOpacity() {
        return this.__textOpacity.get();
    }
    set textOpacity(newValue: number) {
        this.__textOpacity.set(newValue);
    }
    private clockAnime() {
        Context.animateTo({
            duration: 600,
            curve: Curve.FastOutSlowIn,
            delay: 0,
            iterations: 1,
            onFinish: () => {
            }
        }, () => {
            this.rotaAngle = this.isRotate ? 90 : 0;
            this.textOpacity = this.isRotate ? 0 : 1;
            this.offsetPos = this.isRotate ? `${px2vp(this.widthPx) * 0.085}vp` : '0';
        });
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("entry/src/main/ets/pages/Index.ets(89:5)");
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.whichPage == 1) {
                this.ifElseBranchUpdateFunction(0, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new Pomodoro(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 91 });
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
                        Flex.debugLine("entry/src/main/ets/pages/Index.ets(94:9)");
                        Flex.offset({
                            x: this.offsetPos,
                            y: this.offsetPos
                        });
                        Flex.width(Constants.PERCENT_MAX);
                        Flex.height(Constants.PERCENT_MAX);
                        Flex.backgroundColor({ "id": 16777269, "type": 10001, params: [], "bundleName": "com.blingcc.flipclock", "moduleName": "entry" });
                    }, Flex);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Row.create();
                        Row.debugLine("entry/src/main/ets/pages/Index.ets(99:11)");
                        Row.translate({ x: 0, y: `${px2vp(this.widthPx) * 0.1}vp` });
                    }, Row);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create(`${this.time.getFullYear().toString()} - ${this.time.getMonth() % 10 == this.time.getMonth() ? '0' :
                            ''}${this.time.getMonth().toString()} - ${this.time.getDate() % 10 == this.time.getDate() ? '0' :
                            ''}${this.time.getDate().toString()}`);
                        Text.debugLine("entry/src/main/ets/pages/Index.ets(100:13)");
                        Text.fontColor('#aaa');
                        Text.fontSize('23vp');
                        Text.opacity(this.textOpacity);
                    }, Text);
                    Text.pop();
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Image.create({ "id": 16777544, "type": 20000, params: [], "bundleName": "com.blingcc.flipclock", "moduleName": "entry" });
                        Image.debugLine("entry/src/main/ets/pages/Index.ets(106:13)");
                        Image.fillColor('#aaa');
                        Image.width('28vp');
                        Image.height('27vp');
                        Image.padding({ top: 4, left: 6 });
                        Image.onClick(() => {
                            this.isRotate = !this.isRotate;
                            this.clockAnime();
                        });
                    }, Image);
                    Row.pop();
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        __Common__.create();
                        __Common__.rotate({ x: 0, y: 0, z: 1, centerX: '50%', centerY: '50%', angle: this.rotaAngle });
                    }, __Common__);
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new PageTurningAnimation(this, {
                                    axis: [0, 0, 0, 1, 0, 0],
                                    rotaRate: -90,
                                    originalAngle: 0,
                                    timeT: enumT.HOUR
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 119 });
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
                    __Common__.pop();
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        __Common__.create();
                        __Common__.translate({ x: 0, y: `-${px2vp(this.widthPx) * 0.2}vp` });
                        __Common__.rotate({ x: 0, y: 0, z: 1, angle: this.rotaAngle });
                    }, __Common__);
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new PageTurningAnimation(this, {
                                    axis: [0, 0, 0, 1, 0, 0],
                                    rotaRate: -90,
                                    originalAngle: 0,
                                    timeT: enumT.MIN
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 126 });
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
                        __Common__.rotate({ x: 0, y: 0, z: 1, angle: this.rotaAngle });
                    }, __Common__);
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new PageTurningAnimation(this, {
                                    axis: [0, 0, 0, 1, 0, 0],
                                    rotaRate: -90,
                                    originalAngle: 0,
                                    timeT: enumT.SEC
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 134 });
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
                                let componentCall = new FlipClock(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 152 });
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
registerNamedRoute(() => new Index(undefined, {}), "", { bundleName: "com.blingcc.flipclock", moduleName: "entry", pagePath: "pages/Index", pageFullPath: "entry/src/main/ets/pages/Index", integratedHsp: "false" });
