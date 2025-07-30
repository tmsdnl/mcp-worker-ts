FROM node:20-alpine

WORKDIR /app

# Enable corepack for pnpm
RUN corepack enable

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --prod --frozen-lockfile

# Copy built application
COPY dist/ ./dist/

# Run the application
ENTRYPOINT ["node", "dist/server.js"]