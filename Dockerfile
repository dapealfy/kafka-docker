# Use OpenJDK as base image
FROM openjdk:11-jre-slim

# Set environment variables
ENV KAFKA_VERSION=3.6.1
ENV SCALA_VERSION=2.13
ENV KAFKA_HOME=/opt/kafka

# Install required packages
RUN apt-get update && \
    apt-get install -y wget

# Download and setup Kafka
RUN wget -q https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -O /tmp/kafka.tgz && \
    tar xzf /tmp/kafka.tgz -C /opt && \
    ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME} && \
    rm /tmp/kafka.tgz

# Add Kafka's bin directory to PATH
ENV PATH=${PATH}:${KAFKA_HOME}/bin

# Create directory for Kafka logs
RUN mkdir -p /tmp/kafka-logs

# Expose Kafka and Zookeeper ports
EXPOSE 9092 2181

WORKDIR ${KAFKA_HOME}

# Copy the start script
COPY start-kafka.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-kafka.sh

CMD ["start-kafka.sh"]