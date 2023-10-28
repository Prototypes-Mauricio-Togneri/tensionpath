import {Context, registerCallable} from '../../index'

export const matchmakingCallable = registerCallable(async (_: any, __: Context) => {
  return {
    roomId: 'foo',
  }
})
