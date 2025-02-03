import GObject, { register, property } from "astal/gobject"
import { monitorFile, readFileAsync } from "astal/file"
import { bind } from "astal"
import { sh, shAsync } from "~/utils/fn"

const get = (args: string) => Number(sh`brightnessctl ${args}`)
const screen = sh`ls -w1 /sys/class/backlight | head -1`
const kbd = sh`ls -w1 /sys/class/leds | head -1`

@register({ GTypeName: "Brightness" })
class BrightnessClass extends GObject.Object {
  static instance: BrightnessClass
  static get_default() {
    if (!this.instance)
      this.instance = new BrightnessClass()

    return this.instance
  }

  #kbdMax = get(`--device ${kbd} max`)
  #kbd = get(`--device ${kbd} get`)
  #screenMax = get("max")
  #screen = get("get") / (get("max") || 1)

  @property(Number)
  get kbd() { return this.#kbd }

  set kbd(value) {
    if (value < 0 || value > this.#kbdMax)
      return

    shAsync(`brightnessctl -d ${kbd} s ${value} -q`).then(() => {
      this.#kbd = value
      this.notify("kbd")
    })
  }

  @property(Number)
  get screen() { return this.#screen }

  set screen(percent) {
    if (percent < 0)
      percent = 0

    if (percent > 1)
      percent = 1

    shAsync(`brightnessctl set ${Math.floor(percent * 100)}% -q`).then(() => {
      this.#screen = percent
      this.notify("screen")
    })
  }

  constructor() {
    super()

    const screenPath = `/sys/class/backlight/${screen}/brightness`
    const kbdPath = `/sys/class/leds/${kbd}/brightness`

    monitorFile(screenPath, async f => {
      const v = await readFileAsync(f)
      this.#screen = Number(v) / this.#screenMax
      this.notify("screen")
    })

    monitorFile(kbdPath, async f => {
      const v = await readFileAsync(f)
      this.#kbd = Number(v) / this.#kbdMax
      this.notify("kbd")
    })
  }
}


export default function BrightnessSlider({className=""}:{ className?: string }) {
  const brightness = BrightnessClass.get_default()

  // const popup = (
  //   <Popup
  //     marginTop={36}
  //     marginRight={60}
  //     valign={Gtk.Align.START}
  //     halign={Gtk.Align.END}
  //
  //   ><box css={"min-width:200px; min-height:200px; background:red;"}>
  //       <button onClick={()=>popup.hide()}>hide me</button>
  //     </box></Popup>
  // )

  return (<button 
    // onClick={()=>popup.show()}
    className={className}
    cursor="pointer"  
    onScroll={(_,{delta_y}) => {
    const nv = brightness.screen + delta_y/50
    if (nv >= 0.01 && nv <= 1.01){
      brightness.screen = nv
    }
  }}>
    <box>
      <icon icon={"light-mode-symbolic"} />
      <label label={bind(brightness, "screen").as(v => `${Math.floor(v*100)}%`)} />
    </box>
  </button>)
}
