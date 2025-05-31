import { bind } from "astal"
import { Gdk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"

export default function Workspaces({ monitor }: { monitor: Gdk.Monitor }) {
    const hypr = Hyprland.get_default()


    return <box className="Workspaces">
        {bind(hypr, "workspaces").as(wss => wss
            .filter(ws => !(ws.id >= -99 && ws.id <= -2) && monitor.get_model() === ws.get_monitor().get_model())
            .sort((a, b) => a.id - b.id)
            .map(ws => (
                <button
                    // css={bind(ws, "monitor").as(mntr => `color: ${stringToColor(mntr.get_name().toString())}`)}
                    cursor="pointer"
                    className={bind(hypr, "focusedWorkspace").as(fw =>
                        ws === fw ? "focused" : "")}
                    onClicked={() => ws.focus()}>
                    <label className={"barItem"} label={ws.id.toString()} />
                </button>
            )),
        )}
    </box>
}
