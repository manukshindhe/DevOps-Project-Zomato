# Use a full-featured Node.js image with build tools
FROM node:18

# Set working directory
WORKDIR /app

# Install necessary system dependencies
RUN apt-get update && apt-get install -y python3 g++ make

# Copy package.json and package-lock.json first for caching
COPY package*.json ./

# Ensure clean install of dependencies
RUN npm install --legacy-peer-deps && npm audit fix || true

# Copy the rest of the application
COPY . .

# Increase available memory for Node.js
ENV NODE_OPTIONS="--max-old-space-size=2048"

# Build the React app
RUN npm run build

# Expose the port
EXPOSE 3000

# Use a lightweight server to serve the built React app
CMD ["npx", "serve", "-s", "build", "-l", "3000"]
