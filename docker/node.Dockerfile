# Use a lightweight official Node.js LTS image
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files first to leverage Docker layer caching
COPY package*.json ./

# Install all dependencies (including devDependencies if needed for tests)
RUN npm ci

# Copy the rest of the application source code
COPY . .

# --- Production Image Stage ---
FROM node:20-alpine AS runner

WORKDIR /app

# Set environment to production
ENV NODE_ENV=production

# Create a non-root user for security (best practice for Hadolint)
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Copy built artifacts and dependencies from builder stage
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

# Switch to non-root user
USER nodejs

# Expose the port your app runs on
EXPOSE 8080

# Command to start your Node.js application or test suite
CMD ["npm", "start"]
