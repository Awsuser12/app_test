# Python 3.11 Docker image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application
COPY app.py .

# Expose the port the app will run on
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
