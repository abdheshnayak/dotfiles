import GObject, { register, property } from "astal/gobject"
import { bind, Variable } from "astal"
import { shAsync } from "~/utils/fn"

@register({ GTypeName: "NightLight" })
class NightLightClass extends GObject.Object {
    static instance: NightLightClass
    static get_default() {
        if (!this.instance)
            this.instance = new NightLightClass()

        return this.instance
    }



    #temprature = Variable<number>(4000)


  @property()
    get temprature() { return this.#temprature.get() }

  set temprature(v) {
      const next = this.#temprature.get() === 4000 ? 6000 : 4000
      this.#temprature.set(next)
      this.notify("temprature")
      shAsync(`hyprctl hyprsunset temperature ${next}`)
  }


  constructor() {
      shAsync("hyprctl hyprsunset temperature 4000")
      super()
  }
}


export default function NightLightButton({ className = "" }: { className?: string }) {
    const light = NightLightClass.get_default()

    const getIcon = (v: number) => {
        return v === 4000 ? "💡" : "🧊"
    }

    return (<button
    // onClick={()=>popup.show()}
        onClick={() => {
            light.temprature = 0
        }}
        className={className}
        cursor="pointer"
    >

        <box>
            {bind(light, "temprature").as(Number).as(getIcon)}
        </box>
    </button>)
}
