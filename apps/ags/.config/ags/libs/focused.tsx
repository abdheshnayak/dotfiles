
import { bind } from "astal"
import Hyprland from "gi://AstalHyprland"

export default function FocusedClient() {
    const hypr = Hyprland.get_default()
    const focused = bind(hypr, "focusedClient")

    return <box
        css={"margin: 0 0.5rem;"}
        visible={focused.as(Boolean)}>
        {focused.as(client => (
            client && <label label={bind(client, "initial_title").as(String)} />
        ))}
    </box>
}
