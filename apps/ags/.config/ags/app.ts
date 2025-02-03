
import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/bar"

App.start({
    icons: "./icons",
    css: style,
    instanceName: "tsapp",
    requestHandler(request, res) {
        print(request)
        res("ok")
    },
    main: () => {
        App.get_monitors().map(Bar)
    // App.get_monitors().map(TimeBar)
    },
})
