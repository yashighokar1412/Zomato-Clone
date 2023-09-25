# Use Node.js 16 slim as the base image
FROM node:16-slim as builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Create a production-ready image
FROM node:16-slim

# Set the working directory
WORKDIR /app

# Copy the build artifacts from the previous stage
COPY --from=builder /app/build ./build
COPY package*.json ./

# Install only production dependencies
RUN npm install --production

# Expose port 3000 for your Node.js server
EXPOSE 3000

# Start your Node.js server
CMD ["npm", "start"]
