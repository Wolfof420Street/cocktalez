#!/bin/bash

# Create .env file from environment variables
echo "SENTRY_DSN=$SENTRY_DSN" > .env
echo "COCKTAIL_DB_KEY=$COCKTAIL_DB_KEY" >> .env
