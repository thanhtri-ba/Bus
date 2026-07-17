"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const client_1 = require("@prisma/client");
const auth_middleware_1 = require("./middleware/auth.middleware");
const admin_middleware_1 = require("./middleware/admin.middleware");
const router = (0, express_1.Router)();
router.use(auth_middleware_1.verifyAccessToken);
router.use(admin_middleware_1.requireAdmin);
const prisma = new client_1.PrismaClient();
const createCrudRouter = (delegate, resourceName) => {
    const crudRouter = (0, express_1.Router)();
    crudRouter.get('/', async (req, res) => {
        const { range, sort, filter } = req.query;
        let skip = 0;
        let take = 10;
        if (range) {
            try {
                const parsedRange = JSON.parse(range);
                skip = parsedRange[0];
                take = parsedRange[1] - parsedRange[0] + 1;
            }
            catch (error) { }
        }
        let orderBy = {};
        if (sort) {
            try {
                const parsedSort = JSON.parse(sort);
                const field = parsedSort[0];
                const order = parsedSort[1].toLowerCase();
                orderBy = { [field]: order };
            }
            catch (error) { }
        }
        let where = {};
        if (filter) {
            try {
                const parsedFilter = JSON.parse(filter);
                for (const key of Object.keys(parsedFilter)) {
                    if (key === 'q') {
                        // handle search
                    }
                    else if (key === 'id' && Array.isArray(parsedFilter[key])) {
                        where[key] = { in: parsedFilter[key] };
                    }
                    else {
                        where[key] = parsedFilter[key];
                    }
                }
            }
            catch (error) { }
        }
        try {
            const [data, total] = await Promise.all([
                delegate.findMany({ skip, take, orderBy, where }),
                delegate.count({ where })
            ]);
            res.setHeader('Content-Range', `${resourceName} ${skip}-${skip + data.length - 1}/${total}`);
            res.setHeader('X-Total-Count', total);
            res.json(data);
        }
        catch (error) {
            const message = error instanceof Error ? error.message : 'An unexpected error occurred';
            res.status(500).json({ error: message });
        }
    });
    crudRouter.get('/:id', async (req, res) => {
        try {
            const data = await delegate.findUnique({ where: { id: req.params.id } });
            if (data) {
                res.json(data);
            }
            else {
                res.status(404).json({ error: 'Not found' });
            }
        }
        catch (error) {
            const message = error instanceof Error ? error.message : 'An unexpected error occurred';
            res.status(500).json({ error: message });
        }
    });
    crudRouter.post('/', async (req, res) => {
        try {
            const { id, ...createData } = req.body;
            const data = await delegate.create({ data: createData });
            res.status(201).json(data);
        }
        catch (error) {
            const message = error instanceof Error ? error.message : 'An unexpected error occurred';
            res.status(500).json({ error: message });
        }
    });
    crudRouter.put('/:id', async (req, res) => {
        try {
            const { id: _, ...updateData } = req.body;
            const data = await delegate.update({ where: { id: req.params.id }, data: updateData });
            res.json(data);
        }
        catch (error) {
            const message = error instanceof Error ? error.message : 'An unexpected error occurred';
            res.status(500).json({ error: message });
        }
    });
    crudRouter.delete('/:id', async (req, res) => {
        try {
            const data = await delegate.delete({ where: { id: req.params.id } });
            res.json(data);
        }
        catch (error) {
            const message = error instanceof Error ? error.message : 'An unexpected error occurred';
            res.status(500).json({ error: message });
        }
    });
    return crudRouter;
};
router.use('/users', createCrudRouter(prisma.user, 'users'));
router.use('/bookings', createCrudRouter(prisma.booking, 'bookings'));
router.use('/trips', createCrudRouter(prisma.trip, 'trips'));
router.use('/busAgents', createCrudRouter(prisma.busAgent, 'busAgents'));
router.use('/promotions', createCrudRouter(prisma.promotion, 'promotions'));
router.use('/cities', createCrudRouter(prisma.city, 'cities'));
router.use('/routes', createCrudRouter(prisma.route, 'routes'));
exports.default = router;
