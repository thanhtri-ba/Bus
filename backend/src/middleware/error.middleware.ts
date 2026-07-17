import { Request, Response, NextFunction } from 'express';
import { logger } from '../core/logger';
import { getRequestContext } from '../core/async-context';

export function errorMiddleware(err: any, req: Request, res: Response, next: NextFunction) {
  const context = getRequestContext();
  
  logger.error('request_failed', {
    errorName: err.name,
    errorMessage: err.message,
    stack: process.env.NODE_ENV === 'production' ? undefined : err.stack,
  });

  res.status(err.status || 500).json({
    message: err.status < 500 ? err.message : 'Internal server error',
    requestId: context?.requestId,
  });
}