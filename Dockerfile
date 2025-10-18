FROM dart:stable

# Set working directory
WORKDIR /app

# Copy only server folder
COPY server/ .

# Install dependencies
RUN dart pub get

# Expose port
EXPOSE 8080

# Run app
CMD ["dart", "run", "lib/main/main.dart"]