import { astalify } from "astal/gtk3";
import { Gtk } from "astal/gtk3";
import {BoxProps} from "astal/gtk3/widget";

const Box= ({
  child,
  children,
}:BoxProps)  => {
  if (children) {
    return <box>{children}</box>
  }

  return <>{child}</>
}
export default function FlexBox  ({
  child,
  children,
  className = "",
  gap = 0,
  direction = "row",
}: BoxProps & {
    className?: string
    gap?: number
    direction?: "row" | "column"
  })  {
  const getGap = () => {
    switch (direction) {
      case "row":
        return `background: red; padding: 0;`
      default:
        return `min-height: ${gap}px;`
    }
  }

  const getDirection = () => {
    switch (direction) {
      case "row":
        return Gtk.Orientation.HORIZONTAL
      default:
        return Gtk.Orientation.VERTICAL
    }
  }

  if ( Array.isArray(children) ) {
    return <box className={className} orientation={getDirection()} > 
      {children.map(c => <box orientation={getDirection()}> <box css={getGap()}/>  <box>{c}</box> <box css={getGap()}/> </box>)} 
    </box>
  }

  return <> {child} </>
};
