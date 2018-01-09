// @flow

import { NativeModules } from 'react-native'

const {AppMetrica} = NativeModules

export default {

  /**
   * Sends a custom event message with optional parameters.
   * @param {string} message
   * @param {object} [params=null]
   */
  reportEvent (message: string, params: ?Object = null) {
    AppMetrica.reportEvent(message, params)
  },

  /**
   * Sends an error message with optional parameters.
   * @param {string} message
   * @param {object} [params=null]
   */
  reportError (message: string, params: ?Object = null) {
    AppMetrica.reportError(message, params)
  }
}
