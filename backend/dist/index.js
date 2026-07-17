"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("./instrument");
const Sentry = __importStar(require("@sentry/node"));
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const compression_1 = __importDefault(require("compression"));
const client_1 = require("@prisma/client");
const cache_1 = require("./core/cache");
const app = (0, express_1.default)();
const prisma = new client_1.PrismaClient();
const port = process.env.PORT || 3000;
const request_context_middleware_1 = require("./middleware/request-context.middleware");
const logging_middleware_1 = require("./middleware/logging.middleware");
const error_middleware_1 = require("./middleware/error.middleware");
const logger_1 = require("./core/logger");
app.use((0, cors_1.default)({
    exposedHeaders: ['Content-Range', 'X-Total-Count'],
}));
app.use((0, compression_1.default)());
app.use(express_1.default.json());
app.use(request_context_middleware_1.requestContextMiddleware);
app.use(logging_middleware_1.loggingMiddleware);
const ai_routes_1 = __importDefault(require("./modules/ai/ai.routes"));
const booking_routes_1 = __importDefault(require("./modules/booking/booking.routes"));
const admin_routes_1 = __importDefault(require("./admin.routes"));
const auth_routes_1 = __importDefault(require("./auth.routes"));
app.use('/api/auth', auth_routes_1.default);
app.use('/api/ai', ai_routes_1.default);
app.use('/api/bookings', booking_routes_1.default);
app.use('/api/admin', admin_routes_1.default);
app.get('/', (req, res) => {
    res.send('BusZ Backend API is running!');
});
// Public API for Flutter App
app.get('/api/trips', async (req, res, next) => {
    try {
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 20;
        const skip = (page - 1) * limit;
        const cacheKey = `trips_page_${page}_limit_${limit}`;
        const result = await (0, cache_1.getCached)(cacheKey, async () => {
            const [data, total] = await Promise.all([
                prisma.tripSchedule.findMany({
                    skip,
                    take: limit,
                    include: {
                        trip: {
                            include: {
                                busAgent: true,
                                route: {
                                    include: {
                                        departureCity: true,
                                        arrivalCity: true,
                                    }
                                }
                            }
                        },
                        prices: true,
                        checkpoints: { include: { station: true } }
                    }
                }),
                prisma.tripSchedule.count()
            ]);
            return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
        }, 300);
        res.json(result);
    }
    catch (error) {
        next(error);
    }
});
app.get('/api/promotions', async (req, res, next) => {
    try {
        const promotions = await (0, cache_1.getCached)('promotions', async () => {
            return prisma.promotion.findMany({
                where: { isActive: true },
                orderBy: { createdAt: 'desc' }
            });
        }, 300);
        res.json(promotions);
    }
    catch (error) {
        next(error);
    }
});
Sentry.setupExpressErrorHandler(app);
app.use(error_middleware_1.errorMiddleware);
if (require.main === module) {
    app.listen(port, () => {
        logger_1.logger.info(`Server is running on port ${port}`);
    });
}
exports.default = app;
