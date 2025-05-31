import { GLib, Variable } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk3"
import Time from "~/libs/time"
import { getAnchor } from "~/utils/fn"

export default function TimeBar(monitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT,BOTTOM } = Astal.WindowAnchor

  const app = Astal.Application.get_default()

  const  format = "%I:%M:%S %p"

  const time = Variable<string>("").poll(1000, () =>
    GLib.DateTime.new_now_local().format(format)!
    // sh`clock`!
  )

  return <window
    name="timeBar"
    className="TimeBar"
    // gdkmonitor={monitor}
    visible={true}
    exclusivity={Astal.Exclusivity.IGNORE}
    events={undefined}
    // @ts-ignore 
    application={app}
    anchor={getAnchor({
      xalign: 'center',
      yalign: 'bottom',
    })}
  >
    <label
      onDestroy={() => time.drop()}
      label={time()}
    />
  </window>
}
