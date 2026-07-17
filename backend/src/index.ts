import './instrument';
import * as Sentry from '@sentry/node';
import express from 'express';
import cors from 'cors';
import compression from 'compression';
import { PrismaClient } from '@prisma/client';
import { getCached } from './core/cache';

const app = express();
const prisma = new PrismaClient();
const port = process.env.PORT || 3000;

import { requestContextMiddleware } from './middleware/request-context.middleware';
import { loggingMiddleware } from './middleware/logging.middleware';
import { errorMiddleware } from './middleware/error.middleware';
import { logger } from './core/logger';

app.use(cors({
  exposedHeaders: ['Content-Range', 'X-Total-Count'],
}));
app.use(compression());
app.use(express.json());
app.use(requestContextMiddleware);
app.use(loggingMiddleware);

import aiRoutes from './modules/ai/ai.routes';
import bookingRoutes from './modules/booking/booking.routes';
import adminRoutes from './admin.routes';
import authRoutes from './auth.routes';

app.use('/api/auth', authRoutes);

app.use('/api/ai', aiRoutes);
app.use('/api/bookings', bookingRoutes);
app.use('/api/admin', adminRoutes);

app.get('/', (req, res) => {
  res.send('BusZ Backend API is running!');
});

// Public API for Flutter App
app.get('/api/trips', async (req, res, next) => {
  try {
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 20;
    const skip = (page - 1) * limit;

    const cacheKey = `trips_page_${page}_limit_${limit}`;

    const result = await getCached(cacheKey, async () => {
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
  } catch (error) {
    next(error);
  }
});

app.get('/api/promotions', async (req, res, next) => {
  try {
    const promotions = await getCached('promotions', async () => {
      return prisma.promotion.findMany({
        where: { isActive: true },
        orderBy: { createdAt: 'desc' }
      });
    }, 300);
    res.json(promotions);
  } catch (error) {
    next(error);
  }
});

Sentry.setupExpressErrorHandler(app);
app.use(errorMiddleware);

if (require.main === module) {
  app.listen(port, () => {
    logger.info(`Server is running on port ${port}`);
  });
}

export default app;
