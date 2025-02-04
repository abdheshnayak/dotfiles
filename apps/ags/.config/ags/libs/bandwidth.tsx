import { bind, Variable } from "astal"
import Network from "gi://AstalNetwork"
import { sh } from "~/utils/fn"

const b1024 = BigInt(1024)

const stats = () => {
    try {
        const resp = sh`ifstat wlo1 1 1 -j -p`!
        const jesp = JSON.parse(resp)
        return jesp
    } catch (e) {
        return { "kernel": { "wlo1": { "rx_bytes": 0, "tx_bytes": 0 } } }
    }
}

const getParsed = (bytes: bigint) => {
    const units = ["k", "m", "g", "t", "p", "e", "z", "y"]
    let i = 0
    bytes = bytes / b1024
    while (bytes >= b1024) {
        bytes /= b1024
        i++
    }
    return `${Math.floor(Number(bytes))} ${units[i]}`
}

let oldBandwidth = stats()
const getBandwidth = () => {
    try {
        const newBandwidth = stats()
        const downDiff = newBandwidth.kernel.wlo1.rx_bytes - oldBandwidth.kernel.wlo1.rx_bytes
        const upDiff = newBandwidth.kernel.wlo1.tx_bytes - oldBandwidth.kernel.wlo1.tx_bytes

        oldBandwidth = newBandwidth
        return { down: downDiff, up: upDiff }
    } catch (e) {
        console.log(e)
        return { down: 0, up: 0 }
    }
}

export default function Bandwidth({ className = "" }: { format?: string, className?: string }) {
    const network = Network.get_default()
    const out = Variable<string>("").poll(1000, () => {
        const op = getBandwidth()
        return `${getParsed(BigInt(op.down))} ↓ ${getParsed(BigInt(op.up))} ↑`
    },

    )

    // const resp =sh`clock`

    return <label
        visible={bind(network.wifi, "ssid").as(Boolean)}
        className={className}
        css={"min-width:140px;"}
        onDestroy={() => out.drop()}
        label={out()}
    />
}

export const bandwidth = () => {
    const out = Variable<string>("").poll(1000, () => {
        const op = getBandwidth()
        return `${getParsed(BigInt(op.down))} ↓ ${getParsed(BigInt(op.up))} ↑`
    },

    )

    return out()
}
