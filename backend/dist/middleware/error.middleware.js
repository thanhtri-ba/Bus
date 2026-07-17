"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.errorMiddleware = errorMiddleware;
const logger_1 = require("../core/logger");
const async_context_1 = require("../core/async-context");
function errorMiddleware(err, req, res, next) {
    const context = (0, async_context_1.getRequestContext)();
    logger_1.logger.error('request_failed', {
        errorName: err.name,
        errorMessage: err.message,
        stack: process.env.NODE_ENV === 'production' ? undefined : err.stack,
    });
    res.status(err.status || 500).json({
        message: err.status < 500 ? err.message : 'Internal server error',
        requestId: context?.requestId,
    });
}
