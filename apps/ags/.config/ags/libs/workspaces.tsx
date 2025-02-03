import { bind } from "astal"
import Hyprland from "gi://AstalHyprland"

export default function Workspaces() {
  const hypr = Hyprland.get_default()


  return <box className="Workspaces">
    {bind(hypr, "workspaces").as(wss => wss
      .filter(ws => !(ws.id >= -99 && ws.id <= -2)) // filter out special workspaces
      .sort((a, b) => a.id - b.id)
      .map(ws => (
        <button
          cursor="pointer"
          className={bind(hypr, "focusedWorkspace").as(fw =>
            ws === fw ? "focused" : "")}
          onClicked={() => ws.focus()}>
          <label className={"barItem"} label={ws.id.toString()} />
        </button>
      ))
    )}
  </box>
}
