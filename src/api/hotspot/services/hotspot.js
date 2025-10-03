'use strict';

/**
 * hotspot service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::hotspot.hotspot');
