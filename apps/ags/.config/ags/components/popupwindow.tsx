
import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import { WindowProps } from "astal/gtk3/widget";

function Padding({ winName }: { winName: string }) {
  return (
    <button
      className={"button-padding"}
      canFocus={false}
      onClicked={() => App.toggle_window(winName)}
      hexpand
      vexpand
    />
  );
}

function Layout({
  child,
  name,
  position,
}: {
  child?: JSX.Element;
  name: string;
  position: string;
}) {
  switch (position) {
    case "top":
      return (
        <box vertical>
          {child}
          <Padding winName={name} />
        </box>
      );
    case "top_center":
      return (
        <box>
          <Padding winName={name} />
          <box vertical hexpand={false}>
            {child}
            <Padding winName={name} />
          </box>
          <Padding winName={name} />
        </box>
      );
    case "top_left":
      return (
        <box>
          <box vertical hexpand={false}>
            {child}
            <Padding winName={name} />
          </box>
          <Padding winName={name} />
        </box>
      );
    case "top_right":
      return (
        <box>
          <Padding winName={name} />
          <box vertical hexpand={false}>
            {child}
            <Padding winName={name} />
          </box>
        </box>
      );
    case "bottom":
      return (
        <box vertical>
          <Padding winName={name} />
          {child}
        </box>
      );
    case "bottom_center":
      return (
        <box>
          <Padding winName={name} />
          <box vertical hexpand={false}>
            <Padding winName={name} />
            {child}
          </box>
          <Padding winName={name} />
        </box>
      );
    case "bottom_left":
      return (
        <box>
          <box vertical hexpand={false}>
            <Padding winName={name} />
            {child}
          </box>
          <Padding winName={name} />
        </box>
      );
    case "bottom_right":
      return (
        <box>
          <Padding winName={name} />
          <box vertical hexpand={false}>
            <Padding winName={name} />
            {child}
          </box>
        </box>
      );
    //default to center
    default:
      return (
        <centerbox>
          <Padding winName={name} />
          <centerbox orientation={Gtk.Orientation.VERTICAL}>
            <Padding winName={name} />
            {child}
            <Padding winName={name} />
          </centerbox>
          <Padding winName={name} />
        </centerbox>
      );
  }
}

type PopupWindowProps = WindowProps & {
  child?: unknown;
  name: string;
  visible?: boolean;
  animation?: string;
  layout?: string;
};

export default function PopupWindow({
  child,
  name,
  visible,
  layout = "center",
  ...props
}: PopupWindowProps) {
  const { TOP, RIGHT, BOTTOM, LEFT } = Astal.WindowAnchor;

  const app = Astal.Application.get_default()

  visible = true
  return (
    <window
      visible={visible}
      name={name}
      namespace={name}
      layer={Astal.Layer.TOP}
      // keymode={Astal.Keymode.EXCLUSIVE}
      // @ts-ignore
      application={app}
      anchor={TOP | RIGHT}
      // onKeyPressede={(_, keyval) => {
      //   if (keyval === Gdk.KEY_Escape) {
      //     visible = false
      //   }
      // }}
      {...props}
    >
      <Layout name={name} position={layout}>
        {child}
      </Layout>
    </window>
  );
}
