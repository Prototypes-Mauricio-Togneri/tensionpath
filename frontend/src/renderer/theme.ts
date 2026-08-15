/**
 * Canvas colours, read from the design tokens declared on :root in
 * src/assets/styles.css.
 * A canvas cannot resolve var(), so the tokens are read once at startup rather
 * than copied into the renderer as literals — docs/ui.md stays the single
 * place colour is decided, for the battlefield as much as for the HUD.
 */
export type RendererTheme = {
  background: string
  backgroundDeep: string
  border: string
  text: string
  textRgb: string
  accent: string
  accentRgb: string
  allyRgb: string
  enemyRgb: string
}

/**
 * Reads one custom property off the document root.
 * @param styles - Computed style of the root element
 * @param token - Custom property name, including the leading dashes
 * @returns The declared value, trimmed
 */
function readToken(styles: CSSStyleDeclaration, token: string): string {
  return styles.getPropertyValue(token).trim()
}

/**
 * Snapshots the theme tokens for the canvas.
 * @returns Colours ready to assign to fillStyle and strokeStyle
 */
export function readTheme(): RendererTheme {
  const styles = getComputedStyle(document.documentElement)

  return {
    background: readToken(styles, '--color-bg'),
    backgroundDeep: readToken(styles, '--color-bg-deep'),
    border: readToken(styles, '--color-border'),
    text: readToken(styles, '--color-text'),
    textRgb: readToken(styles, '--color-text-rgb'),
    accent: readToken(styles, '--color-accent'),
    accentRgb: readToken(styles, '--color-accent-rgb'),
    allyRgb: readToken(styles, '--color-ally-rgb'),
    enemyRgb: readToken(styles, '--color-enemy-rgb'),
  }
}

/**
 * Builds a canvas colour from one of the -rgb design tokens.
 * @param triplet - Comma-separated channels, as the token declares them
 * @param alpha - Opacity between 0 and 1
 * @returns An rgba() string, the only colour format docs/ui.md allows
 */
export function withAlpha(triplet: string, alpha: number): string {
  return `rgba(${triplet}, ${alpha})`
}
