
import { sh } from "~/utils/fn";

export default function PowerButton() {
  return <button
    cursor="pointer"
    className="iconOnly barItem"
    onClicked={() => sh("wlogout")}
  >
    <icon icon="power-symbolic"/>
  </button>
}
