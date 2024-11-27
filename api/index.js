const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const logger = require('./logger');

const app = express();
const port = 3000;

const db = new Pool({
    user: 'postgres',
    host: 'postgres-service',
    database: 'postgres',
    password: 'password',
    port: 5432,
});

app.use(cors());

app.use((req, res, next) => {
    logger.info(`${req.method} ${req.originalUrl}`);
    next();
});

app.get('/', (req, res) => {
    console.log('Hello World');
    res.status(200).send('Hello World');
});

app.get('/counter', async (req, res) => {
    try {
        const client = await db.connect();
        const result = await client.query('SELECT "Count" FROM "Counter" LIMIT 1');
        let currentCount = result.rows[0]?.Count || 0;
        const updatedCount = currentCount + 1;

        await client.query('UPDATE "Counter" SET "Count" = $1', [updatedCount]);
        client.release();
        const response = { current: currentCount, updated: updatedCount };
        logger.info('Counter:', response);
        res.json(response);
    } catch (error) {
        logger.error('Error:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

app.listen(port, () => {
    console.log(`API running on port ${port}`);
});
