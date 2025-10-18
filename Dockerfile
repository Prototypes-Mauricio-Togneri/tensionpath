FROM dart:stable

WORKDIR /app

# Copy only server folder
COPY server/ .

# Install dependencies
RUN dart pub get

# Expose Heroku port
EXPOSE 8080

# Declare entry point
ENTRYPOINT ["dart", "run", "lib/main/main.dart"]