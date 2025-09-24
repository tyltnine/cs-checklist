#!/bin/bash

# Adams Apples - Production-Hardened Complete Project Setup
# Version 2.0 - With all production improvements

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}Adam's Apples Production Setup v2.0${NC}"
echo -e "${GREEN}==========================================${NC}\n"

# Get project root directory name
read -p "Enter project directory name (default: adams-apples): " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-adams-apples}

# Create main project directory
echo -e "${YELLOW}Creating project directory: $PROJECT_NAME${NC}"
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

# Initialize Git repository with gitflow
echo -e "${YELLOW}Initializing Git repository with production branches...${NC}"
git init
git checkout -b main
git checkout -b develop
git checkout -b release/1.0.0

# Create comprehensive directory structure
echo -e "${YELLOW}Creating production-ready project structure...${NC}"

# Backend directories with clean architecture
mkdir -p backend/src/main/java/com/adamsapples/{config,controller,dto,entity,repository,service,security,util,exception,mapper}
mkdir -p backend/src/main/resources/{static,templates,db/migration}
mkdir -p backend/src/test/java/com/adamsapples/{controller,service,repository,integration}
mkdir -p backend/src/test/resources

# Frontend directories with feature modules
mkdir -p frontend/src/app/{core,shared,features,models,services,guards,interceptors,state}
mkdir -p frontend/src/app/features/{dashboard,locations,trees,varieties,work-orders,time-tracking,clients,invoicing,analytics,nursery}
mkdir -p frontend/src/app/shared/{components,directives,pipes,validators}
mkdir -p frontend/src/assets/{images,icons,fonts,i18n,scss}
mkdir -p frontend/src/environments

# Database directories for Flyway
mkdir -p database/{migrations,seeds,functions,views,triggers,testdata}

# Scripts directory - organized by purpose
mkdir -p scripts/{deployment,backup,maintenance,development,monitoring}

# Jenkins and CI/CD
mkdir -p jenkins
mkdir -p .github/{workflows,ISSUE_TEMPLATE}

# Docker configurations
mkdir -p docker/{backend,frontend,nginx,postgres}

# Documentation
mkdir -p docs/{api,user-guide,technical,database,deployment}

# Tests directory
mkdir -p tests/{integration,e2e,performance,security}

# Monitoring and logs
mkdir -p monitoring/{prometheus,grafana}
mkdir -p logs

# ==================== Create .gitignore ====================
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
target/
*.jar
*.war
*.ear

# Environment files
.env
.env.*
!.env.template
*.pem
*.key
*.crt

# IDE files
.idea/
.vscode/
*.iml
*.ipr
*.iws
.project
.classpath
.settings/
.factorypath
.springBeans
*.sublime-*

# OS files
.DS_Store
Thumbs.db
desktop.ini
*.swp
*.swo

# Logs
*.log
logs/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build directories
dist/
build/
out/
bin/
*.class

# Test coverage
coverage/
.nyc_output/
*.lcov
.coverage

# Temporary files
*.tmp
*.temp
*.bak
*~
.cache/

# AWS
.aws/
*.pem

# Docker
.docker/

# Database
*.sql.gz
backup/

# Monitoring
monitoring/prometheus/data/
monitoring/grafana/data/
EOF

# ==================== Create production README ====================
cat > README.md << 'EOF'
# Adam's Apples - Agricultural Management System

## 🍎 Production-Ready PWA for Orchard & Nursery Management

### Tech Stack
- **Backend**: Spring Boot 3.x (Java 17) with production hardening
- **Frontend**: Angular 17+ PWA with offline-first architecture
- **Database**: PostgreSQL 15 with PostGIS + citext extensions
- **Cache**: Redis with TTL and eviction policies
- **Migrations**: Flyway for versioned database changes
- **Testing**: Testcontainers for integration tests
- **Infrastructure**: Docker, AWS (EC2, RDS, S3)
- **CI/CD**: Jenkins with automated testing and deployment

## Quick Start

### Prerequisites
- Java 17+
- Node.js 18+
- Docker & Docker Compose
- PostgreSQL 15
- Maven 3.8+

### Development Setup

1. **Clone and setup environment**
```bash
git clone <repository>
cd adams-apples
cp .env.template .env
# Edit .env with your values
```

2. **Start infrastructure**
```bash
docker-compose up -d postgres redis
./scripts/development/wait-for-db.sh
```

3. **Run database migrations**
```bash
./scripts/development/migrate.sh
```

4. **Start backend**
```bash
cd backend
mvn spring-boot:run
```

5. **Start frontend**
```bash
cd frontend
npm install
npm start
```

### Production Deployment
```bash
./scripts/deployment/deploy.sh production
```

## Testing

```bash
# All tests with real PostgreSQL
./scripts/development/test-all.sh

# Backend only
cd backend && mvn test

# Frontend only
cd frontend && npm test

# Integration tests
docker-compose -f docker-compose.test.yml up --abort-on-container-exit
```

## Database Management

```bash
# Create new migration
./scripts/development/create-migration.sh "add_client_notes"

# Run migrations
./scripts/development/migrate.sh

# Rollback last migration
./scripts/development/rollback.sh
```

## Monitoring

- Health Check: http://localhost:8080/actuator/health
- Metrics: http://localhost:8080/actuator/prometheus
- API Docs: http://localhost:8080/swagger-ui.html

## Project Structure
```
adams-apples/
├── backend/          # Spring Boot API with clean architecture
├── frontend/         # Angular PWA with offline support
├── database/         # Flyway migrations and seeds
├── docker/           # Docker configurations
├── scripts/          # Automation scripts
├── jenkins/          # CI/CD pipeline
├── monitoring/       # Prometheus & Grafana configs
└── docs/            # Documentation
```

