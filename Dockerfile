# -----------------------------
# Stage 1: Build stage
# -----------------------------
FROM ruby:3.1.4 AS builder

ENV RAILS_ENV=production \
    RACK_ENV=production \
    BUNDLE_PATH=/bundle \
    PORT=3001

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    imagemagick \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy Gemfiles and install all gems (including development for asset precompile)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the app
COPY . .

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE

# Precompile assets
RUN bundle exec rails assets:precompile

# -----------------------------
# Stage 2: Final production image
# -----------------------------
FROM ruby:3.1.4 AS production

ENV RAILS_ENV=production \
    RACK_ENV=production \
    BUNDLE_PATH=/bundle \
    BUNDLE_WITHOUT="development:test" \
    PORT=3001

# Install only runtime dependencies
RUN apt-get update -qq && apt-get install -y \
    libpq-dev \
    nodejs \
    yarn \
    imagemagick \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy only production gems and precompiled assets from builder
COPY --from=builder /app /app
COPY --from=builder /bundle /bundle

# Expose port
EXPOSE 3001

# Start the app
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
