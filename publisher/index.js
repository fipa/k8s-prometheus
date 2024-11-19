const amqp = require('amqplib');
const logger = require('./logger');

const rabbitMQUrl = 'amqp://guest:guest@rabbitmq-service:5672'; // Service URL of RabbitMQ in Kubernetes
const queueName = 'events';

(async function publishEvent() {
    try {
        const connection = await amqp.connect(rabbitMQUrl);
        const channel = await connection.createChannel();

        await channel.assertQueue(queueName, { durable: false });

        const message = 'Hello, world!';
        channel.sendToQueue(queueName, Buffer.from(message));
        logger.info(`Message sent: ${message}`);

        setTimeout(() => {
            connection.close();
        }, 500);
    } catch (error) {
        logger.error('Error:', error);
    }
})();
