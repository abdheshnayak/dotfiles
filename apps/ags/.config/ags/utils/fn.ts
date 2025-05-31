import { exec, execAsync  } from "astal"
import { Astal } from "astal/gtk3"

export function bash(strings: TemplateStringsArray | string, ...values: unknown[]) {
  const cmd = typeof strings === "string" ? strings : strings
    .flatMap((str, i) => str + `${values[i] ?? ""}`)
    .join("")

  return exec([cmd])
}

export async function bashAsync(strings: TemplateStringsArray | string, ...values: unknown[]) {
  const cmd = typeof strings === "string" ? strings : strings
    .flatMap((str, i) => str + `${values[i] ?? ""}`)
    .join("")

  return execAsync([cmd])
}


export function sh(strings: TemplateStringsArray | string, ...values: unknown[]) {
  const cmd = typeof strings === "string" ? strings : strings
    .flatMap((str, i) => str + `${values[i] ?? ""}`)
    .join("")

  return exec(["sh", "-c", cmd])
}

export async function shAsync(strings: TemplateStringsArray | string, ...values: unknown[]) {
  const cmd = typeof strings === "string" ? strings : strings
    .flatMap((str, i) => str + `${values[i] ?? ""}`)
    .join("")

  return execAsync(["sh", "-c", cmd])
}



export const getAnchor = ({
  xalign = 'left',
  yalign = 'top',
}:{
    xalign: 'left' | 'right' | 'center'
    yalign: 'top' | 'bottom' | 'center'
  }) => {

  const { TOP, LEFT, RIGHT,BOTTOM } = Astal.WindowAnchor

  var xAnchor 
  switch (xalign) {
    case 'left':
      xAnchor = LEFT
      break
    case 'right':
      xAnchor = RIGHT
      break
    default:
      break
  }

  var yAnchor 
  switch (yalign) {
    case 'top':
      yAnchor = TOP
      break
    case 'bottom':
      yAnchor = BOTTOM
      break
    default:
      break
  }

  if (xAnchor === undefined && yAnchor === undefined) {
    return LEFT | TOP
  }

  if (xAnchor === undefined) {
    return yAnchor as Astal.WindowAnchor
  }
  if (yAnchor === undefined) {
    return xAnchor as Astal.WindowAnchor
  }


  return (xAnchor | yAnchor) as Astal.WindowAnchor
}
