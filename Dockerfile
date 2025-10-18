FROM dart:stable

WORKDIR /app

# Copy only server folder
COPY server/ .

# Install dependencies
RUN dart pub get

# Expose port
EXPOSE 8080

# Declare entrypoint
ENTRYPOINT ["dart", "run", "lib/main/main.dart"]

# Default parameters (can be overridden)
CMD []