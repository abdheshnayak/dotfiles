import { bind } from "astal"
import B from "gi://AstalBluetooth"
import { shAsync } from "~/utils/fn"


export default function Bluetooth({ className = "" }: { className?: string }) {
    const bluetooth = B.get_default()
    return <button
        cursor="pointer"
        className={"iconOnly " + className}
        onClick={() => shAsync`blueman-manager`}
        tooltipText={bind(bluetooth, "isConnected")
            .as(connected => connected ? "connected" : "not connected")}
    >
        <box css={bind(bluetooth, "isPowered")
            .as(powered => powered ? "color:skyblue" : "color: tomato")}>
            {bind(bluetooth, "isConnected")
                .as(
                    connected => connected ?
                        <icon icon="bluetooth-symbolic" /> :
                        <icon icon="bluetooth-disabled-symbolic" />,
                )}
        </box>
    </button>
}
