const amqp = require('amqplib');
const axios = require('axios');
const logger = require('./logger');

const rabbitMQUrl = 'amqp://guest:guest@rabbitmq-service:5672';
const queueName = 'events';

(async function consumeEvent() {
    try {
        const connection = await amqp.connect(rabbitMQUrl);
        const channel = await connection.createChannel();

        await channel.assertQueue(queueName, { durable: false });

        logger.info('Waiting for messages...');
        channel.consume(queueName, async (msg) => {
            if (msg !== null) {
                logger.info(`Received: ${msg.content.toString()}`);
                try {
                    const response = await axios.get('http://api-service:3000/counter');
                    logger.info('Fetched data:', response.data);
                } catch (error) {
                    logger.error('API fetch failed:', error.message);
                }
                channel.ack(msg);
            }
        });
    } catch (error) {
        console.error('Error:', error);
    }
})();
