/**
 * Localization module. Detects the browser language and resolves
 * to a supported locale, defaulting to English.
 */

import {LOCALIZED_EN} from '@/i18n/en'

// Supported locale map (language code → string table)
const LOCALES: Record<string, Record<string, string>> = {
  en: LOCALIZED_EN,
}

const browserLang = navigator.language.slice(0, 2) // Two-letter language code
const resolvedLang = browserLang in LOCALES ? browserLang : 'en' // Resolved locale (falls back to English)
const strings = LOCALES[resolvedLang] ?? LOCALIZED_EN // Active string table

// Set HTML lang attribute for accessibility
document.documentElement.lang = resolvedLang

/**
 * Returns the localized string for the given key.
 * Supports positional parameters: t('key', 'val0', 'val1') replaces {0}, {1}, etc.
 * @param key - Dot-notation i18n key (e.g. 'screen.home.play')
 * @param params - Positional replacement values
 * @returns Localized string, or the key itself when it is missing
 */
export const t = (key: string, ...params: string[]): string => {
  const str = strings[key] ?? key
  if (params.length === 0) {
    return str
  }
  return str.replace(/\{(\d+)\}/g, (_: string, index: string) => params[Number(index)] ?? '')
}
