# Use a single base image for consistency
FROM node:18-alpine AS base

# Set the working directory
WORKDIR /app

# Install necessary dependencies
RUN apk add --no-cache libc6-compat git

# Copy package files and install dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Set environment variables
ENV OPENAI_API_KEY=""
ENV CODE=""
ARG DOCKER=true

# Copy the rest of the application files
COPY . .

# Build the application
RUN yarn build

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["node", "server.js"]
