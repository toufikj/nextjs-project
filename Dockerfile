# Stage 1: build
FROM node:20-alpine AS builder
WORKDIR /app

# install build deps
COPY package*.json ./
RUN npm ci --production=false

# copy source and build
COPY . .
RUN npm run build

# Stage 2: runtime
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production PORT=3000

# copy next build output and production node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package*.json ./
# copy node_modules from builder (built by npm ci)
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000
# start Next.js in production
CMD ["npm", "start"]
