import UIAbility from "@ohos:app.ability.UIAbility";
import type AbilityConstant from "@ohos:app.ability.AbilityConstant";
import type Want from "@ohos:app.ability.Want";
import hilog from "@ohos:hilog";
import type window from "@ohos:window";
import type { BusinessError } from "@ohos:base";
import preferences from "@ohos:data.preferences";
let dataPreferences: preferences.Preferences | null = null;
export default class EntryAbility extends UIAbility {
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    }
    onDestroy(): void {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    }
    onWindowStageCreate(windowStage: window.WindowStage): void {
        preferences.getPreferences(this.context, 'myStore', (err: BusinessError, val: preferences.Preferences) => {
            if (err) {
                console.error("Failed to get preferences. code =" + err.code + ", message =" + err.message);
                return;
            }
            dataPreferences = val;
            console.info("Succeeded in getting preferences.");
        });
        console.info('onWindowStageCreate');
        let windowClass: window.Window | undefined = undefined;
        windowStage.getMainWindow((err: BusinessError, data) => {
            const errCode: number = err.code;
            if (errCode) {
                console.error(`Failed to obtain the main window. Cause code: ${err.code}, message: ${err.message}`);
                return;
            }
            windowClass = data;
            let isLayoutFullScreen = true;
            try {
                let promise = windowClass.setSpecificSystemBarEnabled('navigationIndicator', false);
                promise.then(() => {
                    console.info('Succeeded in setting the system bar to be invisible.');
                }).catch((err: BusinessError) => {
                    console.error(`Failed to set the system bar to be invisible. Cause code: ${err.code}, message: ${err.message}`);
                });
            }
            catch (exception) {
                console.error(`Failed to set the system bar to be invisible. Cause code: ${exception.code}, message: ${exception.message}`);
            }
            try {
                let promise = windowClass.setWindowLayoutFullScreen(isLayoutFullScreen);
                promise.then(() => {
                    console.info('Succeeded in setting the window layout to full-screen mode.');
                }).catch((err: BusinessError) => {
                    console.error(`Failed to set the window layout to full-screen mode. Cause code: ${err.code}, message: ${err.message}`);
                });
            }
            catch (exception) {
                console.error(`Failed to set the window layout to full-screen mode. Cause code: ${exception.code}, message: ${exception.message}`);
            }
        });
        windowStage.loadContent('pages/Index', (err) => {
            if (err.code) {
                hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
                return;
            }
            hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
        });
    }
    // onWindowStageCreate(windowStage: window.WindowStage): void {
    //   // Main window is created, set main page for this ability
    //   hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    //
    //   windowStage.loadContent('pages/Index', (err) => {
    //     if (err.code) {
    //       hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
    //       return;
    //     }
    //
    //     hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    //   });
    // }
    onWindowStageDestroy(): void {
        // Main window is destroyed, release UI related resources
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
    }
    onForeground(): void {
        // Ability has brought to foreground
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
    }
    onBackground(): void {
        // Ability has back to background
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
    }
}
