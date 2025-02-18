# Use a full-featured image with build tools
FROM node:16

# Set working directory
WORKDIR /app

# Install necessary system dependencies (helps fix errors)
RUN apt-get update && apt-get install -y python3 g++ make

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy the rest of the application
COPY . .

# Increase available memory for Node.js
ENV NODE_OPTIONS="--max-old-space-size=1024"

# Build the React app
RUN npm run build

# Expose the port
EXPOSE 3000

# Use a lightweight server to serve the built React app
CMD ["npx", "serve", "-s", "build", "-l", "3000"]
