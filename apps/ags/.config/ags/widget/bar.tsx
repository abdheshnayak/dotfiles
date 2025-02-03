import { Astal, Gtk, Gdk } from "astal/gtk3"
import Bandwidth from "~/libs/bandwidth"
import BatteryLevel from "~/libs/battery"
import Bluetooth from "~/libs/bluetooth"
import Brightness from "~/libs/brighness"
import FocusedClient from "~/libs/focused"
import PowerButton from "~/libs/powerbutton"
import Ram from "~/libs/ram"
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
    // gdkmonitor={monitor}
    visible={true}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    // @ts-ignore 
    application={app}
    anchor={TOP | LEFT | RIGHT}>
    <centerbox>
      <box hexpand 
        halign={Gtk.Align.START}
      >
        <Workspaces />
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
