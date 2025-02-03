import { bind } from "astal"
import Tray from "gi://AstalTray"

const getTrayIcon = (title: string) => {
  switch (title) {
    case "blueman":
      return "bluetooth-symbolic"
    case "TelegramDesktop":
      return "telegram-desktop-symbolic"
    case "obs":
      return "obs-symbolic"
    default:
      console.error("icon not found", title)
      return "question-symbolic"
  }
}

export default function SysTray({className=""}:{ className?: string }) {
  const tray = Tray.get_default()

  return <box className={"SysTray " + className} visible={bind(tray, "items").as(a => a.length > 0)}>
    {bind(tray, "items").as(items => items.map((item) => 
    {
        if (item.title==="blueman") return <box></box>

        return (
          <button
            cursor="pointer"
            visible={bind(item, "title").as(Boolean)}
            tooltipMarkup={bind(item, "tooltipMarkup")}
            className="iconOnly"
            // usePopover={false}
            // actionGroup={bind(item, "actionGroup").as(ag => ["dbusmenu", ag])}
            // menuModel={bind(item, "menuModel")}
            onClick={() => item.activate(0,0)}
          >
            <icon icon={getTrayIcon(bind(item, "title").get())} />
          </button>

        )
      }
    ))}
  </box>
}
