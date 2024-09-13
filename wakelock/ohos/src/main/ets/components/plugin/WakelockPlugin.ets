import {
  AbilityAware,
  AbilityPluginBinding,
  FlutterPlugin,
  FlutterPluginBinding,
} from '@ohos/flutter_ohos';

import { WakelockApi, ToggleMessage, IsEnabledMessage } from './Messages'
import { Context } from '@ohos.abilityAccessCtrl';
import runningLock from '@ohos.runningLock';
import window from '@ohos.window';


/** WakelockPlugin **/
export default class WakelockPlugin extends WakelockApi implements FlutterPlugin, AbilityAware {
  private context: Context | null = null;
  private lock: runningLock.RunningLock | null = null;

  onAttachedToAbility(binding: AbilityPluginBinding): void {
    this.context = binding.getAbility().context;
  }

  onDetachedFromAbility(): void {
    this.lock?.unhold();
    this.lock = null;
    this.context = null;
  }

  getUniqueClassName(): string {
    return "WakelockPlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    WakelockApi.setup(binding.getBinaryMessenger(), this)
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    WakelockApi.setup(binding.getBinaryMessenger(), null)
  }

  async toggle(msg: ToggleMessage): Promise<void> {
    try {
      if (this.context != null) {
        let windowClass = await window.getLastWindow(this.context);
        await windowClass.setWindowKeepScreenOn(msg.getEnable());
      }
    } catch (err) {
      console.error('toggle failed, err: ' + err);
    }
  }

  async isEnabled(): Promise<IsEnabledMessage> {
    let isEnabled = false;
    try {
      if (this.context != null) {
        let windowClass = await window.getLastWindow(this.context);
        isEnabled = isEnabled || await windowClass.getWindowProperties().isKeepScreenOn;
      }
    } catch (err) {
      console.error('toggle failed, err: ' + err);
    }
    return new IsEnabledMessage(isEnabled);
  }
}