"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.verifyAccessToken = verifyAccessToken;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
function verifyAccessToken(req, res, next) {
    const authorization = req.headers.authorization;
    if (!authorization?.startsWith('Bearer ')) {
        res.status(401).json({
            message: 'Authentication required',
        });
        return;
    }
    const token = authorization.slice(7);
    const secret = process.env.JWT_SECRET;
    if (!secret) {
        res.status(500).json({
            message: 'JWT configuration is missing',
        });
        return;
    }
    try {
        const payload = jsonwebtoken_1.default.verify(token, secret);
        if (typeof payload !== 'object' ||
            typeof payload.sub !== 'string' ||
            typeof payload.role !== 'string') {
            res.status(401).json({
                message: 'Invalid access token',
            });
            return;
        }
        req.user = {
            id: payload.sub,
            role: payload.role,
            email: typeof payload.email === 'string'
                ? payload.email
                : undefined,
        };
        next();
    }
    catch {
        res.status(401).json({
            message: 'Invalid or expired access token',
        });
    }
}
