import { Variable } from "astal"
import { sh } from "~/utils/fn"

// am pm
export default function Ram({ className = "" }: { format?: string, className?: string }) {
    const ram = Variable<string>("").poll(1000, () =>
    sh`~/.local/bin/utils/memory`!,
    )

    // const resp =sh`clock`

    return <box className={className}>
        <icon css={"color: #6bbf59"} icon={"ram-memory-symbolic"} />
        <label
            onDestroy={() => ram.drop()}
            label={ram()}
            // label={resp}
        />
    </box>
}
