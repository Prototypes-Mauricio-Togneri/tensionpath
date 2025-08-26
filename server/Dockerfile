FROM dart:stable

# Set working directory
WORKDIR /app

# Copy pubspec and lock files, install dependencies
COPY pubspec.* ./
RUN dart pub get

# Copy the rest of your app code
COPY . .

# Expose the port (optional)
EXPOSE 8080

# Run the server, using the PORT env var
CMD ["dart", "run", "lib/main.dart"]