import { Variable, GLib  } from "astal"
import { sh } from "~/utils/fn"

// am pm
export default function Ram({ className = "" }: { format?: string, className?: string }) {
  const ram = Variable<string>("").poll(1000, () =>
    sh`memory`!
  )

  // const resp =sh`clock`

  return <box className={className}>
    <icon icon={"ram-memory-symbolic"} />
<label
    onDestroy={() => ram.drop()}
    label={ram()}
    // label={resp}
  />
  </box>
}
