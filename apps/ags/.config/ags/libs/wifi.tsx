
import { bind } from "astal"
import Network from "gi://AstalNetwork"
import { shAsync } from "~/utils/fn"
import { bandwidth } from "./bandwidth"

const formatSsid = (ssid: string) => {
  if (ssid=="null") {
    return ""
  }

  if (ssid && ssid.length > 15) {
    // make 15 but use first 3 ... and last 3 ...
    return `${ssid.slice(0, 4)}...${ssid.slice(-5)}`
  }

  return ssid
}

export default function Wifi({className=""}:{ className?: string }) {
  const network = Network.get_default()
  const wifi = bind(network, "wifi")


  return <button
    className={className}
    cursor="pointer"
    onClick={() => shAsync`kitty --class dotfiles-floating -e nmtui`}
    visible={wifi.as(Boolean)}>
    {wifi.as(wifi => {
      if (!wifi) return <icon icon="question-symbolic" />

      return (
        <box>
          <icon icon={bind(network.wifi,"iconName")}/>
          {
bind(network.wifi,"activeConnection").as(Boolean).as(connected=> connected? <box>
          <label css={"font-size:0.75em;"} label={bind(wifi, "ssid").as(String).as(ssid=>formatSsid(ssid))} />
          <label css={"font-size:0.75em; min-width:1.5em"} label="|" />
          <label css={"font-size:0.75em; min-width:7.2em"} label={bandwidth()} />
            </box> : "")
          }
        </box>
      )
    })}
  </button>
}
