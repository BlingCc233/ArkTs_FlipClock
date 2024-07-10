if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface EachContent_Params {
    whichPage?: number;
    widthPx?: number;
}
interface Index_Params {
    tabArray?: Array<TabItem>;
    currentIndex?: number;
}
import { FlipClock } from "@bundle:ohos.samples.etsclock/entry/ets/pages/FlipClock";
import Constants from "@bundle:ohos.samples.etsclock/entry/ets/common/CommonConstants";
import display from "@ohos:display";
import hilog from "@ohos:hilog";
import { initTabData } from "@bundle:ohos.samples.etsclock/entry/ets/viewmodel/TabViewModel";
import type { TabItem } from '../viewmodel/TabItem';
import { Pomodoro } from "@bundle:ohos.samples.etsclock/entry/ets/pages/Pomodoro";
import { PageTurningAnimation, enumT } from "@bundle:ohos.samples.etsclock/entry/ets/pages/PageTurningAnimation";
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
            Column.width(Constants.PERCENT_MAX);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(name);
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
            Tabs.barWidth(Constants.PERCENT_MAX);
            Tabs.barHeight('52vp');
            Tabs.padding({
                top: '30vp'
            });
            Tabs.width(Constants.PERCENT_MAX);
            Tabs.height(Constants.PERCENT_MAX);
            Tabs.backgroundColor({ "id": 16777420, "type": 10001, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
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
                                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 40 });
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
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.whichPage == 1) {
                this.ifElseBranchUpdateFunction(0, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new Pomodoro(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 72 });
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
                        Flex.width(Constants.PERCENT_MAX);
                        Flex.height(Constants.PERCENT_MAX);
                        Flex.backgroundColor({ "id": 16777420, "type": 10001, params: [], "bundleName": "ohos.samples.etsclock", "moduleName": "entry" });
                    }, Flex);
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new PageTurningAnimation(this, {
                                    axis: [0, 0, 0, 1, 0, 0],
                                    rotaRate: -90,
                                    originalAngle: 0,
                                    timeT: enumT.HOUR
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 80 });
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
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 86 });
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
                                }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 93 });
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
                                let componentCall = new FlipClock(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 106 });
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
registerNamedRoute(() => new Index(undefined, {}), "", { bundleName: "ohos.samples.etsclock", moduleName: "entry", pagePath: "pages/Index", pageFullPath: "entry/src/main/ets/pages/Index", integratedHsp: "false" });