## Security Features
- JWT authentication with refresh tokens
- S3 presigned URLs for secure uploads
- Redis session management with TTL
- Environment-based configuration
- SQL injection prevention via prepared statements
- XSS protection via Angular sanitization

## Contact
- Start Date: $(date +%Y-%m-%d)
- Version: 1.0.0
EOF

# ==================== Create .env.template ====================
cat > .env.template << 'EOF'
# Application Environment
NODE_ENV=development
SPRING_PROFILE=dev

# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=adams_apples
DB_USER=adams_user
DB_PASSWORD=CHANGE_ME_STRONG_PASSWORD_MIN_20_CHARS
DB_POOL_SIZE=10

# Redis Configuration
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=CHANGE_ME_REDIS_PASSWORD
REDIS_MAX_MEMORY=512mb
REDIS_TTL_SECONDS=3600

# Application Ports
APP_PORT=8080
FRONTEND_PORT=4200

# AWS Configuration (S3 File Storage)
AWS_ACCESS_KEY_ID=your_access_key_here
AWS_SECRET_ACCESS_KEY=your_secret_key_here
AWS_REGION=us-east-1
S3_BUCKET=adams-apples-files
S3_PRESIGNED_URL_EXPIRY=3600

# Security
JWT_SECRET=CHANGE_ME_MINIMUM_64_RANDOM_CHARACTERS_USE_OPENSSL_RAND_BASE64_48
JWT_EXPIRATION=86400000
JWT_REFRESH_EXPIRATION=604800000

# External APIs
WEATHER_API_KEY=your_openweathermap_api_key
STRIPE_SECRET_KEY=sk_test_your_stripe_key
STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret

# Monitoring
SENTRY_DSN=https://your-sentry-dsn
LOG_LEVEL=INFO

# Email (AWS SES or SMTP)
MAIL_HOST=email-smtp.us-east-1.amazonaws.com
MAIL_PORT=587
MAIL_USERNAME=your_ses_username
MAIL_PASSWORD=your_ses_password
MAIL_FROM=noreply@adamsapples.com

# Backup Configuration
BACKUP_RETENTION_DAYS=30
BACKUP_S3_BUCKET=adams-apples-backups
EOF

