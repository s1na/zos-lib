'use strict';

process.env.NODE_ENV = 'test'

require('chai')
  .use(require('@zos/core').assertions)
  .should()
