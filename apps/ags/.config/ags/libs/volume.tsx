import { bind } from "astal"
import Wp from "gi://AstalWp"
import { shAsync } from "~/utils/fn"

export default function AudioSlider({ className = "" }: { className?: string }) {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!
    return <button
        className={className}
        cursor="pointer"
        onClick={() => shAsync`pavucontrol`}
        onScroll={(_, { delta_y }) => {
            const nv = speaker.volume + delta_y / 50
            if (nv >= 0 && nv <= 1.01)
                speaker.volume = nv
        }}>
        <box>
            <icon css={"color: #6bbf59"} icon={bind(speaker, "volumeIcon")} />
            <label label={bind(speaker, "volume").as(v => `${Math.floor(v * 100)}%`)} />
        </box>

        {/* <slider */}
        {/*   hexpand */}
        {/*   onDragged={({ value }) => speaker.volume = value} */}
        {/*   value={bind(speaker, "volume")} */}
        {/* /> */}
    </button>
}