# ==================== Create docker-compose.yml with production hardening ====================
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  postgres:
    image: postgis/postgis:15-3.3
    container_name: adams-postgres
    environment:
      POSTGRES_DB: ${DB_NAME:-adams_apples}
      POSTGRES_USER: ${DB_USER:-adams_user}
      POSTGRES_PASSWORD: ${DB_PASSWORD:?Database password required}
      POSTGRES_INITDB_ARGS: "--encoding=UTF8 --locale=en_US.UTF-8"
      POSTGRES_HOST_AUTH_METHOD: md5
    ports:
      - "${DB_PORT:-5432}:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./database/migrations:/docker-entrypoint-initdb.d/migrations
      - ./docker/postgres/postgresql.conf:/etc/postgresql/postgresql.conf
    command: postgres -c config_file=/etc/postgresql/postgresql.conf
    networks:
      - adams-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER:-adams_user} -d ${DB_NAME:-adams_apples}"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s
    restart: unless-stopped
    deploy:
      resources:
        limits:
          memory: 1G
        reservations:
          memory: 512M

  redis:
    image: redis:7-alpine
    container_name: adams-redis
    command: >
      redis-server
      --maxmemory ${REDIS_MAX_MEMORY:-512mb}
      --maxmemory-policy allkeys-lru
      --appendonly yes
      --appendfsync everysec
      --requirepass ${REDIS_PASSWORD:-changeme}
      --tcp-backlog 511
      --timeout 0
      --tcp-keepalive 300
    ports:
      - "${REDIS_PORT:-6379}:6379"
    volumes:
      - redis_data:/data
    networks:
      - adams-network
    healthcheck:
      test: ["CMD", "redis-cli", "--raw", "incr", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 20s
    restart: unless-stopped
    deploy:
      resources:
        limits:
          memory: 512M
        reservations:
          memory: 256M

  flyway:
    image: flyway/flyway:9-alpine
    container_name: adams-flyway
    command: -connectRetries=60 migrate
    volumes:
      - ./database/migrations:/flyway/sql
      - ./database/flyway.conf:/flyway/conf/flyway.conf
    environment:
      FLYWAY_URL: jdbc:postgresql://postgres:5432/${DB_NAME:-adams_apples}
      FLYWAY_USER: ${DB_USER:-adams_user}
      FLYWAY_PASSWORD: ${DB_PASSWORD:?Database password required}
      FLYWAY_SCHEMAS: adams_apples,public
      FLYWAY_BASELINE_ON_MIGRATE: "true"
      FLYWAY_VALIDATE_ON_MIGRATE: "true"
    depends_on:
      postgres:
        condition: service_healthy
    networks:
      - adams-network

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile
      args:
        JAR_FILE: target/*.jar
    container_name: adams-backend
    ports:
      - "${APP_PORT:-8080}:8080"
      - "9090:9090"  # Prometheus metrics
    environment:
      SPRING_PROFILES_ACTIVE: ${SPRING_PROFILE:-dev}
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/${DB_NAME:-adams_apples}
      SPRING_DATASOURCE_USERNAME: ${DB_USER:-adams_user}
      SPRING_DATASOURCE_PASSWORD: ${DB_PASSWORD:?Database password required}
      SPRING_REDIS_HOST: redis
      SPRING_REDIS_PORT: 6379
      SPRING_REDIS_PASSWORD: ${REDIS_PASSWORD:-changeme}
      AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
      AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
      AWS_REGION: ${AWS_REGION:-us-east-1}
      S3_BUCKET: ${S3_BUCKET:-adams-apples-files}
      JWT_SECRET: ${JWT_SECRET:?JWT secret required}
      WEATHER_API_KEY: ${WEATHER_API_KEY}
      JAVA_OPTS: "-Xmx512m -Xms256m"
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
      flyway:
        condition: service_completed_successfully
    networks:
      - adams-network
    volumes:
      - ./logs:/app/logs
      - ./uploads:/app/uploads
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/actuator/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s
    restart: unless-stopped
    deploy:
      resources:
        limits:
          memory: 1G
        reservations:
          memory: 512M

  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
      args:
        NODE_ENV: ${NODE_ENV:-development}
    container_name: adams-frontend
    ports:
      - "${FRONTEND_PORT:-4200}:80"
    environment:
      API_URL: ${API_URL:-http://localhost:8080}
      NODE_ENV: ${NODE_ENV:-development}
    networks:
      - adams-network
    depends_on:
      backend:
        condition: service_healthy
    restart: unless-stopped
    deploy:
      resources:
        limits:
          memory: 512M
        reservations:
          memory: 256M

  nginx:
    image: nginx:alpine
    container_name: adams-nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./docker/nginx/nginx.conf:/etc/nginx/nginx.conf
      - ./docker/nginx/ssl:/etc/nginx/ssl
    networks:
      - adams-network
    depends_on:
      - frontend
      - backend
    restart: unless-stopped

volumes:
  postgres_data:
    driver: local
  redis_data:
    driver: local

networks:
  adams-network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16
EOF

# ==================== Create Flyway configuration ====================
cat > database/flyway.conf << 'EOF'
flyway.url=${FLYWAY_URL}
flyway.user=${FLYWAY_USER}
flyway.password=${FLYWAY_PASSWORD}
flyway.schemas=adams_apples,public
flyway.locations=filesystem:/flyway/sql
flyway.baselineOnMigrate=true
flyway.validateOnMigrate=true
flyway.cleanDisabled=true
flyway.outOfOrder=false
flyway.mixed=false
flyway.group=true
flyway.encoding=UTF-8
EOF

# ==================== Create initial Flyway migration ====================
cat > database/migrations/V001__initial_schema.sql << 'EOF'
-- V001__initial_schema.sql - Production-hardened initial schema

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;
CREATE EXTENSION IF NOT EXISTS citext;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- Create schema
CREATE SCHEMA IF NOT EXISTS adams_apples;
SET search_path TO adams_apples, public;

-- Audit function for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Locations table with PostGIS geography
CREATE TABLE locations (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    name CITEXT NOT NULL UNIQUE,
    location_type VARCHAR(50) NOT NULL CHECK (location_type IN ('ADAMS_ORCHARD', 'NURSERY', 'CLIENT_PROPERTY')),
    address TEXT,
    coordinates GEOGRAPHY(POINT, 4326),
    polygon_boundary GEOGRAPHY(POLYGON, 4326),
    owner_type VARCHAR(50) CHECK (owner_type IN ('OWNED', 'RENTED', 'CLIENT_MANAGED')),
    client_id BIGINT,
    soil_type VARCHAR(100),
    soil_ph DECIMAL(3,1) CHECK (soil_ph BETWEEN 0 AND 14),
    elevation_ft INTEGER,
    slope_percentage DECIMAL(4,1),
    drainage_quality VARCHAR(50),
    irrigation_type VARCHAR(100),
    acreage DECIMAL(10,2),
    metadata JSONB DEFAULT '{}',
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_locations_coordinates ON locations USING GIST(coordinates);
CREATE INDEX idx_locations_boundary ON locations USING GIST(polygon_boundary);
CREATE INDEX idx_locations_metadata ON locations USING GIN(metadata jsonb_path_ops);
CREATE INDEX idx_locations_type ON locations(location_type);
CREATE INDEX idx_locations_active ON locations(active) WHERE active = true;

-- Clients table
CREATE TABLE clients (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    business_name CITEXT,
    contact_name VARCHAR(100) NOT NULL,
    email CITEXT UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    billing_address TEXT,
    billing_rate DECIMAL(6,2),
    contract_type VARCHAR(50),
    payment_terms VARCHAR(100),
    preferred_payment_method VARCHAR(50),
    stripe_customer_id VARCHAR(255),
    tax_exempt BOOLEAN DEFAULT FALSE,
    tax_id VARCHAR(50),
    metadata JSONB DEFAULT '{}',
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_clients_email ON clients(email);
CREATE INDEX idx_clients_active ON clients(active) WHERE active = true;

-- Add foreign key for locations
ALTER TABLE locations ADD CONSTRAINT fk_locations_client 
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL;

-- Varieties table with case-insensitive uniqueness
CREATE TABLE varieties (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    fruit_type VARCHAR(50) NOT NULL,
    variety_name CITEXT NOT NULL,
    ripening_group VARCHAR(50),
    ripening_window_start DATE,
    ripening_window_end DATE,
    chill_hours_required INTEGER,
    degree_days_to_harvest INTEGER,
    pollination_group VARCHAR(10),
    pollinators TEXT[],
    disease_resistance TEXT[],
    susceptibilities TEXT[],
    storage_life_days INTEGER,
    uses TEXT[],
    flavor_profile TEXT,
    texture VARCHAR(100),
    color VARCHAR(100),
    size_category VARCHAR(50),
    commercial_value VARCHAR(50),
    heritage_variety BOOLEAN DEFAULT FALSE,
    usda_zone_min INTEGER,
    usda_zone_max INTEGER,
    -- Adam's specific fields
    vigor INTEGER CHECK (vigor BETWEEN 0 AND 5),
    car_rating INTEGER CHECK (car_rating BETWEEN 0 AND 5),
    black_spot INTEGER CHECK (black_spot BETWEEN 0 AND 5),
    summer_rots INTEGER CHECK (summer_rots BETWEEN 0 AND 5),
    generation VARCHAR(50),
    disease_notes TEXT,
    regular_crop INTEGER CHECK (regular_crop BETWEEN 0 AND 5),
    taste_rating INTEGER CHECK (taste_rating BETWEEN 0 AND 5),
    taste_notes TEXT,
    storage_quality VARCHAR(50),
    days_after_bloom_fall INTEGER,
    ripening_group_detail VARCHAR(100),
    metadata JSONB DEFAULT '{}',
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_variety_fruit_name UNIQUE(fruit_type, variety_name)
);

CREATE INDEX idx_varieties_fruit_type ON varieties(fruit_type);
CREATE INDEX idx_varieties_ripening ON varieties(ripening_group);
CREATE INDEX idx_varieties_metadata ON varieties USING GIN(metadata jsonb_path_ops);

-- Trees table with comprehensive tracking
CREATE TABLE trees (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    location_id BIGINT NOT NULL REFERENCES locations(id) ON DELETE CASCADE,
    tree_identifier VARCHAR(50) NOT NULL,
    row_number INTEGER,
    position_in_row INTEGER,
    coordinates GEOGRAPHY(POINT, 4326),
    variety_id BIGINT REFERENCES varieties(id),
    rootstock VARCHAR(100),
    planting_date DATE,
    grafting_date DATE,
    grafting_type VARCHAR(50),
    scion_source VARCHAR(100),
    age_years INTEGER GENERATED ALWAYS AS (
        CASE 
            WHEN planting_date IS NOT NULL 
            THEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, planting_date))
            ELSE NULL 
        END
    ) STORED,
    status VARCHAR(50) DEFAULT 'HEALTHY' CHECK (status IN ('HEALTHY', 'ATTENTION', 'DISEASED', 'DEAD', 'REMOVED')),
    health_score INTEGER CHECK (health_score BETWEEN 0 AND 100),
    height_ft DECIMAL(4,1),
    trunk_diameter_in DECIMAL(4,2),
    canopy_diameter_ft DECIMAL(4,1),
    training_system VARCHAR(50),
    last_pruning_date DATE,
    last_spray_date DATE,
    expected_yield_lbs DECIMAL(8,2),
    actual_yield_lbs DECIMAL(8,2),
    client_billable BOOLEAN DEFAULT FALSE,
    metadata JSONB DEFAULT '{}',
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_tree_location_identifier UNIQUE(location_id, tree_identifier)
);

CREATE INDEX idx_trees_location ON trees(location_id);
CREATE INDEX idx_trees_variety ON trees(variety_id);
CREATE INDEX idx_trees_status ON trees(status);
CREATE INDEX idx_trees_coordinates ON trees USING GIST(coordinates);
CREATE INDEX idx_trees_metadata ON trees USING GIN(metadata jsonb_path_ops);

-- Nursery rootstock planning
CREATE TABLE nursery_rootstock_plans (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    year INTEGER NOT NULL,
    rootstock_type VARCHAR(50) NOT NULL CHECK (rootstock_type IN ('DWARF', 'M9', 'M111', 'OTHER')),
    planned_quantity INTEGER NOT NULL DEFAULT 0,
    actual_quantity INTEGER DEFAULT 0,
    success_rate DECIMAL(5,2) GENERATED ALWAYS AS (
        CASE 
            WHEN planned_quantity > 0 
            THEN (actual_quantity::DECIMAL / planned_quantity) * 100
            ELSE 0 
        END
    ) STORED,
    client_id BIGINT REFERENCES clients(id),
    client_name VARCHAR(100),
    location_id BIGINT REFERENCES locations(id),
    status VARCHAR(50) DEFAULT 'PLANNED' CHECK (status IN ('PLANNED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED')),
    notes TEXT,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_rootstock_year ON nursery_rootstock_plans(year);
CREATE INDEX idx_rootstock_type ON nursery_rootstock_plans(rootstock_type);
CREATE INDEX idx_rootstock_client ON nursery_rootstock_plans(client_id);
CREATE INDEX idx_rootstock_status ON nursery_rootstock_plans(status);

-- Work orders
CREATE TABLE work_orders (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    location_id BIGINT REFERENCES locations(id),
    client_id BIGINT REFERENCES clients(id),
    order_number VARCHAR(50) UNIQUE NOT NULL DEFAULT ('WO-' || TO_CHAR(CURRENT_DATE, 'YYYYMMDD') || '-' || LPAD(nextval('work_order_seq')::text, 5, '0')),
    order_type VARCHAR(50),
    priority VARCHAR(20) DEFAULT 'NORMAL' CHECK (priority IN ('LOW', 'NORMAL', 'HIGH', 'URGENT')),
    status VARCHAR(50) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'SCHEDULED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED')),
    title VARCHAR(200) NOT NULL,
    description TEXT,
    scheduled_date DATE,
    start_time TIMESTAMP WITH TIME ZONE,
    end_time TIMESTAMP WITH TIME ZONE,
    estimated_hours DECIMAL(5,2),
    actual_hours DECIMAL(5,2),
    materials_cost DECIMAL(10,2) DEFAULT 0,
    labor_cost DECIMAL(10,2) DEFAULT 0,
    total_cost DECIMAL(10,2) GENERATED ALWAYS AS (COALESCE(materials_cost, 0) + COALESCE(labor_cost, 0)) STORED,
    billable BOOLEAN DEFAULT TRUE,
    assigned_to BIGINT[],
    completed_by BIGINT,
    completion_date TIMESTAMP WITH TIME ZONE,
    photos JSONB DEFAULT '[]',
    metadata JSONB DEFAULT '{}',
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create sequence for work order numbers
CREATE SEQUENCE work_order_seq START 1;

CREATE INDEX idx_work_orders_location ON work_orders(location_id);
CREATE INDEX idx_work_orders_client ON work_orders(client_id);
CREATE INDEX idx_work_orders_status ON work_orders(status);
CREATE INDEX idx_work_orders_scheduled ON work_orders(scheduled_date);
CREATE INDEX idx_work_orders_priority ON work_orders(priority);

-- Users table
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    email CITEXT UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    role VARCHAR(50) NOT NULL DEFAULT 'USER',
    hourly_rate DECIMAL(6,2),
    client_id BIGINT REFERENCES clients(id),
    permissions JSONB DEFAULT '{}',
    active BOOLEAN DEFAULT TRUE,
    email_verified BOOLEAN DEFAULT FALSE,
    last_login TIMESTAMP WITH TIME ZONE,
    failed_login_attempts INTEGER DEFAULT 0,
    locked_until TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_active ON users(active) WHERE active = true;

-- Apply updated_at triggers
CREATE TRIGGER update_locations_updated_at BEFORE UPDATE ON locations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_clients_updated_at BEFORE UPDATE ON clients
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_varieties_updated_at BEFORE UPDATE ON varieties
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_trees_updated_at BEFORE UPDATE ON trees
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_nursery_rootstock_updated_at BEFORE UPDATE ON nursery_rootstock_plans
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_work_orders_updated_at BEFORE UPDATE ON work_orders
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Grant permissions (adjust as needed)
GRANT ALL ON SCHEMA adams_apples TO adams_user;
GRANT ALL ON ALL TABLES IN SCHEMA adams_apples TO adams_user;
GRANT ALL ON ALL SEQUENCES IN SCHEMA adams_apples TO adams_user;
EOF

# ==================== Create V002 migration for additional tables ====================
cat > database/migrations/V002__additional_tables.sql << 'EOF'
-- V002__additional_tables.sql - Additional production tables

SET search_path TO adams_apples, public;

-- Time tracking
CREATE TABLE time_entries (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    user_id BIGINT NOT NULL REFERENCES users(id),
    work_order_id BIGINT REFERENCES work_orders(id),
    location_id BIGINT REFERENCES locations(id),
    task_type VARCHAR(100),
    start_time TIMESTAMP WITH TIME ZONE NOT NULL,
    end_time TIMESTAMP WITH TIME ZONE,
    duration_minutes INTEGER GENERATED ALWAYS AS (
        CASE 
            WHEN end_time IS NOT NULL 
            THEN EXTRACT(EPOCH FROM (end_time - start_time))/60
            ELSE NULL 
        END
    ) STORED,
    break_minutes INTEGER DEFAULT 0,
    billable BOOLEAN DEFAULT TRUE,
    hourly_rate DECIMAL(6,2),
    total_cost DECIMAL(8,2),
    notes TEXT,
    approved BOOLEAN DEFAULT FALSE,
    approved_by BIGINT REFERENCES users(id),
    synced BOOLEAN DEFAULT FALSE,
    device_id VARCHAR(100),
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_time_entries_user ON time_entries(user_id);
CREATE INDEX idx_time_entries_work_order ON time_entries(work_order_id);
CREATE INDEX idx_time_entries_location ON time_entries(location_id);
CREATE INDEX idx_time_entries_date ON time_entries(DATE(start_time));
CREATE INDEX idx_time_entries_billable ON time_entries(billable) WHERE billable = true;

-- Invoices
CREATE TABLE invoices (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    client_id BIGINT NOT NULL REFERENCES clients(id),
    location_id BIGINT REFERENCES locations(id),
    invoice_date DATE NOT NULL,
    due_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'DRAFT' CHECK (status IN ('DRAFT', 'SENT', 'VIEWED', 'PAID', 'OVERDUE', 'CANCELLED')),
    subtotal DECIMAL(12,2) DEFAULT 0,
    tax_rate DECIMAL(5,2) DEFAULT 0,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    discount_percentage DECIMAL(5,2) DEFAULT 0,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    processing_fee DECIMAL(8,2) DEFAULT 0,
    total_amount DECIMAL(12,2) DEFAULT 0,
    payment_method VARCHAR(50),
    payment_date DATE,
    stripe_payment_intent VARCHAR(255),
    check_number VARCHAR(50),
    notes TEXT,
    terms TEXT,
    sent_date TIMESTAMP WITH TIME ZONE,
    viewed_date TIMESTAMP WITH TIME ZONE,
    reminder_sent_count INTEGER DEFAULT 0,
    last_reminder_date TIMESTAMP WITH TIME ZONE,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_invoices_client ON invoices(client_id);
CREATE INDEX idx_invoices_status ON invoices(status);
CREATE INDEX idx_invoices_date ON invoices(invoice_date);
CREATE INDEX idx_invoices_due ON invoices(due_date);

-- Weather data
CREATE TABLE weather_data (
    id BIGSERIAL PRIMARY KEY,
    location_id BIGINT NOT NULL REFERENCES locations(id),
    observation_date DATE NOT NULL,
    min_temp_f DECIMAL(5,2),
    max_temp_f DECIMAL(5,2),
    avg_temp_f DECIMAL(5,2),
    precipitation_in DECIMAL(5,2),
    humidity_percent INTEGER,
    wind_speed_mph DECIMAL(4,1),
    degree_days DECIMAL(6,2),
    cumulative_degree_days DECIMAL(8,2),
    chill_hours DECIMAL(6,2),
    cumulative_chill_hours DECIMAL(8,2),
    source VARCHAR(50),
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_weather_location_date UNIQUE(location_id, observation_date)
);

CREATE INDEX idx_weather_location ON weather_data(location_id);
CREATE INDEX idx_weather_date ON weather_data(observation_date);

-- Sync queue for offline support
CREATE TABLE sync_queue (
    id BIGSERIAL PRIMARY KEY,
    device_id VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    entity_id BIGINT,
    entity_uuid UUID,
    operation VARCHAR(20) NOT NULL CHECK (operation IN ('INSERT', 'UPDATE', 'DELETE')),
    data JSONB NOT NULL,
    sync_status VARCHAR(50) DEFAULT 'PENDING' CHECK (sync_status IN ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'FAILED')),
    retry_count INTEGER DEFAULT 0,
    max_retries INTEGER DEFAULT 3,
    error_message TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    synced_at TIMESTAMP WITH TIME ZONE
);

CREATE INDEX idx_sync_queue_device ON sync_queue(device_id);
CREATE INDEX idx_sync_queue_status ON sync_queue(sync_status);
CREATE INDEX idx_sync_queue_created ON sync_queue(created_at);

-- Apply triggers
CREATE TRIGGER update_time_entries_updated_at BEFORE UPDATE ON time_entries
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_invoices_updated_at BEFORE UPDATE ON invoices
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
EOF

# ==================== Create backend pom.xml with production dependencies ====================
cat > backend/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.1.5</version>
        <relativePath/>
    </parent>
    
    <groupId>com.adamsapples</groupId>
    <artifactId>adams-apples-backend</artifactId>
    <version>1.0.0</version>
    <name>Adams Apples Backend</name>
    <description>Production-ready Agricultural Management System API</description>
    
    <properties>
        <java.version>17</java.version>
        <testcontainers.version>1.19.3</testcontainers.version>
        <flyway.version>9.22.3</flyway.version>
        <aws.version>2.21.0</aws.version>
    </properties>
    
    <dependencies>
        <!-- Spring Boot Starters -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-mail</artifactId>
        </dependency>
        
        <!-- Database -->
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.flywaydb</groupId>
            <artifactId>flyway-core</artifactId>
            <version>${flyway.version}</version>
        </dependency>
        
        <!-- AWS SDK -->
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>s3</artifactId>
            <version>${aws.version}</version>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>ses</artifactId>
            <version>${aws.version}</version>
        </dependency>
        
        <!-- Security -->
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-api</artifactId>
            <version>0.11.5</version>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-impl</artifactId>
            <version>0.11.5</version>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-jackson</artifactId>
            <version>0.11.5</version>
            <scope>runtime</scope>
        </dependency>
        
        <!-- API Documentation -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
            <version>2.2.0</version>
        </dependency>
        
        <!-- Monitoring -->
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-registry-prometheus</artifactId>
        </dependency>
        
        <!-- Utilities -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
        </dependency>
        
        <!-- Testing -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>testcontainers</artifactId>
            <version>${testcontainers.version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>postgresql</artifactId>
            <version>${testcontainers.version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>${testcontainers.version}</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.flywaydb</groupId>
                <artifactId>flyway-maven-plugin</artifactId>
                <version>${flyway.version}</version>
            </plugin>
        </plugins>
    </build>
</project>
EOF

# ==================== Create Spring Boot application.yml ====================
cat > backend/src/main/resources/application.yml << 'EOF'
spring:
  application:
    name: adams-apples
  
  profiles:
    active: ${SPRING_PROFILES_ACTIVE:dev}
  
  datasource:
    url: ${SPRING_DATASOURCE_URL:jdbc:postgresql://localhost:5432/adams_apples}
    username: ${SPRING_DATASOURCE_USERNAME:adams_user}
    password: ${SPRING_DATASOURCE_PASSWORD:changeme}
    driver-class-name: org.postgresql.Driver
    hikari:
      maximum-pool-size: ${DB_POOL_SIZE:10}
      minimum-idle: 5
      connection-timeout: 30000
      idle-timeout: 600000
      max-lifetime: 1800000
      leak-detection-threshold: 60000
  
  jpa:
    hibernate:
      ddl-auto: validate
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true
        jdbc:
          batch_size: 25
          batch_versioned_data: true
        order_inserts: true
        order_updates: true
        default_schema: adams_apples
    open-in-view: false
  
  redis:
    host: ${SPRING_REDIS_HOST:localhost}
    port: ${SPRING_REDIS_PORT:6379}
    password: ${SPRING_REDIS_PASSWORD:}
    timeout: 2000ms
    lettuce:
      pool:
        max-active: 8
        max-idle: 8
        min-idle: 0
        max-wait: -1ms
  
  flyway:
    enabled: true
    baseline-on-migrate: true
    locations: classpath:db/migration
    schemas: adams_apples
    validate-on-migrate: true
  
  servlet:
    multipart:
      max-file-size: 10MB
      max-request-size: 10MB
      enabled: true
  
  mail:
    host: ${MAIL_HOST:localhost}
    port: ${MAIL_PORT:1025}
    username: ${MAIL_USERNAME:}
    password: ${MAIL_PASSWORD:}
    properties:
      mail:
        smtp:
          auth: true
          starttls:
            enable: true

# AWS Configuration
aws:
  s3:
    bucket: ${S3_BUCKET:adams-apples-files}
    region: ${AWS_REGION:us-east-1}
    presigned-url-expiration: ${S3_PRESIGNED_URL_EXPIRY:3600}
  access-key-id: ${AWS_ACCESS_KEY_ID:}
  secret-access-key: ${AWS_SECRET_ACCESS_KEY:}

# JWT Configuration
jwt:
  secret: ${JWT_SECRET:change-this-to-a-very-long-random-string}
  expiration: ${JWT_EXPIRATION:86400000}
  refresh-expiration: ${JWT_REFRESH_EXPIRATION:604800000}

# Actuator / Monitoring
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus,flyway
      base-path: /actuator
  endpoint:
    health:
      show-details: when-authorized
      probes:
        enabled: true
  metrics:
    export:
      prometheus:
        enabled: true
    tags:
      application: ${spring.application.name}

# Logging
logging:
  level:
    com.adamsapples: ${LOG_LEVEL:DEBUG}
    org.springframework.web: INFO
    org.hibernate.SQL: DEBUG
    org.hibernate.type.descriptor.sql.BasicBinder: TRACE
    org.flywaydb: INFO
  pattern:
    console: "%d{yyyy-MM-dd HH:mm:ss} - %msg%n"
    file: "%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n"
  file:
    name: logs/adams-apples.log
    max-size: 10MB
    max-history: 30

# API Documentation
springdoc:
  api-docs:
    path: /api-docs
  swagger-ui:
    path: /swagger-ui.html
    enabled: true

# CORS Configuration
cors:
  allowed-origins: ${CORS_ORIGINS:http://localhost:4200,http://localhost}
  allowed-methods: GET,POST,PUT,DELETE,OPTIONS
  allowed-headers: "*"
  allow-credentials: true
EOF

# ==================== Create development helper scripts ====================

# Database migration script
cat > scripts/development/migrate.sh << 'EOF'
#!/bin/bash
echo "Running database migrations..."
docker-compose run --rm flyway migrate
echo "Migrations complete!"
EOF
chmod +x scripts/development/migrate.sh

# Create migration script
cat > scripts/development/create-migration.sh << 'EOF'
#!/bin/bash
MIGRATION_NAME=$1
if [ -z "$MIGRATION_NAME" ]; then
    echo "Usage: ./create-migration.sh <migration_name>"
    exit 1
fi

TIMESTAMP=$(date +%Y%m%d%H%M%S)
VERSION=$(ls database/migrations/*.sql | wc -l | xargs)
VERSION=$((VERSION + 1))
VERSION=$(printf "V%03d" $VERSION)

FILENAME="database/migrations/${VERSION}__${MIGRATION_NAME}.sql"
touch $FILENAME
echo "-- ${VERSION}__${MIGRATION_NAME}.sql" > $FILENAME
echo "-- Created: $(date)" >> $FILENAME
echo "" >> $FILENAME
echo "SET search_path TO adams_apples, public;" >> $FILENAME
echo "" >> $FILENAME

echo "Created migration: $FILENAME"
EOF
chmod +x scripts/development/create-migration.sh

# Test script with Testcontainers
cat > scripts/development/test-all.sh << 'EOF'
#!/bin/bash
set -e

echo "Starting test suite with real PostgreSQL via Testcontainers..."

# Backend tests
echo "Running backend tests..."
cd backend
mvn clean test
cd ..

# Frontend tests
echo "Running frontend tests..."
cd frontend
npm run test:ci
cd ..

# Integration tests
echo "Running integration tests..."
docker-compose -f docker-compose.test.yml up --abort-on-container-exit

echo "All tests passed!"
EOF
chmod +x scripts/development/test-all.sh

# Wait for database script
cat > scripts/development/wait-for-db.sh << 'EOF'
#!/bin/bash
echo "Waiting for PostgreSQL to be ready..."
until docker exec adams-postgres pg_isready -U adams_user -d adams_apples
do
  echo "Waiting for database..."
  sleep 2
done
echo "Database is ready!"
EOF
chmod +x scripts/development/wait-for-db.sh

# ==================== Create production deployment script ====================
cat > scripts/deployment/deploy.sh << 'EOF'
#!/bin/bash
ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: ./deploy.sh [staging|production]"
    exit 1
fi

echo "Deploying to $ENVIRONMENT..."

# Load environment variables
if [ -f ".env.$ENVIRONMENT" ]; then
    export $(cat .env.$ENVIRONMENT | xargs)
fi

# Backup database before deployment
if [ "$ENVIRONMENT" == "production" ]; then
    echo "Creating backup..."
    ./scripts/backup/backup-db.sh
fi

# Build and deploy
docker-compose -f docker-compose.$ENVIRONMENT.yml build
docker-compose -f docker-compose.$ENVIRONMENT.yml down
docker-compose -f docker-compose.$ENVIRONMENT.yml up -d

# Run migrations
echo "Running migrations..."
docker-compose -f docker-compose.$ENVIRONMENT.yml run --rm flyway migrate

# Health check
echo "Waiting for services to be healthy..."
sleep 30
curl -f http://localhost:8080/actuator/health || exit 1

echo "Deployment to $ENVIRONMENT complete!"
EOF
chmod +x scripts/deployment/deploy.sh

# ==================== Create Jenkinsfile ====================
cat > jenkins/Jenkinsfile << 'EOF'
pipeline {
    agent any
    
    tools {
        maven 'Maven-3.8'
        nodejs 'NodeJS-18'
    }
    
    environment {
        DOCKER_REGISTRY = credentials('docker-registry')
        APP_NAME = 'adams-apples'
        SONAR_TOKEN = credentials('sonar-token')
        SLACK_WEBHOOK = credentials('slack-webhook')
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                script {
                    env.GIT_COMMIT = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                    env.GIT_BRANCH = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                }
            }
        }
        
        stage('Quality Gates') {
            parallel {
                stage('Backend Tests') {
                    steps {
                        dir('backend') {
                            sh 'mvn clean test'
                            junit 'target/surefire-reports/*.xml'
                        }
                    }
                }
                
                stage('Frontend Tests') {
                    steps {
                        dir('frontend') {
                            sh 'npm ci'
                            sh 'npm run test:ci'
                            sh 'npm run lint'
                        }
                    }
                }
                
                stage('Security Scan') {
                    steps {
                        sh 'docker run --rm -v $(pwd):/src aquasec/trivy filesystem /src'
                    }
                }
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    dir('backend') {
                        sh 'mvn sonar:sonar -Dsonar.projectKey=adams-apples'
                    }
                }
            }
        }
        
        stage('Build Docker Images') {
            when {
                anyOf {
                    branch 'main'
                    branch 'develop'
                }
            }
            steps {
                script {
                    def backendImage = docker.build("${APP_NAME}-backend:${env.GIT_COMMIT}", "./backend")
                    def frontendImage = docker.build("${APP_NAME}-frontend:${env.GIT_COMMIT}", "./frontend")
                    
                    docker.withRegistry("https://${DOCKER_REGISTRY}", 'docker-credentials') {
                        backendImage.push()
                        backendImage.push('latest')
                        frontendImage.push()
                        frontendImage.push('latest')
                    }
                }
            }
        }
        
        stage('Deploy to Staging') {
            when {
                branch 'develop'
            }
            steps {
                sshagent(['staging-ssh-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no user@staging-server '
                            cd /opt/adams-apples
                            git pull origin develop
                            docker-compose -f docker-compose.staging.yml pull
                            docker-compose -f docker-compose.staging.yml up -d
                            docker-compose -f docker-compose.staging.yml run --rm flyway migrate
                        '
                    '''
                }
            }
        }
        
        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
                
                sshagent(['production-ssh-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no user@production-server '
                            cd /opt/adams-apples
                            ./scripts/deployment/deploy.sh production
                        '
                    '''
                }
            }
        }
    }
    
    post {
        success {
            sh """
                curl -X POST -H 'Content-type: application/json' \
                --data '{"text":"✅ Build Successful: ${env.JOB_NAME} - ${env.BUILD_NUMBER}"}' \
                ${SLACK_WEBHOOK}
            """
        }
        failure {
            sh """
                curl -X POST -H 'Content-type: application/json' \
                --data '{"text":"❌ Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}"}' \
                ${SLACK_WEBHOOK}
            """
        }
        always {
            cleanWs()
        }
    }
}
EOF

# ==================== Initialize Git repository ====================
echo -e "${YELLOW}Initializing Git repository...${NC}"
git add .
git commit -m "Initial commit: Production-hardened Adam's Apples Agricultural Management System"

# ==================== Create initial variety seed data ====================
cat > database/seeds/V100__seed_varieties.sql << 'EOF'
-- V100__seed_varieties.sql - Initial variety data using UPSERT pattern

SET search_path TO adams_apples, public;

-- Adam's apple varieties with UPSERT for idempotency
INSERT INTO varieties (
    fruit_type, variety_name, ripening_group, vigor, car_rating,
    black_spot, summer_rots, regular_crop, taste_rating, heritage_variety
) VALUES 
    ('Apple', 'Doga Crab', 'Early', 4, 2, 1, 1, 4, 3, false),
    ('Apple', 'Vista Belle', 'Early', 3, 2, 2, 3, 4, 4, false),
    ('Apple', 'Lodi', 'Early', 4, 1, 3, 4, 3, 3, false),
    ('Apple', 'Transparent', 'Early', 3, 2, 3, 4, 3, 3, true),
    ('Apple', 'Pristine', 'Early-Mid', 3, 4, 1, 1, 4, 4, false),
    ('Apple', 'State Fair', 'Mid', 3, 3, 2, 2, 4, 4, false),
    ('Apple', 'Honey Crisp', 'Late', 3, 3, 2, 3, 2, 5, false),
    ('Apple', 'Ashmead''s Kernel', 'Late', 3, 4, 2, 1, 3, 5, true),
    ('Apple', 'Golden Russet', 'Late', 3, 5, 1, 1, 4, 5, true),
    ('Apple', 'Arkansas Black', 'Very Late', 3, 5, 2, 1, 3, 4, true)
ON CONFLICT (fruit_type, variety_name) 
DO UPDATE SET
    ripening_group = EXCLUDED.ripening_group,
    vigor = EXCLUDED.vigor,
    car_rating = EXCLUDED.car_rating,
    black_spot = EXCLUDED.black_spot,
    summer_rots = EXCLUDED.summer_rots,
    regular_crop = EXCLUDED.regular_crop,
    taste_rating = EXCLUDED.taste_rating,
    heritage_variety = EXCLUDED.heritage_variety,
    updated_at = CURRENT_TIMESTAMP
WHERE varieties.updated_at < CURRENT_TIMESTAMP;
EOF

# ==================== Final message ====================
echo -e "\n${GREEN}==========================================${NC}"
echo -e "${GREEN}Production Setup Complete! v2.0${NC}"
echo -e "${GREEN}==========================================${NC}\n"
echo -e "Project created in: ${GREEN}$(pwd)${NC}\n"
echo -e "${BLUE}Key Improvements Implemented:${NC}"
echo -e "✅ Flyway migrations for version control"
echo -e "✅ citext extension for case-insensitive varieties"
echo -e "✅ PostGIS with GEOGRAPHY for accurate distances"
echo -e "✅ Redis with TTL and eviction policies"
echo -e "✅ Testcontainers for real PostgreSQL testing"
echo -e "✅ Health checks and monitoring endpoints"
echo -e "✅ UPSERT patterns for idempotent data loading"
echo -e "✅ Production-ready Docker configuration"
echo -e "\n${YELLOW}Next Steps:${NC}"
echo -e "1. Copy .env.template to .env and configure: ${GREEN}cp .env.template .env${NC}"
echo -e "2. Start infrastructure: ${GREEN}docker-compose up -d postgres redis${NC}"
echo -e "3. Wait for database: ${GREEN}./scripts/development/wait-for-db.sh${NC}"
echo -e "4. Run migrations: ${GREEN}./scripts/development/migrate.sh${NC}"
echo -e "5. Configure GitHub: ${GREEN}git remote add origin <your-repo-url>${NC}"
echo -e "6. Push to repository: ${GREEN}git push -u origin main${NC}"
echo -e "\n${BLUE}Access Points:${NC}"
echo -e "   Frontend: ${GREEN}http://localhost:4200${NC}"
echo -e "   Backend API: ${GREEN}http://localhost:8080${NC}"
echo -e "   API Docs: ${GREEN}http://localhost:8080/swagger-ui.html${NC}"
echo -e "   Health: ${GREEN}http://localhost:8080/actuator/health${NC}"
echo -e "   Database: ${GREEN}localhost:5432${NC}"
echo -e "\n${GREEN}Happy coding! 🍎${NC}"