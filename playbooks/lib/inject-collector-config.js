'use strict'

module.exports.register = function () {
  this.once('contentAggregated', ({ contentAggregate }) => {
    for (const { origins } of contentAggregate) {
      for (const origin of origins) {
        const ext = origin.descriptor.ext || {}
        if (!('collector' in ext && ext.collector == null)) continue
        origin.descriptor.ext = Object.assign(ext, {
          collector: {
            run: {
              command: `gradlew npmRun -Pcommand=collector`,
              local: true,
            },
            scan: {
              dir: 'build/api',
              base: 'modules/develop/attachments',
            },
          },
        })
      }
    }
  })
}
