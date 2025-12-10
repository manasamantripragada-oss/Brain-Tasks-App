# -----------------------------
# 1. Build Stage
# -----------------------------
FROM node:18-alpine AS build

WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the project
COPY . .

# Build the Vite project
RUN npm run build

# -----------------------------
# 2. Production Stage (Nginx)
# -----------------------------
FROM nginx:alpine

# Copy build files t
