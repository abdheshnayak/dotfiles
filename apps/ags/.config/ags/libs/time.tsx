import { Variable, GLib  } from "astal"
import { sh } from "~/utils/fn"

// am pm
export default function Time({ format = "%e %h %a %I:%M:%S %p", className = "" }: { format?: string, className?: string }) {
  const time = Variable<string>("").poll(1000, () =>
    GLib.DateTime.new_now_local().format(format)!
  )

  // const resp =sh`clock`

  return <label
    className={className}
    onDestroy={() => time.drop()}
    label={time()}
    // label={resp}
  />
}
