import GObject, { register, property } from "astal/gobject"
import { bind, Variable } from "astal"
import { sh, shAsync } from "~/utils/fn"

const get = () => sh`gsettings get org.gnome.desktop.interface color-scheme`

@register({ GTypeName: "Theme" })
class ThemeClass extends GObject.Object {
    static instance: ThemeClass
    static get_default() {
        if (!this.instance)
            this.instance = new ThemeClass()

        return this.instance
    }

    #theme = get()

  @property()
    get theme() { return this.#theme }

  set theme(v) {
      const next = get() === "'prefer-light'" ? "prefer-dark" : "prefer-light"

      shAsync(`gsettings set org.gnome.desktop.interface color-scheme ${next} && settheme`).then(() => {
          this.#theme = get()
          this.notify("theme")
      })
  }


  constructor() {
      super()

      const out = Variable<string>("").poll(1000, () => {
          const resp = get()
          this.#theme = resp
          this.notify("theme")
          return resp
      },


      )

      out()
  }
}


export default function ThemeButton({ className = "" }: { className?: string }) {
    const theme = ThemeClass.get_default()

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

    const getIcon = (v: string) => {
        return v === "'prefer-dark'" ? "🌛" : "🌞"
    // 🌙
    }

    return (<button
    // onClick={()=>popup.show()}
        onClick={() => {
            theme.theme = "prefer-light"
        }}
        className={className}
        cursor="pointer"
    >

        <box>
            {bind(theme, "theme").as(String).as(getIcon)}
        </box>
    </button>)
}
