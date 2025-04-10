import { Astal, Gtk, Gdk } from "astal/gtk3"
import BatteryLevel from "~/libs/battery"
import Bluetooth from "~/libs/bluetooth"
import Brightness from "~/libs/brighness"
import FocusedClient from "~/libs/focused"
import NightLightButton from "~/libs/night"
import PowerButton from "~/libs/powerbutton"
import Ram from "~/libs/ram"
import ThemeButton from "~/libs/theme"
import Time from "~/libs/time"
import SysTray from "~/libs/tray"
import AudioSlider from "~/libs/volume"
import Wifi from "~/libs/wifi"
import Workspaces from "~/libs/workspaces"

export default function Bar(monitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    const app = Astal.Application.get_default()

    return <window
        name="bar"
        className="Bar"
        gdkmonitor={monitor}
        visible={true}
        // layer={Astal.Layer.TOP}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        // @ts-ignore
        application={app}
        anchor={TOP | LEFT | RIGHT}>
        <centerbox>
            <box hexpand
                halign={Gtk.Align.START}
            >
                <Workspaces monitor={monitor} />
                <FocusedClient />
            </box>
            <box
                halign={Gtk.Align.CENTER}
            >
                <Time className="barItem" />
                <SysTray className="barItem" />

                {/* <Media /> */}
            </box>
            <box hexpand halign={Gtk.Align.END} >
                <NightLightButton />
                <ThemeButton />
                <Ram className="barItem" />
                {/* <Bandwidth className="barItem" /> */}
                <Wifi className="barItem" />
                <AudioSlider className="barItem" />
                <Brightness className="barItem" />
                <BatteryLevel className="barItem" />
                <Bluetooth className="barItem" />

                <PowerButton />
            </box>
        </centerbox>
    </window>
}
