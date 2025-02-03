import { bind } from "astal"
import Battery from "gi://AstalBattery"

export default function BatteryLevel({className=""}:{ className?: string }) {
  const bat = Battery.get_default()

  return <box className={className}
    visible={bind(bat, "isPresent")}>
    <icon icon={bind(bat, "batteryIconName")} />
    <label label={bind(bat, "percentage").as(p =>
      `${Math.floor(p * 100)}%`
    )} />
  </box>
}
